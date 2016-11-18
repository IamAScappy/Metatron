//
//  ID3v2InvolvedPeopleListTest.swift
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

class ID3v2InvolvedPeopleListTest: XCTestCase {

    // MARK: Instance Methods

    func testCreateClone() {
        let stuff = ID3v2InvolvedPeopleList()

        stuff.textEncoding = ID3v2TextEncoding.latin1

        stuff.persons = ["Abc 123"]

        let other = ID3v2InvolvedPeopleListFormat.regular.createStuffSubclass(fromOther: stuff)

        XCTAssert(other.textEncoding == stuff.textEncoding)

        XCTAssert(other.persons == stuff.persons)
    }

    func testImposeStuff() {
        let frame = ID3v2Frame(identifier: ID3v2FrameID.ipls)

        let stuff1 = frame.imposeStuff(format: ID3v2InvolvedPeopleListFormat.regular)
        let stuff2 = frame.imposeStuff(format: ID3v2InvolvedPeopleListFormat.regular)

        XCTAssert(frame.stuff is ID3v2InvolvedPeopleList)

        XCTAssert(frame.stuff === stuff1)
        XCTAssert(frame.stuff === stuff2)
    }

    // MARK:

    func testVersion2CaseA() {
        let stuff = ID3v2InvolvedPeopleList()

        stuff.textEncoding = ID3v2TextEncoding.latin1

        stuff.persons = ["Abc 123"]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v2) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2InvolvedPeopleList(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)

            XCTAssert(other.persons == stuff.persons)
        }

        do {
            let other = ID3v2InvolvedPeopleList(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)

            XCTAssert(other.persons == stuff.persons)
        }

        do {
            let other = ID3v2InvolvedPeopleList(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)

            XCTAssert(other.persons == stuff.persons)
        }
    }

    func testVersion2CaseB() {
        let stuff = ID3v2InvolvedPeopleList()

        stuff.textEncoding = ID3v2TextEncoding.latin1

        stuff.persons = ["Абв 123"]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v2) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2InvolvedPeopleList(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)

            XCTAssert(other.persons != stuff.persons)
        }

        do {
            let other = ID3v2InvolvedPeopleList(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)

            XCTAssert(other.persons != stuff.persons)
        }

        do {
            let other = ID3v2InvolvedPeopleList(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)

            XCTAssert(other.persons != stuff.persons)
        }
    }

    func testVersion2CaseC() {
        let stuff = ID3v2InvolvedPeopleList()

        stuff.textEncoding = ID3v2TextEncoding.utf8

        stuff.persons = ["Абв 123"]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v2) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2InvolvedPeopleList(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)

            XCTAssert(other.persons == stuff.persons)
        }

        do {
            let other = ID3v2InvolvedPeopleList(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)

            XCTAssert(other.persons == stuff.persons)
        }

        do {
            let other = ID3v2InvolvedPeopleList(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)

            XCTAssert(other.persons == stuff.persons)
        }
    }

    func testVersion2CaseD() {
        let stuff = ID3v2InvolvedPeopleList()

        stuff.textEncoding = ID3v2TextEncoding.utf16

        stuff.persons = ["Abc 1", "Abc 2"]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v2) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2InvolvedPeopleList(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)

            XCTAssert(other.persons == stuff.persons)
        }

        do {
            let other = ID3v2InvolvedPeopleList(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)

            XCTAssert(other.persons == stuff.persons)
        }

        do {
            let other = ID3v2InvolvedPeopleList(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)

            XCTAssert(other.persons == stuff.persons)
        }
    }

    func testVersion2CaseE() {
        let stuff = ID3v2InvolvedPeopleList()

        stuff.textEncoding = ID3v2TextEncoding.utf16BE

        stuff.persons = ["", "Abc 2"]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v2) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2InvolvedPeopleList(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)

            XCTAssert(other.persons == stuff.persons)
        }

        do {
            let other = ID3v2InvolvedPeopleList(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)

            XCTAssert(other.persons == stuff.persons)
        }

        do {
            let other = ID3v2InvolvedPeopleList(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)

            XCTAssert(other.persons == stuff.persons)
        }
    }

    func testVersion2CaseF() {
        let stuff = ID3v2InvolvedPeopleList()

        stuff.textEncoding = ID3v2TextEncoding.utf16LE

        stuff.persons = ["Abc 1", ""]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v2) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2InvolvedPeopleList(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)

            XCTAssert(other.persons == stuff.persons)
        }

        do {
            let other = ID3v2InvolvedPeopleList(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)

            XCTAssert(other.persons == stuff.persons)
        }

        do {
            let other = ID3v2InvolvedPeopleList(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)

            XCTAssert(other.persons == stuff.persons)
        }
    }

    func testVersion2CaseG() {
        let stuff = ID3v2InvolvedPeopleList()

        stuff.textEncoding = ID3v2TextEncoding.latin1

        stuff.persons = ["", ""]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v2) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2InvolvedPeopleList(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)

            XCTAssert(other.persons == stuff.persons)
        }

        do {
            let other = ID3v2InvolvedPeopleList(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)

            XCTAssert(other.persons == stuff.persons)
        }

        do {
            let other = ID3v2InvolvedPeopleList(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)

            XCTAssert(other.persons == stuff.persons)
        }
    }

    func testVersion2CaseH() {
        let stuff = ID3v2InvolvedPeopleList()

        stuff.textEncoding = ID3v2TextEncoding.utf16

        stuff.persons = [""]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v2) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2InvolvedPeopleList(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)

            XCTAssert(other.persons == stuff.persons)
        }

        do {
            let other = ID3v2InvolvedPeopleList(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)

            XCTAssert(other.persons == stuff.persons)
        }

        do {
            let other = ID3v2InvolvedPeopleList(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)

            XCTAssert(other.persons == stuff.persons)
        }
    }

    func testVersion2CaseI() {
        let stuff = ID3v2InvolvedPeopleList()

        stuff.textEncoding = ID3v2TextEncoding.utf8

        stuff.persons = []

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.toData(version: ID3v2Version.v2) == nil)
    }

    func testVersion2CaseJ() {
        let stuff = ID3v2InvolvedPeopleList(fromData: [], version: ID3v2Version.v2)

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.textEncoding == ID3v2TextEncoding.utf8)

        XCTAssert(stuff.persons == [])

        XCTAssert(stuff.toData(version: ID3v2Version.v2) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v3) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v4) == nil)
    }

    // MARK:

    func testVersion3CaseA() {
        let stuff = ID3v2InvolvedPeopleList()

        stuff.textEncoding = ID3v2TextEncoding.latin1

        stuff.persons = ["Abc 123"]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2InvolvedPeopleList(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)

            XCTAssert(other.persons == stuff.persons)
        }

        do {
            let other = ID3v2InvolvedPeopleList(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)

            XCTAssert(other.persons == stuff.persons)
        }

        do {
            let other = ID3v2InvolvedPeopleList(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)

            XCTAssert(other.persons == stuff.persons)
        }
    }

    func testVersion3CaseB() {
        let stuff = ID3v2InvolvedPeopleList()

        stuff.textEncoding = ID3v2TextEncoding.latin1

        stuff.persons = ["Абв 123"]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2InvolvedPeopleList(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)

            XCTAssert(other.persons != stuff.persons)
        }

        do {
            let other = ID3v2InvolvedPeopleList(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)

            XCTAssert(other.persons != stuff.persons)
        }

        do {
            let other = ID3v2InvolvedPeopleList(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)

            XCTAssert(other.persons != stuff.persons)
        }
    }

    func testVersion3CaseC() {
        let stuff = ID3v2InvolvedPeopleList()

        stuff.textEncoding = ID3v2TextEncoding.utf8

        stuff.persons = ["Абв 123"]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2InvolvedPeopleList(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)

            XCTAssert(other.persons == stuff.persons)
        }

        do {
            let other = ID3v2InvolvedPeopleList(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)

            XCTAssert(other.persons == stuff.persons)
        }

        do {
            let other = ID3v2InvolvedPeopleList(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)

            XCTAssert(other.persons == stuff.persons)
        }
    }

    func testVersion3CaseD() {
        let stuff = ID3v2InvolvedPeopleList()

        stuff.textEncoding = ID3v2TextEncoding.utf16

        stuff.persons = ["Abc 1", "Abc 2"]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2InvolvedPeopleList(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)

            XCTAssert(other.persons == stuff.persons)
        }

        do {
            let other = ID3v2InvolvedPeopleList(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)

            XCTAssert(other.persons == stuff.persons)
        }

        do {
            let other = ID3v2InvolvedPeopleList(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)

            XCTAssert(other.persons == stuff.persons)
        }
    }

    func testVersion3CaseE() {
        let stuff = ID3v2InvolvedPeopleList()

        stuff.textEncoding = ID3v2TextEncoding.utf16BE

        stuff.persons = ["", "Abc 2"]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2InvolvedPeopleList(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)

            XCTAssert(other.persons == stuff.persons)
        }

        do {
            let other = ID3v2InvolvedPeopleList(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)

            XCTAssert(other.persons == stuff.persons)
        }

        do {
            let other = ID3v2InvolvedPeopleList(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)

            XCTAssert(other.persons == stuff.persons)
        }
    }

    func testVersion3CaseF() {
        let stuff = ID3v2InvolvedPeopleList()

        stuff.textEncoding = ID3v2TextEncoding.utf16LE

        stuff.persons = ["Abc 1", ""]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2InvolvedPeopleList(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)

            XCTAssert(other.persons == stuff.persons)
        }

        do {
            let other = ID3v2InvolvedPeopleList(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)

            XCTAssert(other.persons == stuff.persons)
        }

        do {
            let other = ID3v2InvolvedPeopleList(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)

            XCTAssert(other.persons == stuff.persons)
        }
    }

    func testVersion3CaseG() {
        let stuff = ID3v2InvolvedPeopleList()

        stuff.textEncoding = ID3v2TextEncoding.latin1

        stuff.persons = ["", ""]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2InvolvedPeopleList(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)

            XCTAssert(other.persons == stuff.persons)
        }

        do {
            let other = ID3v2InvolvedPeopleList(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)

            XCTAssert(other.persons == stuff.persons)
        }

        do {
            let other = ID3v2InvolvedPeopleList(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)

            XCTAssert(other.persons == stuff.persons)
        }
    }

    func testVersion3CaseH() {
        let stuff = ID3v2InvolvedPeopleList()

        stuff.textEncoding = ID3v2TextEncoding.utf16

        stuff.persons = [""]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2InvolvedPeopleList(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)

            XCTAssert(other.persons == stuff.persons)
        }

        do {
            let other = ID3v2InvolvedPeopleList(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)

            XCTAssert(other.persons == stuff.persons)
        }

        do {
            let other = ID3v2InvolvedPeopleList(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)

            XCTAssert(other.persons == stuff.persons)
        }
    }

    func testVersion3CaseI() {
        let stuff = ID3v2InvolvedPeopleList()

        stuff.textEncoding = ID3v2TextEncoding.utf8

        stuff.persons = []

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.toData(version: ID3v2Version.v3) == nil)
    }

    func testVersion3CaseJ() {
        let stuff = ID3v2InvolvedPeopleList(fromData: [], version: ID3v2Version.v3)

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.textEncoding == ID3v2TextEncoding.utf8)

        XCTAssert(stuff.persons == [])

        XCTAssert(stuff.toData(version: ID3v2Version.v3) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v2) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v4) == nil)
    }

    // MARK:

    func testVersion4CaseA() {
        let stuff = ID3v2InvolvedPeopleList()

        stuff.textEncoding = ID3v2TextEncoding.latin1

        stuff.persons = ["Abc 123"]

        XCTAssert(!stuff.isEmpty)

        XCTAssert(stuff.toData(version: ID3v2Version.v4) == nil)
    }

    func testVersion4CaseB() {
        let stuff = ID3v2InvolvedPeopleList()

        stuff.textEncoding = ID3v2TextEncoding.latin1

        stuff.persons = ["Абв 123"]

        XCTAssert(!stuff.isEmpty)

        XCTAssert(stuff.toData(version: ID3v2Version.v4) == nil)
    }

    func testVersion4CaseC() {
        let stuff = ID3v2InvolvedPeopleList()

        stuff.textEncoding = ID3v2TextEncoding.utf8

        stuff.persons = ["Абв 123"]

        XCTAssert(!stuff.isEmpty)

        XCTAssert(stuff.toData(version: ID3v2Version.v4) == nil)
    }

    func testVersion4CaseD() {
        let stuff = ID3v2InvolvedPeopleList()

        stuff.textEncoding = ID3v2TextEncoding.utf16

        stuff.persons = ["Abc 1", "Abc 2"]

        XCTAssert(!stuff.isEmpty)

        XCTAssert(stuff.toData(version: ID3v2Version.v4) == nil)
    }

    func testVersion4CaseE() {
        let stuff = ID3v2InvolvedPeopleList()

        stuff.textEncoding = ID3v2TextEncoding.utf16BE

        stuff.persons = ["", "Abc 2"]

        XCTAssert(!stuff.isEmpty)

        XCTAssert(stuff.toData(version: ID3v2Version.v4) == nil)
    }

    func testVersion4CaseF() {
        let stuff = ID3v2InvolvedPeopleList()

        stuff.textEncoding = ID3v2TextEncoding.utf16LE

        stuff.persons = ["Abc 1", ""]

        XCTAssert(!stuff.isEmpty)

        XCTAssert(stuff.toData(version: ID3v2Version.v4) == nil)
    }

    func testVersion4CaseG() {
        let stuff = ID3v2InvolvedPeopleList()

        stuff.textEncoding = ID3v2TextEncoding.latin1

        stuff.persons = ["", ""]

        XCTAssert(!stuff.isEmpty)

        XCTAssert(stuff.toData(version: ID3v2Version.v4) == nil)
    }

    func testVersion4CaseH() {
        let stuff = ID3v2InvolvedPeopleList()

        stuff.textEncoding = ID3v2TextEncoding.utf16

        stuff.persons = [""]

        XCTAssert(!stuff.isEmpty)

        XCTAssert(stuff.toData(version: ID3v2Version.v4) == nil)
    }

    func testVersion4CaseI() {
        let stuff = ID3v2InvolvedPeopleList()

        stuff.textEncoding = ID3v2TextEncoding.utf8

        stuff.persons = []

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.toData(version: ID3v2Version.v4) == nil)
    }

    func testVersion4CaseJ() {
        let stuff = ID3v2InvolvedPeopleList(fromData: [], version: ID3v2Version.v2)

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.textEncoding == ID3v2TextEncoding.utf8)

        XCTAssert(stuff.persons == [])

        XCTAssert(stuff.toData(version: ID3v2Version.v4) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v2) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v3) == nil)
    }
}
