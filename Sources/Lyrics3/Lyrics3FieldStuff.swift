//
//  Lyrics3FieldStuff.swift
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
