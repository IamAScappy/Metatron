//
//  Lyrics3FieldTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 24.10.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class Lyrics3FieldTest: XCTestCase {

    // MARK: Instance Methods

    func testStuff() {
        let field = Lyrics3Field(identifier: Lyrics3FieldID.eal)

        let stuff1 = field.stuff(format: Lyrics3UnknownValueFormat.regular)
        let stuff2 = field.stuff(format: Lyrics3UnknownValueFormat.regular)

        XCTAssert(field.stuff !== stuff1)
        XCTAssert(field.stuff !== stuff2)

        XCTAssert(stuff1 !== stuff2)
    }

    func testImposeStuff() {
        let field = Lyrics3Field(identifier: Lyrics3FieldID.ear)

        let stuff1 = field.imposeStuff(format: Lyrics3UnknownValueFormat.regular)
        let stuff2 = field.imposeStuff(format: Lyrics3UnknownValueFormat.regular)

        XCTAssert(field.stuff === stuff1)
        XCTAssert(field.stuff === stuff2)

        XCTAssert(stuff1 === stuff2)
    }

    func testRevokeStuff() {
        let field = Lyrics3Field(identifier: Lyrics3FieldID.ett)

        let stuff = field.imposeStuff(format: Lyrics3UnknownValueFormat.regular)

        for _ in 0..<123 {
            stuff.content.append(UInt8(arc4random_uniform(256)))
        }

        XCTAssert(!field.isEmpty)

        XCTAssert(field.revokeStuff() === stuff)
        XCTAssert(field.revokeStuff() == nil)

        XCTAssert(field.isEmpty)

        XCTAssert(field.stuff !== stuff)

        let otherStuff = field.imposeStuff(format: Lyrics3UnknownValueFormat.regular)

        XCTAssert(otherStuff.content.isEmpty)
    }

    func testReset() {
        let field = Lyrics3Field(identifier: Lyrics3FieldID.img)

        let stuff = field.imposeStuff(format: Lyrics3UnknownValueFormat.regular)

        for _ in 0..<123 {
            stuff.content.append(UInt8(arc4random_uniform(256)))
        }

        XCTAssert(!field.isEmpty)

        field.reset()

        XCTAssert(field.isEmpty)

        XCTAssert(field.stuff !== stuff)

        let otherStuff = field.imposeStuff(format: Lyrics3UnknownValueFormat.regular)

        XCTAssert(otherStuff.content.isEmpty)
    }

    // MARK:

    func testVersion1CaseA() {
        let field = Lyrics3Field(identifier: Lyrics3FieldID.ind)

        XCTAssert(field.isEmpty)

        XCTAssert(field.toData(version: Lyrics3Version.v1) == nil)

        let stuff = field.imposeStuff(format: Lyrics3UnknownValueFormat.regular)

        for _ in 0..<123 {
            stuff.content.append(UInt8(arc4random_uniform(256)))
        }

        XCTAssert(!field.isEmpty)

        XCTAssert(field.toData(version: Lyrics3Version.v1) == nil)
    }

    func testVersion1CaseB() {
        let field = Lyrics3Field(identifier: Lyrics3FieldID.lyr)

        XCTAssert(field.isEmpty)

        XCTAssert(field.toData(version: Lyrics3Version.v1) == nil)

        let stuff = field.imposeStuff(format: Lyrics3UnknownValueFormat.regular)

        for _ in 0..<123 {
            stuff.content.append(UInt8(arc4random_uniform(256)))
        }

        XCTAssert(!field.isEmpty)

        guard let data = field.toData(version: Lyrics3Version.v1) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        var offset = 0

        guard let other = Lyrics3Field(fromBodyData: data, offset: &offset, version: Lyrics3Version.v1) else {
            return XCTFail()
        }

        XCTAssert(offset == data.count)

        XCTAssert(!other.isEmpty)

        XCTAssert(other.identifier == field.identifier)

        let otherStuff = other.imposeStuff(format: Lyrics3UnknownValueFormat.regular)

        XCTAssert(otherStuff.content == stuff.content)
    }

    // MARK:

    func testVersion2CaseA() {
        let field = Lyrics3Field(identifier: Lyrics3FieldID.ind)

        XCTAssert(field.isEmpty)

        XCTAssert(field.toData(version: Lyrics3Version.v2) == nil)

        let stuff = field.imposeStuff(format: Lyrics3UnknownValueFormat.regular)

        for _ in 0..<123 {
            stuff.content.append(UInt8(arc4random_uniform(256)))
        }

        XCTAssert(!field.isEmpty)

        guard let data = field.toData(version: Lyrics3Version.v2) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        var offset = 0

        guard let other = Lyrics3Field(fromBodyData: data, offset: &offset, version: Lyrics3Version.v2) else {
            return XCTFail()
        }

        XCTAssert(offset == data.count)

        XCTAssert(!other.isEmpty)

        XCTAssert(other.identifier == field.identifier)

        let otherStuff = other.imposeStuff(format: Lyrics3UnknownValueFormat.regular)

        XCTAssert(otherStuff.content == stuff.content)
    }

    func testVersion2CaseB() {
        let field = Lyrics3Field(identifier: Lyrics3FieldID.lyr)

        XCTAssert(field.isEmpty)

        XCTAssert(field.toData(version: Lyrics3Version.v2) == nil)

        let stuff = field.imposeStuff(format: Lyrics3UnknownValueFormat.regular)

        for _ in 0..<123 {
            stuff.content.append(UInt8(arc4random_uniform(256)))
        }

        XCTAssert(!field.isEmpty)

        guard let data = field.toData(version: Lyrics3Version.v2) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        var offset = 0

        guard let other = Lyrics3Field(fromBodyData: data, offset: &offset, version: Lyrics3Version.v2) else {
            return XCTFail()
        }

        XCTAssert(offset == data.count)

        XCTAssert(!other.isEmpty)

        XCTAssert(other.identifier == field.identifier)

        let otherStuff = other.imposeStuff(format: Lyrics3UnknownValueFormat.regular)

        XCTAssert(otherStuff.content == stuff.content)
    }
}
