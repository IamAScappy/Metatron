//
//  TagTimePeriodTest.swift
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

class TagTimePeriodTest: XCTestCase {

    // MARK: Instance Methods

    func testInit() {
        do {
            let startTime = TagTime()
            let endTime = TagTime()

            let timePeriod = TagTimePeriod(start: startTime, end: endTime)

            XCTAssert(timePeriod.start == startTime)
            XCTAssert(timePeriod.end == endTime)

            XCTAssert(timePeriod.isValid == true)
        }

        do {
            let startTime = TagTime(hour: 12, minute: 43, second: 5)
            let endTime = TagTime(hour: 21, minute: 34, second: 6)

            let timePeriod = TagTimePeriod(start: startTime, end: endTime)

            XCTAssert(timePeriod.start == startTime)
            XCTAssert(timePeriod.end == endTime)

            XCTAssert(timePeriod.isValid == true)
        }

        do {
            let startTime = TagTime(hour: 21, minute: 34, second: 6)
            let endTime = TagTime(hour: 12, minute: 43, second: 5)

            let timePeriod = TagTimePeriod(start: startTime, end: endTime)

            XCTAssert(timePeriod.start == startTime)
            XCTAssert(timePeriod.end == endTime)

            XCTAssert(timePeriod.isValid == false)
        }

        do {
            let startTime = TagTime(hour: 12, minute: 34, second: 56)
            let endTime = TagTime(hour: 12, minute: 34, second: 56)

            let timePeriod = TagTimePeriod(start: startTime, end: endTime)

            XCTAssert(timePeriod.start == startTime)
            XCTAssert(timePeriod.end == endTime)

            XCTAssert(timePeriod.isValid == true)
        }

        do {
            let startTime = TagTime(hour: 24, minute: 60, second: 60)
            let endTime = TagTime(hour: 12, minute: 34, second: 56)

            let timePeriod = TagTimePeriod(start: startTime, end: endTime)

            XCTAssert(timePeriod.start == startTime)
            XCTAssert(timePeriod.end == endTime)

            XCTAssert(timePeriod.isValid == false)
        }

        do {
            let startTime = TagTime(hour: 12, minute: 34, second: 56)
            let endTime = TagTime(hour: 24, minute: 60, second: 60)

            let timePeriod = TagTimePeriod(start: startTime, end: endTime)

            XCTAssert(timePeriod.start == startTime)
            XCTAssert(timePeriod.end == endTime)

            XCTAssert(timePeriod.isValid == false)
        }

        do {
            let startTime = TagTime(hour: 24, minute: 60, second: 60)
            let endTime = TagTime(hour: 24, minute: 60, second: 60)

            let timePeriod = TagTimePeriod(start: startTime, end: endTime)

            XCTAssert(timePeriod.start == startTime)
            XCTAssert(timePeriod.end == endTime)

            XCTAssert(timePeriod.isValid == false)
        }
    }

    // MARK:

    func testComparable() {
        do {
            let startTime1 = TagTime(hour: 12, minute: 43, second: 5)
            let endTime1 = TagTime(hour: 21, minute: 34, second: 6)

            let timePeriod1 = TagTimePeriod(start: startTime1, end: endTime1)

            let startTime2 = TagTime(hour: 12, minute: 43, second: 5)
            let endTime2 = TagTime(hour: 21, minute: 34, second: 6)

            let timePeriod2 = TagTimePeriod(start: startTime2, end: endTime2)

            XCTAssertFalse(timePeriod1 < timePeriod2)
            XCTAssertFalse(timePeriod1 > timePeriod2)

            XCTAssert(timePeriod1 <= timePeriod2)
            XCTAssert(timePeriod1 >= timePeriod2)
        }

        do {
            let startTime1 = TagTime(hour: 12, minute: 43, second: 5)
            let endTime1 = TagTime(hour: 21, minute: 34, second: 6)

            let timePeriod1 = TagTimePeriod(start: startTime1, end: endTime1)

            let startTime2 = TagTime(hour: 21, minute: 34, second: 6)
            let endTime2 = TagTime(hour: 21, minute: 34, second: 6)

            let timePeriod2 = TagTimePeriod(start: startTime2, end: endTime2)

            XCTAssert(timePeriod1 < timePeriod2)
            XCTAssert(timePeriod2 > timePeriod1)

            XCTAssert(timePeriod1 <= timePeriod2)
            XCTAssert(timePeriod2 >= timePeriod1)
        }

        do {
            let startTime1 = TagTime(hour: 12, minute: 43, second: 5)
            let endTime1 = TagTime(hour: 12, minute: 43, second: 5)

            let timePeriod1 = TagTimePeriod(start: startTime1, end: endTime1)

            let startTime2 = TagTime(hour: 12, minute: 43, second: 5)
            let endTime2 = TagTime(hour: 21, minute: 34, second: 6)

            let timePeriod2 = TagTimePeriod(start: startTime2, end: endTime2)

            XCTAssertFalse(timePeriod1 < timePeriod2)
            XCTAssertFalse(timePeriod1 > timePeriod2)

            XCTAssert(timePeriod1 <= timePeriod2)
            XCTAssert(timePeriod1 >= timePeriod2)
        }

        do {
            let startTime1 = TagTime(hour: 12, minute: 43, second: 5)
            let endTime1 = TagTime(hour: 12, minute: 43, second: 5)

            let timePeriod1 = TagTimePeriod(start: startTime1, end: endTime1)

            let startTime2 = TagTime(hour: 21, minute: 34, second: 6)
            let endTime2 = TagTime(hour: 21, minute: 34, second: 6)

            let timePeriod2 = TagTimePeriod(start: startTime2, end: endTime2)

            XCTAssert(timePeriod1 < timePeriod2)
            XCTAssert(timePeriod2 > timePeriod1)

            XCTAssert(timePeriod1 <= timePeriod2)
            XCTAssert(timePeriod2 >= timePeriod1)
        }
    }

    func testEquatable() {
        do {
            let startTime1 = TagTime(hour: 12, minute: 43, second: 5)
            let endTime1 = TagTime(hour: 21, minute: 34, second: 6)

            let timePeriod1 = TagTimePeriod(start: startTime1, end: endTime1)

            let startTime2 = TagTime(hour: 12, minute: 43, second: 5)
            let endTime2 = TagTime(hour: 21, minute: 34, second: 6)

            let timePeriod2 = TagTimePeriod(start: startTime2, end: endTime2)

            XCTAssert(timePeriod1 == timePeriod2)
        }

        do {
            let startTime1 = TagTime(hour: 21, minute: 34, second: 6)
            let endTime1 = TagTime(hour: 21, minute: 34, second: 6)

            let timePeriod1 = TagTimePeriod(start: startTime1, end: endTime1)

            let startTime2 = TagTime(hour: 12, minute: 43, second: 5)
            let endTime2 = TagTime(hour: 21, minute: 34, second: 6)

            let timePeriod2 = TagTimePeriod(start: startTime2, end: endTime2)

            XCTAssert(timePeriod1 != timePeriod2)
        }

        do {
            let startTime1 = TagTime(hour: 12, minute: 43, second: 5)
            let endTime1 = TagTime(hour: 12, minute: 43, second: 5)

            let timePeriod1 = TagTimePeriod(start: startTime1, end: endTime1)

            let startTime2 = TagTime(hour: 12, minute: 43, second: 5)
            let endTime2 = TagTime(hour: 21, minute: 34, second: 6)

            let timePeriod2 = TagTimePeriod(start: startTime2, end: endTime2)

            XCTAssert(timePeriod1 != timePeriod2)
        }

        do {
            let startTime1 = TagTime(hour: 12, minute: 43, second: 5)
            let endTime1 = TagTime(hour: 12, minute: 43, second: 5)

            let timePeriod1 = TagTimePeriod(start: startTime1, end: endTime1)

            let startTime2 = TagTime(hour: 21, minute: 34, second: 6)
            let endTime2 = TagTime(hour: 21, minute: 34, second: 6)

            let timePeriod2 = TagTimePeriod(start: startTime2, end: endTime2)

            XCTAssert(timePeriod1 != timePeriod2)
        }
    }

    // MARK:

    func testReset() {
        let startTime = TagTime(hour: 12, minute: 43, second: 5)
        let endTime = TagTime(hour: 21, minute: 34, second: 6)

        var timePeriod = TagTimePeriod(start: startTime, end: endTime)

        timePeriod.reset()

        XCTAssert(timePeriod.start == TagTime())
        XCTAssert(timePeriod.end == TagTime())

        XCTAssert(timePeriod.isValid == true)
    }
}
