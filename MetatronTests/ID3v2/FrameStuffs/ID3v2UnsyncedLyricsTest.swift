//
//  ID3v2UnsyncedLyricsTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 07.09.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class ID3v2UnsyncedLyricsTest: XCTestCase {

    // MARK: Instance Methods

    func testCreateClone() {
        let stuff = ID3v2UnsyncedLyrics()

        stuff.textEncoding = ID3v2TextEncoding.latin1
        stuff.language = ID3v2Language.eng

        stuff.description = "Abc 123"
        stuff.content = "Abc 456"

        let other = ID3v2UnsyncedLyricsFormat.regular.createStuffSubclass(fromOther: stuff)

        XCTAssert(other.textEncoding == stuff.textEncoding)
        XCTAssert(other.language == stuff.language)

        XCTAssert(other.description == stuff.description)
        XCTAssert(other.content == stuff.content)
    }

    func testImposeStuff() {
        let frame = ID3v2Frame(identifier: ID3v2FrameID.uslt)

        let stuff1 = frame.imposeStuff(format: ID3v2UnsyncedLyricsFormat.regular)
        let stuff2 = frame.imposeStuff(format: ID3v2UnsyncedLyricsFormat.regular)

        XCTAssert(frame.stuff is ID3v2UnsyncedLyrics)

        XCTAssert(frame.stuff === stuff1)
        XCTAssert(frame.stuff === stuff2)
    }

    // MARK:

    func testVersion2CaseA() {
        let stuff = ID3v2UnsyncedLyrics()

        stuff.textEncoding = ID3v2TextEncoding.latin1
        stuff.language = ID3v2Language.und

        stuff.description = "Abc 123"
        stuff.content = "Abc 456"

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v2) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2UnsyncedLyrics(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.content == stuff.content)
        }

        do {
            let other = ID3v2UnsyncedLyrics(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.content == stuff.content)
        }

        do {
            let other = ID3v2UnsyncedLyrics(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.content == stuff.content)
        }
    }

    func testVersion2CaseB() {
        let stuff = ID3v2UnsyncedLyrics()

        stuff.textEncoding = ID3v2TextEncoding.latin1
        stuff.language = ID3v2Language.eng

        stuff.description = "Абв 123"
        stuff.content = "Абв 456"

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v2) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2UnsyncedLyrics(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.description != stuff.description)
            XCTAssert(other.content != stuff.content)
        }

        do {
            let other = ID3v2UnsyncedLyrics(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.description != stuff.description)
            XCTAssert(other.content != stuff.content)
        }

        do {
            let other = ID3v2UnsyncedLyrics(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.description != stuff.description)
            XCTAssert(other.content != stuff.content)
        }
    }

    func testVersion2CaseC() {
        let stuff = ID3v2UnsyncedLyrics()

        stuff.textEncoding = ID3v2TextEncoding.utf16LE

        guard let language = ID3v2Language(code: [65, 66, 67]) else {
            return XCTFail()
        }

        stuff.language = language

        stuff.description = "Abc 123"
        stuff.content = "Abc 456"

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v2) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2UnsyncedLyrics(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.content == stuff.content)
        }

        do {
            let other = ID3v2UnsyncedLyrics(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.content == stuff.content)
        }

        do {
            let other = ID3v2UnsyncedLyrics(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.content == stuff.content)
        }
    }

    func testVersion2CaseD() {
        let stuff = ID3v2UnsyncedLyrics()

        stuff.textEncoding = ID3v2TextEncoding.utf16BE
        stuff.language = ID3v2Language.tat

        stuff.description = ""
        stuff.content = "Abc 123"

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v2) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2UnsyncedLyrics(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.content == stuff.content)
        }

        do {
            let other = ID3v2UnsyncedLyrics(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.content == stuff.content)
        }

        do {
            let other = ID3v2UnsyncedLyrics(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.content == stuff.content)
        }
    }

    func testVersion2CaseE() {
        let stuff = ID3v2UnsyncedLyrics()

        stuff.textEncoding = ID3v2TextEncoding.utf8
        stuff.language = ID3v2Language.rus

        stuff.description = "Абв 123"
        stuff.content = "Абв 456"

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v2) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2UnsyncedLyrics(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.content == stuff.content)
        }

        do {
            let other = ID3v2UnsyncedLyrics(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.content == stuff.content)
        }

        do {
            let other = ID3v2UnsyncedLyrics(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.content == stuff.content)
        }
    }

    func testVersion2CaseF() {
        let stuff = ID3v2UnsyncedLyrics()

        stuff.textEncoding = ID3v2TextEncoding.utf16
        stuff.language = ID3v2Language.und

        stuff.description = ""
        stuff.content = ""

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.toData(version: ID3v2Version.v2) == nil)
    }

    func testVersion2CaseG() {
        let stuff = ID3v2UnsyncedLyrics(fromData: [], version: ID3v2Version.v2)

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.textEncoding == ID3v2TextEncoding.utf8)
        XCTAssert(stuff.language == ID3v2Language.und)

        XCTAssert(stuff.description == "")
        XCTAssert(stuff.content == "")

        XCTAssert(stuff.toData(version: ID3v2Version.v2) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v3) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v4) == nil)
    }

    // MARK:

    func testVersion3CaseA() {
        let stuff = ID3v2UnsyncedLyrics()

        stuff.textEncoding = ID3v2TextEncoding.latin1
        stuff.language = ID3v2Language.und

        stuff.description = "Abc 123"
        stuff.content = "Abc 456"

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2UnsyncedLyrics(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.content == stuff.content)
        }

        do {
            let other = ID3v2UnsyncedLyrics(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.content == stuff.content)
        }

        do {
            let other = ID3v2UnsyncedLyrics(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.content == stuff.content)
        }
    }

    func testVersion3CaseB() {
        let stuff = ID3v2UnsyncedLyrics()

        stuff.textEncoding = ID3v2TextEncoding.latin1
        stuff.language = ID3v2Language.eng

        stuff.description = "Абв 123"
        stuff.content = "Абв 456"

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2UnsyncedLyrics(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.description != stuff.description)
            XCTAssert(other.content != stuff.content)
        }

        do {
            let other = ID3v2UnsyncedLyrics(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.description != stuff.description)
            XCTAssert(other.content != stuff.content)
        }

        do {
            let other = ID3v2UnsyncedLyrics(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.description != stuff.description)
            XCTAssert(other.content != stuff.content)
        }
    }

    func testVersion3CaseC() {
        let stuff = ID3v2UnsyncedLyrics()

        stuff.textEncoding = ID3v2TextEncoding.utf16LE

        guard let language = ID3v2Language(code: [65, 66, 67]) else {
            return XCTFail()
        }

        stuff.language = language

        stuff.description = "Abc 123"
        stuff.content = "Abc 456"

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2UnsyncedLyrics(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.content == stuff.content)
        }

        do {
            let other = ID3v2UnsyncedLyrics(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.content == stuff.content)
        }

        do {
            let other = ID3v2UnsyncedLyrics(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.content == stuff.content)
        }
    }

    func testVersion3CaseD() {
        let stuff = ID3v2UnsyncedLyrics()

        stuff.textEncoding = ID3v2TextEncoding.utf16BE
        stuff.language = ID3v2Language.tat

        stuff.description = ""
        stuff.content = "Abc 123"

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2UnsyncedLyrics(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.content == stuff.content)
        }

        do {
            let other = ID3v2UnsyncedLyrics(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.content == stuff.content)
        }

        do {
            let other = ID3v2UnsyncedLyrics(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.content == stuff.content)
        }
    }

    func testVersion3CaseE() {
        let stuff = ID3v2UnsyncedLyrics()

        stuff.textEncoding = ID3v2TextEncoding.utf8
        stuff.language = ID3v2Language.rus

        stuff.description = "Абв 123"
        stuff.content = "Абв 456"

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2UnsyncedLyrics(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.content == stuff.content)
        }

        do {
            let other = ID3v2UnsyncedLyrics(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.content == stuff.content)
        }

        do {
            let other = ID3v2UnsyncedLyrics(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.content == stuff.content)
        }
    }

    func testVersion3CaseF() {
        let stuff = ID3v2UnsyncedLyrics()

        stuff.textEncoding = ID3v2TextEncoding.utf16
        stuff.language = ID3v2Language.und

        stuff.description = ""
        stuff.content = ""

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.toData(version: ID3v2Version.v3) == nil)
    }

    func testVersion3CaseG() {
        let stuff = ID3v2UnsyncedLyrics(fromData: [], version: ID3v2Version.v3)

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.textEncoding == ID3v2TextEncoding.utf8)
        XCTAssert(stuff.language == ID3v2Language.und)

        XCTAssert(stuff.description == "")
        XCTAssert(stuff.content == "")

        XCTAssert(stuff.toData(version: ID3v2Version.v3) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v2) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v4) == nil)
    }

    // MARK:

    func testVersion4CaseA() {
        let stuff = ID3v2UnsyncedLyrics()

        stuff.textEncoding = ID3v2TextEncoding.latin1
        stuff.language = ID3v2Language.und

        stuff.description = "Abc 123"
        stuff.content = "Abc 456"

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v4) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2UnsyncedLyrics(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.content == stuff.content)
        }

        do {
            let other = ID3v2UnsyncedLyrics(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.content == stuff.content)
        }

        do {
            let other = ID3v2UnsyncedLyrics(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.content == stuff.content)
        }
    }

    func testVersion4CaseB() {
        let stuff = ID3v2UnsyncedLyrics()

        stuff.textEncoding = ID3v2TextEncoding.latin1
        stuff.language = ID3v2Language.eng

        stuff.description = "Абв 123"
        stuff.content = "Абв 456"

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v4) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2UnsyncedLyrics(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.description != stuff.description)
            XCTAssert(other.content != stuff.content)
        }

        do {
            let other = ID3v2UnsyncedLyrics(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.description != stuff.description)
            XCTAssert(other.content != stuff.content)
        }

        do {
            let other = ID3v2UnsyncedLyrics(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.description != stuff.description)
            XCTAssert(other.content != stuff.content)
        }
    }

    func testVersion4CaseC() {
        let stuff = ID3v2UnsyncedLyrics()

        stuff.textEncoding = ID3v2TextEncoding.utf16LE

        guard let language = ID3v2Language(code: [65, 66, 67]) else {
            return XCTFail()
        }

        stuff.language = language

        stuff.description = "Abc 123"
        stuff.content = "Abc 456"

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v4) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2UnsyncedLyrics(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.content == stuff.content)
        }

        do {
            let other = ID3v2UnsyncedLyrics(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.content == stuff.content)
        }

        do {
            let other = ID3v2UnsyncedLyrics(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.content == stuff.content)
        }
    }

    func testVersion4CaseD() {
        let stuff = ID3v2UnsyncedLyrics()

        stuff.textEncoding = ID3v2TextEncoding.utf16BE
        stuff.language = ID3v2Language.tat

        stuff.description = ""
        stuff.content = "Abc 123"

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v4) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2UnsyncedLyrics(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.content == stuff.content)
        }

        do {
            let other = ID3v2UnsyncedLyrics(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.content == stuff.content)
        }

        do {
            let other = ID3v2UnsyncedLyrics(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.content == stuff.content)
        }
    }

    func testVersion4CaseE() {
        let stuff = ID3v2UnsyncedLyrics()

        stuff.textEncoding = ID3v2TextEncoding.utf8
        stuff.language = ID3v2Language.rus

        stuff.description = "Абв 123"
        stuff.content = "Абв 456"

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v4) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2UnsyncedLyrics(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.content == stuff.content)
        }

        do {
            let other = ID3v2UnsyncedLyrics(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.content == stuff.content)
        }

        do {
            let other = ID3v2UnsyncedLyrics(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.description == stuff.description)
            XCTAssert(other.content == stuff.content)
        }
    }

    func testVersion4CaseF() {
        let stuff = ID3v2UnsyncedLyrics()

        stuff.textEncoding = ID3v2TextEncoding.utf16
        stuff.language = ID3v2Language.und

        stuff.description = ""
        stuff.content = ""

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.toData(version: ID3v2Version.v4) == nil)
    }

    func testVersion4CaseG() {
        let stuff = ID3v2UnsyncedLyrics(fromData: [], version: ID3v2Version.v4)

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.textEncoding == ID3v2TextEncoding.utf8)
        XCTAssert(stuff.language == ID3v2Language.und)

        XCTAssert(stuff.description == "")
        XCTAssert(stuff.content == "")

        XCTAssert(stuff.toData(version: ID3v2Version.v4) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v2) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v3) == nil)
    }
}
