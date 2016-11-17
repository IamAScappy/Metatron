//
//  APETagAlbumTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 15.09.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class APETagAlbumTest: XCTestCase {

    // MARK: Instance Methods

    func test() {
        let tag = APETag()

        do {
            let value = ""

            tag.album = value

            XCTAssert(tag.album == value)

            XCTAssert(tag["Album"] == nil)

            do {
                tag.version = APEVersion.v1

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = APEVersion.v2

                XCTAssert(tag.toData() == nil)
            }

            guard let item = tag.appendItem("Album") else {
                return XCTFail()
            }

            item.stringValue = value

            XCTAssert(tag.album == value)
        }

        do {
            let value = "Abc 123"

            tag.album = value

            XCTAssert(tag.album == value)

            guard let item = tag["Album"] else {
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

                XCTAssert(other.album == value)
            }

            do {
                tag.version = APEVersion.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.album == value)
            }

            item.stringValue = value

            XCTAssert(tag.album == value)
        }

        do {
            let value = "Абв 123"

            tag.album = value

            XCTAssert(tag.album == value)

            guard let item = tag["Album"] else {
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

                XCTAssert(other.album == value)
            }

            do {
                tag.version = APEVersion.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.album == value)
            }

            item.stringValue = value

            XCTAssert(tag.album == value)
        }

        do {
            let value = Array<String>(repeating: "Abc", count: 123).joined(separator: "\n")

            tag.album = value

            XCTAssert(tag.album == value)

            guard let item = tag["Album"] else {
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

                XCTAssert(other.album == value)
            }

            do {
                tag.version = APEVersion.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.album == value)
            }

            item.stringValue = value

            XCTAssert(tag.album == value)
        }

        guard let item = tag.appendItem("Album") else {
            return XCTFail()
        }

        do {
            item.stringListValue = ["Abc 1", "Abc 2"]

            XCTAssert(tag.album == "Abc 1")
        }

        do {
            item.stringListValue = ["", "Abc 2"]

            XCTAssert(tag.album == "")
        }

        do {
            item.stringListValue = ["Abc 1", ""]

            XCTAssert(tag.album == "Abc 1")
        }

        do {
            item.stringListValue = ["", ""]

            XCTAssert(tag.album == "")
        }
    }
}
