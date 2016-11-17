//
//  Lyrics3TextInformationTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 24.10.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class Lyrics3TextInformationTest: XCTestCase {

    // MARK: Instance Methods

    func testCreateClone() {
        let stuff = Lyrics3TextInformation()

        stuff.content = "Abc 123"

        let other = Lyrics3TextInformationFormat.regular.createStuffSubclass(fromOther: stuff)

        XCTAssert(other.content == stuff.content)
    }

    func testImposeStuff() {
        let field = Lyrics3Field(identifier: Lyrics3FieldID.inf)

        let stuff1 = field.imposeStuff(format: Lyrics3TextInformationFormat.regular)
        let stuff2 = field.imposeStuff(format: Lyrics3TextInformationFormat.regular)

        XCTAssert(field.stuff is Lyrics3TextInformation)

        XCTAssert(field.stuff === stuff1)
        XCTAssert(field.stuff === stuff2)
    }

    // MARK:

    func testCaseA() {
        let stuff = Lyrics3TextInformation()

        stuff.content = "Abc 123"

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        let other = Lyrics3TextInformation(fromData: data)

        XCTAssert(!stuff.isEmpty)

        XCTAssert(other.content == stuff.content)
    }

    func testCaseB() {
        let stuff = Lyrics3TextInformation()

        stuff.content = "Абв 123"

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        let other = Lyrics3TextInformation(fromData: data)

        XCTAssert(!stuff.isEmpty)

        XCTAssert(other.content != stuff.content)
    }

    func testCaseC() {
        let stuff = Lyrics3TextInformation()

        stuff.content = "Abc 1\nAbc 2\n\rAbc3\rAbc4\r\n"

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        let other = Lyrics3TextInformation(fromData: data)

        XCTAssert(!stuff.isEmpty)

        XCTAssert(other.content == "Abc 1\nAbc 2\n\rAbc3\rAbc4\n")
    }

    func testCaseD() {
        let stuff = Lyrics3TextInformation()

        stuff.content = ""

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.toData() == nil)
    }

    func testCaseE() {
        let stuff = Lyrics3TextInformation(fromData: [])

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.content == "")

        XCTAssert(stuff.toData() == nil)
    }
}
