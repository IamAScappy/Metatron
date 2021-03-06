//
//  APETagCoverArtTest.swift
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

class APETagCoverArtTest: XCTestCase {

    // MARK: Instance Methods

    func test() {
        let tag = APETag()

        do {
            let value = TagImage()

            tag.coverArt = value

            XCTAssert(tag.coverArt == TagImage())

            XCTAssert(tag["Cover Art (Front)"] == nil)

            do {
                tag.version = APEVersion.v1

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = APEVersion.v2

                XCTAssert(tag.toData() == nil)
            }

            guard let item = tag.appendItem("Cover Art (Front)") else {
                return XCTFail()
            }

            item.imageValue = value

            XCTAssert(tag.coverArt == TagImage())
        }

        do {
            let value = TagImage(data: [], description: "Abc 123")

            tag.coverArt = value

            XCTAssert(tag.coverArt == TagImage())

            XCTAssert(tag["Cover Art (Front)"] == nil)

            do {
                tag.version = APEVersion.v1

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = APEVersion.v2

                XCTAssert(tag.toData() == nil)
            }

            guard let item = tag.appendItem("Cover Art (Front)") else {
                return XCTFail()
            }

            item.imageValue = value

            XCTAssert(tag.coverArt == TagImage())
        }

        do {
            let value = TagImage(data: [], description: "Абв 123")

            tag.coverArt = value

            XCTAssert(tag.coverArt == TagImage())

            XCTAssert(tag["Cover Art (Front)"] == nil)

            do {
                tag.version = APEVersion.v1

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = APEVersion.v2

                XCTAssert(tag.toData() == nil)
            }

            guard let item = tag.appendItem("Cover Art (Front)") else {
                return XCTFail()
            }

            item.imageValue = value

            XCTAssert(tag.coverArt == TagImage())
        }

        do {
            let value = TagImage(data: [1, 2, 3])

            tag.coverArt = value

            XCTAssert(tag.coverArt == value)

            guard let item = tag["Cover Art (Front)"] else {
                return XCTFail()
            }

            guard let itemValue = item.imageValue else {
                return XCTFail()
            }

            XCTAssert(itemValue == value)

            do {
                tag.version = APEVersion.v1

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = APEVersion.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.coverArt == value)
            }

            item.imageValue = value

            XCTAssert(tag.coverArt == value)
        }

        do {
            let value = TagImage(data: [1, 2, 3], description: "Abc 123")

            tag.coverArt = value

            XCTAssert(tag.coverArt == value)

            guard let item = tag["Cover Art (Front)"] else {
                return XCTFail()
            }

            guard let itemValue = item.imageValue else {
                return XCTFail()
            }

            XCTAssert(itemValue == value)

            do {
                tag.version = APEVersion.v1

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = APEVersion.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.coverArt == value)
            }

            item.imageValue = value

            XCTAssert(tag.coverArt == value)
        }

        do {
            let value = TagImage(data: [0, 0, 0], description: "Abc 123")

            tag.coverArt = value

            XCTAssert(tag.coverArt == value)

            guard let item = tag["Cover Art (Front)"] else {
                return XCTFail()
            }

            guard let itemValue = item.imageValue else {
                return XCTFail()
            }

            XCTAssert(itemValue == value)

            do {
                tag.version = APEVersion.v1

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = APEVersion.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.coverArt == value)
            }

            item.imageValue = value

            XCTAssert(tag.coverArt == value)
        }

        guard let item = tag.appendItem("Cover Art (Front)") else {
            return XCTFail()
        }

        do {
            item.value = [0]

            XCTAssert(tag.coverArt == TagImage())
        }

        do {
            item.value = [0, 1, 2, 3]

            XCTAssert(tag.coverArt == TagImage(data: [1, 2, 3]))
        }

        do {
            item.value = [0, 0, 0, 0]

            XCTAssert(tag.coverArt == TagImage(data: [0, 0, 0]))
        }

        do {
            XCTAssert(tag.removeItem(item.identifier) == true)

            do {
                XCTAssert(tag.itemList.count == 0)

                guard let item = tag.appendItem("Cover Art (Abc 1)") else {
                    return XCTFail()
                }

                XCTAssert(tag.itemList.count == 1)

                item.imageValue = TagImage(data: [1, 2, 3])

                XCTAssert(tag.coverArt == TagImage(data: [1, 2, 3]))
            }

            do {
                XCTAssert(tag.itemList.count == 1)

                guard let item = tag.appendItem("Cover Art (Abc 2)") else {
                    return XCTFail()
                }

                XCTAssert(tag.itemList.count == 2)

                item.imageValue = TagImage()

                XCTAssert(tag.coverArt == TagImage(data: [1, 2, 3]))
            }

            do {
                XCTAssert(tag.itemList.count == 2)

                guard let item = tag.appendItem("Cover Art (Back)") else {
                    return XCTFail()
                }

                XCTAssert(tag.itemList.count == 3)

                item.imageValue = TagImage(data: [4, 5, 6])

                XCTAssert(tag.coverArt == TagImage(data: [4, 5, 6]))
            }

            do {
                XCTAssert(tag.itemList.count == 3)

                guard let item = tag.appendItem("Cover Art (Front)") else {
                    return XCTFail()
                }

                XCTAssert(tag.itemList.count == 4)

                item.imageValue = TagImage(data: [7, 8, 9])

                XCTAssert(tag.coverArt == TagImage(data: [7, 8, 9]))
            }
        }
    }
}
