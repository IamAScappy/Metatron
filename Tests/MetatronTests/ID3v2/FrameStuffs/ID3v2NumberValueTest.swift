//
//  ID3v2NumberValueTest.swift
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

class ID3v2NumberValueTest: XCTestCase {

    // MARK: Instance Methods

    func test() {
    	let stuff = ID3v2TextInformation()

        do {
            stuff.numberValue = TagNumber()

            XCTAssert(stuff.numberValue == TagNumber())
            XCTAssert(stuff.fields == [])
        }

        do {
            stuff.numberValue = TagNumber(0, total: 12)

            XCTAssert(stuff.numberValue == TagNumber())
            XCTAssert(stuff.fields == [])
        }

        do {
            stuff.numberValue = TagNumber(34, total: 12)

            XCTAssert(stuff.numberValue == TagNumber())
            XCTAssert(stuff.fields == [])
        }

        do {
            stuff.numberValue = TagNumber(-12, total: 34)

            XCTAssert(stuff.numberValue == TagNumber())
            XCTAssert(stuff.fields == [])
        }

        do {
            stuff.numberValue = TagNumber(12, total: -34)

            XCTAssert(stuff.numberValue == TagNumber())
            XCTAssert(stuff.fields == [])
        }

        do {
            stuff.numberValue = TagNumber(12)

            XCTAssert(stuff.numberValue == TagNumber(12))
            XCTAssert(stuff.fields == ["12"])
        }

        do {
            stuff.numberValue = TagNumber(12, total: 34)

            XCTAssert(stuff.numberValue == TagNumber(12, total: 34))
            XCTAssert(stuff.fields == ["12/34"])
        }

        do {
            stuff.fields = []

            XCTAssert(stuff.numberValue == TagNumber())
        }

        do {
            stuff.fields = ["/1234"]

            XCTAssert(stuff.numberValue == TagNumber())
        }

        do {
            stuff.fields = ["1234/"]

            XCTAssert(stuff.numberValue == TagNumber())
        }

        do {
            stuff.fields = ["12//34"]

            XCTAssert(stuff.numberValue == TagNumber())
        }

        do {
            stuff.fields = ["12:34"]

            XCTAssert(stuff.numberValue == TagNumber())
        }

        do {
            stuff.fields = ["12-34"]

            XCTAssert(stuff.numberValue == TagNumber())
        }

		do {
            stuff.fields = ["0"]

            let value = stuff.numberValue

            XCTAssert((value.value == 0) && (value.total == 0))
        }

        do {
            stuff.fields = ["12"]

            let value = stuff.numberValue

            XCTAssert((value.value == 12) && (value.total == 0))
        }

        do {
            stuff.fields = ["12/34"]

            let value = stuff.numberValue

            XCTAssert((value.value == 12) && (value.total == 34))
        }

        do {
            stuff.fields = ["12/0"]

            let value = stuff.numberValue

            XCTAssert((value.value == 12) && (value.total == 0))
        }

        do {
            stuff.fields = ["0/12"]

            let value = stuff.numberValue

            XCTAssert((value.value == 0) && (value.total == 12))
        }

        do {
            stuff.fields = ["34/12"]

            let value = stuff.numberValue

            XCTAssert((value.value == 34) && (value.total == 12))
        }

        do {
            stuff.fields = ["-12/34"]

            let value = stuff.numberValue

            XCTAssert((value.value == -12) && (value.total == 34))
        }

        do {
            stuff.fields = ["12/-34"]

            let value = stuff.numberValue

            XCTAssert((value.value == 12) && (value.total == -34))
        }

        do {
            stuff.fields = ["-12/-34"]

            let value = stuff.numberValue

            XCTAssert((value.value == -12) && (value.total == -34))
        }
    }
}
