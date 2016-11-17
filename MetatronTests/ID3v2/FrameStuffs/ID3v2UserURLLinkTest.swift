//
//  ID3v2UserURLLinkTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 06.09.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class ID3v2UserURLLinkTest: XCTestCase {

    // MARK: Instance Methods

    func testCreateClone() {
        let stuff = ID3v2UserURLLink()

        stuff.textEncoding = ID3v2TextEncoding.latin1

        stuff.description = "Abc 123"
        stuff.url = "Abc 456"

        let other = ID3v2UserURLLinkFormat.regular.createStuffSubclass(fromOther: stuff)

        XCTAssert(other.textEncoding == stuff.textEncoding)

        XCTAssert(other.description == stuff.description)
        XCTAssert(other.url == stuff.url)
    }

    func testImposeStuff() {
        let frame = ID3v2Frame(identifier: ID3v2FrameID.wxxx)

        let stuff1 = frame.imposeStuff(format: ID3v2UserURLLinkFormat.regular)
        let stuff2 = frame.imposeStuff(format: ID3v2UserURLLinkFormat.regular)

        XCTAssert(frame.stuff is ID3v2UserURLLink)

        XCTAssert(frame.stuff === stuff1)
        XCTAssert(frame.stuff === stuff2)
    }

    // MARK:

    func testVersion2CaseA() {
        let stuff = ID3v2UserURLLink()

        stuff.textEncoding = ID3v2TextEncoding.latin1

        stuff.description = "Abc 123"
        stuff.url = "Abc 456"

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v2) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2UserURLLink(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.url == stuff.url)
        }

        do {
            let other = ID3v2UserURLLink(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.url == stuff.url)
        }

        do {
            let other = ID3v2UserURLLink(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.url == stuff.url)
        }
    }

    func testVersion2CaseB() {
        let stuff = ID3v2UserURLLink()

        stuff.textEncoding = ID3v2TextEncoding.latin1

        stuff.description = "Абв 123"
        stuff.url = "Абв 456"

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v2) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2UserURLLink(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)

            XCTAssert(other.description != stuff.description)
            XCTAssert(other.url != stuff.url)
        }

        do {
            let other = ID3v2UserURLLink(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)

            XCTAssert(other.description != stuff.description)
            XCTAssert(other.url != stuff.url)
        }

        do {
            let other = ID3v2UserURLLink(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)

            XCTAssert(other.description != stuff.description)
            XCTAssert(other.url != stuff.url)
        }
    }

    func testVersion2CaseC() {
        let stuff = ID3v2UserURLLink()

        stuff.textEncoding = ID3v2TextEncoding.utf16LE

        stuff.description = "Abc 123"
        stuff.url = "Абв 456"

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v2) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2UserURLLink(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.url != stuff.url)
        }

        do {
            let other = ID3v2UserURLLink(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.url != stuff.url)
        }

        do {
            let other = ID3v2UserURLLink(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.url != stuff.url)
        }
    }

    func testVersion2CaseD() {
        let stuff = ID3v2UserURLLink()

        stuff.textEncoding = ID3v2TextEncoding.utf16BE

        stuff.description = ""
        stuff.url = "Abc 123"

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v2) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2UserURLLink(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.url == stuff.url)
        }

        do {
            let other = ID3v2UserURLLink(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.url == stuff.url)
        }

        do {
            let other = ID3v2UserURLLink(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.url == stuff.url)
        }
    }

    func testVersion2CaseE() {
        let stuff = ID3v2UserURLLink()

        stuff.textEncoding = ID3v2TextEncoding.utf8

        stuff.description = "Абв 123"
        stuff.url = "Abc 456"

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v2) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2UserURLLink(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.url == stuff.url)
        }

        do {
            let other = ID3v2UserURLLink(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.url == stuff.url)
        }

        do {
            let other = ID3v2UserURLLink(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.url == stuff.url)
        }
    }

    func testVersion2CaseF() {
        let stuff = ID3v2UserURLLink()

        stuff.textEncoding = ID3v2TextEncoding.utf16

        stuff.description = "Abc 123"
        stuff.url = ""

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.toData(version: ID3v2Version.v2) == nil)
    }

    func testVersion2CaseG() {
        let stuff = ID3v2UserURLLink(fromData: [], version: ID3v2Version.v2)

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.textEncoding == ID3v2TextEncoding.utf8)

        XCTAssert(stuff.description == "")
        XCTAssert(stuff.url == "")

        XCTAssert(stuff.toData(version: ID3v2Version.v2) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v3) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v4) == nil)
    }

    // MARK:

    func testVersion3CaseA() {
        let stuff = ID3v2UserURLLink()

        stuff.textEncoding = ID3v2TextEncoding.latin1

        stuff.description = "Abc 123"
        stuff.url = "Abc 456"

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2UserURLLink(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.url == stuff.url)
        }

        do {
            let other = ID3v2UserURLLink(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.url == stuff.url)
        }

        do {
            let other = ID3v2UserURLLink(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.url == stuff.url)
        }
    }

    func testVersion3CaseB() {
        let stuff = ID3v2UserURLLink()

        stuff.textEncoding = ID3v2TextEncoding.latin1

        stuff.description = "Абв 123"
        stuff.url = "Абв 456"

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2UserURLLink(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)

            XCTAssert(other.description != stuff.description)
            XCTAssert(other.url != stuff.url)
        }

        do {
            let other = ID3v2UserURLLink(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)

            XCTAssert(other.description != stuff.description)
            XCTAssert(other.url != stuff.url)
        }

        do {
            let other = ID3v2UserURLLink(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)

            XCTAssert(other.description != stuff.description)
            XCTAssert(other.url != stuff.url)
        }
    }

    func testVersion3CaseC() {
        let stuff = ID3v2UserURLLink()

        stuff.textEncoding = ID3v2TextEncoding.utf16LE

        stuff.description = "Abc 123"
        stuff.url = "Абв 456"

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2UserURLLink(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.url != stuff.url)
        }

        do {
            let other = ID3v2UserURLLink(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.url != stuff.url)
        }

        do {
            let other = ID3v2UserURLLink(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.url != stuff.url)
        }
    }

    func testVersion3CaseD() {
        let stuff = ID3v2UserURLLink()

        stuff.textEncoding = ID3v2TextEncoding.utf16BE

        stuff.description = ""
        stuff.url = "Abc 123"

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2UserURLLink(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.url == stuff.url)
        }

        do {
            let other = ID3v2UserURLLink(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.url == stuff.url)
        }

        do {
            let other = ID3v2UserURLLink(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.url == stuff.url)
        }
    }

    func testVersion3CaseE() {
        let stuff = ID3v2UserURLLink()

        stuff.textEncoding = ID3v2TextEncoding.utf8

        stuff.description = "Абв 123"
        stuff.url = "Abc 456"

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2UserURLLink(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.url == stuff.url)
        }

        do {
            let other = ID3v2UserURLLink(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.url == stuff.url)
        }

        do {
            let other = ID3v2UserURLLink(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.url == stuff.url)
        }
    }

    func testVersion3CaseF() {
        let stuff = ID3v2UserURLLink()

        stuff.textEncoding = ID3v2TextEncoding.utf16

        stuff.description = "Abc 123"
        stuff.url = ""

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.toData(version: ID3v2Version.v3) == nil)
    }

    func testVersion3CaseG() {
        let stuff = ID3v2UserURLLink(fromData: [], version: ID3v2Version.v3)

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.textEncoding == ID3v2TextEncoding.utf8)

        XCTAssert(stuff.description == "")
        XCTAssert(stuff.url == "")

        XCTAssert(stuff.toData(version: ID3v2Version.v3) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v2) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v4) == nil)
    }

    // MARK:

    func testVersion4CaseA() {
        let stuff = ID3v2UserURLLink()

        stuff.textEncoding = ID3v2TextEncoding.latin1

        stuff.description = "Abc 123"
        stuff.url = "Abc 456"

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v4) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2UserURLLink(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.url == stuff.url)
        }

        do {
            let other = ID3v2UserURLLink(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.url == stuff.url)
        }

        do {
            let other = ID3v2UserURLLink(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.url == stuff.url)
        }
    }

    func testVersion4CaseB() {
        let stuff = ID3v2UserURLLink()

        stuff.textEncoding = ID3v2TextEncoding.latin1

        stuff.description = "Абв 123"
        stuff.url = "Абв 456"

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v4) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2UserURLLink(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)

            XCTAssert(other.description != stuff.description)
            XCTAssert(other.url != stuff.url)
        }

        do {
            let other = ID3v2UserURLLink(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)

            XCTAssert(other.description != stuff.description)
            XCTAssert(other.url != stuff.url)
        }

        do {
            let other = ID3v2UserURLLink(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)

            XCTAssert(other.description != stuff.description)
            XCTAssert(other.url != stuff.url)
        }
    }

    func testVersion4CaseC() {
        let stuff = ID3v2UserURLLink()

        stuff.textEncoding = ID3v2TextEncoding.utf16LE

        stuff.description = "Abc 123"
        stuff.url = "Абв 456"

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v4) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2UserURLLink(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.url != stuff.url)
        }

        do {
            let other = ID3v2UserURLLink(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.url != stuff.url)
        }

        do {
            let other = ID3v2UserURLLink(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.url != stuff.url)
        }
    }

    func testVersion4CaseD() {
        let stuff = ID3v2UserURLLink()

        stuff.textEncoding = ID3v2TextEncoding.utf16BE

        stuff.description = ""
        stuff.url = "Abc 123"

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v4) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2UserURLLink(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.url == stuff.url)
        }

        do {
            let other = ID3v2UserURLLink(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.url == stuff.url)
        }

        do {
            let other = ID3v2UserURLLink(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.url == stuff.url)
        }
    }

    func testVersion4CaseE() {
        let stuff = ID3v2UserURLLink()

        stuff.textEncoding = ID3v2TextEncoding.utf8

        stuff.description = "Абв 123"
        stuff.url = "Abc 456"

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v4) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2UserURLLink(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.url == stuff.url)
        }

        do {
            let other = ID3v2UserURLLink(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.url == stuff.url)
        }

        do {
            let other = ID3v2UserURLLink(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.url == stuff.url)
        }
    }

    func testVersion4CaseF() {
        let stuff = ID3v2UserURLLink()

        stuff.textEncoding = ID3v2TextEncoding.utf16

        stuff.description = "Abc 123"
        stuff.url = ""

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.toData(version: ID3v2Version.v4) == nil)
    }

    func testVersion4CaseG() {
        let stuff = ID3v2UserURLLink(fromData: [], version: ID3v2Version.v4)

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.textEncoding == ID3v2TextEncoding.utf8)

        XCTAssert(stuff.description == "")
        XCTAssert(stuff.url == "")

        XCTAssert(stuff.toData(version: ID3v2Version.v4) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v2) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v3) == nil)
    }
}
