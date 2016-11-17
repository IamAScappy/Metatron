//
//  TagTimeTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 15.09.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
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
