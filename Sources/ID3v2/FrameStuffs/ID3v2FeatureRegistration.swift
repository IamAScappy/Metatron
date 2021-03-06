//
//  ID3v2FeatureRegistration.swift
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

public class ID3v2FeatureRegistration: ID3v2FrameStuff {

    // MARK: Instance Properties

    var identifier: String = ""
    var supplement: [UInt8] = []

    var slotSymbol: UInt8 = 0

    // MARK:

    public var isEmpty: Bool {
        return self.identifier.isEmpty
    }

    // MARK: Initializers

    public init() {
    }

    public init(fromData data: [UInt8], version: ID3v2Version) {
        guard (data.count > 2) && (data[0] != 0) else {
            return
        }

        guard let identifier = ID3v2TextEncoding.latin1.decode(data) else {
            return
        }

        guard identifier.endIndex < data.count else {
            return
        }

        self.identifier = identifier.text
        self.slotSymbol = data[identifier.endIndex]
        self.supplement = [UInt8](data.suffix(from: identifier.endIndex + 1))
    }

    // MARK: Instance Methods

    public func toData(version: ID3v2Version) -> [UInt8]? {
        guard !self.isEmpty else {
            return nil
        }

        switch version {
        case ID3v2Version.v2:
            return nil

        case ID3v2Version.v3:
            guard self.slotSymbol >= 128 else {
                return nil
            }

        case ID3v2Version.v4:
            guard self.slotSymbol >= 128 else {
                return nil
            }

            guard self.slotSymbol <= 240 else {
                return nil
            }
        }

        var data = ID3v2TextEncoding.latin1.encode(self.identifier, termination: true)

        data.append(self.slotSymbol)
        data.append(contentsOf: self.supplement)

        return data
    }

    public func toData() -> (data: [UInt8], version: ID3v2Version)? {
        guard let data = self.toData(version: ID3v2Version.v3) else {
            return nil
        }

        return (data: data, version: ID3v2Version.v3)
    }
}

public class ID3v2FeatureRegistrationFormat: ID3v2FrameStuffSubclassFormat {

    // MARK: Type Properties

    public static let regular = ID3v2FeatureRegistrationFormat()

    // MARK: Instance Methods

    public func createStuffSubclass(fromData data: [UInt8], version: ID3v2Version) -> ID3v2FeatureRegistration {
        return ID3v2FeatureRegistration(fromData: data, version: version)
    }

    public func createStuffSubclass(fromOther other: ID3v2FeatureRegistration) -> ID3v2FeatureRegistration {
        let stuff = ID3v2FeatureRegistration()

        stuff.identifier = other.identifier
        stuff.supplement = other.supplement

        stuff.slotSymbol = other.slotSymbol

        return stuff
    }

    public func createStuffSubclass() -> ID3v2FeatureRegistration {
        return ID3v2FeatureRegistration()
    }
}
