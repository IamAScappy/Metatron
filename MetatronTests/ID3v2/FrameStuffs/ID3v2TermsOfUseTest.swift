//
//  ID3v2TermsOfUseTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 08.09.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class ID3v2TermsOfUseTest: XCTestCase {

    // MARK: Instance Methods

    func testCreateClone() {
        let stuff = ID3v2TermsOfUse()

        stuff.textEncoding = ID3v2TextEncoding.latin1
        stuff.language = ID3v2Language.eng

        stuff.text = "Abc 123"

        let other = ID3v2TermsOfUseFormat.regular.createStuffSubclass(fromOther: stuff)

        XCTAssert(other.textEncoding == stuff.textEncoding)
        XCTAssert(other.language == stuff.language)

        XCTAssert(other.text == stuff.text)
    }

    func testImposeStuff() {
        let frame = ID3v2Frame(identifier: ID3v2FrameID.user)

        let stuff1 = frame.imposeStuff(format: ID3v2TermsOfUseFormat.regular)
        let stuff2 = frame.imposeStuff(format: ID3v2TermsOfUseFormat.regular)

        XCTAssert(frame.stuff is ID3v2TermsOfUse)

        XCTAssert(frame.stuff === stuff1)
        XCTAssert(frame.stuff === stuff2)
    }

    // MARK:

    func testVersion2CaseA() {
        let stuff = ID3v2TermsOfUse()

        stuff.textEncoding = ID3v2TextEncoding.latin1
        stuff.language = ID3v2Language.und

        stuff.text = "Abc 123"

        XCTAssert(!stuff.isEmpty)

        XCTAssert(stuff.toData(version: ID3v2Version.v2) == nil)
    }

    func testVersion2CaseB() {
        let stuff = ID3v2TermsOfUse()

        stuff.textEncoding = ID3v2TextEncoding.latin1
        stuff.language = ID3v2Language.eng

        stuff.text = "Абв 123"

        XCTAssert(!stuff.isEmpty)

        XCTAssert(stuff.toData(version: ID3v2Version.v2) == nil)
    }

    func testVersion2CaseC() {
        let stuff = ID3v2TermsOfUse()

        stuff.textEncoding = ID3v2TextEncoding.utf16LE

        guard let language = ID3v2Language(code: [65, 66, 67]) else {
            return XCTFail()
        }

        stuff.language = language

        stuff.text = "Abc 123"

        XCTAssert(!stuff.isEmpty)

        XCTAssert(stuff.toData(version: ID3v2Version.v2) == nil)
    }

    func testVersion2CaseD() {
        let stuff = ID3v2TermsOfUse()

        stuff.textEncoding = ID3v2TextEncoding.utf16BE
        stuff.language = ID3v2Language.tat

        stuff.text = "Abc 123"

        XCTAssert(!stuff.isEmpty)

        XCTAssert(stuff.toData(version: ID3v2Version.v2) == nil)
    }

    func testVersion2CaseE() {
        let stuff = ID3v2TermsOfUse()

        stuff.textEncoding = ID3v2TextEncoding.utf8
        stuff.language = ID3v2Language.rus

        stuff.text = "Абв 123"

        XCTAssert(!stuff.isEmpty)

        XCTAssert(stuff.toData(version: ID3v2Version.v2) == nil)
    }

    func testVersion2CaseF() {
        let stuff = ID3v2TermsOfUse()

        stuff.textEncoding = ID3v2TextEncoding.utf16
        stuff.language = ID3v2Language.und

        stuff.text = ""

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.toData(version: ID3v2Version.v2) == nil)
    }

    func testVersion2CaseG() {
        let stuff = ID3v2TermsOfUse(fromData: [], version: ID3v2Version.v2)

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.textEncoding == ID3v2TextEncoding.utf8)
        XCTAssert(stuff.language == ID3v2Language.und)

        XCTAssert(stuff.text == "")

        XCTAssert(stuff.toData(version: ID3v2Version.v2) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v3) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v4) == nil)
    }

    // MARK:

    func testVersion3CaseA() {
        let stuff = ID3v2TermsOfUse()

        stuff.textEncoding = ID3v2TextEncoding.latin1
        stuff.language = ID3v2Language.und

        stuff.text = "Abc 123"

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2TermsOfUse(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.text == stuff.text)
        }

        do {
            let other = ID3v2TermsOfUse(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.text == stuff.text)
        }

        do {
            let other = ID3v2TermsOfUse(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.text == stuff.text)
        }
    }

    func testVersion3CaseB() {
        let stuff = ID3v2TermsOfUse()

        stuff.textEncoding = ID3v2TextEncoding.latin1
        stuff.language = ID3v2Language.eng

        stuff.text = "Абв 123"

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2TermsOfUse(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.text != stuff.text)
        }

        do {
            let other = ID3v2TermsOfUse(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.text != stuff.text)
        }

        do {
            let other = ID3v2TermsOfUse(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.text != stuff.text)
        }
    }

    func testVersion3CaseC() {
        let stuff = ID3v2TermsOfUse()

        stuff.textEncoding = ID3v2TextEncoding.utf16LE

        guard let language = ID3v2Language(code: [65, 66, 67]) else {
            return XCTFail()
        }

        stuff.language = language

        stuff.text = "Abc 123"

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2TermsOfUse(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.text == stuff.text)
        }

        do {
            let other = ID3v2TermsOfUse(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.text == stuff.text)
        }

        do {
            let other = ID3v2TermsOfUse(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.text == stuff.text)
        }
    }

    func testVersion3CaseD() {
        let stuff = ID3v2TermsOfUse()

        stuff.textEncoding = ID3v2TextEncoding.utf16BE
        stuff.language = ID3v2Language.tat

        stuff.text = "Abc 123"

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2TermsOfUse(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.text == stuff.text)
        }

        do {
            let other = ID3v2TermsOfUse(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.text == stuff.text)
        }

        do {
            let other = ID3v2TermsOfUse(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.text == stuff.text)
        }
    }

    func testVersion3CaseE() {
        let stuff = ID3v2TermsOfUse()

        stuff.textEncoding = ID3v2TextEncoding.utf8
        stuff.language = ID3v2Language.rus

        stuff.text = "Абв 123"

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2TermsOfUse(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.text == stuff.text)
        }

        do {
            let other = ID3v2TermsOfUse(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.text == stuff.text)
        }

        do {
            let other = ID3v2TermsOfUse(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.text == stuff.text)
        }
    }

    func testVersion3CaseF() {
        let stuff = ID3v2TermsOfUse()

        stuff.textEncoding = ID3v2TextEncoding.utf16
        stuff.language = ID3v2Language.und

        stuff.text = ""

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.toData(version: ID3v2Version.v3) == nil)
    }

    func testVersion3CaseG() {
        let stuff = ID3v2TermsOfUse(fromData: [], version: ID3v2Version.v3)

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.textEncoding == ID3v2TextEncoding.utf8)
        XCTAssert(stuff.language == ID3v2Language.und)

        XCTAssert(stuff.text == "")

        XCTAssert(stuff.toData(version: ID3v2Version.v3) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v2) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v4) == nil)
    }

    // MARK:

    func testVersion4CaseA() {
        let stuff = ID3v2TermsOfUse()

        stuff.textEncoding = ID3v2TextEncoding.latin1
        stuff.language = ID3v2Language.und

        stuff.text = "Abc 123"

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v4) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2TermsOfUse(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.text == stuff.text)
        }

        do {
            let other = ID3v2TermsOfUse(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.text == stuff.text)
        }

        do {
            let other = ID3v2TermsOfUse(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.text == stuff.text)
        }
    }

    func testVersion4CaseB() {
        let stuff = ID3v2TermsOfUse()

        stuff.textEncoding = ID3v2TextEncoding.latin1
        stuff.language = ID3v2Language.eng

        stuff.text = "Абв 123"

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v4) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2TermsOfUse(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.text != stuff.text)
        }

        do {
            let other = ID3v2TermsOfUse(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.text != stuff.text)
        }

        do {
            let other = ID3v2TermsOfUse(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.text != stuff.text)
        }
    }

    func testVersion4CaseC() {
        let stuff = ID3v2TermsOfUse()

        stuff.textEncoding = ID3v2TextEncoding.utf16LE

        guard let language = ID3v2Language(code: [65, 66, 67]) else {
            return XCTFail()
        }

        stuff.language = language

        stuff.text = "Abc 123"

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v4) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2TermsOfUse(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.text == stuff.text)
        }

        do {
            let other = ID3v2TermsOfUse(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.text == stuff.text)
        }

        do {
            let other = ID3v2TermsOfUse(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.text == stuff.text)
        }
    }

    func testVersion4CaseD() {
        let stuff = ID3v2TermsOfUse()

        stuff.textEncoding = ID3v2TextEncoding.utf16BE
        stuff.language = ID3v2Language.tat

        stuff.text = "Abc 123"

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v4) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2TermsOfUse(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.text == stuff.text)
        }

        do {
            let other = ID3v2TermsOfUse(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.text == stuff.text)
        }

        do {
            let other = ID3v2TermsOfUse(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.text == stuff.text)
        }
    }

    func testVersion4CaseE() {
        let stuff = ID3v2TermsOfUse()

        stuff.textEncoding = ID3v2TextEncoding.utf8
        stuff.language = ID3v2Language.rus

        stuff.text = "Абв 123"

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v4) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2TermsOfUse(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.text == stuff.text)
        }

        do {
            let other = ID3v2TermsOfUse(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.text == stuff.text)
        }

        do {
            let other = ID3v2TermsOfUse(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.text == stuff.text)
        }
    }

    func testVersion4CaseF() {
        let stuff = ID3v2TermsOfUse()

        stuff.textEncoding = ID3v2TextEncoding.utf16
        stuff.language = ID3v2Language.und

        stuff.text = ""

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.toData(version: ID3v2Version.v4) == nil)
    }

    func testVersion4CaseG() {
        let stuff = ID3v2TermsOfUse(fromData: [], version: ID3v2Version.v4)

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.textEncoding == ID3v2TextEncoding.utf8)
        XCTAssert(stuff.language == ID3v2Language.und)

        XCTAssert(stuff.text == "")

        XCTAssert(stuff.toData(version: ID3v2Version.v4) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v2) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v3) == nil)
    }
}
