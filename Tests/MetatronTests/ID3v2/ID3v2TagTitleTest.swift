//
//  ID3v2TagTitleTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 03.10.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class ID3v2TagTitleTest: XCTestCase {

    // MARK: Instance Methods

    func test() {
        let tag = ID3v2Tag()

        do {
            let value = ""

            tag.title = value

            XCTAssert(tag.title == value)

            let frame = tag.appendFrameSet(ID3v2FrameID.tit2).mainFrame

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

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = [value]

            XCTAssert(tag.title == value)
        }

        do {
            let value = "Abc 123"

            tag.title = value

            XCTAssert(tag.title == value)

            let frame = tag.appendFrameSet(ID3v2FrameID.tit2).mainFrame

            XCTAssert(frame.stuff(format: ID3v2TextInformationFormat.regular).fields == [value])

            do {
                tag.version = ID3v2Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.title == value)
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.title == value)
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.title == value)
            }

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = [value]

            XCTAssert(tag.title == value)
        }

        do {
            let value = "Абв 123"

            tag.title = value

            XCTAssert(tag.title == value)

            let frame = tag.appendFrameSet(ID3v2FrameID.tit2).mainFrame

            XCTAssert(frame.stuff(format: ID3v2TextInformationFormat.regular).fields == [value])

            do {
                tag.version = ID3v2Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.title == value)
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.title == value)
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.title == value)
            }

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = [value]

            XCTAssert(tag.title == value)
        }

        do {
            let value = Array<String>(repeating: "Abc", count: 123).joined(separator: "\n")

            tag.title = value

            XCTAssert(tag.title == value)

            let frame = tag.appendFrameSet(ID3v2FrameID.tit2).mainFrame

            XCTAssert(frame.stuff(format: ID3v2TextInformationFormat.regular).fields == [value])

            do {
                tag.version = ID3v2Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.title == value)
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.title == value)
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.title == value)
            }

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = [value]

            XCTAssert(tag.title == value)
        }

        let frame = tag.appendFrameSet(ID3v2FrameID.tit2).mainFrame

        do {
            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = ["Abc 1", "Abc 2"]

            XCTAssert(tag.title == "Abc 1")
        }

        do {
            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = ["", "Abc 2"]

            XCTAssert(tag.title == "")
        }

        do {
            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = ["Abc 1", ""]

            XCTAssert(tag.title == "Abc 1")
        }

        do {
            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = ["", ""]

            XCTAssert(tag.title == "")
        }
    }
}
