//
//  ID3v2UnknownValueTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 27.08.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class ID3v2UnknownValueTest: XCTestCase {

    // MARK: Instance Methods

    func testCreateClone() {
        let stuff = ID3v2UnknownValue()

        stuff.content = [1, 2, 3, 4]

        let other = ID3v2UnknownValueFormat.regular.createStuffSubclass(fromOther: stuff)

        XCTAssert(other.content == stuff.content)
    }

    func testImposeStuff() {
        let frame = ID3v2Frame(identifier: ID3v2FrameID.crm)

        let stuff1 = frame.imposeStuff(format: ID3v2UnknownValueFormat.regular)
        let stuff2 = frame.imposeStuff(format: ID3v2UnknownValueFormat.regular)

        XCTAssert(frame.stuff is ID3v2UnknownValue)

        XCTAssert(frame.stuff === stuff1)
        XCTAssert(frame.stuff === stuff2)
    }

    // MARK:

    func testVersion2CaseA() {
        let stuff = ID3v2UnknownValue()

        stuff.content = [1, 2, 3, 4]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v2) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2UnknownValue(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!stuff.isEmpty)

            XCTAssert(other.content == stuff.content)
        }

        do {
            let other = ID3v2UnknownValue(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!stuff.isEmpty)

            XCTAssert(other.content == stuff.content)
        }

        do {
            let other = ID3v2UnknownValue(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!stuff.isEmpty)

            XCTAssert(other.content == stuff.content)
        }
    }

    func testVersion2CaseB() {
        let stuff = ID3v2UnknownValue()

        stuff.content = []

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.toData(version: ID3v2Version.v2) == nil)
    }

    func testVersion2CaseC() {
        let stuff = ID3v2UnknownValue(fromData: [], version: ID3v2Version.v2)

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.content == [])

        XCTAssert(stuff.toData(version: ID3v2Version.v2) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v3) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v4) == nil)
    }

    // MARK:

    func testVersion3CaseA() {
        let stuff = ID3v2UnknownValue()

        stuff.content = [1, 2, 3, 4]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2UnknownValue(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!stuff.isEmpty)

            XCTAssert(other.content == stuff.content)
        }

        do {
            let other = ID3v2UnknownValue(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!stuff.isEmpty)

            XCTAssert(other.content == stuff.content)
        }

        do {
            let other = ID3v2UnknownValue(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!stuff.isEmpty)

            XCTAssert(other.content == stuff.content)
        }
    }

    func testVersion3CaseB() {
        let stuff = ID3v2UnknownValue()

        stuff.content = []

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.toData(version: ID3v2Version.v3) == nil)
    }

    func testVersion3CaseC() {
        let stuff = ID3v2UnknownValue(fromData: [], version: ID3v2Version.v3)

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.content == [])

        XCTAssert(stuff.toData(version: ID3v2Version.v3) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v2) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v4) == nil)
    }

    // MARK:

    func testVersion4CaseA() {
        let stuff = ID3v2UnknownValue()

        stuff.content = [1, 2, 3, 4]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v4) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2UnknownValue(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!stuff.isEmpty)

            XCTAssert(other.content == stuff.content)
        }

        do {
            let other = ID3v2UnknownValue(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!stuff.isEmpty)

            XCTAssert(other.content == stuff.content)
        }

        do {
            let other = ID3v2UnknownValue(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!stuff.isEmpty)

            XCTAssert(other.content == stuff.content)
        }
    }

    func testVersion4CaseB() {
        let stuff = ID3v2UnknownValue()

        stuff.content = []

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.toData(version: ID3v2Version.v4) == nil)
    }

    func testVersion4CaseC() {
        let stuff = ID3v2UnknownValue(fromData: [], version: ID3v2Version.v4)

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.content == [])

        XCTAssert(stuff.toData(version: ID3v2Version.v4) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v2) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v3) == nil)
    }
}
