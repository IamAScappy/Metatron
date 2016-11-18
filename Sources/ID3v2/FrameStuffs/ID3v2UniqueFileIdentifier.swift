//
//  ID3v2UniqueFileIdentifier.swift
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

public class ID3v2UniqueFileIdentifier: ID3v2FrameStuff {

    // MARK: Instance Properties

    public var ownerIdentifier: String = ""

    public var content: [UInt8] = []

    // MARK:

    public var isEmpty: Bool {
        if self.ownerIdentifier.isEmpty {
            return true
        }

        if self.content.isEmpty {
            return true
        }

        return false
    }

    // MARK: Initializers

    public init() {
    }

    public required init(fromData data: [UInt8], version: ID3v2Version) {
        guard (data.count > 1) && (data[0] != 0) else {
            return
        }

        guard let ownerIdentifier = ID3v2TextEncoding.latin1.decode(data) else {
            return
        }

        guard ownerIdentifier.endIndex < data.count else {
            return
        }

        self.ownerIdentifier = ownerIdentifier.text

        self.content = [UInt8](data.suffix(from: ownerIdentifier.endIndex))
    }

    // MARK: Instance Methods

    public func toData(version: ID3v2Version) -> [UInt8]? {
        guard !self.isEmpty else {
            return nil
        }

        var data = ID3v2TextEncoding.latin1.encode(self.ownerIdentifier, termination: true)

        data.append(contentsOf: self.content)

        return data
    }

    public func toData() -> (data: [UInt8], version: ID3v2Version)? {
        guard let data = self.toData(version: ID3v2Version.v4) else {
            return nil
        }

        return (data: data, version: ID3v2Version.v4)
    }
}

public class ID3v2UniqueFileIdentifierFormat: ID3v2FrameStuffSubclassFormat {

    // MARK: Type Properties

    public static let regular = ID3v2UniqueFileIdentifierFormat()

    // MARK: Instance Methods

    public func createStuffSubclass(fromData data: [UInt8], version: ID3v2Version) -> ID3v2UniqueFileIdentifier {
        return ID3v2UniqueFileIdentifier(fromData: data, version: version)
    }

    public func createStuffSubclass(fromOther other: ID3v2UniqueFileIdentifier) -> ID3v2UniqueFileIdentifier {
        let stuff = ID3v2UniqueFileIdentifier()

        stuff.ownerIdentifier = other.ownerIdentifier

        stuff.content = other.content

        return stuff
    }

    public func createStuffSubclass() -> ID3v2UniqueFileIdentifier {
        return ID3v2UniqueFileIdentifier()
    }
}
