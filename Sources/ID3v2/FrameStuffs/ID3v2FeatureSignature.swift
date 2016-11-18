//
//  ID3v2FeatureSignature.swift
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

public class ID3v2FeatureSignature: ID3v2FrameStuff {

    // MARK: Instance Properties

    var content: [UInt8] = []

    var slotSymbol: UInt8 = 0

    // MARK:

    public var isEmpty: Bool {
        return self.content.isEmpty
    }

    // MARK: Initializers

    public init() {
    }

    public required init(fromData data: [UInt8], version: ID3v2Version) {
        guard data.count > 1 else {
            return
        }

        self.slotSymbol = data[0]

        self.content = [UInt8](data.suffix(from: 1))
    }

    // MARK: Instance Methods

    public func toData(version: ID3v2Version) -> [UInt8]? {
        guard !self.isEmpty else {
            return nil
        }

        switch version {
        case ID3v2Version.v2, ID3v2Version.v3:
            return nil

        case ID3v2Version.v4:
            var data: [UInt8] = [self.slotSymbol]

            data.append(contentsOf: self.content)

            return data
        }
    }

    public func toData() -> (data: [UInt8], version: ID3v2Version)? {
        guard let data = self.toData(version: ID3v2Version.v4) else {
            return nil
        }

        return (data: data, version: ID3v2Version.v4)
    }
}

public class ID3v2FeatureSignatureFormat: ID3v2FrameStuffSubclassFormat {

    // MARK: Type Properties

    public static let regular = ID3v2FeatureSignatureFormat()

    // MARK: Instance Methods

    public func createStuffSubclass(fromData data: [UInt8], version: ID3v2Version) -> ID3v2FeatureSignature {
        return ID3v2FeatureSignature(fromData: data, version: version)
    }

    public func createStuffSubclass(fromOther other: ID3v2FeatureSignature) -> ID3v2FeatureSignature {
        let stuff = ID3v2FeatureSignature()

        stuff.content = other.content

        stuff.slotSymbol = other.slotSymbol

        return stuff
    }

    public func createStuffSubclass() -> ID3v2FeatureSignature {
        return ID3v2FeatureSignature()
    }
}
