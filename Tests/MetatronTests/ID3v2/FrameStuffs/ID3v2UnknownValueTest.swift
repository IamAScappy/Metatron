//
//  ID3v2UnknownValueTest.swift
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
