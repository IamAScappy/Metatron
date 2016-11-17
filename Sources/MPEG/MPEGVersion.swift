//
//  MPEGVersion.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 28.10.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import Foundation

public enum MPEGVersion: Int {
    case v1 //MPEG Version 1
    case v2 //MPEG Version 2
    case v2x5 //MPEG Version 2.5

    // MARK: Instance Properties

    var majorIndex: Int {
    	switch self {
        case .v1:
            return 0

        case .v2, .v2x5:
            return 1
        }
    }

    var index: Int {
        return self.rawValue
    }
}
