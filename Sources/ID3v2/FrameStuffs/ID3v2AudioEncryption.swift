//
//  ID3v2AudioEncryption.swift
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

public class ID3v2AudioEncryption: ID3v2FrameStuff {

    // MARK: Instance Properties

    public var ownerIdentifier: String = ""

    public var previewStart: UInt16 = 0
    public var previewLength: UInt16 = 0

    public var encryptionInfo: [UInt8] = []

    // MARK:

    public var isEmpty: Bool {
        return self.ownerIdentifier.isEmpty
    }

    // MARK: Initializers

    public init() {
    }

    public required init(fromData data: [UInt8], version: ID3v2Version) {
        guard (data.count > 5) && (data[0] != 0) else {
            return
        }

        guard let ownerIdentifier = ID3v2TextEncoding.latin1.decode(data) else {
            return
        }

        let offset = ownerIdentifier.endIndex

        guard offset <= data.count - 4 else {
            return
        }

        self.ownerIdentifier = ownerIdentifier.text

        self.previewStart = UInt16(data[offset + 1]) | (UInt16(data[offset + 0]) << 8)
        self.previewLength = UInt16(data[offset + 3]) | (UInt16(data[offset + 2]) << 8)

        self.encryptionInfo = [UInt8](data.suffix(from: offset + 4))
    }

    // MARK: Instance Methods

    public func toData(version: ID3v2Version) -> [UInt8]? {
        guard !self.isEmpty else {
            return nil
        }

        var data = ID3v2TextEncoding.latin1.encode(self.ownerIdentifier, termination: true)

        data.append(contentsOf: [UInt8((self.previewStart >> 8) & 255),
                                 UInt8((self.previewStart) & 255),
                                 UInt8((self.previewLength >> 8) & 255),
                                 UInt8((self.previewLength) & 255)])

        data.append(contentsOf: self.encryptionInfo)

        return data
    }

    public func toData() -> (data: [UInt8], version: ID3v2Version)? {
        guard let data = self.toData(version: ID3v2Version.v4) else {
            return nil
        }

        return (data: data, version: ID3v2Version.v4)
    }
}

public class ID3v2AudioEncryptionFormat: ID3v2FrameStuffSubclassFormat {

    // MARK: Type Properties

    public static let regular = ID3v2AudioEncryptionFormat()

    // MARK: Instance Methods

    public func createStuffSubclass(fromData data: [UInt8], version: ID3v2Version) -> ID3v2AudioEncryption {
        return ID3v2AudioEncryption(fromData: data, version: version)
    }

    public func createStuffSubclass(fromOther other: ID3v2AudioEncryption) -> ID3v2AudioEncryption {
        let stuff = ID3v2AudioEncryption()

        stuff.ownerIdentifier = other.ownerIdentifier

        stuff.previewStart = other.previewStart
        stuff.previewLength = other.previewLength

        stuff.encryptionInfo = other.encryptionInfo

        return stuff
    }

    public func createStuffSubclass() -> ID3v2AudioEncryption {
        return ID3v2AudioEncryption()
    }
}
