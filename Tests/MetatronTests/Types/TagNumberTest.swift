//
//  TagNumberTest.swift
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

class TagNumberTest: XCTestCase {

    // MARK: Instance Methods

    func testInit() {
        do {
            let number = TagNumber()

            XCTAssert(number.value == 0)
            XCTAssert(number.total == 0)

            XCTAssert(number.isValid == false)

            let revised = number.revised

            XCTAssert(revised.value == 0)
            XCTAssert(revised.total == 0)

            XCTAssert(revised.isValid == false)
        }

        do {
            let number = TagNumber(12)

            XCTAssert(number.value == 12)
            XCTAssert(number.total == 0)

            XCTAssert(number.isValid == true)

            let revised = number.revised

            XCTAssert(revised.value == 12)
            XCTAssert(revised.total == 0)

            XCTAssert(revised.isValid == true)
        }

        do {
            let number = TagNumber(12, total: 34)

            XCTAssert(number.value == 12)
            XCTAssert(number.total == 34)

            XCTAssert(number.isValid == true)

            let revised = number.revised

            XCTAssert(revised.value == 12)
            XCTAssert(revised.total == 34)

            XCTAssert(revised.isValid == true)
        }

        do {
            let number = TagNumber(0, total: 12)

            XCTAssert(number.value == 0)
            XCTAssert(number.total == 12)

            XCTAssert(number.isValid == false)

            let revised = number.revised

            XCTAssert(revised.value == 0)
            XCTAssert(revised.total == 0)

            XCTAssert(revised.isValid == false)
        }

        do {
            let number = TagNumber(34, total: 12)

            XCTAssert(number.value == 34)
            XCTAssert(number.total == 12)

            XCTAssert(number.isValid == false)

            let revised = number.revised

            XCTAssert(revised.value == 34)
            XCTAssert(revised.total == 0)

            XCTAssert(revised.isValid == true)
        }

        do {
            let number = TagNumber(-12, total: 34)

            XCTAssert(number.value == -12)
            XCTAssert(number.total == 34)

            XCTAssert(number.isValid == false)

            let revised = number.revised

            XCTAssert(revised.value == 0)
            XCTAssert(revised.total == 0)

            XCTAssert(revised.isValid == false)
        }

        do {
            let number = TagNumber(12, total: -34)

            XCTAssert(number.value == 12)
            XCTAssert(number.total == -34)

            XCTAssert(number.isValid == false)

            let revised = number.revised

            XCTAssert(revised.value == 12)
            XCTAssert(revised.total == 0)

            XCTAssert(revised.isValid == true)
        }
    }

    // MARK:

    func testComparable() {
        do {
            let number1 = TagNumber(12, total: 34)
            let number2 = TagNumber(12, total: 34)

            XCTAssertFalse(number1 < number2)
            XCTAssertFalse(number1 > number2)

            XCTAssert(number1 <= number2)
            XCTAssert(number1 >= number2)
        }

        do {
            let number1 = TagNumber(12, total: 34)
            let number2 = TagNumber(34, total: 34)

            XCTAssert(number1 < number2)
            XCTAssert(number2 > number1)

            XCTAssert(number1 <= number2)
            XCTAssert(number2 >= number1)
        }

        do {
            let number1 = TagNumber(12, total: 34)
            let number2 = TagNumber(12, total: 56)

            XCTAssertFalse(number1 < number2)
            XCTAssertFalse(number1 > number2)

            XCTAssert(number1 <= number2)
            XCTAssert(number1 >= number2)
        }

        do {
            let number1 = TagNumber(12, total: 56)
            let number2 = TagNumber(34, total: 34)

            XCTAssert(number1 < number2)
            XCTAssert(number2 > number1)

            XCTAssert(number1 <= number2)
            XCTAssert(number2 >= number1)
        }
    }

    func testEquatable() {
        do {
            let number1 = TagNumber(12, total: 34)
            let number2 = TagNumber(12, total: 34)

            XCTAssert(number1 == number2)
        }

        do {
            let number1 = TagNumber(12, total: 34)
            let number2 = TagNumber(34, total: 34)

            XCTAssert(number1 != number2)
        }

        do {
            let number1 = TagNumber(12, total: 12)
            let number2 = TagNumber(12, total: 34)

            XCTAssert(number1 != number2)
        }

        do {
            let number1 = TagNumber(12, total: 12)
            let number2 = TagNumber(34, total: 34)

            XCTAssert(number1 != number2)
        }
    }

    // MARK:

    func testReset() {
        var number = TagNumber(12, total: 34)

        number.reset()

        XCTAssert(number.value == 0)
        XCTAssert(number.total == 0)

        XCTAssert(number.isValid == false)
    }
}
