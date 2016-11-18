//
//  MediaRegistry.swift
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
