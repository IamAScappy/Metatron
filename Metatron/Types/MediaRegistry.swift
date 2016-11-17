//
//  MediaRegistry.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 10.11.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import Foundation

public class MediaRegistry {

	// MARK: Type Properties

    public static let regular = MediaRegistry()

    // MARK: Instance Properties

    public private(set) var medias: [String: MediaFormat]

    // MARK: Initializers

    private init() {
        self.medias = ["mp3": MPEGMediaFormat.regular]
    }

    // MARK: Instance Methods

    @discardableResult
    public func registerMedia(format: MediaFormat, fileExtension: String) -> Bool {
        guard !fileExtension.isEmpty else {
            return false
        }

        let key = fileExtension.lowercased()

        guard self.medias[key] == nil else {
            return false
        }

        self.medias[key] = format

        return true
    }

    public func identifyFilePath(_ filePath: String) -> MediaFormat? {
        guard let extensionStart = filePath.range(of: ".", options: String.CompareOptions.backwards) else {
            return nil
        }

        guard extensionStart.lowerBound > filePath.startIndex else {
            return nil
        }

        guard extensionStart.upperBound < filePath.endIndex else {
            return nil
        }

        return self.medias[filePath.substring(from: extensionStart.upperBound).lowercased()]
    }
}

public func createMedia(fromStream stream: Stream) throws -> Media {
    for (_, format) in MediaRegistry.regular.medias {
        do {
            return try format.createMedia(fromStream: stream)
        } catch MediaError.invalidFormat {
        }
    }

    throw MediaError.invalidFormat
}

public func createMedia(fromFilePath filePath: String, readOnly: Bool) throws -> Media {
    if let format = MediaRegistry.regular.identifyFilePath(filePath) {
        return try format.createMedia(fromFilePath: filePath, readOnly: readOnly)
    }

    for (_, format) in MediaRegistry.regular.medias {
        do {
            return try format.createMedia(fromFilePath: filePath, readOnly: readOnly)
        } catch MediaError.invalidFormat {
        }
    }

    throw MediaError.invalidFormat
}

public func createMedia(fromData data: [UInt8], readOnly: Bool) throws -> Media {
    for (_, format) in MediaRegistry.regular.medias {
        do {
            return try format.createMedia(fromData: data, readOnly: readOnly)
        } catch MediaError.invalidFormat {
        }
    }

    throw MediaError.invalidFormat
}
