//
//  ID3v2TagCommentsTest.swift
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

import XCTest

@testable import Metatron

class ID3v2TagCommentsTest: XCTestCase {

    // MARK: Instance Methods

    func test() {
        let tag = ID3v2Tag()

        do {
            let value: [String] = []

            let joined = value.joined(separator: "\n")

            tag.comments = value

            XCTAssert(tag.comments == value)

            let frame = tag.appendFrameSet(ID3v2FrameID.comm).mainFrame

            XCTAssert(frame.stuff == nil)

            do {
                tag.version = ID3v2Version.v2

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = ID3v2Version.v3

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = ID3v2Version.v4

                XCTAssert(tag.toData() == nil)
            }

            frame.imposeStuff(format: ID3v2CommentsFormat.regular).content = joined

            XCTAssert(tag.comments == value)
        }

        do {
            let value = [""]

            let joined = value.joined(separator: "\n")

            tag.comments = value

            XCTAssert(tag.comments == [])

            let frame = tag.appendFrameSet(ID3v2FrameID.comm).mainFrame

            XCTAssert(frame.stuff == nil)

            do {
                tag.version = ID3v2Version.v2

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = ID3v2Version.v3

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = ID3v2Version.v4

                XCTAssert(tag.toData() == nil)
            }

            frame.imposeStuff(format: ID3v2CommentsFormat.regular).content = joined

            XCTAssert(tag.comments == [])
        }

        do {
            let value = ["Abc 123"]

            let joined = value.joined(separator: "\n")

            tag.comments = value

            XCTAssert(tag.comments == [joined])

            let frame = tag.appendFrameSet(ID3v2FrameID.comm).mainFrame

            XCTAssert(frame.stuff(format: ID3v2CommentsFormat.regular).content == joined)

            do {
                tag.version = ID3v2Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comments == [joined])
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comments == [joined])
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comments == [joined])
            }

            frame.imposeStuff(format: ID3v2CommentsFormat.regular).content = joined

            XCTAssert(tag.comments == [joined])
        }

        do {
            let value = ["Абв 123"]

            let joined = value.joined(separator: "\n")

            tag.comments = value

            XCTAssert(tag.comments == [joined])

            let frame = tag.appendFrameSet(ID3v2FrameID.comm).mainFrame

            XCTAssert(frame.stuff(format: ID3v2CommentsFormat.regular).content == joined)

            do {
                tag.version = ID3v2Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comments == [joined])
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comments == [joined])
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comments == [joined])
            }

            frame.imposeStuff(format: ID3v2CommentsFormat.regular).content = joined

            XCTAssert(tag.comments == [joined])
        }

        do {
            let value = ["Abc 1", "Abc 2"]

            let joined = value.joined(separator: "\n")

            tag.comments = value

            XCTAssert(tag.comments == [joined])

            let frame = tag.appendFrameSet(ID3v2FrameID.comm).mainFrame

            XCTAssert(frame.stuff(format: ID3v2CommentsFormat.regular).content == joined)

            do {
                tag.version = ID3v2Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comments == [joined])
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comments == [joined])
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comments == [joined])
            }

            frame.imposeStuff(format: ID3v2CommentsFormat.regular).content = joined

            XCTAssert(tag.comments == [joined])
        }

        do {
            let value = ["", "Abc 2"]

            let joined = value.joined(separator: "\n")

            tag.comments = value

            XCTAssert(tag.comments == [joined])

            let frame = tag.appendFrameSet(ID3v2FrameID.comm).mainFrame

            XCTAssert(frame.stuff(format: ID3v2CommentsFormat.regular).content == joined)

            do {
                tag.version = ID3v2Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comments == [joined])
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comments == [joined])
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comments == [joined])
            }

            frame.imposeStuff(format: ID3v2CommentsFormat.regular).content = joined

            XCTAssert(tag.comments == [joined])
        }

        do {
            let value = ["Abc 1", ""]

            let joined = value.joined(separator: "\n")

            tag.comments = value

            XCTAssert(tag.comments == [joined])

            let frame = tag.appendFrameSet(ID3v2FrameID.comm).mainFrame

            XCTAssert(frame.stuff(format: ID3v2CommentsFormat.regular).content == joined)

            do {
                tag.version = ID3v2Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comments == [joined])
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comments == [joined])
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comments == [joined])
            }

            frame.imposeStuff(format: ID3v2CommentsFormat.regular).content = joined

            XCTAssert(tag.comments == [joined])
        }

        do {
            let value = ["", ""]

            let joined = value.joined(separator: "\n")

            tag.comments = value

            XCTAssert(tag.comments == [joined])

            let frame = tag.appendFrameSet(ID3v2FrameID.comm).mainFrame

            XCTAssert(frame.stuff(format: ID3v2CommentsFormat.regular).content == joined)

            do {
                tag.version = ID3v2Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comments == [joined])
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comments == [joined])
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comments == [joined])
            }

            frame.imposeStuff(format: ID3v2CommentsFormat.regular).content = joined

            XCTAssert(tag.comments == [joined])
        }

        do {
            let value = [Array<String>(repeating: "Abc", count: 123).joined(separator: "\n")]

            let joined = value.joined(separator: "\n")

            tag.comments = value

            XCTAssert(tag.comments == [joined])

            let frame = tag.appendFrameSet(ID3v2FrameID.comm).mainFrame

            XCTAssert(frame.stuff(format: ID3v2CommentsFormat.regular).content == joined)

            do {
                tag.version = ID3v2Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comments == [joined])
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comments == [joined])
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comments == [joined])
            }

            frame.imposeStuff(format: ID3v2CommentsFormat.regular).content = joined

            XCTAssert(tag.comments == [joined])
        }

        do {
            let value = Array<String>(repeating: "Abc", count: 123)

            let joined = value.joined(separator: "\n")

            tag.comments = value

            XCTAssert(tag.comments == [joined])

            let frame = tag.appendFrameSet(ID3v2FrameID.comm).mainFrame

            XCTAssert(frame.stuff(format: ID3v2CommentsFormat.regular).content == joined)

            do {
                tag.version = ID3v2Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comments == [joined])
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comments == [joined])
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comments == [joined])
            }

            frame.imposeStuff(format: ID3v2CommentsFormat.regular).content = joined

            XCTAssert(tag.comments == [joined])
        }
    }
}
