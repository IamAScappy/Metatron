//
//  ID3v2UnknownValue.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 16.08.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import Foundation

public class ID3v2UnknownValue: ID3v2FrameStuff {

    // MARK: Instance Properties

    public var content: [UInt8] = []

    // MARK:

    public var isEmpty: Bool {
    	return self.content.isEmpty
    }

    // MARK: Initializers

    public init() {
    }

    public required init(fromData data: [UInt8], version: ID3v2Version) {
    	self.content = data
    }

    // MARK: Instance Methods

    public func toData(version: ID3v2Version) -> [UInt8]? {
        guard !self.isEmpty else {
            return nil
        }

        return self.content
    }

    public func toData() -> (data: [UInt8], version: ID3v2Version)? {
        guard let data = self.toData(version: ID3v2Version.v4) else {
            return nil
        }

        return (data: data, version: ID3v2Version.v4)
    }
}

public class ID3v2UnknownValueFormat: ID3v2FrameStuffSubclassFormat {

    // MARK: Type Properties

    public static let regular = ID3v2UnknownValueFormat()

    // MARK: Instance Methods

    public func createStuffSubclass(fromData data: [UInt8], version: ID3v2Version) -> ID3v2UnknownValue {
        return ID3v2UnknownValue(fromData: data, version: version)
    }

    public func createStuffSubclass(fromOther other: ID3v2UnknownValue) -> ID3v2UnknownValue {
        let stuff = ID3v2UnknownValue()

        stuff.content = other.content

        return stuff
    }

    public func createStuffSubclass() -> ID3v2UnknownValue {
        return ID3v2UnknownValue()
    }
}
