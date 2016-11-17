//
//  TagDatePeriodTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 15.09.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class TagDatePeriodTest: XCTestCase {

    // MARK: Instance Methods

    func testInit() {
        do {
            let startDate = TagDate()
            let endDate = TagDate()

            let datePeriod = TagDatePeriod(start: startDate, end: endDate)

            XCTAssert(datePeriod.start == startDate)
            XCTAssert(datePeriod.end == endDate)

            XCTAssert(datePeriod.isValid == false)
        }

        do {
            let startDate = TagDate(year: 1998, month: 2, day: 13, time: TagTime(hour: 12, minute: 43, second: 5))
            let endDate = TagDate(year: 2001, month: 1, day: 31, time: TagTime(hour: 21, minute: 34, second: 6))

            let datePeriod = TagDatePeriod(start: startDate, end: endDate)

            XCTAssert(datePeriod.start == startDate)
            XCTAssert(datePeriod.end == endDate)

            XCTAssert(datePeriod.isValid == true)
        }

        do {
            let startDate = TagDate(year: 2001, month: 1, day: 31, time: TagTime(hour: 21, minute: 34, second: 6))
            let endDate = TagDate(year: 1998, month: 2, day: 13, time: TagTime(hour: 12, minute: 43, second: 5))

            let datePeriod = TagDatePeriod(start: startDate, end: endDate)

            XCTAssert(datePeriod.start == startDate)
            XCTAssert(datePeriod.end == endDate)

            XCTAssert(datePeriod.isValid == false)
        }

        do {
            let startDate = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: 34, second: 56))
            let endDate = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: 34, second: 56))

            let datePeriod = TagDatePeriod(start: startDate, end: endDate)

            XCTAssert(datePeriod.start == startDate)
            XCTAssert(datePeriod.end == endDate)

            XCTAssert(datePeriod.isValid == true)
        }

        do {
            let startDate = TagDate(year: 0, month: 13, day: 32, time: TagTime(hour: 24, minute: 60, second: 60))
            let endDate = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: 34, second: 56))

            let datePeriod = TagDatePeriod(start: startDate, end: endDate)

            XCTAssert(datePeriod.start == startDate)
            XCTAssert(datePeriod.end == endDate)

            XCTAssert(datePeriod.isValid == false)
        }

        do {
            let startDate = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: 34, second: 56))
            let endDate = TagDate(year: 0, month: 13, day: 32, time: TagTime(hour: 24, minute: 60, second: 60))

            let datePeriod = TagDatePeriod(start: startDate, end: endDate)

            XCTAssert(datePeriod.start == startDate)
            XCTAssert(datePeriod.end == endDate)

            XCTAssert(datePeriod.isValid == false)
        }

        do {
            let startDate = TagDate(year: 0, month: 13, day: 32, time: TagTime(hour: 24, minute: 60, second: 60))
            let endDate = TagDate(year: 0, month: 13, day: 32, time: TagTime(hour: 24, minute: 60, second: 60))

            let datePeriod = TagDatePeriod(start: startDate, end: endDate)

            XCTAssert(datePeriod.start == startDate)
            XCTAssert(datePeriod.end == endDate)

            XCTAssert(datePeriod.isValid == false)
        }
    }

    // MARK:

    func testComparable() {
        do {
            let startDate1 = TagDate(year: 1998, month: 2, day: 13, time: TagTime(hour: 12, minute: 43, second: 5))
            let endDate1 = TagDate(year: 2001, month: 1, day: 31, time: TagTime(hour: 21, minute: 34, second: 6))

            let datePeriod1 = TagDatePeriod(start: startDate1, end: endDate1)

            let startDate2 = TagDate(year: 1998, month: 2, day: 13, time: TagTime(hour: 12, minute: 43, second: 5))
            let endDate2 = TagDate(year: 2001, month: 1, day: 31, time: TagTime(hour: 21, minute: 34, second: 6))

            let datePeriod2 = TagDatePeriod(start: startDate2, end: endDate2)

            XCTAssertFalse(datePeriod1 < datePeriod2)
            XCTAssertFalse(datePeriod1 > datePeriod2)

            XCTAssert(datePeriod1 <= datePeriod2)
            XCTAssert(datePeriod1 >= datePeriod2)
        }

        do {
            let startDate1 = TagDate(year: 1998, month: 2, day: 13, time: TagTime(hour: 12, minute: 43, second: 5))
            let endDate1 = TagDate(year: 2001, month: 1, day: 31, time: TagTime(hour: 21, minute: 34, second: 6))

            let datePeriod1 = TagDatePeriod(start: startDate1, end: endDate1)

            let startDate2 = TagDate(year: 2001, month: 1, day: 31, time: TagTime(hour: 21, minute: 34, second: 6))
            let endDate2 = TagDate(year: 2001, month: 1, day: 31, time: TagTime(hour: 21, minute: 34, second: 6))

            let datePeriod2 = TagDatePeriod(start: startDate2, end: endDate2)

            XCTAssert(datePeriod1 < datePeriod2)
            XCTAssert(datePeriod2 > datePeriod1)

            XCTAssert(datePeriod1 <= datePeriod2)
            XCTAssert(datePeriod2 >= datePeriod1)
        }

        do {
            let startDate1 = TagDate(year: 1998, month: 2, day: 13, time: TagTime(hour: 12, minute: 43, second: 5))
            let endDate1 = TagDate(year: 1998, month: 2, day: 13, time: TagTime(hour: 12, minute: 43, second: 5))

            let datePeriod1 = TagDatePeriod(start: startDate1, end: endDate1)

            let startDate2 = TagDate(year: 1998, month: 2, day: 13, time: TagTime(hour: 12, minute: 43, second: 5))
            let endDate2 = TagDate(year: 2001, month: 1, day: 31, time: TagTime(hour: 21, minute: 34, second: 6))

            let datePeriod2 = TagDatePeriod(start: startDate2, end: endDate2)

            XCTAssertFalse(datePeriod1 < datePeriod2)
            XCTAssertFalse(datePeriod1 > datePeriod2)

            XCTAssert(datePeriod1 <= datePeriod2)
            XCTAssert(datePeriod1 >= datePeriod2)
        }

        do {
            let startDate1 = TagDate(year: 1998, month: 2, day: 13, time: TagTime(hour: 12, minute: 43, second: 5))
            let endDate1 = TagDate(year: 1998, month: 2, day: 13, time: TagTime(hour: 12, minute: 43, second: 5))

            let datePeriod1 = TagDatePeriod(start: startDate1, end: endDate1)

            let startDate2 = TagDate(year: 2001, month: 1, day: 31, time: TagTime(hour: 21, minute: 34, second: 6))
            let endDate2 = TagDate(year: 2001, month: 1, day: 31, time: TagTime(hour: 21, minute: 34, second: 6))

            let datePeriod2 = TagDatePeriod(start: startDate2, end: endDate2)

            XCTAssert(datePeriod1 < datePeriod2)
            XCTAssert(datePeriod2 > datePeriod1)

            XCTAssert(datePeriod1 <= datePeriod2)
            XCTAssert(datePeriod2 >= datePeriod1)
        }
    }

    func testEquatable() {
        do {
            let startDate1 = TagDate(year: 1998, month: 2, day: 13, time: TagTime(hour: 12, minute: 43, second: 5))
            let endDate1 = TagDate(year: 2001, month: 1, day: 31, time: TagTime(hour: 21, minute: 34, second: 6))

            let datePeriod1 = TagDatePeriod(start: startDate1, end: endDate1)

            let startDate2 = TagDate(year: 1998, month: 2, day: 13, time: TagTime(hour: 12, minute: 43, second: 5))
            let endDate2 = TagDate(year: 2001, month: 1, day: 31, time: TagTime(hour: 21, minute: 34, second: 6))

            let datePeriod2 = TagDatePeriod(start: startDate2, end: endDate2)

            XCTAssert(datePeriod1 == datePeriod2)
        }

        do {
            let startDate1 = TagDate(year: 2001, month: 1, day: 31, time: TagTime(hour: 21, minute: 34, second: 6))
            let endDate1 = TagDate(year: 2001, month: 1, day: 31, time: TagTime(hour: 21, minute: 34, second: 6))

            let datePeriod1 = TagDatePeriod(start: startDate1, end: endDate1)

            let startDate2 = TagDate(year: 1998, month: 2, day: 13, time: TagTime(hour: 12, minute: 43, second: 5))
            let endDate2 = TagDate(year: 2001, month: 1, day: 31, time: TagTime(hour: 21, minute: 34, second: 6))

            let datePeriod2 = TagDatePeriod(start: startDate2, end: endDate2)

            XCTAssert(datePeriod1 != datePeriod2)
        }

        do {
            let startDate1 = TagDate(year: 1998, month: 2, day: 13, time: TagTime(hour: 12, minute: 43, second: 5))
            let endDate1 = TagDate(year: 1998, month: 2, day: 13, time: TagTime(hour: 12, minute: 43, second: 5))

            let datePeriod1 = TagDatePeriod(start: startDate1, end: endDate1)

            let startDate2 = TagDate(year: 1998, month: 2, day: 13, time: TagTime(hour: 12, minute: 43, second: 5))
            let endDate2 = TagDate(year: 2001, month: 1, day: 31, time: TagTime(hour: 21, minute: 34, second: 6))

            let datePeriod2 = TagDatePeriod(start: startDate2, end: endDate2)

            XCTAssert(datePeriod1 != datePeriod2)
        }

        do {
            let startDate1 = TagDate(year: 1998, month: 2, day: 13, time: TagTime(hour: 12, minute: 43, second: 5))
            let endDate1 = TagDate(year: 1998, month: 2, day: 13, time: TagTime(hour: 12, minute: 43, second: 5))

            let datePeriod1 = TagDatePeriod(start: startDate1, end: endDate1)

            let startDate2 = TagDate(year: 2001, month: 1, day: 31, time: TagTime(hour: 21, minute: 34, second: 6))
            let endDate2 = TagDate(year: 2001, month: 1, day: 31, time: TagTime(hour: 21, minute: 34, second: 6))

            let datePeriod2 = TagDatePeriod(start: startDate2, end: endDate2)

            XCTAssert(datePeriod1 != datePeriod2)
        }
    }

    // MARK:

    func testReset() {
        let startDate = TagDate(year: 1998, month: 2, day: 13, time: TagTime(hour: 12, minute: 43, second: 5))
        let endDate = TagDate(year: 2001, month: 1, day: 31, time: TagTime(hour: 21, minute: 34, second: 6))

        var datePeriod = TagDatePeriod(start: startDate, end: endDate)

        datePeriod.reset()

        XCTAssert(datePeriod.start == TagDate())
        XCTAssert(datePeriod.end == TagDate())

        XCTAssert(datePeriod.isValid == false)
    }
}
