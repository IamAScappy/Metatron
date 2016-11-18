//
//  ID3v2UniqueFileIdentifierTest.swift
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

class ID3v2UniqueFileIdentifierTest: XCTestCase {

    // MARK: Instance Methods

    func testCreateClone() {
        let stuff = ID3v2UniqueFileIdentifier()

        stuff.ownerIdentifier = "Abc 123"

        stuff.content = [0, 1, 2, 3, 0, 4, 5, 6]

        let other = ID3v2UniqueFileIdentifierFormat.regular.createStuffSubclass(fromOther: stuff)

        XCTAssert(other.ownerIdentifier == stuff.ownerIdentifier)

        XCTAssert(other.content == stuff.content)
    }

    func testImposeStuff() {
        let frame = ID3v2Frame(identifier: ID3v2FrameID.ufid)

        let stuff1 = frame.imposeStuff(format: ID3v2UniqueFileIdentifierFormat.regular)
        let stuff2 = frame.imposeStuff(format: ID3v2UniqueFileIdentifierFormat.regular)

        XCTAssert(frame.stuff is ID3v2UniqueFileIdentifier)

        XCTAssert(frame.stuff === stuff1)
        XCTAssert(frame.stuff === stuff2)
    }

    // MARK:

    func testVersion2CaseA() {
        let stuff = ID3v2UniqueFileIdentifier()

        stuff.ownerIdentifier = "Abc 123"

        stuff.content = [0, 1, 2, 3, 0, 4, 5, 6]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v2) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2UniqueFileIdentifier(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.ownerIdentifier == stuff.ownerIdentifier)

            XCTAssert(other.content == stuff.content)
        }

        do {
            let other = ID3v2UniqueFileIdentifier(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.ownerIdentifier == stuff.ownerIdentifier)

            XCTAssert(other.content == stuff.content)
        }

        do {
            let other = ID3v2UniqueFileIdentifier(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.ownerIdentifier == stuff.ownerIdentifier)

            XCTAssert(other.content == stuff.content)
        }
    }

    func testVersion2CaseB() {
        let stuff = ID3v2UniqueFileIdentifier()

        stuff.ownerIdentifier = "Абв 123"

        stuff.content = [0, 1, 2, 3, 0, 4, 5, 6]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v2) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2UniqueFileIdentifier(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.ownerIdentifier != stuff.ownerIdentifier)

            XCTAssert(other.content == stuff.content)
        }

        do {
            let other = ID3v2UniqueFileIdentifier(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.ownerIdentifier != stuff.ownerIdentifier)

            XCTAssert(other.content == stuff.content)
        }

        do {
            let other = ID3v2UniqueFileIdentifier(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.ownerIdentifier != stuff.ownerIdentifier)

            XCTAssert(other.content == stuff.content)
        }
    }

    func testVersion2CaseC() {
        let stuff = ID3v2UniqueFileIdentifier()

        stuff.ownerIdentifier = "Abc 123"

        stuff.content = [6, 5, 4, 0, 3, 2, 1, 0]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v2) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2UniqueFileIdentifier(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.ownerIdentifier == stuff.ownerIdentifier)

            XCTAssert(other.content == stuff.content)
        }

        do {
            let other = ID3v2UniqueFileIdentifier(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.ownerIdentifier == stuff.ownerIdentifier)

            XCTAssert(other.content == stuff.content)
        }

        do {
            let other = ID3v2UniqueFileIdentifier(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.ownerIdentifier == stuff.ownerIdentifier)

            XCTAssert(other.content == stuff.content)
        }
    }

    func testVersion2CaseD() {
        let stuff = ID3v2UniqueFileIdentifier()

        stuff.ownerIdentifier = "Abc 123"

        stuff.content = []

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.toData(version: ID3v2Version.v2) == nil)
    }

    func testVersion2CaseE() {
        let stuff = ID3v2UniqueFileIdentifier()

        stuff.ownerIdentifier = ""

        stuff.content = [0, 1, 2, 3, 0, 4, 5, 6]

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.toData(version: ID3v2Version.v2) == nil)
    }

    func testVersion2CaseF() {
        let stuff = ID3v2UniqueFileIdentifier(fromData: [], version: ID3v2Version.v2)

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.ownerIdentifier == "")

        XCTAssert(stuff.content == [])

        XCTAssert(stuff.toData(version: ID3v2Version.v2) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v3) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v4) == nil)
    }

    // MARK:

    func testVersion3CaseA() {
        let stuff = ID3v2UniqueFileIdentifier()

        stuff.ownerIdentifier = "Abc 123"

        stuff.content = [0, 1, 2, 3, 0, 4, 5, 6]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2UniqueFileIdentifier(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.ownerIdentifier == stuff.ownerIdentifier)

            XCTAssert(other.content == stuff.content)
        }

        do {
            let other = ID3v2UniqueFileIdentifier(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.ownerIdentifier == stuff.ownerIdentifier)

            XCTAssert(other.content == stuff.content)
        }

        do {
            let other = ID3v2UniqueFileIdentifier(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.ownerIdentifier == stuff.ownerIdentifier)

            XCTAssert(other.content == stuff.content)
        }
    }

    func testVersion3CaseB() {
        let stuff = ID3v2UniqueFileIdentifier()

        stuff.ownerIdentifier = "Абв 123"

        stuff.content = [0, 1, 2, 3, 0, 4, 5, 6]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2UniqueFileIdentifier(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.ownerIdentifier != stuff.ownerIdentifier)

            XCTAssert(other.content == stuff.content)
        }

        do {
            let other = ID3v2UniqueFileIdentifier(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.ownerIdentifier != stuff.ownerIdentifier)

            XCTAssert(other.content == stuff.content)
        }

        do {
            let other = ID3v2UniqueFileIdentifier(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.ownerIdentifier != stuff.ownerIdentifier)

            XCTAssert(other.content == stuff.content)
        }
    }

    func testVersion3CaseC() {
        let stuff = ID3v2UniqueFileIdentifier()

        stuff.ownerIdentifier = "Abc 123"

        stuff.content = [6, 5, 4, 0, 3, 2, 1, 0]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2UniqueFileIdentifier(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.ownerIdentifier == stuff.ownerIdentifier)

            XCTAssert(other.content == stuff.content)
        }

        do {
            let other = ID3v2UniqueFileIdentifier(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.ownerIdentifier == stuff.ownerIdentifier)

            XCTAssert(other.content == stuff.content)
        }

        do {
            let other = ID3v2UniqueFileIdentifier(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.ownerIdentifier == stuff.ownerIdentifier)

            XCTAssert(other.content == stuff.content)
        }
    }

    func testVersion3CaseD() {
        let stuff = ID3v2UniqueFileIdentifier()

        stuff.ownerIdentifier = "Abc 123"

        stuff.content = []

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.toData(version: ID3v2Version.v3) == nil)
    }

    func testVersion3CaseE() {
        let stuff = ID3v2UniqueFileIdentifier()

        stuff.ownerIdentifier = ""

        stuff.content = [0, 1, 2, 3, 0, 4, 5, 6]

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.toData(version: ID3v2Version.v3) == nil)
    }

    func testVersion3CaseF() {
        let stuff = ID3v2UniqueFileIdentifier(fromData: [], version: ID3v2Version.v3)

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.ownerIdentifier == "")

        XCTAssert(stuff.content == [])

        XCTAssert(stuff.toData(version: ID3v2Version.v3) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v2) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v4) == nil)
    }

    // MARK:

    func testVersion4CaseA() {
        let stuff = ID3v2UniqueFileIdentifier()

        stuff.ownerIdentifier = "Abc 123"

        stuff.content = [0, 1, 2, 3, 0, 4, 5, 6]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v4) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2UniqueFileIdentifier(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.ownerIdentifier == stuff.ownerIdentifier)

            XCTAssert(other.content == stuff.content)
        }

        do {
            let other = ID3v2UniqueFileIdentifier(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.ownerIdentifier == stuff.ownerIdentifier)

            XCTAssert(other.content == stuff.content)
        }

        do {
            let other = ID3v2UniqueFileIdentifier(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.ownerIdentifier == stuff.ownerIdentifier)

            XCTAssert(other.content == stuff.content)
        }
    }

    func testVersion4CaseB() {
        let stuff = ID3v2UniqueFileIdentifier()

        stuff.ownerIdentifier = "Абв 123"

        stuff.content = [0, 1, 2, 3, 0, 4, 5, 6]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v4) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2UniqueFileIdentifier(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.ownerIdentifier != stuff.ownerIdentifier)

            XCTAssert(other.content == stuff.content)
        }

        do {
            let other = ID3v2UniqueFileIdentifier(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.ownerIdentifier != stuff.ownerIdentifier)

            XCTAssert(other.content == stuff.content)
        }

        do {
            let other = ID3v2UniqueFileIdentifier(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.ownerIdentifier != stuff.ownerIdentifier)

            XCTAssert(other.content == stuff.content)
        }
    }

    func testVersion4CaseC() {
        let stuff = ID3v2UniqueFileIdentifier()

        stuff.ownerIdentifier = "Abc 123"

        stuff.content = [6, 5, 4, 0, 3, 2, 1, 0]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v4) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2UniqueFileIdentifier(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.ownerIdentifier == stuff.ownerIdentifier)

            XCTAssert(other.content == stuff.content)
        }

        do {
            let other = ID3v2UniqueFileIdentifier(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.ownerIdentifier == stuff.ownerIdentifier)

            XCTAssert(other.content == stuff.content)
        }

        do {
            let other = ID3v2UniqueFileIdentifier(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.ownerIdentifier == stuff.ownerIdentifier)

            XCTAssert(other.content == stuff.content)
        }
    }

    func testVersion4CaseD() {
        let stuff = ID3v2UniqueFileIdentifier()

        stuff.ownerIdentifier = "Abc 123"

        stuff.content = []

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.toData(version: ID3v2Version.v4) == nil)
    }

    func testVersion4CaseE() {
        let stuff = ID3v2UniqueFileIdentifier()

        stuff.ownerIdentifier = ""

        stuff.content = [0, 1, 2, 3, 0, 4, 5, 6]

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.toData(version: ID3v2Version.v4) == nil)
    }

    func testVersion4CaseF() {
        let stuff = ID3v2UniqueFileIdentifier(fromData: [], version: ID3v2Version.v4)

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.ownerIdentifier == "")

        XCTAssert(stuff.content == [])

        XCTAssert(stuff.toData(version: ID3v2Version.v4) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v2) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v3) == nil)
    }
}
