//
//  TagTimeTest.swift
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

class TagTimeTest: XCTestCase {

    // MARK: Instance Methods

    func testInit() {
        do {
            let time = TagTime()

            XCTAssert(time.hour == 0)
            XCTAssert(time.minute == 0)
            XCTAssert(time.second == 0)

            XCTAssert(time.isMidnight == true)
            XCTAssert(time.isValid == true)

            let revised = time.revised

            XCTAssert(revised.hour == 0)
            XCTAssert(revised.minute == 0)
            XCTAssert(revised.second == 0)

            XCTAssert(revised.isValid == true)
        }

        do {
            let time = TagTime(hour: 12)

            XCTAssert(time.hour == 12)
            XCTAssert(time.minute == 0)
            XCTAssert(time.second == 0)

            XCTAssert(time.isMidnight == false)
            XCTAssert(time.isValid == true)

            let revised = time.revised

            XCTAssert(revised.hour == 12)
            XCTAssert(revised.minute == 0)
            XCTAssert(revised.second == 0)

            XCTAssert(revised.isValid == true)
        }

        do {
            let time = TagTime(hour: 12, minute: 34)

            XCTAssert(time.hour == 12)
            XCTAssert(time.minute == 34)
            XCTAssert(time.second == 0)

            XCTAssert(time.isMidnight == false)
            XCTAssert(time.isValid == true)

            let revised = time.revised

            XCTAssert(revised.hour == 12)
            XCTAssert(revised.minute == 34)
            XCTAssert(revised.second == 0)

            XCTAssert(revised.isValid == true)
        }

        do {
            let time = TagTime(hour: 12, minute: 34, second: 56)

            XCTAssert(time.hour == 12)
            XCTAssert(time.minute == 34)
            XCTAssert(time.second == 56)

            XCTAssert(time.isMidnight == false)
            XCTAssert(time.isValid == true)

            let revised = time.revised

            XCTAssert(revised.hour == 12)
            XCTAssert(revised.minute == 34)
            XCTAssert(revised.second == 56)

            XCTAssert(revised.isValid == true)
        }

        do {
            let time = TagTime(hour: -1)

            XCTAssert(time.hour == -1)
            XCTAssert(time.minute == 0)
            XCTAssert(time.second == 0)

            XCTAssert(time.isMidnight == false)
            XCTAssert(time.isValid == false)

            let revised = time.revised

            XCTAssert(revised.hour == 0)
            XCTAssert(revised.minute == 0)
            XCTAssert(revised.second == 0)

            XCTAssert(revised.isValid == true)
        }

        do {
            let time = TagTime(hour: 24)

            XCTAssert(time.hour == 24)
            XCTAssert(time.minute == 0)
            XCTAssert(time.second == 0)

            XCTAssert(time.isMidnight == false)
            XCTAssert(time.isValid == false)

            let revised = time.revised

            XCTAssert(revised.hour == 0)
            XCTAssert(revised.minute == 0)
            XCTAssert(revised.second == 0)

            XCTAssert(revised.isValid == true)
        }

        do {
            let time = TagTime(hour: 12, minute: -1)

            XCTAssert(time.hour == 12)
            XCTAssert(time.minute == -1)
            XCTAssert(time.second == 0)

            XCTAssert(time.isMidnight == false)
            XCTAssert(time.isValid == false)

            let revised = time.revised

            XCTAssert(revised.hour == 12)
            XCTAssert(revised.minute == 0)
            XCTAssert(revised.second == 0)

            XCTAssert(revised.isValid == true)
        }

        do {
            let time = TagTime(hour: 12, minute: 60)

            XCTAssert(time.hour == 12)
            XCTAssert(time.minute == 60)
            XCTAssert(time.second == 0)

            XCTAssert(time.isMidnight == false)
            XCTAssert(time.isValid == false)

            let revised = time.revised

            XCTAssert(revised.hour == 12)
            XCTAssert(revised.minute == 0)
            XCTAssert(revised.second == 0)

            XCTAssert(revised.isValid == true)
        }

        do {
            let time = TagTime(hour: 12, minute: 34, second: -1)

            XCTAssert(time.hour == 12)
            XCTAssert(time.minute == 34)
            XCTAssert(time.second == -1)

            XCTAssert(time.isMidnight == false)
            XCTAssert(time.isValid == false)

            let revised = time.revised

            XCTAssert(revised.hour == 12)
            XCTAssert(revised.minute == 34)
            XCTAssert(revised.second == 0)

            XCTAssert(revised.isValid == true)
        }

        do {
            let time = TagTime(hour: 12, minute: 34, second: 60)

            XCTAssert(time.hour == 12)
            XCTAssert(time.minute == 34)
            XCTAssert(time.second == 60)

            XCTAssert(time.isMidnight == false)
            XCTAssert(time.isValid == false)

            let revised = time.revised

            XCTAssert(revised.hour == 12)
            XCTAssert(revised.minute == 34)
            XCTAssert(revised.second == 0)

            XCTAssert(revised.isValid == true)
        }
    }

    // MARK:

    func testComparable() {
        do {
            let time1 = TagTime(hour: 12, minute: 34, second: 56)
            let time2 = TagTime(hour: 12, minute: 34, second: 56)

            XCTAssertFalse(time1 < time2)
            XCTAssertFalse(time1 > time2)

            XCTAssert(time1 <= time2)
            XCTAssert(time1 >= time2)
        }

        do {
            let time1 = TagTime(hour: 12, minute: 34, second: 56)
            let time2 = TagTime(hour: 21, minute: 34, second: 56)

            XCTAssert(time1 < time2)
            XCTAssert(time2 > time1)

            XCTAssert(time1 <= time2)
            XCTAssert(time2 >= time1)
        }

        do {
            let time1 = TagTime(hour: 12, minute: 34, second: 56)
            let time2 = TagTime(hour: 12, minute: 43, second: 56)

            XCTAssert(time1 < time2)
            XCTAssert(time2 > time1)

            XCTAssert(time1 <= time2)
            XCTAssert(time2 >= time1)
        }

        do {
            let time1 = TagTime(hour: 12, minute: 34, second: 5)
            let time2 = TagTime(hour: 12, minute: 34, second: 6)

            XCTAssert(time1 < time2)
            XCTAssert(time2 > time1)

            XCTAssert(time1 <= time2)
            XCTAssert(time2 >= time1)
        }

        do {
            let time1 = TagTime(hour: 12, minute: 43, second: 56)
            let time2 = TagTime(hour: 21, minute: 34, second: 56)

            XCTAssert(time1 < time2)
            XCTAssert(time2 > time1)

            XCTAssert(time1 <= time2)
            XCTAssert(time2 >= time1)
        }

        do {
            let time1 = TagTime(hour: 12, minute: 34, second: 6)
            let time2 = TagTime(hour: 21, minute: 34, second: 5)

            XCTAssert(time1 < time2)
            XCTAssert(time2 > time1)

            XCTAssert(time1 <= time2)
            XCTAssert(time2 >= time1)
        }

        do {
            let time1 = TagTime(hour: 12, minute: 34, second: 6)
            let time2 = TagTime(hour: 12, minute: 43, second: 5)

            XCTAssert(time1 < time2)
            XCTAssert(time2 > time1)

            XCTAssert(time1 <= time2)
            XCTAssert(time2 >= time1)
        }

        do {
            let time1 = TagTime(hour: 12, minute: 34, second: 5)
            let time2 = TagTime(hour: 21, minute: 43, second: 6)

            XCTAssert(time1 < time2)
            XCTAssert(time2 > time1)

            XCTAssert(time1 <= time2)
            XCTAssert(time2 >= time1)
        }
    }

    func testEquatable() {
        do {
            let time1 = TagTime(hour: 12, minute: 34, second: 56)
            let time2 = TagTime(hour: 12, minute: 34, second: 56)

            XCTAssert(time1 == time2)
        }

        do {
            let time1 = TagTime(hour: 12, minute: 34, second: 56)
            let time2 = TagTime(hour: 21, minute: 34, second: 56)

            XCTAssert(time1 != time2)
        }

        do {
            let time1 = TagTime(hour: 12, minute: 34, second: 56)
            let time2 = TagTime(hour: 12, minute: 43, second: 56)

            XCTAssert(time1 != time2)
        }

        do {
            let time1 = TagTime(hour: 12, minute: 34, second: 5)
            let time2 = TagTime(hour: 12, minute: 34, second: 6)

            XCTAssert(time1 != time2)
        }

        do {
            let time1 = TagTime(hour: 12, minute: 34, second: 5)
            let time2 = TagTime(hour: 21, minute: 43, second: 6)

            XCTAssert(time1 != time2)
        }
    }

    // MARK:

    func testReset() {
        var time = TagTime(hour: 12, minute: 34, second: 56)

        time.reset()

        XCTAssert(time.hour == 0)
        XCTAssert(time.minute == 0)
        XCTAssert(time.second == 0)

        XCTAssert(time.isValid == true)
    }
}
