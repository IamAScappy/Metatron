//
//  ID3v2FeatureSignature.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 08.09.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
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
