//
//  MPEGMediaSlot.swift
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

class MPEGMediaIntroSlot<T: TagCreator> {

    // MARK: Instance Properties

    var range: Range<UInt64>

    var tag: T.TagType?

    // MARK: Initializers

    init() {
        self.range = 0..<0
    }

    init?(creator: T, stream: Stream, range: Range<UInt64>) {
        assert(stream.isOpen && stream.isReadable && (range.count > 0), "Invalid stream or range")

        self.range = range

        repeat {
            guard let tag = creator.createTag(fromStream: stream, range: &self.range) else {
                return nil
            }

            if self.range.upperBound == range.upperBound {
                self.range = range.lowerBound..<self.range.lowerBound
            } else {
                self.tag = tag

                break
            }
        }
        while true
    }
}

class MPEGMediaOutroSlot<T: TagCreator> {

    // MARK: Instance Properties

    var range: Range<UInt64>

    var tag: T.TagType?

    // MARK: Initializers

    init() {
        self.range = 0..<0
    }

    init?(creator: T, stream: Stream, range: Range<UInt64>) {
        assert(stream.isOpen && stream.isReadable && (range.count > 0), "Invalid stream or range")

        self.range = range

        repeat {
            guard let tag = creator.createTag(fromStream: stream, range: &self.range) else {
                return nil
            }

            if self.range.upperBound < range.upperBound {
                self.range = self.range.upperBound..<range.upperBound
            } else {
                self.tag = tag

                break
            }
        }
        while true
    }
}
