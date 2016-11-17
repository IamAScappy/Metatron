//
//  MPEGEmphasis.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 28.10.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import Foundation

public enum MPEGEmphasis: UInt8 {
    case none = 0

    case e50x15ms = 1
    case ccitJx17 = 3

    case reserved = 2
}
