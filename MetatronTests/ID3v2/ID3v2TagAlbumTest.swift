//
//  ID3v2TagAlbumTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 03.10.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class ID3v2TagAlbumTest: XCTestCase {

    // MARK: Instance Methods

    func test() {
        let tag = ID3v2Tag()

        do {
            let value = ""

            tag.album = value

            XCTAssert(tag.album == value)

            let frame = tag.appendFrameSet(ID3v2FrameID.talb).mainFrame

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

            XCTAssert(tag.album == value)
        }

        do {
            let value = "Abc 123"

            tag.album = value

            XCTAssert(tag.album == value)

            let frame = tag.appendFrameSet(ID3v2FrameID.talb).mainFrame

            XCTAssert(frame.stuff(format: ID3v2TextInformationFormat.regular).fields == [value])

            do {
                tag.version = ID3v2Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.album == value)
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.album == value)
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.album == value)
            }

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = [value]

            XCTAssert(tag.album == value)
        }

        do {
            let value = "Абв 123"

            tag.album = value

            XCTAssert(tag.album == value)

            let frame = tag.appendFrameSet(ID3v2FrameID.talb).mainFrame

            XCTAssert(frame.stuff(format: ID3v2TextInformationFormat.regular).fields == [value])

            do {
                tag.version = ID3v2Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.album == value)
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.album == value)
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.album == value)
            }

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = [value]

            XCTAssert(tag.album == value)
        }

        do {
            let value = Array<String>(repeating: "Abc", count: 123).joined(separator: "\n")

            tag.album = value

            XCTAssert(tag.album == value)

            let frame = tag.appendFrameSet(ID3v2FrameID.talb).mainFrame

            XCTAssert(frame.stuff(format: ID3v2TextInformationFormat.regular).fields == [value])

            do {
                tag.version = ID3v2Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.album == value)
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.album == value)
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.album == value)
            }

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = [value]

            XCTAssert(tag.album == value)
        }

        let frame = tag.appendFrameSet(ID3v2FrameID.talb).mainFrame

        do {
            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = ["Abc 1", "Abc 2"]

            XCTAssert(tag.album == "Abc 1")
        }

        do {
            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = ["", "Abc 2"]

            XCTAssert(tag.album == "")
        }

        do {
            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = ["Abc 1", ""]

            XCTAssert(tag.album == "Abc 1")
        }

        do {
            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = ["", ""]

            XCTAssert(tag.album == "")
        }
    }
}
