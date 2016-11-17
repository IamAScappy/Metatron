//
//  APETagTitleTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 15.09.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class APETagTitleTest: XCTestCase {

    // MARK: Instance Methods

    func test() {
        let tag = APETag()

        do {
            let value = ""

            tag.title = value

            XCTAssert(tag.title == value)

            XCTAssert(tag["Title"] == nil)

            do {
                tag.version = APEVersion.v1

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = APEVersion.v2

                XCTAssert(tag.toData() == nil)
            }

            guard let item = tag.appendItem("Title") else {
                return XCTFail()
            }

            item.stringValue = value

            XCTAssert(tag.title == value)
        }

        do {
            let value = "Abc 123"

            tag.title = value

            XCTAssert(tag.title == value)

            guard let item = tag["Title"] else {
                return XCTFail()
            }

            guard let itemValue = item.stringValue else {
                return XCTFail()
            }

            XCTAssert(itemValue == value)

            do {
                tag.version = APEVersion.v1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.title == value)
            }

            do {
                tag.version = APEVersion.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.title == value)
            }

            item.stringValue = value

            XCTAssert(tag.title == value)
        }

        do {
            let value = "Абв 123"

            tag.title = value

            XCTAssert(tag.title == value)

            guard let item = tag["Title"] else {
                return XCTFail()
            }

            guard let itemValue = item.stringValue else {
                return XCTFail()
            }

            XCTAssert(itemValue == value)

            do {
                tag.version = APEVersion.v1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.title == value)
            }

            do {
                tag.version = APEVersion.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.title == value)
            }

            item.stringValue = value

            XCTAssert(tag.title == value)
        }

        do {
            let value = Array<String>(repeating: "Abc", count: 123).joined(separator: "\n")

            tag.title = value

            XCTAssert(tag.title == value)

            guard let item = tag["Title"] else {
                return XCTFail()
            }

            guard let itemValue = item.stringValue else {
                return XCTFail()
            }

            XCTAssert(itemValue == value)

            do {
                tag.version = APEVersion.v1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.title == value)
            }

            do {
                tag.version = APEVersion.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.title == value)
            }

            item.stringValue = value

            XCTAssert(tag.title == value)
        }

        guard let item = tag.appendItem("Title") else {
            return XCTFail()
        }

        do {
            item.stringListValue = ["Abc 1", "Abc 2"]

            XCTAssert(tag.title == "Abc 1")
        }

        do {
            item.stringListValue = ["", "Abc 2"]

            XCTAssert(tag.title == "")
        }

        do {
            item.stringListValue = ["Abc 1", ""]

            XCTAssert(tag.title == "Abc 1")
        }

        do {
            item.stringListValue = ["", ""]

            XCTAssert(tag.title == "")
        }
    }
}
