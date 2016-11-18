//
//  ExtensionsTest.swift
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

class ExtensionsTest: XCTestCase {

    // MARK: Instance Methods

    func testStringPrefix() {
        do {
            let value = ""

            XCTAssert(value.prefix(0) == "")
        }

        do {
            let value = ""

            XCTAssert(value.prefix(123) == "")
        }

        do {
            let value = "Abc 123"

            XCTAssert(value.prefix(0) == "")
        }

        do {
            let value = "Abc 123"

            XCTAssert(value.prefix(3) == "Abc")
        }

        do {
            let value = "Abc 123"

            XCTAssert(value.prefix(123) == "Abc 123")
        }
    }

    func testStringListRevised() {
        do {
            let value: [String] = []

            XCTAssert(value.revised == [])
        }

        do {
            let value = [""]

            XCTAssert(value.revised == [])
        }

        do {
            let value = ["Abc 123"]

            XCTAssert(value.revised == value)
        }

        do {
            let value = ["Абв 123"]

            XCTAssert(value.revised == value)
        }

        do {
            let value = ["Abc 1", "Abc 2"]

            XCTAssert(value.revised == value)
        }

        do {
            let value = ["", "Abc 2"]

            XCTAssert(value.revised == ["Abc 2"])
        }

        do {
            let value = ["Abc 1", ""]

            XCTAssert(value.revised == ["Abc 1"])
        }

        do {
            let value = ["", ""]

            XCTAssert(value.revised == [])
        }

        do {
            let value = [Array<String>(repeating: "Abc", count: 123).joined(separator: "\n")]

            XCTAssert(value.revised == value)
        }

        do {
            let value = Array<String>(repeating: "Abc", count: 123)

            XCTAssert(value.revised == value)
        }
    }

    // MARK:

    func testArrayLastIndex() {
        do {
            let value: [UInt8] = []

            XCTAssert(value.lastIndex(of: 0) == nil)
            XCTAssert(value.lastIndex(of: 123) == nil)
        }

        do {
            let value: [UInt8] = [123]

            XCTAssert(value.lastIndex(of: 0) == nil)
            XCTAssert(value.lastIndex(of: 123) == 0)
        }

        do {
            let value: [UInt8] = [1, 2, 3]

            XCTAssert(value.lastIndex(of: 0) == nil)
            XCTAssert(value.lastIndex(of: 2) == 1)
        }

        do {
            let value: [UInt8] = [0, 0, 0]

            XCTAssert(value.lastIndex(of: 0) == 2)
            XCTAssert(value.lastIndex(of: 2) == nil)
        }
    }

    func testArrayFirstOccurrence() {
        do {
            let value: [UInt8] = []

            XCTAssert(value.firstOccurrence(of: []) == nil)
            XCTAssert(value.firstOccurrence(of: [123]) == nil)
            XCTAssert(value.firstOccurrence(of: [1, 2, 3]) == nil)
            XCTAssert(value.firstOccurrence(of: [0, 0, 0]) == nil)
        }

        do {
            let value: [UInt8] = [123]

            XCTAssert(value.firstOccurrence(of: []) == nil)
            XCTAssert(value.firstOccurrence(of: [123]) == 0)
            XCTAssert(value.firstOccurrence(of: [1, 2, 3]) == nil)
            XCTAssert(value.firstOccurrence(of: [0, 0, 0]) == nil)
        }

        do {
            let value: [UInt8] = [1, 2, 3]

            XCTAssert(value.firstOccurrence(of: []) == nil)
            XCTAssert(value.firstOccurrence(of: [123]) == nil)
            XCTAssert(value.firstOccurrence(of: [1, 2, 3]) == 0)
            XCTAssert(value.firstOccurrence(of: [0, 0, 0]) == nil)
        }

        do {
            let value: [UInt8] = [0, 0, 0]

            XCTAssert(value.firstOccurrence(of: []) == nil)
            XCTAssert(value.firstOccurrence(of: [123]) == nil)
            XCTAssert(value.firstOccurrence(of: [1, 2, 3]) == nil)
            XCTAssert(value.firstOccurrence(of: [0, 0, 0]) == 0)
        }

        do {
            let value: [UInt8] = [123, 1, 2, 3, 0, 0, 0, 123, 1, 2, 3, 0, 0, 0]

            XCTAssert(value.firstOccurrence(of: []) == nil)
            XCTAssert(value.firstOccurrence(of: [123]) == 0)
            XCTAssert(value.firstOccurrence(of: [1, 2, 3]) == 1)
            XCTAssert(value.firstOccurrence(of: [0, 0, 0]) == 4)
        }
    }

    func testArrayLastOccurrence() {
        do {
            let value: [UInt8] = []

            XCTAssert(value.lastOccurrence(of: []) == nil)
            XCTAssert(value.lastOccurrence(of: [123]) == nil)
            XCTAssert(value.lastOccurrence(of: [1, 2, 3]) == nil)
            XCTAssert(value.lastOccurrence(of: [0, 0, 0]) == nil)
        }

        do {
            let value: [UInt8] = [123]

            XCTAssert(value.lastOccurrence(of: []) == nil)
            XCTAssert(value.lastOccurrence(of: [123]) == 0)
            XCTAssert(value.lastOccurrence(of: [1, 2, 3]) == nil)
            XCTAssert(value.lastOccurrence(of: [0, 0, 0]) == nil)
        }

        do {
            let value: [UInt8] = [1, 2, 3]

            XCTAssert(value.lastOccurrence(of: []) == nil)
            XCTAssert(value.lastOccurrence(of: [123]) == nil)
            XCTAssert(value.lastOccurrence(of: [1, 2, 3]) == 0)
            XCTAssert(value.lastOccurrence(of: [0, 0, 0]) == nil)
        }

        do {
            let value: [UInt8] = [0, 0, 0]

            XCTAssert(value.lastOccurrence(of: []) == nil)
            XCTAssert(value.lastOccurrence(of: [123]) == nil)
            XCTAssert(value.lastOccurrence(of: [1, 2, 3]) == nil)
            XCTAssert(value.lastOccurrence(of: [0, 0, 0]) == 0)
        }

        do {
            let value: [UInt8] = [123, 1, 2, 3, 0, 0, 0, 123, 1, 2, 3, 0, 0, 0]

            XCTAssert(value.lastOccurrence(of: []) == nil)
            XCTAssert(value.lastOccurrence(of: [123]) == 7)
            XCTAssert(value.lastOccurrence(of: [1, 2, 3]) == 8)
            XCTAssert(value.lastOccurrence(of: [0, 0, 0]) == 11)
        }
    }
}
