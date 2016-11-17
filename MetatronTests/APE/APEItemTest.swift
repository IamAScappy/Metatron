//
//  APEItemTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 26.08.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class APEItemTest: XCTestCase {

    // MARK: Instance Methods

    func testCheckIdentifier() {
        XCTAssert(APEItem.checkIdentifier("i") == false)
        XCTAssert(APEItem.checkIdentifier("Id3") == false)
        XCTAssert(APEItem.checkIdentifier("tAg") == false)
        XCTAssert(APEItem.checkIdentifier("Oggs") == false)
        XCTAssert(APEItem.checkIdentifier("mp+") == false)

        XCTAssert(APEItem.checkIdentifier("Abc 123") == true)
        XCTAssert(APEItem.checkIdentifier("Абв 123") == false)

        XCTAssert(APEItem.checkIdentifier("artist") == true)
        XCTAssert(APEItem.checkIdentifier("Title") == true)
        XCTAssert(APEItem.checkIdentifier("GENRE") == true)
    }

    func testReset() {
        guard let item = APEItem(identifier: "Abc 123") else {
            return XCTFail()
        }

        item.value = [1, 2, 3]

        item.access = APEItem.Access.readOnly
        item.format = APEItem.Format.binary

        XCTAssert(item.isValid)
        XCTAssert(!item.isEmpty)

        item.reset()

        XCTAssert(item.isValid)
        XCTAssert(item.isEmpty)

        XCTAssert(item.identifier == "Abc 123")

        XCTAssert(item.access == APEItem.Access.readWrite)
        XCTAssert(item.format == APEItem.Format.textual)

        XCTAssert(item.value == [])
    }

    // MARK:

    func testVersion1CaseA() {
        guard let item = APEItem(identifier: "Abc 123") else {
            return XCTFail()
        }

        XCTAssert(item.isValid && item.isEmpty)

        item.access = APEItem.Access.readWrite
        item.format = APEItem.Format.textual

        XCTAssert(item.toData(version: APEVersion.v1) == nil)

        item.numberValue = TagNumber(1, total: 2)

        XCTAssert(item.isValid && (!item.isEmpty))

        guard let data = item.toData(version: APEVersion.v1) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            var offset = 0

            guard let other = APEItem(fromBodyData: data, offset: &offset, version: APEVersion.v1) else {
                return XCTFail()
            }

            XCTAssert(offset == data.count)

            XCTAssert(other.isValid && (!other.isEmpty))

            XCTAssert(other.identifier == item.identifier)

            XCTAssert(other.access == APEItem.Access.readWrite)
            XCTAssert(other.format == APEItem.Format.textual)

            XCTAssert(other.value == item.value)
        }

        do {
            var offset = 0

            guard let other = APEItem(fromBodyData: data, offset: &offset, version: APEVersion.v2) else {
                return XCTFail()
            }

            XCTAssert(offset == data.count)

            XCTAssert(other.isValid && (!other.isEmpty))

            XCTAssert(other.identifier == item.identifier)

            XCTAssert(other.access == APEItem.Access.readWrite)
            XCTAssert(other.format == APEItem.Format.textual)

            XCTAssert(other.value == item.value)
        }
    }

    func testVersion1CaseB() {
        guard let item = APEItem(identifier: "Abc 123") else {
            return XCTFail()
        }

        XCTAssert(item.isValid && item.isEmpty)

        item.access = APEItem.Access.readOnly
        item.format = APEItem.Format.textual

        XCTAssert(item.toData(version: APEVersion.v1) == nil)

        item.timeValue = TagTime(hour: 12, minute: 34, second: 56)

        XCTAssert(item.isValid && (!item.isEmpty))

        guard let data = item.toData(version: APEVersion.v1) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            var offset = 0

            guard let other = APEItem(fromBodyData: data, offset: &offset, version: APEVersion.v1) else {
                return XCTFail()
            }

            XCTAssert(offset == data.count)

            XCTAssert(other.isValid && (!other.isEmpty))

            XCTAssert(other.identifier == item.identifier)

            XCTAssert(other.access == APEItem.Access.readWrite)
            XCTAssert(other.format == APEItem.Format.textual)

            XCTAssert(other.value == item.value)
        }

        do {
            var offset = 0

            guard let other = APEItem(fromBodyData: data, offset: &offset, version: APEVersion.v2) else {
                return XCTFail()
            }

            XCTAssert(offset == data.count)

            XCTAssert(other.isValid && (!other.isEmpty))

            XCTAssert(other.identifier == item.identifier)

            XCTAssert(other.access == APEItem.Access.readWrite)
            XCTAssert(other.format == APEItem.Format.textual)

            XCTAssert(other.value == item.value)
        }
    }

    func testVersion1CaseC() {
        guard let item = APEItem(identifier: "Abc 123") else {
            return XCTFail()
        }

        XCTAssert(item.isValid && item.isEmpty)

        item.access = APEItem.Access.readOnly
        item.format = APEItem.Format.locator

        XCTAssert(item.toData(version: APEVersion.v1) == nil)

        item.dateValue = TagDate(year: 1998, month: 12, day: 31)

        XCTAssert(item.isValid && (!item.isEmpty))

        XCTAssert(item.toData(version: APEVersion.v1) == nil)
    }

    func testVersion1CaseD() {
        guard let item = APEItem(identifier: "Abc 123") else {
            return XCTFail()
        }

        XCTAssert(item.isValid && item.isEmpty)

        item.access = APEItem.Access.readWrite
        item.format = APEItem.Format.binary

        XCTAssert(item.toData(version: APEVersion.v2) == nil)

        item.imageValue = TagImage(data: [1, 2, 3], description: "Abc 123")

        XCTAssert(item.isValid && (!item.isEmpty))

        XCTAssert(item.toData(version: APEVersion.v1) == nil)
    }

    // MARK:

    func testVersion2CaseA() {
        guard let item = APEItem(identifier: "Abc 123") else {
            return XCTFail()
        }

        XCTAssert(item.isValid && item.isEmpty)

        item.access = APEItem.Access.readWrite
        item.format = APEItem.Format.textual

        XCTAssert(item.toData(version: APEVersion.v1) == nil)

        item.numberValue = TagNumber(1, total: 2)

        XCTAssert(item.isValid && (!item.isEmpty))

        guard let data = item.toData(version: APEVersion.v2) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            var offset = 0

            guard let other = APEItem(fromBodyData: data, offset: &offset, version: APEVersion.v2) else {
                return XCTFail()
            }

            XCTAssert(offset == data.count)

            XCTAssert(other.isValid && (!other.isEmpty))

            XCTAssert(other.identifier == item.identifier)

            XCTAssert(other.access == item.access)
            XCTAssert(other.format == item.format)

            XCTAssert(other.value == item.value)
        }

        do {
            var offset = 0

            guard let other = APEItem(fromBodyData: data, offset: &offset, version: APEVersion.v1) else {
                return XCTFail()
            }

            XCTAssert(offset == data.count)

            XCTAssert(other.isValid && (!other.isEmpty))

            XCTAssert(other.identifier == item.identifier)

            XCTAssert(other.access == item.access)
            XCTAssert(other.format == item.format)

            XCTAssert(other.value == item.value)
        }
    }

    func testVersion2CaseB() {
        guard let item = APEItem(identifier: "Abc 123") else {
            return XCTFail()
        }

        XCTAssert(item.isValid && item.isEmpty)

        item.access = APEItem.Access.readOnly
        item.format = APEItem.Format.textual

        XCTAssert(item.toData(version: APEVersion.v1) == nil)

        item.timeValue = TagTime(hour: 12, minute: 34, second: 56)

        XCTAssert(item.isValid && (!item.isEmpty))

        guard let data = item.toData(version: APEVersion.v2) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            var offset = 0

            guard let other = APEItem(fromBodyData: data, offset: &offset, version: APEVersion.v2) else {
                return XCTFail()
            }

            XCTAssert(offset == data.count)

            XCTAssert(other.isValid && (!other.isEmpty))

            XCTAssert(other.identifier == item.identifier)

            XCTAssert(other.access == item.access)
            XCTAssert(other.format == item.format)

            XCTAssert(other.value == item.value)
        }

        do {
            var offset = 0

            guard let other = APEItem(fromBodyData: data, offset: &offset, version: APEVersion.v1) else {
                return XCTFail()
            }

            XCTAssert(offset == data.count)

            XCTAssert(other.isValid && (!other.isEmpty))

            XCTAssert(other.identifier == item.identifier)

            XCTAssert(other.access == item.access)
            XCTAssert(other.format == item.format)

            XCTAssert(other.value == item.value)
        }
    }

    func testVersion2CaseC() {
        guard let item = APEItem(identifier: "Abc 123") else {
            return XCTFail()
        }

        XCTAssert(item.isValid && item.isEmpty)

        item.access = APEItem.Access.readOnly
        item.format = APEItem.Format.locator

        XCTAssert(item.toData(version: APEVersion.v1) == nil)

        item.dateValue = TagDate(year: 1998, month: 12, day: 31)

        XCTAssert(item.isValid && (!item.isEmpty))

        guard let data = item.toData(version: APEVersion.v2) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            var offset = 0

            guard let other = APEItem(fromBodyData: data, offset: &offset, version: APEVersion.v2) else {
                return XCTFail()
            }

            XCTAssert(offset == data.count)

            XCTAssert(other.isValid && (!other.isEmpty))

            XCTAssert(other.identifier == item.identifier)

            XCTAssert(other.access == item.access)
            XCTAssert(other.format == item.format)

            XCTAssert(other.value == item.value)
        }

        do {
            var offset = 0

            guard let other = APEItem(fromBodyData: data, offset: &offset, version: APEVersion.v1) else {
                return XCTFail()
            }

            XCTAssert(offset == data.count)

            XCTAssert(other.isValid && (!other.isEmpty))

            XCTAssert(other.identifier == item.identifier)

            XCTAssert(other.access == item.access)
            XCTAssert(other.format == item.format)

            XCTAssert(other.value == item.value)
        }
    }

    func testVersion2CaseD() {
        guard let item = APEItem(identifier: "Abc 123") else {
            return XCTFail()
        }

        XCTAssert(item.isValid && item.isEmpty)

        item.access = APEItem.Access.readWrite
        item.format = APEItem.Format.binary

        XCTAssert(item.toData(version: APEVersion.v2) == nil)

        item.imageValue = TagImage(data: [1, 2, 3], description: "Abc 123")

        XCTAssert(item.isValid && (!item.isEmpty))

        guard let data = item.toData(version: APEVersion.v2) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            var offset = 0

            guard let other = APEItem(fromBodyData: data, offset: &offset, version: APEVersion.v2) else {
                return XCTFail()
            }

            XCTAssert(offset == data.count)

            XCTAssert(other.isValid && (!other.isEmpty))

            XCTAssert(other.identifier == item.identifier)

            XCTAssert(other.access == item.access)
            XCTAssert(other.format == item.format)

            XCTAssert(other.value == item.value)
        }

        do {
            var offset = 0

            guard let other = APEItem(fromBodyData: data, offset: &offset, version: APEVersion.v1) else {
                return XCTFail()
            }

            XCTAssert(offset == data.count)

            XCTAssert(other.isValid && (!other.isEmpty))

            XCTAssert(other.identifier == item.identifier)

            XCTAssert(other.access == item.access)
            XCTAssert(other.format == item.format)

            XCTAssert(other.value == item.value)
        }
    }
}
