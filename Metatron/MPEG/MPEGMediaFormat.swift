//
//  MPEGMediaFormat.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 13.10.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import Foundation

public class MPEGMediaFormat: MediaFormat {

    // MARK: Type Properties

    public static let regular = MPEGMediaFormat()

    // MARK: Instance Methods

    public func createMedia(fromStream stream: Stream) throws -> Media  {
        return try MPEGMedia(fromStream: stream)
    }

    public func createMedia(fromFilePath filePath: String, readOnly: Bool) throws -> Media {
        return try MPEGMedia(fromFilePath: filePath, readOnly: readOnly)
    }

    public func createMedia(fromData data: [UInt8], readOnly: Bool) throws -> Media {
        return try MPEGMedia(fromData: data, readOnly: readOnly)
    }
}
