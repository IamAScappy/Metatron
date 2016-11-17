//
//  Lyrics3UnknownValueTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 24.10.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class Lyrics3UnknownValueTest: XCTestCase {

    // MARK: Instance Methods

    func testCreateClone() {
        let stuff = Lyrics3UnknownValue()

        stuff.content = [1, 2, 3, 4]

        let other = Lyrics3UnknownValueFormat.regular.createStuffSubclass(fromOther: stuff)

        XCTAssert(other.content == stuff.content)
    }

    func testImposeStuff() {
        let field = Lyrics3Field(identifier: Lyrics3FieldID.lyr)

        let stuff1 = field.imposeStuff(format: Lyrics3UnknownValueFormat.regular)
        let stuff2 = field.imposeStuff(format: Lyrics3UnknownValueFormat.regular)

        XCTAssert(field.stuff is Lyrics3UnknownValue)

        XCTAssert(field.stuff === stuff1)
        XCTAssert(field.stuff === stuff2)
    }

    // MARK:

    func testCaseA() {
        let stuff = Lyrics3UnknownValue()

        stuff.content = [1, 2, 3, 4]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        let other = Lyrics3UnknownValue(fromData: data)

        XCTAssert(!stuff.isEmpty)

        XCTAssert(other.content == stuff.content)
    }

    func testCaseB() {
        let stuff = Lyrics3UnknownValue()

        stuff.content = []

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.toData() == nil)
    }

    func testCaseC() {
        let stuff = Lyrics3UnknownValue(fromData: [])

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.content == [])

        XCTAssert(stuff.toData() == nil)
    }
}
