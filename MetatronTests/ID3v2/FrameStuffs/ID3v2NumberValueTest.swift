//
//  ID3v2NumberValueTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 08.10.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class ID3v2NumberValueTest: XCTestCase {

    // MARK: Instance Methods

    func test() {
    	let stuff = ID3v2TextInformation()

        do {
            stuff.numberValue = TagNumber()

            XCTAssert(stuff.numberValue == TagNumber())
            XCTAssert(stuff.fields == [])
        }

        do {
            stuff.numberValue = TagNumber(0, total: 12)

            XCTAssert(stuff.numberValue == TagNumber())
            XCTAssert(stuff.fields == [])
        }

        do {
            stuff.numberValue = TagNumber(34, total: 12)

            XCTAssert(stuff.numberValue == TagNumber())
            XCTAssert(stuff.fields == [])
        }

        do {
            stuff.numberValue = TagNumber(-12, total: 34)

            XCTAssert(stuff.numberValue == TagNumber())
            XCTAssert(stuff.fields == [])
        }

        do {
            stuff.numberValue = TagNumber(12, total: -34)

            XCTAssert(stuff.numberValue == TagNumber())
            XCTAssert(stuff.fields == [])
        }

        do {
            stuff.numberValue = TagNumber(12)

            XCTAssert(stuff.numberValue == TagNumber(12))
            XCTAssert(stuff.fields == ["12"])
        }

        do {
            stuff.numberValue = TagNumber(12, total: 34)

            XCTAssert(stuff.numberValue == TagNumber(12, total: 34))
            XCTAssert(stuff.fields == ["12/34"])
        }

        do {
            stuff.fields = []

            XCTAssert(stuff.numberValue == TagNumber())
        }

        do {
            stuff.fields = ["/1234"]

            XCTAssert(stuff.numberValue == TagNumber())
        }

        do {
            stuff.fields = ["1234/"]

            XCTAssert(stuff.numberValue == TagNumber())
        }

        do {
            stuff.fields = ["12//34"]

            XCTAssert(stuff.numberValue == TagNumber())
        }

        do {
            stuff.fields = ["12:34"]

            XCTAssert(stuff.numberValue == TagNumber())
        }

        do {
            stuff.fields = ["12-34"]

            XCTAssert(stuff.numberValue == TagNumber())
        }

		do {
            stuff.fields = ["0"]

            let value = stuff.numberValue

            XCTAssert((value.value == 0) && (value.total == 0))
        }

        do {
            stuff.fields = ["12"]

            let value = stuff.numberValue

            XCTAssert((value.value == 12) && (value.total == 0))
        }

        do {
            stuff.fields = ["12/34"]

            let value = stuff.numberValue

            XCTAssert((value.value == 12) && (value.total == 34))
        }

        do {
            stuff.fields = ["12/0"]

            let value = stuff.numberValue

            XCTAssert((value.value == 12) && (value.total == 0))
        }

        do {
            stuff.fields = ["0/12"]

            let value = stuff.numberValue

            XCTAssert((value.value == 0) && (value.total == 12))
        }

        do {
            stuff.fields = ["34/12"]

            let value = stuff.numberValue

            XCTAssert((value.value == 34) && (value.total == 12))
        }

        do {
            stuff.fields = ["-12/34"]

            let value = stuff.numberValue

            XCTAssert((value.value == -12) && (value.total == 34))
        }

        do {
            stuff.fields = ["12/-34"]

            let value = stuff.numberValue

            XCTAssert((value.value == 12) && (value.total == -34))
        }

        do {
            stuff.fields = ["-12/-34"]

            let value = stuff.numberValue

            XCTAssert((value.value == -12) && (value.total == -34))
        }
    }
}
