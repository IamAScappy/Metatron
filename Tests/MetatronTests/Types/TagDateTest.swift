//
//  TagDateTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 15.09.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class TagDateTest: XCTestCase {

    // MARK: Instance Methods

    func testInit() {
        do {
            let date = TagDate()

            XCTAssert(date.year == 0)
            XCTAssert(date.month == 1)
            XCTAssert(date.day == 1)

            XCTAssert(date.time.hour == 0)
            XCTAssert(date.time.minute == 0)
            XCTAssert(date.time.second == 0)

            XCTAssert(date.daysInYear == 0)
            XCTAssert(date.daysInMonth == 31)

            XCTAssert(date.isLeapYear == false)
            XCTAssert(date.isValid == false)

            let revised = date.revised

            XCTAssert(revised.year == 0)
            XCTAssert(revised.month == 1)
            XCTAssert(revised.day == 1)

            XCTAssert(revised.time.hour == 0)
            XCTAssert(revised.time.minute == 0)
            XCTAssert(revised.time.second == 0)

            XCTAssert(revised.isValid == false)
        }

        do {
            let date = TagDate(year: 1998)

            XCTAssert(date.year == 1998)
            XCTAssert(date.month == 1)
            XCTAssert(date.day == 1)

            XCTAssert(date.time.hour == 0)
            XCTAssert(date.time.minute == 0)
            XCTAssert(date.time.second == 0)

            XCTAssert(date.daysInYear == 365)
            XCTAssert(date.daysInMonth == 31)

            XCTAssert(date.isLeapYear == false)
            XCTAssert(date.isValid == true)

            let revised = date.revised

            XCTAssert(revised.year == 1998)
            XCTAssert(revised.month == 1)
            XCTAssert(revised.day == 1)

            XCTAssert(revised.time.hour == 0)
            XCTAssert(revised.time.minute == 0)
            XCTAssert(revised.time.second == 0)

            XCTAssert(revised.isValid == true)
        }

        do {
            let date = TagDate(year: 1998, month: 12)

            XCTAssert(date.year == 1998)
            XCTAssert(date.month == 12)
            XCTAssert(date.day == 1)

            XCTAssert(date.time.hour == 0)
            XCTAssert(date.time.minute == 0)
            XCTAssert(date.time.second == 0)

            XCTAssert(date.daysInYear == 365)
            XCTAssert(date.daysInMonth == 31)

            XCTAssert(date.isLeapYear == false)
            XCTAssert(date.isValid == true)

            let revised = date.revised

            XCTAssert(revised.year == 1998)
            XCTAssert(revised.month == 12)
            XCTAssert(revised.day == 1)

            XCTAssert(revised.time.hour == 0)
            XCTAssert(revised.time.minute == 0)
            XCTAssert(revised.time.second == 0)

            XCTAssert(revised.isValid == true)
        }

        do {
            let date = TagDate(year: 1998, month: 12, day: 31)

            XCTAssert(date.year == 1998)
            XCTAssert(date.month == 12)
            XCTAssert(date.day == 31)

            XCTAssert(date.time.hour == 0)
            XCTAssert(date.time.minute == 0)
            XCTAssert(date.time.second == 0)

            XCTAssert(date.daysInYear == 365)
            XCTAssert(date.daysInMonth == 31)

            XCTAssert(date.isLeapYear == false)
            XCTAssert(date.isValid == true)

            let revised = date.revised

            XCTAssert(revised.year == 1998)
            XCTAssert(revised.month == 12)
            XCTAssert(revised.day == 31)

            XCTAssert(revised.time.hour == 0)
            XCTAssert(revised.time.minute == 0)
            XCTAssert(revised.time.second == 0)

            XCTAssert(revised.isValid == true)
        }

        do {
            let date = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: 34, second: 56))

            XCTAssert(date.year == 1998)
            XCTAssert(date.month == 12)
            XCTAssert(date.day == 31)

            XCTAssert(date.time.hour == 12)
            XCTAssert(date.time.minute == 34)
            XCTAssert(date.time.second == 56)

            XCTAssert(date.daysInYear == 365)
            XCTAssert(date.daysInMonth == 31)

            XCTAssert(date.isLeapYear == false)
            XCTAssert(date.isValid == true)

            let revised = date.revised

            XCTAssert(revised.year == 1998)
            XCTAssert(revised.month == 12)
            XCTAssert(revised.day == 31)

            XCTAssert(revised.time.hour == 12)
            XCTAssert(revised.time.minute == 34)
            XCTAssert(revised.time.second == 56)

            XCTAssert(revised.isValid == true)
        }

        do {
            let date = TagDate(year: 10000)

            XCTAssert(date.year == 10000)
            XCTAssert(date.month == 1)
            XCTAssert(date.day == 1)

            XCTAssert(date.time.hour == 0)
            XCTAssert(date.time.minute == 0)
            XCTAssert(date.time.second == 0)

            XCTAssert(date.daysInYear == 0)
            XCTAssert(date.daysInMonth == 31)

            XCTAssert(date.isLeapYear == false)
            XCTAssert(date.isValid == false)

            let revised = date.revised

            XCTAssert(revised.year == 0)
            XCTAssert(revised.month == 1)
            XCTAssert(revised.day == 1)

            XCTAssert(revised.time.hour == 0)
            XCTAssert(revised.time.minute == 0)
            XCTAssert(revised.time.second == 0)

            XCTAssert(revised.isValid == false)
        }

        do {
            let date = TagDate(year: 1998, month: 0)

            XCTAssert(date.year == 1998)
            XCTAssert(date.month == 0)
            XCTAssert(date.day == 1)

            XCTAssert(date.time.hour == 0)
            XCTAssert(date.time.minute == 0)
            XCTAssert(date.time.second == 0)

            XCTAssert(date.daysInYear == 365)
            XCTAssert(date.daysInMonth == 0)

            XCTAssert(date.isLeapYear == false)
            XCTAssert(date.isValid == false)

            let revised = date.revised

            XCTAssert(revised.year == 1998)
            XCTAssert(revised.month == 1)
            XCTAssert(revised.day == 1)

            XCTAssert(revised.time.hour == 0)
            XCTAssert(revised.time.minute == 0)
            XCTAssert(revised.time.second == 0)

            XCTAssert(revised.isValid == true)
        }

        do {
            let date = TagDate(year: 1998, month: 13)

            XCTAssert(date.year == 1998)
            XCTAssert(date.month == 13)
            XCTAssert(date.day == 1)

            XCTAssert(date.time.hour == 0)
            XCTAssert(date.time.minute == 0)
            XCTAssert(date.time.second == 0)

            XCTAssert(date.daysInYear == 365)
            XCTAssert(date.daysInMonth == 0)

            XCTAssert(date.isLeapYear == false)
            XCTAssert(date.isValid == false)

            let revised = date.revised

            XCTAssert(revised.year == 1998)
            XCTAssert(revised.month == 1)
            XCTAssert(revised.day == 1)

            XCTAssert(revised.time.hour == 0)
            XCTAssert(revised.time.minute == 0)
            XCTAssert(revised.time.second == 0)

            XCTAssert(revised.isValid == true)
        }

        do {
            let date = TagDate(year: 1998, month: 12, day: 0)

            XCTAssert(date.year == 1998)
            XCTAssert(date.month == 12)
            XCTAssert(date.day == 0)

            XCTAssert(date.time.hour == 0)
            XCTAssert(date.time.minute == 0)
            XCTAssert(date.time.second == 0)

            XCTAssert(date.daysInYear == 365)
            XCTAssert(date.daysInMonth == 31)

            XCTAssert(date.isLeapYear == false)
            XCTAssert(date.isValid == false)

            let revised = date.revised

            XCTAssert(revised.year == 1998)
            XCTAssert(revised.month == 12)
            XCTAssert(revised.day == 1)

            XCTAssert(revised.time.hour == 0)
            XCTAssert(revised.time.minute == 0)
            XCTAssert(revised.time.second == 0)

            XCTAssert(revised.isValid == true)
        }

        do {
            let date = TagDate(year: 1998, month: 12, day: 32)

            XCTAssert(date.year == 1998)
            XCTAssert(date.month == 12)
            XCTAssert(date.day == 32)

            XCTAssert(date.time.hour == 0)
            XCTAssert(date.time.minute == 0)
            XCTAssert(date.time.second == 0)

            XCTAssert(date.daysInYear == 365)
            XCTAssert(date.daysInMonth == 31)

            XCTAssert(date.isLeapYear == false)
            XCTAssert(date.isValid == false)

            let revised = date.revised

            XCTAssert(revised.year == 1998)
            XCTAssert(revised.month == 12)
            XCTAssert(revised.day == 1)

            XCTAssert(revised.time.hour == 0)
            XCTAssert(revised.time.minute == 0)
            XCTAssert(revised.time.second == 0)

            XCTAssert(revised.isValid == true)
        }

        do {
            let date = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: -1))

            XCTAssert(date.year == 1998)
            XCTAssert(date.month == 12)
            XCTAssert(date.day == 31)

            XCTAssert(date.time.hour == -1)
            XCTAssert(date.time.minute == 0)
            XCTAssert(date.time.second == 0)

            XCTAssert(date.daysInYear == 365)
            XCTAssert(date.daysInMonth == 31)

            XCTAssert(date.isLeapYear == false)
            XCTAssert(date.isValid == false)

            let revised = date.revised

            XCTAssert(revised.year == 1998)
            XCTAssert(revised.month == 12)
            XCTAssert(revised.day == 31)

            XCTAssert(revised.time.hour == 0)
            XCTAssert(revised.time.minute == 0)
            XCTAssert(revised.time.second == 0)

            XCTAssert(revised.isValid == true)
        }

        do {
            let date = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 24))

            XCTAssert(date.year == 1998)
            XCTAssert(date.month == 12)
            XCTAssert(date.day == 31)

            XCTAssert(date.time.hour == 24)
            XCTAssert(date.time.minute == 0)
            XCTAssert(date.time.second == 0)

            XCTAssert(date.daysInYear == 365)
            XCTAssert(date.daysInMonth == 31)

            XCTAssert(date.isLeapYear == false)
            XCTAssert(date.isValid == false)

            let revised = date.revised

            XCTAssert(revised.year == 1998)
            XCTAssert(revised.month == 12)
            XCTAssert(revised.day == 31)

            XCTAssert(revised.time.hour == 0)
            XCTAssert(revised.time.minute == 0)
            XCTAssert(revised.time.second == 0)

            XCTAssert(revised.isValid == true)
        }

        do {
            let date = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: -1))

            XCTAssert(date.year == 1998)
            XCTAssert(date.month == 12)
            XCTAssert(date.day == 31)

            XCTAssert(date.time.hour == 12)
            XCTAssert(date.time.minute == -1)
            XCTAssert(date.time.second == 0)

            XCTAssert(date.daysInYear == 365)
            XCTAssert(date.daysInMonth == 31)

            XCTAssert(date.isLeapYear == false)
            XCTAssert(date.isValid == false)

            let revised = date.revised

            XCTAssert(revised.year == 1998)
            XCTAssert(revised.month == 12)
            XCTAssert(revised.day == 31)

            XCTAssert(revised.time.hour == 12)
            XCTAssert(revised.time.minute == 0)
            XCTAssert(revised.time.second == 0)

            XCTAssert(revised.isValid == true)
        }

        do {
            let date = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: 60))

            XCTAssert(date.year == 1998)
            XCTAssert(date.month == 12)
            XCTAssert(date.day == 31)

            XCTAssert(date.time.hour == 12)
            XCTAssert(date.time.minute == 60)
            XCTAssert(date.time.second == 0)

            XCTAssert(date.daysInYear == 365)
            XCTAssert(date.daysInMonth == 31)

            XCTAssert(date.isLeapYear == false)
            XCTAssert(date.isValid == false)

            let revised = date.revised

            XCTAssert(revised.year == 1998)
            XCTAssert(revised.month == 12)
            XCTAssert(revised.day == 31)

            XCTAssert(revised.time.hour == 12)
            XCTAssert(revised.time.minute == 0)
            XCTAssert(revised.time.second == 0)

            XCTAssert(revised.isValid == true)
        }

        do {
            let date = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: 34, second: -1))

            XCTAssert(date.year == 1998)
            XCTAssert(date.month == 12)
            XCTAssert(date.day == 31)

            XCTAssert(date.time.hour == 12)
            XCTAssert(date.time.minute == 34)
            XCTAssert(date.time.second == -1)

            XCTAssert(date.daysInYear == 365)
            XCTAssert(date.daysInMonth == 31)

            XCTAssert(date.isLeapYear == false)
            XCTAssert(date.isValid == false)

            let revised = date.revised

            XCTAssert(revised.year == 1998)
            XCTAssert(revised.month == 12)
            XCTAssert(revised.day == 31)

            XCTAssert(revised.time.hour == 12)
            XCTAssert(revised.time.minute == 34)
            XCTAssert(revised.time.second == 0)

            XCTAssert(revised.isValid == true)
        }

        do {
            let date = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: 34, second: 60))

            XCTAssert(date.year == 1998)
            XCTAssert(date.month == 12)
            XCTAssert(date.day == 31)

            XCTAssert(date.time.hour == 12)
            XCTAssert(date.time.minute == 34)
            XCTAssert(date.time.second == 60)

            XCTAssert(date.daysInYear == 365)
            XCTAssert(date.daysInMonth == 31)

            XCTAssert(date.isLeapYear == false)
            XCTAssert(date.isValid == false)

            let revised = date.revised

            XCTAssert(revised.year == 1998)
            XCTAssert(revised.month == 12)
            XCTAssert(revised.day == 31)

            XCTAssert(revised.time.hour == 12)
            XCTAssert(revised.time.minute == 34)
            XCTAssert(revised.time.second == 0)

            XCTAssert(revised.isValid == true)
        }
    }

    // MARK:

    func testComparable() {
        do {
            let date1 = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: 34, second: 56))
            let date2 = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: 34, second: 56))

            XCTAssertFalse(date1 < date2)
            XCTAssertFalse(date1 > date2)

            XCTAssert(date1 <= date2)
            XCTAssert(date1 >= date2)
        }

        do {
            let date1 = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: 34, second: 56))
            let date2 = TagDate(year: 2001, month: 12, day: 31, time: TagTime(hour: 12, minute: 34, second: 56))

            XCTAssert(date1 < date2)
            XCTAssert(date2 > date1)

            XCTAssert(date1 <= date2)
            XCTAssert(date2 >= date1)
        }

        do {
            let date1 = TagDate(year: 1998, month: 1, day: 31, time: TagTime(hour: 12, minute: 34, second: 56))
            let date2 = TagDate(year: 1998, month: 2, day: 31, time: TagTime(hour: 12, minute: 34, second: 56))

            XCTAssert(date1 < date2)
            XCTAssert(date2 > date1)

            XCTAssert(date1 <= date2)
            XCTAssert(date2 >= date1)
        }

        do {
            let date1 = TagDate(year: 1998, month: 12, day: 13, time: TagTime(hour: 12, minute: 34, second: 56))
            let date2 = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: 34, second: 56))

            XCTAssert(date1 < date2)
            XCTAssert(date2 > date1)

            XCTAssert(date1 <= date2)
            XCTAssert(date2 >= date1)
        }

        do {
            let date1 = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: 43, second: 5))
            let date2 = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 21, minute: 34, second: 6))

            XCTAssert(date1 < date2)
            XCTAssert(date2 > date1)

            XCTAssert(date1 <= date2)
            XCTAssert(date2 >= date1)
        }

        do {
            let date1 = TagDate(year: 1998, month: 2, day: 31, time: TagTime(hour: 12, minute: 34, second: 56))
            let date2 = TagDate(year: 2001, month: 1, day: 31, time: TagTime(hour: 12, minute: 34, second: 56))

            XCTAssert(date1 < date2)
            XCTAssert(date2 > date1)

            XCTAssert(date1 <= date2)
            XCTAssert(date2 >= date1)
        }

        do {
            let date1 = TagDate(year: 1998, month: 1, day: 31, time: TagTime(hour: 12, minute: 34, second: 56))
            let date2 = TagDate(year: 1998, month: 2, day: 13, time: TagTime(hour: 12, minute: 34, second: 56))

            XCTAssert(date1 < date2)
            XCTAssert(date2 > date1)

            XCTAssert(date1 <= date2)
            XCTAssert(date2 >= date1)
        }

        do {
            let date1 = TagDate(year: 1998, month: 12, day: 13, time: TagTime(hour: 21, minute: 34, second: 6))
            let date2 = TagDate(year: 2001, month: 12, day: 31, time: TagTime(hour: 12, minute: 43, second: 5))

            XCTAssert(date1 < date2)
            XCTAssert(date2 > date1)

            XCTAssert(date1 <= date2)
            XCTAssert(date2 >= date1)
        }

        do {
            let date1 = TagDate(year: 1998, month: 2, day: 13, time: TagTime(hour: 12, minute: 34, second: 56))
            let date2 = TagDate(year: 2001, month: 1, day: 31, time: TagTime(hour: 12, minute: 34, second: 56))

            XCTAssert(date1 < date2)
            XCTAssert(date2 > date1)

            XCTAssert(date1 <= date2)
            XCTAssert(date2 >= date1)
        }

        do {
            let date1 = TagDate(year: 1998, month: 1, day: 31, time: TagTime(hour: 12, minute: 43, second: 5))
            let date2 = TagDate(year: 1998, month: 2, day: 13, time: TagTime(hour: 21, minute: 34, second: 6))

            XCTAssert(date1 < date2)
            XCTAssert(date2 > date1)

            XCTAssert(date1 <= date2)
            XCTAssert(date2 >= date1)
        }

        do {
            let date1 = TagDate(year: 1998, month: 2, day: 13, time: TagTime(hour: 12, minute: 43, second: 5))
            let date2 = TagDate(year: 2001, month: 1, day: 31, time: TagTime(hour: 21, minute: 34, second: 6))

            XCTAssert(date1 < date2)
            XCTAssert(date2 > date1)

            XCTAssert(date1 <= date2)
            XCTAssert(date2 >= date1)
        }
    }

    func testEquatable() {
        do {
            let date1 = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: 34, second: 56))
            let date2 = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: 34, second: 56))

            XCTAssert(date1 == date2)
        }

        do {
            let date1 = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: 34, second: 56))
            let date2 = TagDate(year: 2001, month: 12, day: 31, time: TagTime(hour: 12, minute: 34, second: 56))

            XCTAssert(date1 != date2)
        }

        do {
            let date1 = TagDate(year: 1998, month: 1, day: 31, time: TagTime(hour: 12, minute: 34, second: 56))
            let date2 = TagDate(year: 1998, month: 2, day: 31, time: TagTime(hour: 12, minute: 34, second: 56))

            XCTAssert(date1 != date2)
        }

        do {
            let date1 = TagDate(year: 1998, month: 12, day: 13, time: TagTime(hour: 12, minute: 34, second: 56))
            let date2 = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: 34, second: 56))

            XCTAssert(date1 != date2)
        }

        do {
            let date1 = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: 43, second: 5))
            let date2 = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 21, minute: 34, second: 6))

            XCTAssert(date1 != date2)
        }

        do {
            let date1 = TagDate(year: 1998, month: 2, day: 13, time: TagTime(hour: 12, minute: 43, second: 5))
            let date2 = TagDate(year: 2001, month: 1, day: 31, time: TagTime(hour: 21, minute: 34, second: 6))

            XCTAssert(date1 != date2)
        }
    }

    // MARK:

    func testReset() {
        var date = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: 34, second: 56))

        date.reset()

        XCTAssert(date.year == 0)
        XCTAssert(date.month == 1)
        XCTAssert(date.day == 1)

        XCTAssert(date.time.hour == 0)
        XCTAssert(date.time.minute == 0)
        XCTAssert(date.time.second == 0)

        XCTAssert(date.isValid == false)
    }

}
