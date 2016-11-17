//
//  MPEGChannelMode.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 28.10.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import Foundation

public enum MPEGChannelMode: Hashable {
    case stereo
	case jointStereo(stereoCoding: MPEGStereoCoding)
	case dualChannel
	case singleChannel

	// MARK: Instance Properties

	var index: Int {
        switch self {
        case .stereo:
            return 0

        case .jointStereo:
            return 1

        case .dualChannel:
            return 2

        case .singleChannel:
            return 3
        }
    }

    // MARK:

    var rawValue: UInt8 {
        switch self {
        case .stereo:
            return 0

        case .jointStereo(let stereoCoding):
            return 4 | stereoCoding.rawValue

        case .dualChannel:
            return 8

        case .singleChannel:
            return 12
        }
    }

    public var hashValue: Int {
        return self.rawValue.hashValue
    }

    // MARK: Initializers

    init?(rawValue: UInt8) {
        switch (rawValue >> 2) & 3 {
        case 0:
            self = .stereo

        case 1:
            guard let stereoCoding = MPEGStereoCoding(rawValue: rawValue & 3) else {
                return nil
            }

            self = .jointStereo(stereoCoding: stereoCoding)

        case 2:
            self = .dualChannel

        case 3:
            self = .singleChannel

        default:
            return nil
        }
    }
}

public func == (left: MPEGChannelMode, right: MPEGChannelMode) -> Bool {
    return (left.rawValue == right.rawValue)
}

public func != (left: MPEGChannelMode, right: MPEGChannelMode) -> Bool {
    return (left.rawValue != right.rawValue)
}
