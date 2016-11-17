//
//  TagNumberTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 15.09.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class TagNumberTest: XCTestCase {

    // MARK: Instance Methods

    func testInit() {
        do {
            let number = TagNumber()

            XCTAssert(number.value == 0)
            XCTAssert(number.total == 0)

            XCTAssert(number.isValid == false)

            let revised = number.revised

            XCTAssert(revised.value == 0)
            XCTAssert(revised.total == 0)

            XCTAssert(revised.isValid == false)
        }

        do {
            let number = TagNumber(12)

            XCTAssert(number.value == 12)
            XCTAssert(number.total == 0)

            XCTAssert(number.isValid == true)

            let revised = number.revised

            XCTAssert(revised.value == 12)
            XCTAssert(revised.total == 0)

            XCTAssert(revised.isValid == true)
        }

        do {
            let number = TagNumber(12, total: 34)

            XCTAssert(number.value == 12)
            XCTAssert(number.total == 34)

            XCTAssert(number.isValid == true)

            let revised = number.revised

            XCTAssert(revised.value == 12)
            XCTAssert(revised.total == 34)

            XCTAssert(revised.isValid == true)
        }

        do {
            let number = TagNumber(0, total: 12)

            XCTAssert(number.value == 0)
            XCTAssert(number.total == 12)

            XCTAssert(number.isValid == false)

            let revised = number.revised

            XCTAssert(revised.value == 0)
            XCTAssert(revised.total == 0)

            XCTAssert(revised.isValid == false)
        }

        do {
            let number = TagNumber(34, total: 12)

            XCTAssert(number.value == 34)
            XCTAssert(number.total == 12)

            XCTAssert(number.isValid == false)

            let revised = number.revised

            XCTAssert(revised.value == 34)
            XCTAssert(revised.total == 0)

            XCTAssert(revised.isValid == true)
        }

        do {
            let number = TagNumber(-12, total: 34)

            XCTAssert(number.value == -12)
            XCTAssert(number.total == 34)

            XCTAssert(number.isValid == false)

            let revised = number.revised

            XCTAssert(revised.value == 0)
            XCTAssert(revised.total == 0)

            XCTAssert(revised.isValid == false)
        }

        do {
            let number = TagNumber(12, total: -34)

            XCTAssert(number.value == 12)
            XCTAssert(number.total == -34)

            XCTAssert(number.isValid == false)

            let revised = number.revised

            XCTAssert(revised.value == 12)
            XCTAssert(revised.total == 0)

            XCTAssert(revised.isValid == true)
        }
    }

    // MARK:

    func testComparable() {
        do {
            let number1 = TagNumber(12, total: 34)
            let number2 = TagNumber(12, total: 34)

            XCTAssertFalse(number1 < number2)
            XCTAssertFalse(number1 > number2)

            XCTAssert(number1 <= number2)
            XCTAssert(number1 >= number2)
        }

        do {
            let number1 = TagNumber(12, total: 34)
            let number2 = TagNumber(34, total: 34)

            XCTAssert(number1 < number2)
            XCTAssert(number2 > number1)

            XCTAssert(number1 <= number2)
            XCTAssert(number2 >= number1)
        }

        do {
            let number1 = TagNumber(12, total: 34)
            let number2 = TagNumber(12, total: 56)

            XCTAssertFalse(number1 < number2)
            XCTAssertFalse(number1 > number2)

            XCTAssert(number1 <= number2)
            XCTAssert(number1 >= number2)
        }

        do {
            let number1 = TagNumber(12, total: 56)
            let number2 = TagNumber(34, total: 34)

            XCTAssert(number1 < number2)
            XCTAssert(number2 > number1)

            XCTAssert(number1 <= number2)
            XCTAssert(number2 >= number1)
        }
    }

    func testEquatable() {
        do {
            let number1 = TagNumber(12, total: 34)
            let number2 = TagNumber(12, total: 34)

            XCTAssert(number1 == number2)
        }

        do {
            let number1 = TagNumber(12, total: 34)
            let number2 = TagNumber(34, total: 34)

            XCTAssert(number1 != number2)
        }

        do {
            let number1 = TagNumber(12, total: 12)
            let number2 = TagNumber(12, total: 34)

            XCTAssert(number1 != number2)
        }

        do {
            let number1 = TagNumber(12, total: 12)
            let number2 = TagNumber(34, total: 34)

            XCTAssert(number1 != number2)
        }
    }

    // MARK:

    func testReset() {
        var number = TagNumber(12, total: 34)

        number.reset()

        XCTAssert(number.value == 0)
        XCTAssert(number.total == 0)

        XCTAssert(number.isValid == false)
    }
}
