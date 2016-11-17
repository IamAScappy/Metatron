//
//  TagTimePeriodTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 15.09.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
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
