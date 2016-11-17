//
//  MPEGLayer.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 28.10.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import Foundation

public enum MPEGLayer: Int {
    case layer1 //MPEG Layer I
    case layer2 //MPEG Layer II
    case layer3 //MPEG Layer III

    // MARK: Instance Properties

    var index: Int {
        return self.rawValue
    }
}
