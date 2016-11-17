//
//  ID3v2TimeValueTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 08.10.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class ID3v2TimeValueTest: XCTestCase {

    // MARK: Instance Methods

    func test() {
        let stuff = ID3v2TextInformation()

        do {
            stuff.timeValue = TagTime(hour: -1)

            XCTAssert(stuff.timeValue == TagTime())
            XCTAssert(stuff.fields == [])
        }

        do {
            stuff.timeValue = TagTime(hour: 24)

            XCTAssert(stuff.timeValue == TagTime())
            XCTAssert(stuff.fields == [])
        }

        do {
            stuff.timeValue = TagTime(hour: 12, minute: -1)

            XCTAssert(stuff.timeValue == TagTime())
            XCTAssert(stuff.fields == [])
        }

        do {
            stuff.timeValue = TagTime(hour: 12, minute: 60)

            XCTAssert(stuff.timeValue == TagTime())
            XCTAssert(stuff.fields == [])
        }

        do {
            stuff.timeValue = TagTime(hour: 12, second: -1)

            XCTAssert(stuff.timeValue == TagTime())
            XCTAssert(stuff.fields == [])
        }

        do {
            stuff.timeValue = TagTime(hour: 12, second: 60)

            XCTAssert(stuff.timeValue == TagTime())
            XCTAssert(stuff.fields == [])
        }

        for hour in 0..<24 {
            for minute in 0..<60 {
                for second in 0..<60 {
                    stuff.timeValue = TagTime(hour: hour, minute: minute, second: second)

                    XCTAssert(stuff.timeValue == TagTime(hour: hour, minute: minute))
                }
            }
        }

        do {
            stuff.fields = []

            XCTAssert(stuff.timeValue == TagTime())
        }

        do {
            stuff.fields = ["1"]

            XCTAssert(stuff.timeValue == TagTime())
        }

        do {
            stuff.fields = ["12:3"]

            XCTAssert(stuff.timeValue == TagTime())
        }

        do {
            stuff.fields = ["12:34:5"]

            XCTAssert(stuff.timeValue == TagTime())
        }

        do {
            stuff.fields = [":2:34:56"]

            XCTAssert(stuff.timeValue == TagTime())
        }

        do {
            stuff.fields = ["12::4:56"]

            XCTAssert(stuff.timeValue == TagTime())
        }

        do {
            stuff.fields = ["12:34::6"]

            XCTAssert(stuff.timeValue == TagTime())
        }


        do {
            stuff.fields = ["-2:34:56"]

            XCTAssert(stuff.timeValue == TagTime())
        }

        do {
            stuff.fields = ["12:-4:56"]

            XCTAssert(stuff.timeValue == TagTime())
        }

        do {
            stuff.fields = ["12:34:-6"]

            XCTAssert(stuff.timeValue == TagTime())
        }

        do {
            stuff.fields = ["12-34:56"]

            XCTAssert(stuff.timeValue == TagTime())
        }

        do {
            stuff.fields = ["12:34-56"]

            XCTAssert(stuff.timeValue == TagTime())
        }

        do {
            stuff.fields = ["12-34-56"]

            XCTAssert(stuff.timeValue == TagTime())
        }

        do {
            stuff.fields = ["12"]

            XCTAssert(stuff.timeValue == TagTime())
        }

        do {
            stuff.fields = ["12:34"]

            XCTAssert(stuff.timeValue == TagTime())
        }

        do {
            stuff.fields = ["12:34:56"]

            XCTAssert(stuff.timeValue == TagTime())
        }

        do {
            stuff.fields = ["123"]

            XCTAssert(stuff.timeValue == TagTime())
        }

        do {
            stuff.fields = ["12345"]

            XCTAssert(stuff.timeValue == TagTime())
        }

        do {
            stuff.fields = ["123456"]

            XCTAssert(stuff.timeValue == TagTime())
        }

        do {
            stuff.fields = ["1234"]

            let value = stuff.timeValue

            XCTAssert((value.hour == 12) && (value.minute == 34) && (value.second == 0))
        }

        do {
            stuff.fields = ["9934"]

            let value = stuff.timeValue

            XCTAssert((value.hour == 99) && (value.minute == 34) && (value.second == 0))
        }


        do {
            stuff.fields = ["1299"]

            let value = stuff.timeValue

            XCTAssert((value.hour == 12) && (value.minute == 99) && (value.second == 0))
        }

        do {
            stuff.fields = ["9999"]

            let value = stuff.timeValue

            XCTAssert((value.hour == 99) && (value.minute == 99) && (value.second == 0))
        }
    }
}
