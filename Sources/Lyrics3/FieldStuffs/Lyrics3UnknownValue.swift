//
//  Lyrics3UnknownValue.swift
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
