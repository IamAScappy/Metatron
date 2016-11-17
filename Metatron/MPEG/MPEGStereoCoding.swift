//
//  MPEGStereoCoding.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 28.10.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import Foundation

public enum MPEGStereoCoding: UInt8 {
    case none //Layer I & II: bands 4 to 31

    case intensityOnly //Layer I & II: bands 8 to 31
    case midSideOnly //Layer I & II: bands 12 to 31

    case midSideAndIntensity //Layer I & II: bands 16 to 31
}
