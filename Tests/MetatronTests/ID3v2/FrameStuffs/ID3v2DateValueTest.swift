//
//  ID3v2DateValueTest.swift
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

class ID3v2DateValueTest: XCTestCase {

    // MARK: Instance Methods

    func test() {
        let stuff = ID3v2TextInformation()

        do {
            stuff.dateValue = TagDate()

            XCTAssert(stuff.dateValue == TagDate())
            XCTAssert(stuff.fields == [])
        }

        do {
            stuff.dateValue = TagDate(year: 10000)

            XCTAssert(stuff.dateValue == TagDate())
            XCTAssert(stuff.fields == [])
        }

        do {
            stuff.dateValue = TagDate(year: 1998, month: 0)

            XCTAssert(stuff.dateValue == TagDate())
            XCTAssert(stuff.fields == [])
        }

        do {
            stuff.dateValue = TagDate(year: 1998, month: 13)

            XCTAssert(stuff.dateValue == TagDate())
            XCTAssert(stuff.fields == [])
        }

        do {
            stuff.dateValue = TagDate(year: 1998, day: 0)

            XCTAssert(stuff.dateValue == TagDate())
            XCTAssert(stuff.fields == [])
        }

        do {
            stuff.dateValue = TagDate(year: 1998, day: 32)

            XCTAssert(stuff.dateValue == TagDate())
            XCTAssert(stuff.fields == [])
        }

        do {
            stuff.dateValue = TagDate(year: 1998, time: TagTime(hour: -1))

            XCTAssert(stuff.dateValue == TagDate())
            XCTAssert(stuff.fields == [])
        }

        do {
            stuff.dateValue = TagDate(year: 1998, time: TagTime(hour: 24))

            XCTAssert(stuff.dateValue == TagDate())
            XCTAssert(stuff.fields == [])
        }

        do {
            stuff.dateValue = TagDate(year: 1998, time: TagTime(hour: 0, minute: -1))

            XCTAssert(stuff.dateValue == TagDate())
            XCTAssert(stuff.fields == [])
        }

        do {
            stuff.dateValue = TagDate(year: 1998, time: TagTime(hour: 0, minute: 60))

            XCTAssert(stuff.dateValue == TagDate())
            XCTAssert(stuff.fields == [])
        }

        do {
            stuff.dateValue = TagDate(year: 1998, time: TagTime(hour: 0, second: -1))

            XCTAssert(stuff.dateValue == TagDate())
            XCTAssert(stuff.fields == [])
        }

        do {
            stuff.dateValue = TagDate(year: 1998, time: TagTime(hour: 0, second: 60))

            XCTAssert(stuff.dateValue == TagDate())
            XCTAssert(stuff.fields == [])
        }

        for year in 1998..<2001 {
            for month in 1..<13 {
                for day in 1..<28 {
                    var time = TagTime()

                    time.hour = Int(arc4random_uniform(24))
                    time.minute = Int(arc4random_uniform(60))
                    time.second = Int(arc4random_uniform(60))

                    stuff.dateValue = TagDate(year: year, month: month, day: day, time: time)

                    XCTAssert(stuff.dateValue == TagDate(year: year, month: month, day: day, time: time))
                }
            }
        }

        do {
            stuff.fields = []

            XCTAssert(stuff.dateValue == TagDate())
        }

        do {
            stuff.fields = ["198"]

            XCTAssert(stuff.dateValue == TagDate())
        }

        do {
            stuff.fields = ["1998-1"]

            XCTAssert(stuff.dateValue == TagDate())
        }

        do {
            stuff.fields = ["1998-12-3"]

            XCTAssert(stuff.dateValue == TagDate())
        }

        do {
            stuff.fields = ["-998-12-31"]

            XCTAssert(stuff.dateValue == TagDate())
        }

        do {
            stuff.fields = ["1998--2-31"]

            XCTAssert(stuff.dateValue == TagDate())
        }

        do {
            stuff.fields = ["1998-12--1"]

            XCTAssert(stuff.dateValue == TagDate())
        }

        do {
            stuff.fields = ["1998:12-31"]

            XCTAssert(stuff.dateValue == TagDate())
        }

        do {
            stuff.fields = ["1998-12:31"]

            XCTAssert(stuff.dateValue == TagDate())
        }

        do {
            stuff.fields = ["1998:12:31"]

            XCTAssert(stuff.dateValue == TagDate())
        }

        do {
            stuff.fields = ["1998-12-31 1"]

            XCTAssert(stuff.dateValue == TagDate())
        }

        do {
            stuff.fields = ["1998-12-31 12:3"]

            XCTAssert(stuff.dateValue == TagDate())
        }

        do {
            stuff.fields = ["1998-12-31 12:34:5"]

            XCTAssert(stuff.dateValue == TagDate())
        }

        do {
            stuff.fields = ["1998-12-31 1"]

            XCTAssert(stuff.dateValue == TagDate())
        }

        do {
            stuff.fields = ["1998-12-31 12:3"]

            XCTAssert(stuff.dateValue == TagDate())
        }

        do {
            stuff.fields = ["1998-12-31 12:34:5"]

            XCTAssert(stuff.dateValue == TagDate())
        }

        do {
            stuff.fields = ["1998-12-31 :2:34:56"]

            XCTAssert(stuff.dateValue == TagDate())
        }

        do {
            stuff.fields = ["1998-12-31 12::4:56"]

            XCTAssert(stuff.dateValue == TagDate())
        }

        do {
            stuff.fields = ["1998-12-31 12:34::6"]

            XCTAssert(stuff.dateValue == TagDate())
        }

        do {
            stuff.fields = ["1998-12-31 -2:34:56"]

            XCTAssert(stuff.dateValue == TagDate())
        }

        do {
            stuff.fields = ["1998-12-31 12:-4:56"]

            XCTAssert(stuff.dateValue == TagDate())
        }

        do {
            stuff.fields = ["1998-12-31 12:34:-6"]

            XCTAssert(stuff.dateValue == TagDate())
        }

        do {
            stuff.fields = ["1998-12-31 12-34:56"]

            XCTAssert(stuff.dateValue == TagDate())
        }

        do {
            stuff.fields = ["1998-12-31 12:34-56"]

            XCTAssert(stuff.dateValue == TagDate())
        }

        do {
            stuff.fields = ["1998-12-31 12-34-56"]

            XCTAssert(stuff.dateValue == TagDate())
        }

        do {
            stuff.fields = ["1998"]

            let value = stuff.dateValue

            XCTAssert((value.year == 1998) && (value.month == 1) && (value.day == 1) && (value.time.isMidnight))
        }

        do {
            stuff.fields = ["1998-12"]

            let value = stuff.dateValue

            XCTAssert((value.year == 1998) && (value.month == 12) && (value.day == 1) && (value.time.isMidnight))
        }

        do {
            stuff.fields = ["1998-12-31"]

            let value = stuff.dateValue

            XCTAssert((value.year == 1998) && (value.month == 12) && (value.day == 31) && (value.time.isMidnight))
        }

        do {
            stuff.fields = ["1998-12-31T12"]

            let value = stuff.dateValue

            XCTAssert((value.year == 1998) && (value.month == 12) && (value.day == 31))
            XCTAssert((value.time.hour == 12) && (value.time.minute == 0) && (value.time.second == 0))
        }

        do {
            stuff.fields = ["1998-12-31T12:34"]

            let value = stuff.dateValue

            XCTAssert((value.year == 1998) && (value.month == 12) && (value.day == 31))
            XCTAssert((value.time.hour == 12) && (value.time.minute == 34) && (value.time.second == 0))
        }

        do {
            stuff.fields = ["1998-12-31T12:34:56"]

            let value = stuff.dateValue

            XCTAssert((value.year == 1998) && (value.month == 12) && (value.day == 31))
            XCTAssert((value.time.hour == 12) && (value.time.minute == 34) && (value.time.second == 56))
        }

        do {
            stuff.fields = ["1998-12-31 12"]

            let value = stuff.dateValue

            XCTAssert((value.year == 1998) && (value.month == 12) && (value.day == 31))
            XCTAssert((value.time.hour == 12) && (value.time.minute == 0) && (value.time.second == 0))
        }

        do {
            stuff.fields = ["1998-12-31 12:34"]

            let value = stuff.dateValue

            XCTAssert((value.year == 1998) && (value.month == 12) && (value.day == 31))
            XCTAssert((value.time.hour == 12) && (value.time.minute == 34) && (value.time.second == 0))
        }

        do {
            stuff.fields = ["1998-12-31 12:34:56"]

            let value = stuff.dateValue

            XCTAssert((value.year == 1998) && (value.month == 12) && (value.day == 31))
            XCTAssert((value.time.hour == 12) && (value.time.minute == 34) && (value.time.second == 56))
        }

        do {
            stuff.fields = ["1998-99"]

            let value = stuff.dateValue

            XCTAssert((value.year == 1998) && (value.month == 99) && (value.day == 1) && (value.time.isMidnight))
        }

        do {
            stuff.fields = ["1998-12-99"]

            let value = stuff.dateValue

            XCTAssert((value.year == 1998) && (value.month == 12) && (value.day == 99) && (value.time.isMidnight))
        }

        do {
            stuff.fields = ["1998-12-31T99"]

            let value = stuff.dateValue

            XCTAssert((value.year == 1998) && (value.month == 12) && (value.day == 31))
            XCTAssert((value.time.hour == 99) && (value.time.minute == 0) && (value.time.second == 0))
        }

        do {
            stuff.fields = ["1998-12-31T12:99"]

            let value = stuff.dateValue

            XCTAssert((value.year == 1998) && (value.month == 12) && (value.day == 31))
            XCTAssert((value.time.hour == 12) && (value.time.minute == 99) && (value.time.second == 0))
        }

        do {
            stuff.fields = ["1998-12-31T12:34:99"]

            let value = stuff.dateValue

            XCTAssert((value.year == 1998) && (value.month == 12) && (value.day == 31))
            XCTAssert((value.time.hour == 12) && (value.time.minute == 34) && (value.time.second == 99))
        }

        do {
            stuff.fields = ["9999-99-99 99:99:99"]

            let value = stuff.dateValue

            XCTAssert((value.year == 9999) && (value.month == 99) && (value.day == 99))
            XCTAssert((value.time.hour == 99) && (value.time.minute == 99) && (value.time.second == 99))
        }
    }
}
