//
//  Lyrics3FieldRegistryTest.swift
//  Metatron
//
//  Copyright (c) 2016 Almaz Ibragimov
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import XCTest

@testable import Metatron

class TestFieldStuff: Lyrics3FieldStuff {

    // MARK: Instance Properties

    var isEmpty: Bool {
        return false
    }

    // MARK: Initializers

    init() {
    }

    init(fromData data: [UInt8]) {
    }

    // MARK: Instance Methods

    func toData() -> [UInt8]? {
        return nil
    }

    // MARK:

    func reset() {
    }
}

class TestFieldStuffFormat: Lyrics3FieldStuffSubclassFormat {

    // MARK: Type Properties

    static let regular = TestFieldStuffFormat()

    // MARK: Instance Methods

    func createStuffSubclass(fromData data: [UInt8]) -> TestFieldStuff {
        return TestFieldStuff(fromData: data)
    }

    func createStuffSubclass(fromOther other: TestFieldStuff) -> TestFieldStuff {
        return TestFieldStuff()
    }

    func createStuffSubclass() -> TestFieldStuff {
        return TestFieldStuff()
    }
}

class Lyrics3FieldRegistryTest: XCTestCase {

    // MARK: Instance Methods

    func testIdentifySignature() {
        let registry = Lyrics3FieldRegistry.regular

        registry.registerCustomID("Custom ETT", signature: [69, 84, 84])

        XCTAssert(registry.identifySignature([]) == nil)

        XCTAssert(registry.identifySignature([1]) == nil)
        XCTAssert(registry.identifySignature([1, 2]) == nil)
        XCTAssert(registry.identifySignature([1, 2, 3]) == nil)
        XCTAssert(registry.identifySignature([1, 2, 3, 4]) == nil)

        XCTAssert(registry.identifySignature([65]) == nil)
        XCTAssert(registry.identifySignature([65, 66]) == nil)
        XCTAssert(registry.identifySignature([65, 66, 67, 68]) == nil)

        XCTAssert(registry.identifySignature([69, 84, 84]) == Lyrics3FieldID.ett)
        XCTAssert(registry.identifySignature([69, 84, 84]) == registry.customIDs["Custom ETT"])

        do {
            guard let customID = registry.identifySignature([65, 66, 67]) else {
                return XCTFail()
            }

            XCTAssert(customID.type == Lyrics3FieldType.custom)

            XCTAssert(customID.signature == [65, 66, 67])

            XCTAssert(registry.customIDs[customID.name] != customID)
        }
    }

    func testRegisterCustomID() {
        let registry = Lyrics3FieldRegistry.regular

        XCTAssert(registry.registerCustomID("Abc 123", signature: []) == nil)

        XCTAssert(registry.registerCustomID("Abc 123", signature: [1]) == nil)
        XCTAssert(registry.registerCustomID("Abc 123", signature: [1, 2]) == nil)
        XCTAssert(registry.registerCustomID("Abc 123", signature: [1, 2, 3]) == nil)
        XCTAssert(registry.registerCustomID("Abc 123", signature: [1, 2, 3, 4]) == nil)

        XCTAssert(registry.registerCustomID("Abc 123", signature: [65]) == nil)
        XCTAssert(registry.registerCustomID("Abc 123", signature: [65, 66]) == nil)
        XCTAssert(registry.registerCustomID("Abc 123", signature: [66, 66, 67, 68]) == nil)

        XCTAssert(registry.registerCustomID("", signature: [65, 66, 67]) == nil)

        do {
            guard let customID = registry.registerCustomID("Abc 1", signature: [68, 69, 70]) else {
                return XCTFail()
            }

            XCTAssert(customID.type == Lyrics3FieldType.custom)
            XCTAssert(customID.name == "Abc 1")

            XCTAssert(customID.signature == [68, 69, 70])

            XCTAssert(registry.customIDs["Abc 1"] == customID)

            XCTAssert(registry.registerCustomID("Abc 1", signature: [68, 69, 70]) == nil)
            XCTAssert(registry.registerCustomID("Abc 2", signature: [68, 69, 70]) == nil)
            XCTAssert(registry.registerCustomID("Abc 1", signature: [71, 72, 73]) == nil)
        }

        do {
            guard let customID = registry.registerCustomID("Абв 1", signature: [71, 72, 73]) else {
                return XCTFail()
            }

            XCTAssert(customID.type == Lyrics3FieldType.custom)
            XCTAssert(customID.name == "Абв 1")

            XCTAssert(customID.signature == [71, 72, 73])

            XCTAssert(registry.customIDs["Абв 1"] == customID)

            XCTAssert(registry.registerCustomID("Абв 1", signature: [71, 72, 73]) == nil)
            XCTAssert(registry.registerCustomID("Абв 2", signature: [71, 72, 73]) == nil)
            XCTAssert(registry.registerCustomID("Абв 1", signature: [74, 75, 76]) == nil)
        }
    }

    func testRegisterStuff() {
        let registry = Lyrics3FieldRegistry.regular
        let format = TestFieldStuffFormat.regular

        XCTAssert(registry.registerStuff(format: format, identifier: Lyrics3FieldID.ind) == false)
        XCTAssert(registry.registerStuff(format: format, identifier: Lyrics3FieldID.lyr) == false)

        guard let customID1 = registry.registerCustomID("Custom JKL", signature: [74, 75, 76]) else {
            return XCTFail()
        }

        guard let customID2 = registry.registerCustomID("Custom MNO", signature: [77, 78, 79]) else {
            return XCTFail()
        }

        XCTAssert(registry.registerStuff(format: format, identifier: customID1) == true)
        XCTAssert(registry.registerStuff(format: format, identifier: customID1) == false)

        XCTAssert(registry.registerStuff(format: format, identifier: customID2) == true)
        XCTAssert(registry.registerStuff(format: format, identifier: customID2) == false)

        XCTAssert(registry.stuffs[customID1] === format)
        XCTAssert(registry.stuffs[customID2] === format)
    }
}
