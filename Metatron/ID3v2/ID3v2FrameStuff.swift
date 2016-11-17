//
//  ID3v2FrameStuff.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 15.08.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import Foundation

public protocol ID3v2FrameStuff: class {

    // MARK: Instance Properties

    var isEmpty: Bool {get}

    // MARK: Instance Methods

    func toData(version: ID3v2Version) -> [UInt8]?

    func toData() -> (data: [UInt8], version: ID3v2Version)?
}

public protocol ID3v2FrameStuffFormat: class {

    // MARK: Instance Methods

    func createStuff(fromData: [UInt8], version: ID3v2Version) -> ID3v2FrameStuff
    func createStuff() -> ID3v2FrameStuff
}

public protocol ID3v2FrameStuffSubclassFormat: ID3v2FrameStuffFormat {

    // MARK: Nested Types

    associatedtype Stuff: ID3v2FrameStuff

    // MARK: Instance Methods

    func createStuffSubclass(fromData: [UInt8], version: ID3v2Version) -> Stuff
    func createStuffSubclass(fromOther: Stuff) -> Stuff
    func createStuffSubclass() -> Stuff
}

extension ID3v2FrameStuffSubclassFormat {

    // MARK: Instance Methods

    public func createStuff(fromData data: [UInt8], version: ID3v2Version) -> ID3v2FrameStuff {
        return self.createStuffSubclass(fromData: data, version: version)
    }

    public func createStuff() -> ID3v2FrameStuff {
        return self.createStuffSubclass()
    }
}
