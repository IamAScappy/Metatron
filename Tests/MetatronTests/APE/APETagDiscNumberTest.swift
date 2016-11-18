//
//  APETagDiscNumberTest.swift
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

class APETagDiscNumberTest: XCTestCase {

    // MARK: Instance Methods

    func test() {
        let tag = APETag()

        do {
            let value = TagNumber()

            tag.discNumber = value

            XCTAssert(tag.discNumber == value.revised)

            XCTAssert(tag["Disc"] == nil)

            do {
                tag.version = APEVersion.v1

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = APEVersion.v2

                XCTAssert(tag.toData() == nil)
            }

            guard let item = tag.appendItem("Disc") else {
                return XCTFail()
            }

            item.numberValue = value

            XCTAssert(tag.discNumber == TagNumber())
        }

        do {
            let value = TagNumber(0, total: 12)

            tag.discNumber = value

            XCTAssert(tag.discNumber == value.revised)

            XCTAssert(tag["Disc"] == nil)

            do {
                tag.version = APEVersion.v1

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = APEVersion.v2

                XCTAssert(tag.toData() == nil)
            }

            guard let item = tag.appendItem("Disc") else {
                return XCTFail()
            }

            item.numberValue = value

            XCTAssert(tag.discNumber == TagNumber())
        }

        do {
            let value = TagNumber(34, total: 12)

            tag.discNumber = value

            XCTAssert(tag.discNumber == value.revised)

            guard let item = tag["Disc"] else {
                return XCTFail()
            }

            guard let itemValue = item.numberValue else {
                return XCTFail()
            }

            XCTAssert(itemValue == value.revised)

            do {
                tag.version = APEVersion.v1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.discNumber == value.revised)
            }

            do {
                tag.version = APEVersion.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.discNumber == value.revised)
            }

            item.numberValue = value

            XCTAssert(tag.discNumber == TagNumber())
        }

        do {
            let value = TagNumber(-12, total: 34)

            tag.discNumber = value

            XCTAssert(tag.discNumber == value.revised)

            XCTAssert(tag["Disc"] == nil)

            do {
                tag.version = APEVersion.v1

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = APEVersion.v2

                XCTAssert(tag.toData() == nil)
            }

            guard let item = tag.appendItem("Disc") else {
                return XCTFail()
            }

            item.numberValue = value

            XCTAssert(tag.discNumber == TagNumber())
        }

        do {
            let value = TagNumber(12, total: -34)

            tag.discNumber = value

            XCTAssert(tag.discNumber == value.revised)

            guard let item = tag["Disc"] else {
                return XCTFail()
            }

            guard let itemValue = item.numberValue else {
                return XCTFail()
            }

            XCTAssert(itemValue == TagNumber(12))

            do {
                tag.version = APEVersion.v1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.discNumber == value.revised)
            }

            do {
                tag.version = APEVersion.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.discNumber == value.revised)
            }

            item.numberValue = value

            XCTAssert(tag.discNumber == TagNumber())
        }

        do {
            let value = TagNumber(12)

            tag.discNumber = value

            XCTAssert(tag.discNumber == value.revised)

            guard let item = tag["Disc"] else {
                return XCTFail()
            }

            guard let itemValue = item.numberValue else {
                return XCTFail()
            }

            XCTAssert(itemValue == value.revised)

            do {
                tag.version = APEVersion.v1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.discNumber == value.revised)
            }

            do {
                tag.version = APEVersion.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.discNumber == value.revised)
            }

            item.numberValue = value

            XCTAssert(tag.discNumber == value)
        }

        do {
            let value = TagNumber(12, total: 34)

            tag.discNumber = value

            XCTAssert(tag.discNumber == value.revised)

            guard let item = tag["Disc"] else {
                return XCTFail()
            }

            guard let itemValue = item.numberValue else {
                return XCTFail()
            }

            XCTAssert(itemValue == value.revised)

            do {
                tag.version = APEVersion.v1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.discNumber == value.revised)
            }

            do {
                tag.version = APEVersion.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.discNumber == value.revised)
            }

            item.numberValue = value

            XCTAssert(tag.discNumber == value)
        }

        guard let item = tag.appendItem("Disc") else {
            return XCTFail()
        }

        do {
            item.stringValue = "0"

            XCTAssert(tag.discNumber == TagNumber())
        }

        do {
            item.stringValue = "12"

            XCTAssert(tag.discNumber == TagNumber(12))
        }

        do {
            item.stringValue = "12/34"

            XCTAssert(tag.discNumber == TagNumber(12, total: 34))
        }

        do {
            item.stringValue = "12/0"

            XCTAssert(tag.discNumber == TagNumber(12))
        }

        do {
            item.stringValue = "0/12"

            XCTAssert(tag.discNumber == TagNumber())
        }

        do {
            item.stringValue = "34/12"

            XCTAssert(tag.discNumber == TagNumber(34))
        }

        do {
            item.stringValue = "-12/34"

            XCTAssert(tag.discNumber == TagNumber())
        }

        do {
            item.stringValue = "12/-34"

            XCTAssert(tag.discNumber == TagNumber(12))
        }

        do {
            item.stringValue = "-12/-34"

            XCTAssert(tag.discNumber == TagNumber())
        }
    }
}
