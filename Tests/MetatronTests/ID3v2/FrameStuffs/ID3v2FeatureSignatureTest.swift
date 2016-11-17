//
//  ID3v2FeatureSignatureTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 03.09.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class ID3v2FeatureSignatureTest: XCTestCase {

    // MARK: Instance Methods

    func testCreateClone() {
        let stuff = ID3v2FeatureSignature()

        stuff.content = [0, 1, 2, 3, 0, 4, 5, 6]
        stuff.slotSymbol = 132

        let other = ID3v2FeatureSignatureFormat.regular.createStuffSubclass(fromOther: stuff)

        XCTAssert(other.content == stuff.content)
        XCTAssert(other.slotSymbol == stuff.slotSymbol)
    }

    func testImposeStuff() {
        let frame = ID3v2Frame(identifier: ID3v2FrameID.sign)

        let stuff1 = frame.imposeStuff(format: ID3v2FeatureSignatureFormat.regular)
        let stuff2 = frame.imposeStuff(format: ID3v2FeatureSignatureFormat.regular)

        XCTAssert(frame.stuff is ID3v2FeatureSignature)

        XCTAssert(frame.stuff === stuff1)
        XCTAssert(frame.stuff === stuff2)
    }

    // MARK:

    func testVersion2CaseA() {
        let stuff = ID3v2FeatureSignature()

        stuff.content = [0, 1, 2, 3, 0, 4, 5, 6]
        stuff.slotSymbol = 132

        XCTAssert(!stuff.isEmpty)

        XCTAssert(stuff.toData(version: ID3v2Version.v2) == nil)
    }

    func testVersion2CaseB() {
        let stuff = ID3v2FeatureSignature()

        stuff.content = [6, 5, 4, 0, 3, 2, 1, 0]
        stuff.slotSymbol = 1

        XCTAssert(!stuff.isEmpty)

        XCTAssert(stuff.toData(version: ID3v2Version.v2) == nil)
    }

    func testVersion2CaseC() {
        let stuff = ID3v2FeatureSignature()

        stuff.content = []
        stuff.slotSymbol = 132

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.toData(version: ID3v2Version.v2) == nil)
    }

    func testVersion2CaseD() {
        let stuff = ID3v2FeatureSignature(fromData: [], version: ID3v2Version.v2)

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.content == [])
        XCTAssert(stuff.slotSymbol == 0)

        XCTAssert(stuff.toData(version: ID3v2Version.v2) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v3) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v4) == nil)
    }

    // MARK:

    func testVersion3CaseA() {
        let stuff = ID3v2FeatureSignature()

        stuff.content = [0, 1, 2, 3, 0, 4, 5, 6]
        stuff.slotSymbol = 132

        XCTAssert(!stuff.isEmpty)

        XCTAssert(stuff.toData(version: ID3v2Version.v3) == nil)
    }

    func testVersion3CaseB() {
        let stuff = ID3v2FeatureSignature()

        stuff.content = [6, 5, 4, 0, 3, 2, 1, 0]
        stuff.slotSymbol = 1

        XCTAssert(!stuff.isEmpty)

        XCTAssert(stuff.toData(version: ID3v2Version.v3) == nil)
    }

    func testVersion3CaseC() {
        let stuff = ID3v2FeatureSignature()

        stuff.content = []
        stuff.slotSymbol = 132

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.toData(version: ID3v2Version.v3) == nil)
    }

    func testVersion3CaseD() {
        let stuff = ID3v2FeatureSignature(fromData: [], version: ID3v2Version.v3)

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.content == [])
        XCTAssert(stuff.slotSymbol == 0)

        XCTAssert(stuff.toData(version: ID3v2Version.v3) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v2) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v4) == nil)
    }

    // MARK:

    func testVersion4CaseA() {
        let stuff = ID3v2FeatureSignature()

        stuff.content = [0, 1, 2, 3, 0, 4, 5, 6]
        stuff.slotSymbol = 132

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v4) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2FeatureSignature(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.content == stuff.content)
            XCTAssert(other.slotSymbol == stuff.slotSymbol)
        }

        do {
            let other = ID3v2FeatureSignature(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.content == stuff.content)
            XCTAssert(other.slotSymbol == stuff.slotSymbol)
        }

        do {
            let other = ID3v2FeatureSignature(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.content == stuff.content)
            XCTAssert(other.slotSymbol == stuff.slotSymbol)
        }
    }

    func testVersion4CaseB() {
        let stuff = ID3v2FeatureSignature()

        stuff.content = [6, 5, 4, 0, 3, 2, 1, 0]
        stuff.slotSymbol = 1

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v4) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2FeatureSignature(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.content == stuff.content)
            XCTAssert(other.slotSymbol == stuff.slotSymbol)
        }

        do {
            let other = ID3v2FeatureSignature(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.content == stuff.content)
            XCTAssert(other.slotSymbol == stuff.slotSymbol)
        }

        do {
            let other = ID3v2FeatureSignature(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.content == stuff.content)
            XCTAssert(other.slotSymbol == stuff.slotSymbol)
        }
    }

    func testVersion4CaseC() {
        let stuff = ID3v2FeatureSignature()

        stuff.content = []
        stuff.slotSymbol = 132

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.toData(version: ID3v2Version.v4) == nil)
    }

    func testVersion4CaseD() {
        let stuff = ID3v2FeatureSignature(fromData: [], version: ID3v2Version.v4)

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.content == [])
        XCTAssert(stuff.slotSymbol == 0)

        XCTAssert(stuff.toData(version: ID3v2Version.v4) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v2) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v3) == nil)
    }
}
