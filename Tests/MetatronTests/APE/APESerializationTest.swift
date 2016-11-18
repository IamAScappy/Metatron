//
//  APESerializationTest.swift
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

class APESerializationTest: XCTestCase {

    // MARK: Instance Methods

    func testString() {
        XCTAssert(APESerialization.dataFromString("") == [])

        XCTAssert(APESerialization.stringFromData([]) == nil)

        do {
            let value = "Abc 123"

            let data = APESerialization.dataFromString(value)

            XCTAssert(!data.isEmpty)

            guard let other = APESerialization.stringFromData(data) else {
                return XCTFail()
            }

            XCTAssert(other == value)
        }

        do {
            let value = "Абв 123"

            let data = APESerialization.dataFromString(value)

            XCTAssert(!data.isEmpty)

            guard let other = APESerialization.stringFromData(data) else {
                return XCTFail()
            }

            XCTAssert(other == value)
        }

        do {
            let value = Array<String>(repeating: "Abc", count: 123).joined(separator: "\n")

            let data = APESerialization.dataFromString(value)

            XCTAssert(!data.isEmpty)

            guard let other = APESerialization.stringFromData(data) else {
                return XCTFail()
            }

            XCTAssert(other == value)
        }

        do {
            guard let value = APESerialization.stringFromData([0]) else {
                return XCTFail()
            }

            XCTAssert(value == "")
        }

        do {
            guard let value = APESerialization.stringFromData([UInt8](String("Abc 1\0Abc 2").utf8)) else {
                return XCTFail()
            }

            XCTAssert(value == "Abc 1")
        }
    }

    func testStringList() {
        XCTAssert(APESerialization.dataFromStringList([]) == [])
        XCTAssert(APESerialization.dataFromStringList([""]) == [])

        XCTAssert(APESerialization.stringListFromData([]) == nil)

        do {
            let value = ["Abc 123"]

            let data = APESerialization.dataFromStringList(value)

            XCTAssert(!data.isEmpty)

            guard let other = APESerialization.stringListFromData(data) else {
                return XCTFail()
            }

            XCTAssert(other == value)
        }

        do {
            let value = ["Абв 123"]

            let data = APESerialization.dataFromStringList(value)

            XCTAssert(!data.isEmpty)

            guard let other = APESerialization.stringListFromData(data) else {
                return XCTFail()
            }

            XCTAssert(other == value)
        }

        do {
            let value = ["Abc 1", "Abc 2"]

            let data = APESerialization.dataFromStringList(value)

            XCTAssert(!data.isEmpty)

            guard let other = APESerialization.stringListFromData(data) else {
                return XCTFail()
            }

            XCTAssert(other == value)
        }

        do {
            let value = ["", "Abc 2"]

            let data = APESerialization.dataFromStringList(value)

            XCTAssert(!data.isEmpty)

            guard let other = APESerialization.stringListFromData(data) else {
                return XCTFail()
            }

            XCTAssert(other == value)
        }

        do {
            let value = ["Abc 1", ""]

            let data = APESerialization.dataFromStringList(value)

            XCTAssert(!data.isEmpty)

            guard let other = APESerialization.stringListFromData(data) else {
                return XCTFail()
            }

            XCTAssert(other == value)
        }

        do {
            let value = ["", ""]

            let data = APESerialization.dataFromStringList(value)

            XCTAssert(!data.isEmpty)

            guard let other = APESerialization.stringListFromData(data) else {
                return XCTFail()
            }

            XCTAssert(other == value)
        }

        do {
            let value = [Array<String>(repeating: "Abc", count: 123).joined(separator: "\n")]

            let data = APESerialization.dataFromStringList(value)

            XCTAssert(!data.isEmpty)

            guard let other = APESerialization.stringListFromData(data) else {
                return XCTFail()
            }

            XCTAssert(other == value)
        }

        do {
            let value = Array<String>(repeating: "Abc", count: 123)

            let data = APESerialization.dataFromStringList(value)

            XCTAssert(!data.isEmpty)

            guard let other = APESerialization.stringListFromData(data) else {
                return XCTFail()
            }

            XCTAssert(other == value)
        }

        do {
            guard let value = APESerialization.stringListFromData([UInt8](String("Abc 1\0Abc 2").utf8)) else {
                return XCTFail()
            }

            XCTAssert(value == ["Abc 1", "Abc 2"])
        }

        do {
            guard let value = APESerialization.stringListFromData([UInt8](String("\0Abc 2").utf8)) else {
                return XCTFail()
            }

            XCTAssert(value == ["", "Abc 2"])
        }

        do {
            guard let value = APESerialization.stringListFromData([UInt8](String("Abc 1\0").utf8)) else {
                return XCTFail()
            }

            XCTAssert(value == ["Abc 1", ""])
        }

        do {
            guard let value = APESerialization.stringListFromData([0]) else {
                return XCTFail()
            }

            XCTAssert(value == ["", ""])
        }
    }

    func testNumber() {
        XCTAssert(APESerialization.dataFromNumber(TagNumber()) == [])

        XCTAssert(APESerialization.dataFromNumber(TagNumber(0, total: 12)) == [])
        XCTAssert(APESerialization.dataFromNumber(TagNumber(34, total: 12)) == [])

        XCTAssert(APESerialization.dataFromNumber(TagNumber(-12, total: 34)) == [])
        XCTAssert(APESerialization.dataFromNumber(TagNumber(12, total: -34)) == [])
        XCTAssert(APESerialization.dataFromNumber(TagNumber(-12, total: -34)) == [])

        XCTAssert(APESerialization.numberFromData([]) == nil)

        XCTAssert(APESerialization.numberFromData([UInt8](String("/1234").utf8)) == nil)
        XCTAssert(APESerialization.numberFromData([UInt8](String("1234/").utf8)) == nil)

        XCTAssert(APESerialization.numberFromData([UInt8](String("12//34").utf8)) == nil)

        XCTAssert(APESerialization.numberFromData([UInt8](String("12:34").utf8)) == nil)
        XCTAssert(APESerialization.numberFromData([UInt8](String("12-34").utf8)) == nil)

        do {
            let value = TagNumber(12)

            let data = APESerialization.dataFromNumber(value)

            XCTAssert(!data.isEmpty)

            guard let other = APESerialization.numberFromData(data) else {
                return XCTFail()
            }

            XCTAssert(other == value)
        }

        do {
            let value = TagNumber(12, total: 34)

            let data = APESerialization.dataFromNumber(value)

            XCTAssert(!data.isEmpty)

            guard let other = APESerialization.numberFromData(data) else {
                return XCTFail()
            }

            XCTAssert(other == value)
        }

        do {
            guard let value = APESerialization.numberFromData([UInt8](String("0").utf8)) else {
                return XCTFail()
            }

            XCTAssert((value.value == 0) && (value.total == 0))
        }

        do {
            guard let value = APESerialization.numberFromData([UInt8](String("12").utf8)) else {
                return XCTFail()
            }

            XCTAssert((value.value == 12) && (value.total == 0))
        }

        do {
            guard let value = APESerialization.numberFromData([UInt8](String("12/34").utf8)) else {
                return XCTFail()
            }

            XCTAssert((value.value == 12) && (value.total == 34))
        }

        do {
            guard let value = APESerialization.numberFromData([UInt8](String("12/0").utf8)) else {
                return XCTFail()
            }

            XCTAssert((value.value == 12) && (value.total == 0))
        }

        do {
            guard let value = APESerialization.numberFromData([UInt8](String("0/12").utf8)) else {
                return XCTFail()
            }

            XCTAssert((value.value == 0) && (value.total == 12))
        }

        do {
            guard let value = APESerialization.numberFromData([UInt8](String("34/12").utf8)) else {
                return XCTFail()
            }

            XCTAssert((value.value == 34) && (value.total == 12))
        }

        do {
            guard let value = APESerialization.numberFromData([UInt8](String("-12/34").utf8)) else {
                return XCTFail()
            }

            XCTAssert((value.value == -12) && (value.total == 34))
        }

        do {
            guard let value = APESerialization.numberFromData([UInt8](String("12/-34").utf8)) else {
                return XCTFail()
            }

            XCTAssert((value.value == 12) && (value.total == -34))
        }

        do {
            guard let value = APESerialization.numberFromData([UInt8](String("-12/-34").utf8)) else {
                return XCTFail()
            }

            XCTAssert((value.value == -12) && (value.total == -34))
        }
    }

    func testTime() {
        XCTAssert(APESerialization.dataFromTime(TagTime(hour: -1)) == [])
        XCTAssert(APESerialization.dataFromTime(TagTime(hour: 24)) == [])

        XCTAssert(APESerialization.dataFromTime(TagTime(hour: 12, minute: -1)) == [])
        XCTAssert(APESerialization.dataFromTime(TagTime(hour: 12, minute: 60)) == [])

        XCTAssert(APESerialization.dataFromTime(TagTime(hour: 12, second: -1)) == [])
        XCTAssert(APESerialization.dataFromTime(TagTime(hour: 12, second: 60)) == [])

        XCTAssert(APESerialization.timeFromData([]) == nil)

        XCTAssert(APESerialization.timeFromData([UInt8](String("1").utf8)) == nil)
        XCTAssert(APESerialization.timeFromData([UInt8](String("12:3").utf8)) == nil)
        XCTAssert(APESerialization.timeFromData([UInt8](String("12:34:5").utf8)) == nil)

        XCTAssert(APESerialization.timeFromData([UInt8](String(":2:34:56").utf8)) == nil)
        XCTAssert(APESerialization.timeFromData([UInt8](String("12::4:56").utf8)) == nil)
        XCTAssert(APESerialization.timeFromData([UInt8](String("12:34::6").utf8)) == nil)

        XCTAssert(APESerialization.timeFromData([UInt8](String("-2:34:56").utf8)) == nil)
        XCTAssert(APESerialization.timeFromData([UInt8](String("12:-4:56").utf8)) == nil)
        XCTAssert(APESerialization.timeFromData([UInt8](String("12:34:-6").utf8)) == nil)

        XCTAssert(APESerialization.timeFromData([UInt8](String("12-34:56").utf8)) == nil)
        XCTAssert(APESerialization.timeFromData([UInt8](String("12:34-56").utf8)) == nil)
        XCTAssert(APESerialization.timeFromData([UInt8](String("12-34-56").utf8)) == nil)

        for hour in 0..<24 {
            for minute in 0..<60 {
                for second in 0..<60 {
                    let value = TagTime(hour: hour, minute: minute, second: second)

                    let data = APESerialization.dataFromTime(value)

                    XCTAssert(!data.isEmpty)

                    guard let other = APESerialization.timeFromData(data) else {
                        return XCTFail()
                    }

                    XCTAssert(other == value)
                }
            }
        }

        do {
            guard let value = APESerialization.timeFromData([UInt8](String("12").utf8)) else {
                return XCTFail()
            }

            XCTAssert((value.hour == 12) && (value.minute == 0) && (value.second == 0))
        }

        do {
            guard let value = APESerialization.timeFromData([UInt8](String("12:34").utf8)) else {
                return XCTFail()
            }

            XCTAssert((value.hour == 12) && (value.minute == 34) && (value.second == 0))
        }

        do {
            guard let value = APESerialization.timeFromData([UInt8](String("12:34:56").utf8)) else {
                return XCTFail()
            }

            XCTAssert((value.hour == 12) && (value.minute == 34) && (value.second == 56))
        }

        do {
            guard let value = APESerialization.timeFromData([UInt8](String("99").utf8)) else {
                return XCTFail()
            }

            XCTAssert((value.hour == 99) && (value.minute == 0) && (value.second == 0))
        }

        do {
            guard let value = APESerialization.timeFromData([UInt8](String("12:99").utf8)) else {
                return XCTFail()
            }

            XCTAssert((value.hour == 12) && (value.minute == 99) && (value.second == 0))
        }

        do {
            guard let value = APESerialization.timeFromData([UInt8](String("12:34:99").utf8)) else {
                return XCTFail()
            }

            XCTAssert((value.hour == 12) && (value.minute == 34) && (value.second == 99))
        }

        do {
            guard let value = APESerialization.timeFromData([UInt8](String("99:99:99").utf8)) else {
                return XCTFail()
            }

            XCTAssert((value.hour == 99) && (value.minute == 99) && (value.second == 99))
        }
    }

    func testTimePeriod() {
        XCTAssert(APESerialization.dataFromTimePeriod(TagTimePeriod(start: TagTime(hour: -1), end: TagTime(hour: -1))) == [])
        XCTAssert(APESerialization.dataFromTimePeriod(TagTimePeriod(start: TagTime(hour: 1), end: TagTime(hour: -1))) == [])
        XCTAssert(APESerialization.dataFromTimePeriod(TagTimePeriod(start: TagTime(hour: -1), end: TagTime(hour: 2))) == [])
        XCTAssert(APESerialization.dataFromTimePeriod(TagTimePeriod(start: TagTime(hour: 2), end: TagTime(hour: 1))) == [])

        XCTAssert(APESerialization.timePeriodFromData([]) == nil)

        XCTAssert(APESerialization.timePeriodFromData([UInt8](String("2:43...1:34").utf8)) == nil)
        XCTAssert(APESerialization.timePeriodFromData([UInt8](String("12:43...1:34").utf8)) == nil)
        XCTAssert(APESerialization.timePeriodFromData([UInt8](String("2:43...21:34").utf8)) == nil)

        XCTAssert(APESerialization.timePeriodFromData([UInt8](String("12:43.   .21:34").utf8)) == nil)
        XCTAssert(APESerialization.timePeriodFromData([UInt8](String("12:43. . .21:34").utf8)) == nil)
        XCTAssert(APESerialization.timePeriodFromData([UInt8](String("12:43 ... 21:34").utf8)) == nil)

        XCTAssert(APESerialization.timePeriodFromData([UInt8](String("12:43.21:34").utf8)) == nil)
        XCTAssert(APESerialization.timePeriodFromData([UInt8](String("12.43.21.34").utf8)) == nil)

        XCTAssert(APESerialization.timePeriodFromData([UInt8](String("12:43...").utf8)) == nil)
        XCTAssert(APESerialization.timePeriodFromData([UInt8](String("...21:34").utf8)) == nil)

        do {
            let start = TagTime(hour: 12, minute: 43, second: 5)
            let end = TagTime(hour: 21, minute: 34, second: 6)

            let value = TagTimePeriod(start: start, end: end)

            let data = APESerialization.dataFromTimePeriod(value)

            XCTAssert(!data.isEmpty)

            guard let other = APESerialization.timePeriodFromData(data) else {
                return XCTFail()
            }

            XCTAssert(other == value)
        }

        do {
            let start = TagTime(hour: 12, minute: 34, second: 56)
            let end = TagTime(hour: 12, minute: 34, second: 56)

            let value = TagTimePeriod(start: start, end: end)

            let data = APESerialization.dataFromTimePeriod(value)

            XCTAssert(!data.isEmpty)

            guard let other = APESerialization.timePeriodFromData(data) else {
                return XCTFail()
            }

            XCTAssert(other == value)
        }

        do {
            let data = [UInt8](String("12:43:05...21:34:06").utf8)

            guard let value = APESerialization.timePeriodFromData(data) else {
                return XCTFail()
            }

            let start = value.start
            let end = value.end

            XCTAssert((start.hour == 12) && (start.minute == 43) && (start.second == 5))
            XCTAssert((end.hour == 21) && (end.minute == 34) && (end.second == 6))
        }

        do {
            let data = [UInt8](String("12:34:56...12:34:56").utf8)

            guard let value = APESerialization.timePeriodFromData(data) else {
                return XCTFail()
            }

            let start = value.start
            let end = value.end

            XCTAssert((start.hour == 12) && (start.minute == 34) && (start.second == 56))
            XCTAssert((end.hour == 12) && (end.minute == 34) && (end.second == 56))
        }

        do {
            let data = [UInt8](String("21:34:06...12:43:05").utf8)

            guard let value = APESerialization.timePeriodFromData(data) else {
                return XCTFail()
            }

            let start = value.start
            let end = value.end

            XCTAssert((start.hour == 21) && (start.minute == 34) && (start.second == 6))
            XCTAssert((end.hour == 12) && (end.minute == 43) && (end.second == 5))
        }

        do {
            let data = [UInt8](String("99:99:99...99:99:99").utf8)

            guard let value = APESerialization.timePeriodFromData(data) else {
                return XCTFail()
            }

            let start = value.start
            let end = value.end

            XCTAssert((start.hour == 99) && (start.minute == 99) && (start.second == 99))
            XCTAssert((end.hour == 99) && (end.minute == 99) && (end.second == 99))
        }
    }

    func testDate() {
        XCTAssert(APESerialization.dataFromDate(TagDate()) == [])

        XCTAssert(APESerialization.dataFromDate(TagDate(year: 10000)) == [])

        XCTAssert(APESerialization.dataFromDate(TagDate(year: 1998, month: 0)) == [])
        XCTAssert(APESerialization.dataFromDate(TagDate(year: 1998, month: 13)) == [])

        XCTAssert(APESerialization.dataFromDate(TagDate(year: 1998, day: 0)) == [])
        XCTAssert(APESerialization.dataFromDate(TagDate(year: 1998, day: 32)) == [])

        XCTAssert(APESerialization.dataFromDate(TagDate(year: 1998, time: TagTime(hour: -1))) == [])
        XCTAssert(APESerialization.dataFromDate(TagDate(year: 1998, time: TagTime(hour: 24))) == [])

        XCTAssert(APESerialization.dataFromDate(TagDate(year: 1998, time: TagTime(hour: 0, minute: -1))) == [])
        XCTAssert(APESerialization.dataFromDate(TagDate(year: 1998, time: TagTime(hour: 0, minute: 60))) == [])

        XCTAssert(APESerialization.dataFromDate(TagDate(year: 1998, time: TagTime(hour: 0, second: -1))) == [])
        XCTAssert(APESerialization.dataFromDate(TagDate(year: 1998, time: TagTime(hour: 0, second: 60))) == [])

        XCTAssert(APESerialization.dateFromData([]) == nil)

        XCTAssert(APESerialization.dateFromData([UInt8](String("198").utf8)) == nil)
        XCTAssert(APESerialization.dateFromData([UInt8](String("1998-1").utf8)) == nil)
        XCTAssert(APESerialization.dateFromData([UInt8](String("1998-12-3").utf8)) == nil)

        XCTAssert(APESerialization.dateFromData([UInt8](String("-998-12-31").utf8)) == nil)
        XCTAssert(APESerialization.dateFromData([UInt8](String("1998--2-31").utf8)) == nil)
        XCTAssert(APESerialization.dateFromData([UInt8](String("1998-12--1").utf8)) == nil)

        XCTAssert(APESerialization.dateFromData([UInt8](String("1998:12-31").utf8)) == nil)
        XCTAssert(APESerialization.dateFromData([UInt8](String("1998-12:31").utf8)) == nil)
        XCTAssert(APESerialization.dateFromData([UInt8](String("1998:12:31").utf8)) == nil)

        XCTAssert(APESerialization.dateFromData([UInt8](String("1998-12-31 1").utf8)) == nil)
        XCTAssert(APESerialization.dateFromData([UInt8](String("1998-12-31 12:3").utf8)) == nil)
        XCTAssert(APESerialization.dateFromData([UInt8](String("1998-12-31 12:34:5").utf8)) == nil)

        XCTAssert(APESerialization.dateFromData([UInt8](String("1998-12-31 1").utf8)) == nil)
        XCTAssert(APESerialization.dateFromData([UInt8](String("1998-12-31 12:3").utf8)) == nil)
        XCTAssert(APESerialization.dateFromData([UInt8](String("1998-12-31 12:34:5").utf8)) == nil)

        XCTAssert(APESerialization.dateFromData([UInt8](String("1998-12-31 :2:34:56").utf8)) == nil)
        XCTAssert(APESerialization.dateFromData([UInt8](String("1998-12-31 12::4:56").utf8)) == nil)
        XCTAssert(APESerialization.dateFromData([UInt8](String("1998-12-31 12:34::6").utf8)) == nil)

        XCTAssert(APESerialization.dateFromData([UInt8](String("1998-12-31 -2:34:56").utf8)) == nil)
        XCTAssert(APESerialization.dateFromData([UInt8](String("1998-12-31 12:-4:56").utf8)) == nil)
        XCTAssert(APESerialization.dateFromData([UInt8](String("1998-12-31 12:34:-6").utf8)) == nil)

        XCTAssert(APESerialization.dateFromData([UInt8](String("1998-12-31 12-34:56").utf8)) == nil)
        XCTAssert(APESerialization.dateFromData([UInt8](String("1998-12-31 12:34-56").utf8)) == nil)
        XCTAssert(APESerialization.dateFromData([UInt8](String("1998-12-31 12-34-56").utf8)) == nil)

        XCTAssert(APESerialization.dateFromData([UInt8](String("1998-W12-31").utf8)) == nil)
        XCTAssert(APESerialization.dateFromData([UInt8](String("1998-w12").utf8)) == nil)
        XCTAssert(APESerialization.dateFromData([UInt8](String("1998-W00").utf8)) == nil)
        XCTAssert(APESerialization.dateFromData([UInt8](String("1998-W54").utf8)) == nil)

        for year in 1998..<2001 {
            for month in 1..<13 {
                for day in 1..<28 {
                    var time = TagTime()

                    time.hour = Int(arc4random_uniform(24))
                    time.minute = Int(arc4random_uniform(60))
                    time.second = Int(arc4random_uniform(60))

                    let value = TagDate(year: year, month: month, day: day, time: time)

                    let data = APESerialization.dataFromDate(value)

                    XCTAssert(!data.isEmpty)

                    guard let other = APESerialization.dateFromData(data) else {
                        return XCTFail()
                    }

                    XCTAssert(other == value)
                }
            }
        }

        do {
            guard let value = APESerialization.dateFromData([UInt8](String("1998").utf8)) else {
                return XCTFail()
            }

            XCTAssert((value.year == 1998) && (value.month == 1) && (value.day == 1) && (value.time.isMidnight))
        }

        do {
            guard let value = APESerialization.dateFromData([UInt8](String("1998-W34").utf8)) else {
                return XCTFail()
            }

            XCTAssert((value.year == 1998) && (value.month == 1) && (value.day == 1) && (value.time.isMidnight))
        }

        do {
            guard let value = APESerialization.dateFromData([UInt8](String("1998-12").utf8)) else {
                return XCTFail()
            }

            XCTAssert((value.year == 1998) && (value.month == 12) && (value.day == 1) && (value.time.isMidnight))
        }

        do {
            guard let value = APESerialization.dateFromData([UInt8](String("1998-12-31").utf8)) else {
                return XCTFail()
            }

            XCTAssert((value.year == 1998) && (value.month == 12) && (value.day == 31) && (value.time.isMidnight))
        }

        do {
            guard let value = APESerialization.dateFromData([UInt8](String("1998-12-31 12").utf8)) else {
                return XCTFail()
            }

            XCTAssert((value.year == 1998) && (value.month == 12) && (value.day == 31))
            XCTAssert((value.time.hour == 12) && (value.time.minute == 0) && (value.time.second == 0))
        }

        do {
            guard let value = APESerialization.dateFromData([UInt8](String("1998-12-31 12:34").utf8)) else {
                return XCTFail()
            }

            XCTAssert((value.year == 1998) && (value.month == 12) && (value.day == 31))
            XCTAssert((value.time.hour == 12) && (value.time.minute == 34) && (value.time.second == 0))
        }

        do {
            guard let value = APESerialization.dateFromData([UInt8](String("1998-12-31 12:34:56").utf8)) else {
                return XCTFail()
            }

            XCTAssert((value.year == 1998) && (value.month == 12) && (value.day == 31))
            XCTAssert((value.time.hour == 12) && (value.time.minute == 34) && (value.time.second == 56))
        }

        do {
            guard let value = APESerialization.dateFromData([UInt8](String("1998-12-31T12").utf8)) else {
                return XCTFail()
            }

            XCTAssert((value.year == 1998) && (value.month == 12) && (value.day == 31))
            XCTAssert((value.time.hour == 12) && (value.time.minute == 0) && (value.time.second == 0))
        }

        do {
            guard let value = APESerialization.dateFromData([UInt8](String("1998-12-31T12:34").utf8)) else {
                return XCTFail()
            }

            XCTAssert((value.year == 1998) && (value.month == 12) && (value.day == 31))
            XCTAssert((value.time.hour == 12) && (value.time.minute == 34) && (value.time.second == 0))
        }

        do {
            guard let value = APESerialization.dateFromData([UInt8](String("1998-12-31T12:34:56").utf8)) else {
                return XCTFail()
            }

            XCTAssert((value.year == 1998) && (value.month == 12) && (value.day == 31))
            XCTAssert((value.time.hour == 12) && (value.time.minute == 34) && (value.time.second == 56))
        }

        do {
            guard let value = APESerialization.dateFromData([UInt8](String("1998-99").utf8)) else {
                return XCTFail()
            }

            XCTAssert((value.year == 1998) && (value.month == 99) && (value.day == 1) && (value.time.isMidnight))
        }

        do {
            guard let value = APESerialization.dateFromData([UInt8](String("1998-12-99").utf8)) else {
                return XCTFail()
            }

            XCTAssert((value.year == 1998) && (value.month == 12) && (value.day == 99) && (value.time.isMidnight))
        }

        do {
            guard let value = APESerialization.dateFromData([UInt8](String("1998-12-31 99").utf8)) else {
                return XCTFail()
            }

            XCTAssert((value.year == 1998) && (value.month == 12) && (value.day == 31))
            XCTAssert((value.time.hour == 99) && (value.time.minute == 0) && (value.time.second == 0))
        }

        do {
            guard let value = APESerialization.dateFromData([UInt8](String("1998-12-31 12:99").utf8)) else {
                return XCTFail()
            }

            XCTAssert((value.year == 1998) && (value.month == 12) && (value.day == 31))
            XCTAssert((value.time.hour == 12) && (value.time.minute == 99) && (value.time.second == 0))
        }

        do {
            guard let value = APESerialization.dateFromData([UInt8](String("1998-12-31 12:34:99").utf8)) else {
                return XCTFail()
            }

            XCTAssert((value.year == 1998) && (value.month == 12) && (value.day == 31))
            XCTAssert((value.time.hour == 12) && (value.time.minute == 34) && (value.time.second == 99))
        }

        do {
            guard let value = APESerialization.dateFromData([UInt8](String("9999-99-99 99:99:99").utf8)) else {
                return XCTFail()
            }

            XCTAssert((value.year == 9999) && (value.month == 99) && (value.day == 99))
            XCTAssert((value.time.hour == 99) && (value.time.minute == 99) && (value.time.second == 99))
        }
    }

    func testDatePeriod() {
        XCTAssert(APESerialization.dataFromDatePeriod(TagDatePeriod()) == [])

        XCTAssert(APESerialization.dataFromDatePeriod(TagDatePeriod(start: TagDate(year: 0), end: TagDate(year: 0))) == [])
        XCTAssert(APESerialization.dataFromDatePeriod(TagDatePeriod(start: TagDate(year: 1), end: TagDate(year: 0))) == [])
        XCTAssert(APESerialization.dataFromDatePeriod(TagDatePeriod(start: TagDate(year: 0), end: TagDate(year: 2))) == [])
        XCTAssert(APESerialization.dataFromDatePeriod(TagDatePeriod(start: TagDate(year: 2), end: TagDate(year: 1))) == [])

        XCTAssert(APESerialization.datePeriodFromData([]) == nil)
        XCTAssert(APESerialization.datePeriodFromData([0]) == nil)

        XCTAssert(APESerialization.datePeriodFromData([UInt8](String("198-02-13...201-01-31").utf8)) == nil)
        XCTAssert(APESerialization.datePeriodFromData([UInt8](String("1998-02-13...201-01-31").utf8)) == nil)
        XCTAssert(APESerialization.datePeriodFromData([UInt8](String("198-02-13...2001-01-31").utf8)) == nil)

        XCTAssert(APESerialization.datePeriodFromData([UInt8](String("1998-02-13.   .2001-01-31").utf8)) == nil)
        XCTAssert(APESerialization.datePeriodFromData([UInt8](String("1998-02-13. . .2001-01-31").utf8)) == nil)
        XCTAssert(APESerialization.datePeriodFromData([UInt8](String("1998-02-13 ... 2001-01-31").utf8)) == nil)

        XCTAssert(APESerialization.datePeriodFromData([UInt8](String("1998-02-13.2001-01-31").utf8)) == nil)
        XCTAssert(APESerialization.datePeriodFromData([UInt8](String("1998.02.13.2001.01.31").utf8)) == nil)

        XCTAssert(APESerialization.datePeriodFromData([UInt8](String("1998-02-13...").utf8)) == nil)
        XCTAssert(APESerialization.datePeriodFromData([UInt8](String("...2001-01-31").utf8)) == nil)

        do {
            let start = TagDate(year: 1998, month: 2, day: 13, time: TagTime(hour: 12, minute: 43, second: 5))
            let end = TagDate(year: 2001, month: 1, day: 31, time: TagTime(hour: 21, minute: 34, second: 6))

            let value = TagDatePeriod(start: start, end: end)

            let data = APESerialization.dataFromDatePeriod(value)

            XCTAssert(!data.isEmpty)

            guard let other = APESerialization.datePeriodFromData(data) else {
                return XCTFail()
            }

            XCTAssert(other == value)
        }

        do {
            let start = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: 34, second: 56))
            let end = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: 34, second: 56))

            let value = TagDatePeriod(start: start, end: end)

            let data = APESerialization.dataFromDatePeriod(value)

            XCTAssert(!data.isEmpty)

            guard let other = APESerialization.datePeriodFromData(data) else {
                return XCTFail()
            }

            XCTAssert(other == value)
        }

        do {
            let data = [UInt8](String("1998-02-13 12:43:05...2001-01-31 21:34:06").utf8)

            guard let value = APESerialization.datePeriodFromData(data) else {
                return XCTFail()
            }

            let start = value.start
            let end = value.end

            XCTAssert((start.year == 1998) && (start.month == 2) && (start.day == 13))
            XCTAssert((start.time.hour == 12) && (start.time.minute == 43) && (start.time.second == 5))

            XCTAssert((end.year == 2001) && (end.month == 1) && (end.day == 31))
            XCTAssert((end.time.hour == 21) && (end.time.minute == 34) && (end.time.second == 6))
        }

        do {
            let data = [UInt8](String("1998-12-31 12:34:56...1998-12-31 12:34:56").utf8)

            guard let value = APESerialization.datePeriodFromData(data) else {
                return XCTFail()
            }

            let start = value.start
            let end = value.end

            XCTAssert((start.year == 1998) && (start.month == 12) && (start.day == 31))
            XCTAssert((start.time.hour == 12) && (start.time.minute == 34) && (start.time.second == 56))

            XCTAssert((end.year == 1998) && (end.month == 12) && (end.day == 31))
            XCTAssert((end.time.hour == 12) && (end.time.minute == 34) && (end.time.second == 56))
        }

        do {
            let data = [UInt8](String("2001-01-31 21:34:06...1998-02-13 12:43:05").utf8)

            guard let value = APESerialization.datePeriodFromData(data) else {
                return XCTFail()
            }

            let start = value.start
            let end = value.end

            XCTAssert((start.year == 2001) && (start.month == 1) && (start.day == 31))
            XCTAssert((start.time.hour == 21) && (start.time.minute == 34) && (start.time.second == 6))

            XCTAssert((end.year == 1998) && (end.month == 2) && (end.day == 13))
            XCTAssert((end.time.hour == 12) && (end.time.minute == 43) && (end.time.second == 5))
        }

        do {
            let data = [UInt8](String("9999-99-99 99:99:99...9999-99-99 99:99:99").utf8)

            guard let value = APESerialization.datePeriodFromData(data) else {
                return XCTFail()
            }

            let start = value.start
            let end = value.end

            XCTAssert((start.year == 9999) && (start.month == 99) && (start.day == 99))
            XCTAssert((start.time.hour == 99) && (start.time.minute == 99) && (start.time.second == 99))

            XCTAssert((end.year == 9999) && (end.month == 99) && (end.day == 99))
            XCTAssert((end.time.hour == 99) && (end.time.minute == 99) && (end.time.second == 99))
        }
    }

    func testImage() {
        XCTAssert(APESerialization.dataFromImage(TagImage()) == [])

        XCTAssert(APESerialization.dataFromImage(TagImage(data: [], description: "Abc 123")) == [])
        XCTAssert(APESerialization.dataFromImage(TagImage(data: [], description: "Абв 123")) == [])

        XCTAssert(APESerialization.imageFromData([]) == nil)
        XCTAssert(APESerialization.imageFromData([1, 2, 3]) == nil)

        do {
            let value = TagImage(data: [1, 2, 3])

            let data = APESerialization.dataFromImage(value)

            XCTAssert(!data.isEmpty)

            guard let other = APESerialization.imageFromData(data) else {
                return XCTFail()
            }

            XCTAssert(other == value)
        }

        do {
            let value = TagImage(data: [1, 2, 3], description: "Abc 123")

            let data = APESerialization.dataFromImage(value)

            XCTAssert(!data.isEmpty)

            guard let other = APESerialization.imageFromData(data) else {
                return XCTFail()
            }

            XCTAssert(other == value)
        }

        do {
            let value = TagImage(data: [1, 2, 3], description: "Абв 123")

            let data = APESerialization.dataFromImage(value)

            XCTAssert(!data.isEmpty)

            guard let other = APESerialization.imageFromData(data) else {
                return XCTFail()
            }

            XCTAssert(other == value)
        }

        do {
            let value = TagImage(data: [0, 0, 0], description: "Abc 123")

            let data = APESerialization.dataFromImage(value)

            XCTAssert(!data.isEmpty)

            guard let other = APESerialization.imageFromData(data) else {
                return XCTFail()
            }

            XCTAssert(other == value)
        }

        do {
            guard let value = APESerialization.imageFromData([0]) else {
                return XCTFail()
            }

            XCTAssert((value.data == []) && (value.description == ""))
        }

        do {
            guard let value = APESerialization.imageFromData([0, 1, 2, 3]) else {
                return XCTFail()
            }

            XCTAssert((value.data == [1, 2, 3]) && (value.description == ""))
        }

        do {
            guard let value = APESerialization.imageFromData([0, 0, 0, 0]) else {
                return XCTFail()
            }

            XCTAssert((value.data == [0, 0, 0]) && (value.description == ""))
        }
    }

    func testTimeStamp() {
        XCTAssert(APESerialization.timeStampFromData([]) == nil)
        XCTAssert(APESerialization.timeStampFromData([0]) == nil)

        XCTAssert(APESerialization.timeStampFromData([UInt8](String("12:34:56:78").utf8)) == nil)
        XCTAssert(APESerialization.timeStampFromData([UInt8](String("12:34.56.78").utf8)) == nil)
        XCTAssert(APESerialization.timeStampFromData([UInt8](String("12.34.56.78").utf8)) == nil)

        XCTAssert(APESerialization.timeStampFromData([UInt8](String(":2:34:56.78").utf8)) == nil)
        XCTAssert(APESerialization.timeStampFromData([UInt8](String("12::4:56.78").utf8)) == nil)
        XCTAssert(APESerialization.timeStampFromData([UInt8](String("12:34::6.78").utf8)) == nil)
        XCTAssert(APESerialization.timeStampFromData([UInt8](String("12:34:56.:8").utf8)) == nil)

        XCTAssert(APESerialization.timeStampFromData([UInt8](String("12:-4:56.78").utf8)) == nil)
        XCTAssert(APESerialization.timeStampFromData([UInt8](String("12:34:-6.78").utf8)) == nil)
        XCTAssert(APESerialization.timeStampFromData([UInt8](String("12:34:56.-8").utf8)) == nil)

        XCTAssert(APESerialization.timeStampFromData([UInt8](String("12-34:56:78").utf8)) == nil)
        XCTAssert(APESerialization.timeStampFromData([UInt8](String("12:34-56:78").utf8)) == nil)
        XCTAssert(APESerialization.timeStampFromData([UInt8](String("12:34:56-78").utf8)) == nil)
        XCTAssert(APESerialization.timeStampFromData([UInt8](String("12-34-56-78").utf8)) == nil)

        for i: UInt in 0..<1234 {
            let value = i * 10

            let data = APESerialization.dataFromTimeStamp(value)

            XCTAssert(!data.isEmpty)

            guard let other = APESerialization.timeStampFromData(data) else {
                return XCTFail()
            }

            XCTAssert(other == value)
        }

        do {
            guard let value = APESerialization.timeStampFromData([UInt8](String("312").utf8)) else {
                return XCTFail()
            }

            XCTAssert(value == 312000)
        }

        do {
            guard let value = APESerialization.timeStampFromData([UInt8](String("5:12").utf8)) else {
                return XCTFail()
            }

            XCTAssert(value == 312000)
        }

        do {
            guard let value = APESerialization.timeStampFromData([UInt8](String("4:72").utf8)) else {
                return XCTFail()
            }

            XCTAssert(value == 312000)
        }

        do {
            guard let value = APESerialization.timeStampFromData([UInt8](String("312.33334").utf8)) else {
                return XCTFail()
            }

            XCTAssert(value == 312333)
        }

        do {
            guard let timeStamp = APESerialization.timeStampFromData([UInt8](String("5:12.33334").utf8)) else {
                return XCTFail()
            }

            XCTAssert(timeStamp == 312333)
        }

        do {
            guard let timeStamp = APESerialization.timeStampFromData([UInt8](String("312.3").utf8)) else {
                return XCTFail()
            }

            XCTAssert(timeStamp == 312300)
        }

        do {
            guard let timeStamp = APESerialization.timeStampFromData([UInt8](String("3621.4").utf8)) else {
                return XCTFail()
            }

            XCTAssert(timeStamp == 3621400)
        }

        do {
            guard let timeStamp = APESerialization.timeStampFromData([UInt8](String("1:00:21.4").utf8)) else {
                return XCTFail()
            }

            XCTAssert(timeStamp == 3621400)
        }
    }

    func testLyrics() {
        XCTAssert(APESerialization.dataFromLyrics(TagLyrics()) == [])

        XCTAssert(APESerialization.lyricsFromData([]) == nil)

        do {
            let value = TagLyrics(pieces: [TagLyrics.Piece("Abc 123")])

            let data = APESerialization.dataFromLyrics(value)

            XCTAssert(!data.isEmpty)

            guard let other = APESerialization.lyricsFromData(data) else {
                return XCTFail()
            }

            XCTAssert(other == value)
        }

        do {
            let value = TagLyrics(pieces: [TagLyrics.Piece("Абв 123")])

            let data = APESerialization.dataFromLyrics(value)

            XCTAssert(!data.isEmpty)

            guard let other = APESerialization.lyricsFromData(data) else {
                return XCTFail()
            }

            XCTAssert(other == value)
        }

        do {
            let value = TagLyrics(pieces: [TagLyrics.Piece("Abc 1"),
                                           TagLyrics.Piece("Abc 2")])

            let data = APESerialization.dataFromLyrics(value)

            XCTAssert(!data.isEmpty)

            guard let other = APESerialization.lyricsFromData(data) else {
                return XCTFail()
            }

            XCTAssert(other == value)
        }

        do {
            let value = TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 1230),
                                           TagLyrics.Piece("Abc 2", timeStamp: 4560)])

            let data = APESerialization.dataFromLyrics(value)

            XCTAssert(!data.isEmpty)

            guard let other = APESerialization.lyricsFromData(data) else {
                return XCTFail()
            }

            XCTAssert(other == value)
        }

        do {
            let value = TagLyrics(pieces: [TagLyrics.Piece("Abc 1"),
                                           TagLyrics.Piece("Abc 2", timeStamp: 4560)])

            let data = APESerialization.dataFromLyrics(value)

            XCTAssert(!data.isEmpty)

            guard let other = APESerialization.lyricsFromData(data) else {
                return XCTFail()
            }

            XCTAssert(other == value)
        }

        do {
            let value = TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 1230),
                                           TagLyrics.Piece("Abc 2")])

            let data = APESerialization.dataFromLyrics(value)

            XCTAssert(!data.isEmpty)

            guard let other = APESerialization.lyricsFromData(data) else {
                return XCTFail()
            }

            XCTAssert(other == value)
        }

        do {
            let value = TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 4560),
                                           TagLyrics.Piece("Abc 2", timeStamp: 1230)])

            let data = APESerialization.dataFromLyrics(value)

            XCTAssert(!data.isEmpty)

            guard let other = APESerialization.lyricsFromData(data) else {
                return XCTFail()
            }

            XCTAssert(other == value)
        }

        do {
            let value = TagLyrics(pieces: [TagLyrics.Piece("", timeStamp: 1230),
                                           TagLyrics.Piece("Abc 2", timeStamp: 4560)])

            let data = APESerialization.dataFromLyrics(value)

            XCTAssert(!data.isEmpty)

            guard let other = APESerialization.lyricsFromData(data) else {
                return XCTFail()
            }

            XCTAssert(other == value)
        }

        do {
            let value = TagLyrics(pieces: [TagLyrics.Piece("", timeStamp: 4560),
                                           TagLyrics.Piece("Abc 2", timeStamp: 1230)])

            let data = APESerialization.dataFromLyrics(value)

            XCTAssert(!data.isEmpty)

            guard let other = APESerialization.lyricsFromData(data) else {
                return XCTFail()
            }

            XCTAssert(other == value)
        }

        do {
            let value = TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 1230),
                                           TagLyrics.Piece("", timeStamp: 4560)])

            let data = APESerialization.dataFromLyrics(value)

            XCTAssert(!data.isEmpty)

            guard let other = APESerialization.lyricsFromData(data) else {
                return XCTFail()
            }

            XCTAssert(other == value)
        }

        do {
            let value = TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 4560),
                                           TagLyrics.Piece("", timeStamp: 1230)])

            let data = APESerialization.dataFromLyrics(value)

            XCTAssert(!data.isEmpty)

            guard let other = APESerialization.lyricsFromData(data) else {
                return XCTFail()
            }

            XCTAssert(other == value)
        }

        do {
            let value = TagLyrics(pieces: [TagLyrics.Piece("", timeStamp: 1230),
                                           TagLyrics.Piece("", timeStamp: 4560)])

            let data = APESerialization.dataFromLyrics(value)

            XCTAssert(!data.isEmpty)

            guard let other = APESerialization.lyricsFromData(data) else {
                return XCTFail()
            }

            XCTAssert(other == value)
        }

        do {
            let value = TagLyrics(pieces: [TagLyrics.Piece("", timeStamp: 4560),
                                           TagLyrics.Piece("", timeStamp: 1230)])

            let data = APESerialization.dataFromLyrics(value)

            XCTAssert(!data.isEmpty)

            guard let other = APESerialization.lyricsFromData(data) else {
                return XCTFail()
            }

            XCTAssert(other == value)
        }

        do {
            guard let value = APESerialization.lyricsFromData([0]) else {
                return XCTFail()
            }

            guard value.pieces.count == 1 else {
                return XCTFail()
            }

            XCTAssert((value.pieces[0].text == "") && (value.pieces[0].timeStamp == 0))
        }

        do {
            let data = [UInt8](String("[1.23]Abc 1[4.56]Abc 2").utf8)

            guard let value = APESerialization.lyricsFromData(data) else {
                return XCTFail()
            }

            guard value.pieces.count == 2 else {
                return XCTFail()
            }

            XCTAssert((value.pieces[0].text == "Abc 1") && (value.pieces[0].timeStamp == 1230))
            XCTAssert((value.pieces[1].text == "Abc 2") && (value.pieces[1].timeStamp == 4560))
        }

        do {
            let data = [UInt8](String("[1.23] Abc 1\n[4.56] Abc 2\n").utf8)

            guard let value = APESerialization.lyricsFromData(data) else {
                return XCTFail()
            }

            guard value.pieces.count == 2 else {
                return XCTFail()
            }

            XCTAssert((value.pieces[0].text == "Abc 1") && (value.pieces[0].timeStamp == 1230))
            XCTAssert((value.pieces[1].text == "Abc 2") && (value.pieces[1].timeStamp == 4560))
        }

        do {
            let data = [UInt8](String("[4.56] Abc 1\n[1.23] Abc 2\n").utf8)

            guard let value = APESerialization.lyricsFromData(data) else {
                return XCTFail()
            }

            guard value.pieces.count == 2 else {
                return XCTFail()
            }

            XCTAssert((value.pieces[0].text == "Abc 1") && (value.pieces[0].timeStamp == 4560))
            XCTAssert((value.pieces[1].text == "Abc 2") && (value.pieces[1].timeStamp == 1230))
        }

        do {
            let data = [UInt8](String("[1.23][4.56] Abc 2\n").utf8)

            guard let value = APESerialization.lyricsFromData(data) else {
                return XCTFail()
            }

            guard value.pieces.count == 2 else {
                return XCTFail()
            }

            XCTAssert((value.pieces[0].text == "") && (value.pieces[0].timeStamp == 1230))
            XCTAssert((value.pieces[1].text == "Abc 2") && (value.pieces[1].timeStamp == 4560))
        }

        do {
            let data = [UInt8](String("[1.23] Abc 1\n[4.56]").utf8)

            guard let value = APESerialization.lyricsFromData(data) else {
                return XCTFail()
            }

            guard value.pieces.count == 2 else {
                return XCTFail()
            }

            XCTAssert((value.pieces[0].text == "Abc 1") && (value.pieces[0].timeStamp == 1230))
            XCTAssert((value.pieces[1].text == "") && (value.pieces[1].timeStamp == 4560))
        }

        do {
            let data = [UInt8](String("[1.23][4.56]").utf8)

            guard let value = APESerialization.lyricsFromData(data) else {
                return XCTFail()
            }

            guard value.pieces.count == 2 else {
                return XCTFail()
            }

            XCTAssert((value.pieces[0].text == "") && (value.pieces[0].timeStamp == 1230))
            XCTAssert((value.pieces[1].text == "") && (value.pieces[1].timeStamp == 4560))
        }

        do {
            let data = [UInt8](String("[] Abc 1\n[4.56] Abc 2\n").utf8)

            guard let value = APESerialization.lyricsFromData(data) else {
                return XCTFail()
            }

            guard value.pieces.count == 1 else {
                return XCTFail()
            }

            XCTAssert((value.pieces[0].text == "[] Abc 1\n[4.56] Abc 2\n") && (value.pieces[0].timeStamp == 0))
        }

        do {
            let data = [UInt8](String("[1.23] Abc 1\n[] Abc 2\n").utf8)

            guard let value = APESerialization.lyricsFromData(data) else {
                return XCTFail()
            }

            guard value.pieces.count == 1 else {
                return XCTFail()
            }

            XCTAssert((value.pieces[0].text == "Abc 1\n[] Abc 2") && (value.pieces[0].timeStamp == 1230))
        }

        do {
            let data = [UInt8](String("[] Abc 1\n[] Abc 2\n").utf8)

            guard let value = APESerialization.lyricsFromData(data) else {
                return XCTFail()
            }

            guard value.pieces.count == 1 else {
                return XCTFail()
            }

            XCTAssert((value.pieces[0].text == "[] Abc 1\n[] Abc 2\n") && (value.pieces[0].timeStamp == 0))
        }

        do {
            let data = [UInt8](String("[][] Abc 2\n").utf8)

            guard let value = APESerialization.lyricsFromData(data) else {
                return XCTFail()
            }

            guard value.pieces.count == 1 else {
                return XCTFail()
            }

            XCTAssert((value.pieces[0].text == "[][] Abc 2\n") && (value.pieces[0].timeStamp == 0))
        }

        do {
            let data = [UInt8](String("[] Abc 1\n[]").utf8)

            guard let value = APESerialization.lyricsFromData(data) else {
                return XCTFail()
            }

            guard value.pieces.count == 1 else {
                return XCTFail()
            }

            XCTAssert((value.pieces[0].text == "[] Abc 1\n[]") && (value.pieces[0].timeStamp == 0))
        }

        do {
            let data = [UInt8](String("[][]").utf8)

            guard let value = APESerialization.lyricsFromData(data) else {
                return XCTFail()
            }

            guard value.pieces.count == 1 else {
                return XCTFail()
            }

            XCTAssert((value.pieces[0].text == "[][]") && (value.pieces[0].timeStamp == 0))
        }

        do {
            let data = [UInt8](String("[1.23] Abc\0 1\n[4.56] Abc\0 2\n").utf8)

            guard let value = APESerialization.lyricsFromData(data) else {
                return XCTFail()
            }

            guard value.pieces.count == 2 else {
                return XCTFail()
            }

            XCTAssert((value.pieces[0].text == "Abc") && (value.pieces[0].timeStamp == 1230))
            XCTAssert((value.pieces[1].text == "Abc") && (value.pieces[1].timeStamp == 4560))
        }

        do {
            let data = [UInt8](String("[[1.23]] Abc 1\n[4.56] Abc 2\n").utf8)

            guard let value = APESerialization.lyricsFromData(data) else {
                return XCTFail()
            }

            guard value.pieces.count == 1 else {
                return XCTFail()
            }

            XCTAssert((value.pieces[0].text == "[[1.23]] Abc 1\n[4.56] Abc 2\n") && (value.pieces[0].timeStamp == 0))
        }

        do {
            let data = [UInt8](String("[1.23] Abc 1\n[[4.56]] Abc 2\n").utf8)

            guard let value = APESerialization.lyricsFromData(data) else {
                return XCTFail()
            }

            guard value.pieces.count == 2 else {
                return XCTFail()
            }

            XCTAssert((value.pieces[0].text == "Abc 1\n[") && (value.pieces[0].timeStamp == 1230))
            XCTAssert((value.pieces[1].text == "] Abc 2") && (value.pieces[1].timeStamp == 4560))
        }

        do {
            let data = [UInt8](String("[[1.23]] Abc 1\n[[4.56]] Abc 2\n").utf8)

            guard let value = APESerialization.lyricsFromData(data) else {
                return XCTFail()
            }

            guard value.pieces.count == 1 else {
                return XCTFail()
            }

            XCTAssert((value.pieces[0].text == "[[1.23]] Abc 1\n[[4.56]] Abc 2\n") && (value.pieces[0].timeStamp == 0))
        }

        do {
            let data = [UInt8](String("[Abc 1] Abc 2\n").utf8)

            guard let value = APESerialization.lyricsFromData(data) else {
                return XCTFail()
            }

            guard value.pieces.count == 1 else {
                return XCTFail()
            }

            XCTAssert((value.pieces[0].text == "[Abc 1] Abc 2\n") && (value.pieces[0].timeStamp == 0))
        }

        do {
            let data = [UInt8](String("[\0] Abc 123\n").utf8)

            guard let value = APESerialization.lyricsFromData(data) else {
                return XCTFail()
            }

            guard value.pieces.count == 1 else {
                return XCTFail()
            }

            XCTAssert((value.pieces[0].text == "[") && (value.pieces[0].timeStamp == 0))
        }
    }
}
