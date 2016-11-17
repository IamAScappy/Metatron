//
//  Lyrics3FieldStuff.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 24.10.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import Foundation

public protocol Lyrics3FieldStuff: class {

    // MARK: Instance Properties

    var isEmpty: Bool {get}

    // MARK: Instance Methods

    func toData() -> [UInt8]?
}

public protocol Lyrics3FieldStuffFormat: class {

    // MARK: Instance Methods

    func createStuff(fromData: [UInt8]) -> Lyrics3FieldStuff
    func createStuff() -> Lyrics3FieldStuff
}

public protocol Lyrics3FieldStuffSubclassFormat: Lyrics3FieldStuffFormat {

    // MARK: Nested Types

    associatedtype Stuff: Lyrics3FieldStuff

    // MARK: Instance Methods

    func createStuffSubclass(fromData: [UInt8]) -> Stuff
    func createStuffSubclass(fromOther: Stuff) -> Stuff
    func createStuffSubclass() -> Stuff
}

extension Lyrics3FieldStuffSubclassFormat {

    // MARK: Instance Methods

    public func createStuff(fromData data: [UInt8]) -> Lyrics3FieldStuff {
        return self.createStuffSubclass(fromData: data)
    }

    public func createStuff() -> Lyrics3FieldStuff {
        return self.createStuffSubclass()
    }
}
