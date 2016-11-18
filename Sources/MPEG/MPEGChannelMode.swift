//
//  MPEGChannelMode.swift
//  Metatron
//
//  Copyright (c) 2016 Almaz Ibragimov
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
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
