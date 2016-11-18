//
//  ID3v2Comments.swift
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

public class ID3v2Comments: ID3v2LocalizedText {
}

public class ID3v2CommentsFormat: ID3v2FrameStuffSubclassFormat {

    // MARK: Type Properties

    public static let regular = ID3v2CommentsFormat()

    // MARK: Instance Methods

    public func createStuffSubclass(fromData data: [UInt8], version: ID3v2Version) -> ID3v2Comments {
        return ID3v2Comments(fromData: data, version: version)
    }

    public func createStuffSubclass(fromOther other: ID3v2Comments) -> ID3v2Comments {
        let stuff = ID3v2Comments()

        stuff.textEncoding = other.textEncoding
        stuff.language = other.language

        stuff.description = other.description
        stuff.content = other.content

        return stuff
    }

    public func createStuffSubclass() -> ID3v2Comments {
        return ID3v2Comments()
    }
}
