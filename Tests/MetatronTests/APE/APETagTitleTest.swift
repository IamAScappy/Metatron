//
//  APETagTitleTest.swift
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
