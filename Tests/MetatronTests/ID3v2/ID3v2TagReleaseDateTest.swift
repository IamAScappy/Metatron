//
//  ID3v2TagReleaseDateTest.swift
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

class ID3v2TagReleaseDateTest: XCTestCase {

    // MARK: Instance Methods

    func test() {
        let tag = ID3v2Tag()

        do {
            let value = TagDate()

            tag.releaseDate = value

            XCTAssert(tag.releaseDate == value.revised)

            let frame = tag.appendFrameSet(ID3v2FrameID.tdrc).mainFrame

            let yearFrame = tag.appendFrameSet(ID3v2FrameID.tyer).mainFrame
            let dayFrame = tag.appendFrameSet(ID3v2FrameID.tdat).mainFrame
            let timeFrame = tag.appendFrameSet(ID3v2FrameID.time).mainFrame

            XCTAssert(frame.stuff == nil)

            XCTAssert(yearFrame.stuff == nil)
            XCTAssert(dayFrame.stuff == nil)
            XCTAssert(timeFrame.stuff == nil)

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

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).dateValue = value

            XCTAssert(tag.releaseDate == TagDate())
        }

        do {
            let value = TagDate(year: 10000)

            tag.releaseDate = value

            XCTAssert(tag.releaseDate == value.revised)

            let frame = tag.appendFrameSet(ID3v2FrameID.tdrc).mainFrame

            let yearFrame = tag.appendFrameSet(ID3v2FrameID.tyer).mainFrame
            let dayFrame = tag.appendFrameSet(ID3v2FrameID.tdat).mainFrame
            let timeFrame = tag.appendFrameSet(ID3v2FrameID.time).mainFrame

            XCTAssert(frame.stuff == nil)

            XCTAssert(yearFrame.stuff == nil)
            XCTAssert(dayFrame.stuff == nil)
            XCTAssert(timeFrame.stuff == nil)

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

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).dateValue = value

            XCTAssert(tag.releaseDate == TagDate())
        }

        do {
            let value = TagDate(year: 1998, month: 0)

            tag.releaseDate = value

            XCTAssert(tag.releaseDate == value.revised)

            let frame = tag.appendFrameSet(ID3v2FrameID.tdrc).mainFrame

            let yearFrame = tag.appendFrameSet(ID3v2FrameID.tyer).mainFrame
            let dayFrame = tag.appendFrameSet(ID3v2FrameID.tdat).mainFrame
            let timeFrame = tag.appendFrameSet(ID3v2FrameID.time).mainFrame

            XCTAssert(frame.stuff(format: ID3v2TextInformationFormat.regular).dateValue == value.revised)

            XCTAssert(yearFrame.stuff(format: ID3v2TextInformationFormat.regular).fields == ["1998"])
            XCTAssert(dayFrame.stuff == nil)
            XCTAssert(timeFrame.stuff == nil)

            do {
                tag.version = ID3v2Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.releaseDate == value.revised)
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.releaseDate == value.revised)
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.releaseDate == value.revised)
            }

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).dateValue = value

            XCTAssert(tag.releaseDate == TagDate())
        }

        do {
            let value = TagDate(year: 1998, month: 13)

            tag.releaseDate = value

            XCTAssert(tag.releaseDate == value.revised)

            let frame = tag.appendFrameSet(ID3v2FrameID.tdrc).mainFrame

            let yearFrame = tag.appendFrameSet(ID3v2FrameID.tyer).mainFrame
            let dayFrame = tag.appendFrameSet(ID3v2FrameID.tdat).mainFrame
            let timeFrame = tag.appendFrameSet(ID3v2FrameID.time).mainFrame

            XCTAssert(frame.stuff(format: ID3v2TextInformationFormat.regular).dateValue == value.revised)

            XCTAssert(yearFrame.stuff(format: ID3v2TextInformationFormat.regular).fields == ["1998"])
            XCTAssert(dayFrame.stuff == nil)
            XCTAssert(timeFrame.stuff == nil)

            do {
                tag.version = ID3v2Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.releaseDate == value.revised)
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.releaseDate == value.revised)
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.releaseDate == value.revised)
            }

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).dateValue = value

            XCTAssert(tag.releaseDate == TagDate())
        }

        do {
            let value = TagDate(year: 1998, month: 12, day: 0)

            tag.releaseDate = value

            XCTAssert(tag.releaseDate == value.revised)

            let frame = tag.appendFrameSet(ID3v2FrameID.tdrc).mainFrame

            let yearFrame = tag.appendFrameSet(ID3v2FrameID.tyer).mainFrame
            let dayFrame = tag.appendFrameSet(ID3v2FrameID.tdat).mainFrame
            let timeFrame = tag.appendFrameSet(ID3v2FrameID.time).mainFrame

            XCTAssert(frame.stuff(format: ID3v2TextInformationFormat.regular).dateValue == value.revised)

            XCTAssert(yearFrame.stuff(format: ID3v2TextInformationFormat.regular).fields == ["1998"])
            XCTAssert(dayFrame.stuff(format: ID3v2TextInformationFormat.regular).fields == ["0112"])
            XCTAssert(timeFrame.stuff == nil)

            do {
                tag.version = ID3v2Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.releaseDate == value.revised)
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.releaseDate == value.revised)
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.releaseDate == value.revised)
            }

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).dateValue = value

            XCTAssert(tag.releaseDate == TagDate())
        }

        do {
            let value = TagDate(year: 1998, month: 12, day: 32)

            tag.releaseDate = value

            XCTAssert(tag.releaseDate == value.revised)

            let frame = tag.appendFrameSet(ID3v2FrameID.tdrc).mainFrame

            let yearFrame = tag.appendFrameSet(ID3v2FrameID.tyer).mainFrame
            let dayFrame = tag.appendFrameSet(ID3v2FrameID.tdat).mainFrame
            let timeFrame = tag.appendFrameSet(ID3v2FrameID.time).mainFrame

            XCTAssert(frame.stuff(format: ID3v2TextInformationFormat.regular).dateValue == value.revised)

            XCTAssert(yearFrame.stuff(format: ID3v2TextInformationFormat.regular).fields == ["1998"])
            XCTAssert(dayFrame.stuff(format: ID3v2TextInformationFormat.regular).fields == ["0112"])
            XCTAssert(timeFrame.stuff == nil)

            do {
                tag.version = ID3v2Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.releaseDate == value.revised)
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.releaseDate == value.revised)
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.releaseDate == value.revised)
            }

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).dateValue = value

            XCTAssert(tag.releaseDate == TagDate())
        }

        do {
            let value = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: -1))

            tag.releaseDate = value

            XCTAssert(tag.releaseDate == value.revised)

            let frame = tag.appendFrameSet(ID3v2FrameID.tdrc).mainFrame

            let yearFrame = tag.appendFrameSet(ID3v2FrameID.tyer).mainFrame
            let dayFrame = tag.appendFrameSet(ID3v2FrameID.tdat).mainFrame
            let timeFrame = tag.appendFrameSet(ID3v2FrameID.time).mainFrame

            XCTAssert(frame.stuff(format: ID3v2TextInformationFormat.regular).dateValue == value.revised)

            XCTAssert(yearFrame.stuff(format: ID3v2TextInformationFormat.regular).fields == ["1998"])
            XCTAssert(dayFrame.stuff(format: ID3v2TextInformationFormat.regular).fields == ["3112"])
            XCTAssert(timeFrame.stuff == nil)

            do {
                tag.version = ID3v2Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.releaseDate == value.revised)
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.releaseDate == value.revised)
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.releaseDate == value.revised)
            }

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).dateValue = value

            XCTAssert(tag.releaseDate == TagDate())
        }

        do {
            let value = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 24))

            tag.releaseDate = value

            XCTAssert(tag.releaseDate == value.revised)

            let frame = tag.appendFrameSet(ID3v2FrameID.tdrc).mainFrame

            let yearFrame = tag.appendFrameSet(ID3v2FrameID.tyer).mainFrame
            let dayFrame = tag.appendFrameSet(ID3v2FrameID.tdat).mainFrame
            let timeFrame = tag.appendFrameSet(ID3v2FrameID.time).mainFrame

            XCTAssert(frame.stuff(format: ID3v2TextInformationFormat.regular).dateValue == value.revised)

            XCTAssert(yearFrame.stuff(format: ID3v2TextInformationFormat.regular).fields == ["1998"])
            XCTAssert(dayFrame.stuff(format: ID3v2TextInformationFormat.regular).fields == ["3112"])
            XCTAssert(timeFrame.stuff == nil)

            do {
                tag.version = ID3v2Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.releaseDate == value.revised)
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.releaseDate == value.revised)
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.releaseDate == value.revised)
            }

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).dateValue = value

            XCTAssert(tag.releaseDate == TagDate())
        }

        do {
            let value = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: -1))

            tag.releaseDate = value

            XCTAssert(tag.releaseDate == value.revised)

            let frame = tag.appendFrameSet(ID3v2FrameID.tdrc).mainFrame

            let yearFrame = tag.appendFrameSet(ID3v2FrameID.tyer).mainFrame
            let dayFrame = tag.appendFrameSet(ID3v2FrameID.tdat).mainFrame
            let timeFrame = tag.appendFrameSet(ID3v2FrameID.time).mainFrame

            XCTAssert(frame.stuff(format: ID3v2TextInformationFormat.regular).dateValue == value.revised)

            XCTAssert(yearFrame.stuff(format: ID3v2TextInformationFormat.regular).fields == ["1998"])
            XCTAssert(dayFrame.stuff(format: ID3v2TextInformationFormat.regular).fields == ["3112"])
            XCTAssert(timeFrame.stuff(format: ID3v2TextInformationFormat.regular).fields == ["1200"])

            do {
                tag.version = ID3v2Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.releaseDate == value.revised)
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.releaseDate == value.revised)
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.releaseDate == value.revised)
            }

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).dateValue = value

            XCTAssert(tag.releaseDate == TagDate())
        }

        do {
            let value = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: 60))

            tag.releaseDate = value

            XCTAssert(tag.releaseDate == value.revised)

            let frame = tag.appendFrameSet(ID3v2FrameID.tdrc).mainFrame

            let yearFrame = tag.appendFrameSet(ID3v2FrameID.tyer).mainFrame
            let dayFrame = tag.appendFrameSet(ID3v2FrameID.tdat).mainFrame
            let timeFrame = tag.appendFrameSet(ID3v2FrameID.time).mainFrame

            XCTAssert(frame.stuff(format: ID3v2TextInformationFormat.regular).dateValue == value.revised)

            XCTAssert(yearFrame.stuff(format: ID3v2TextInformationFormat.regular).fields == ["1998"])
            XCTAssert(dayFrame.stuff(format: ID3v2TextInformationFormat.regular).fields == ["3112"])
            XCTAssert(timeFrame.stuff(format: ID3v2TextInformationFormat.regular).fields == ["1200"])

            do {
                tag.version = ID3v2Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.releaseDate == value.revised)
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.releaseDate == value.revised)
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.releaseDate == value.revised)
            }

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).dateValue = value

            XCTAssert(tag.releaseDate == TagDate())
        }

        do {
            let value = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: 34, second: -1))

            tag.releaseDate = value

            XCTAssert(tag.releaseDate == value.revised)

            let frame = tag.appendFrameSet(ID3v2FrameID.tdrc).mainFrame

            let yearFrame = tag.appendFrameSet(ID3v2FrameID.tyer).mainFrame
            let dayFrame = tag.appendFrameSet(ID3v2FrameID.tdat).mainFrame
            let timeFrame = tag.appendFrameSet(ID3v2FrameID.time).mainFrame

            XCTAssert(frame.stuff(format: ID3v2TextInformationFormat.regular).dateValue == value.revised)

            XCTAssert(yearFrame.stuff(format: ID3v2TextInformationFormat.regular).fields == ["1998"])
            XCTAssert(dayFrame.stuff(format: ID3v2TextInformationFormat.regular).fields == ["3112"])
            XCTAssert(timeFrame.stuff(format: ID3v2TextInformationFormat.regular).fields == ["1234"])

            do {
                tag.version = ID3v2Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.releaseDate == value.revised)
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.releaseDate == value.revised)
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.releaseDate == value.revised)
            }

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).dateValue = value

            XCTAssert(tag.releaseDate == TagDate())
        }

        do {
            let value = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: 34, second: 60))

            tag.releaseDate = value

            XCTAssert(tag.releaseDate == value.revised)

            let frame = tag.appendFrameSet(ID3v2FrameID.tdrc).mainFrame

            let yearFrame = tag.appendFrameSet(ID3v2FrameID.tyer).mainFrame
            let dayFrame = tag.appendFrameSet(ID3v2FrameID.tdat).mainFrame
            let timeFrame = tag.appendFrameSet(ID3v2FrameID.time).mainFrame

            XCTAssert(frame.stuff(format: ID3v2TextInformationFormat.regular).dateValue == value.revised)

            XCTAssert(yearFrame.stuff(format: ID3v2TextInformationFormat.regular).fields == ["1998"])
            XCTAssert(dayFrame.stuff(format: ID3v2TextInformationFormat.regular).fields == ["3112"])
            XCTAssert(timeFrame.stuff(format: ID3v2TextInformationFormat.regular).fields == ["1234"])

            do {
                tag.version = ID3v2Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.releaseDate == value.revised)
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.releaseDate == value.revised)
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.releaseDate == value.revised)
            }

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).dateValue = value

            XCTAssert(tag.releaseDate == TagDate())
        }

        do {
            let value = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: 34, second: 56))

            tag.releaseDate = value

            XCTAssert(tag.releaseDate == value.revised)

            let frame = tag.appendFrameSet(ID3v2FrameID.tdrc).mainFrame

            let yearFrame = tag.appendFrameSet(ID3v2FrameID.tyer).mainFrame
            let dayFrame = tag.appendFrameSet(ID3v2FrameID.tdat).mainFrame
            let timeFrame = tag.appendFrameSet(ID3v2FrameID.time).mainFrame

            XCTAssert(frame.stuff(format: ID3v2TextInformationFormat.regular).dateValue == value.revised)

            XCTAssert(yearFrame.stuff(format: ID3v2TextInformationFormat.regular).fields == ["1998"])
            XCTAssert(dayFrame.stuff(format: ID3v2TextInformationFormat.regular).fields == ["3112"])
            XCTAssert(timeFrame.stuff(format: ID3v2TextInformationFormat.regular).fields == ["1234"])

            do {
                tag.version = ID3v2Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.releaseDate == TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: 34)))
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.releaseDate == TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: 34)))
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.releaseDate == value.revised)
            }

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).dateValue = value

            XCTAssert(tag.releaseDate == value)
        }

        do {

            let frame = tag.appendFrameSet(ID3v2FrameID.tdrc).mainFrame

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = ["1998"]

            XCTAssert(tag.releaseDate == TagDate(year: 1998))
        }

        do {
            let frame = tag.appendFrameSet(ID3v2FrameID.tdrc).mainFrame

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = ["1998-12"]

            XCTAssert(tag.releaseDate == TagDate(year: 1998, month: 12))
        }

        do {
            let frame = tag.appendFrameSet(ID3v2FrameID.tdrc).mainFrame

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = ["1998-12-31"]

            XCTAssert(tag.releaseDate == TagDate(year: 1998, month: 12, day: 31))
        }

        do {
            let frame = tag.appendFrameSet(ID3v2FrameID.tdrc).mainFrame

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = ["1998-12-31T12"]

            let time = TagTime(hour: 12)

            XCTAssert(tag.releaseDate == TagDate(year: 1998, month: 12, day: 31, time: time))
        }

        do {
            let frame = tag.appendFrameSet(ID3v2FrameID.tdrc).mainFrame

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = ["1998-12-31T12:34"]

            let time = TagTime(hour: 12, minute: 34)

            XCTAssert(tag.releaseDate == TagDate(year: 1998, month: 12, day: 31, time: time))
        }

        do {
            let frame = tag.appendFrameSet(ID3v2FrameID.tdrc).mainFrame

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = ["1998-12-31T12:34:56"]

            let time = TagTime(hour: 12, minute: 34, second: 56)

            XCTAssert(tag.releaseDate == TagDate(year: 1998, month: 12, day: 31, time: time))
        }

        do {
            let frame = tag.appendFrameSet(ID3v2FrameID.tdrc).mainFrame

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = ["1998-12-31 12"]

            let time = TagTime(hour: 12)

            XCTAssert(tag.releaseDate == TagDate(year: 1998, month: 12, day: 31, time: time))
        }

        do {
            let frame = tag.appendFrameSet(ID3v2FrameID.tdrc).mainFrame

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = ["1998-12-31 12:34"]

            let time = TagTime(hour: 12, minute: 34)

            XCTAssert(tag.releaseDate == TagDate(year: 1998, month: 12, day: 31, time: time))
        }

        do {
            let frame = tag.appendFrameSet(ID3v2FrameID.tdrc).mainFrame

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = ["1998-12-31 12:34:56"]

            let time = TagTime(hour: 12, minute: 34, second: 56)

            XCTAssert(tag.releaseDate == TagDate(year: 1998, month: 12, day: 31, time: time))
        }

        do {
            let frame = tag.appendFrameSet(ID3v2FrameID.tdrc).mainFrame

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = ["1998-99"]

            XCTAssert(tag.releaseDate == TagDate(year: 1998))
        }

        do {
            let frame = tag.appendFrameSet(ID3v2FrameID.tdrc).mainFrame

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = ["1998-12-99"]

            XCTAssert(tag.releaseDate == TagDate(year: 1998, month: 12))
        }

        do {
            let frame = tag.appendFrameSet(ID3v2FrameID.tdrc).mainFrame

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = ["1998-12-31T99"]

            XCTAssert(tag.releaseDate == TagDate(year: 1998, month: 12, day: 31))
        }

        do {
            let frame = tag.appendFrameSet(ID3v2FrameID.tdrc).mainFrame

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = ["1998-12-31T12:99"]

            let time = TagTime(hour: 12)

            XCTAssert(tag.releaseDate == TagDate(year: 1998, month: 12, day: 31, time: time))
        }

        do {
            let frame = tag.appendFrameSet(ID3v2FrameID.tdrc).mainFrame

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = ["1998-12-31T12:34:99"]

            let time = TagTime(hour: 12, minute: 34)

            XCTAssert(tag.releaseDate == TagDate(year: 1998, month: 12, day: 31, time: time))
        }

        do {
            let frame = tag.appendFrameSet(ID3v2FrameID.tdrc).mainFrame

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = ["9999-99-99T99:99:99"]

            XCTAssert(tag.releaseDate == TagDate(year: 9999))
        }
    }
}
