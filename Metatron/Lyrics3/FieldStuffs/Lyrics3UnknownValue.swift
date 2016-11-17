//
//  Lyrics3UnknownValue.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 24.10.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import Foundation

public class Lyrics3UnknownValue: Lyrics3FieldStuff {

    // MARK: Instance Properties

    public var content: [UInt8] = []

    // MARK:

    public var isEmpty: Bool {
    	return self.content.isEmpty
    }

    // MARK: Initializers

    public init() {
    }

    public required init(fromData data: [UInt8]) {
    	self.content = data
    }

    // MARK: Instance Methods

    public func toData() -> [UInt8]? {
        guard !self.isEmpty else {
            return nil
        }

        return self.content
    }
}

public class Lyrics3UnknownValueFormat: Lyrics3FieldStuffSubclassFormat {

    // MARK: Type Properties

    public static let regular = Lyrics3UnknownValueFormat()

    // MARK: Instance Methods

    public func createStuffSubclass(fromData data: [UInt8]) -> Lyrics3UnknownValue {
        return Lyrics3UnknownValue(fromData: data)
    }

    public func createStuffSubclass(fromOther other: Lyrics3UnknownValue) -> Lyrics3UnknownValue {
        let stuff = Lyrics3UnknownValue()

        stuff.content = other.content

        return stuff
    }

    public func createStuffSubclass() -> Lyrics3UnknownValue {
        return Lyrics3UnknownValue()
    }
}
