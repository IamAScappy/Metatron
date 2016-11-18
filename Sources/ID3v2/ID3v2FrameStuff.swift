//
//  ID3v2FrameStuff.swift
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
