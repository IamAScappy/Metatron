//
//  APETagArtistsTest.swift
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

class APETagArtistsTest: XCTestCase {

    // MARK: Instance Methods

    func test() {
        let tag = APETag()

        do {
            let value: [String] = []

            tag.artists = value

            XCTAssert(tag.artists == value)

            XCTAssert(tag["Artist"] == nil)

            do {
                tag.version = APEVersion.v1

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = APEVersion.v2

                XCTAssert(tag.toData() == nil)
            }

            guard let item = tag.appendItem("Artist") else {
                return XCTFail()
            }

            item.stringListValue = value

            XCTAssert(tag.artists == value)
        }

        do {
            let value = [""]

            tag.artists = value

            XCTAssert(tag.artists == [])

            XCTAssert(tag["Artist"] == nil)

            do {
                tag.version = APEVersion.v1

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = APEVersion.v2

                XCTAssert(tag.toData() == nil)
            }

            guard let item = tag.appendItem("Artist") else {
                return XCTFail()
            }

            item.stringListValue = value

            XCTAssert(tag.artists == [])
        }

        do {
            let value = ["Abc 123"]

            tag.artists = value

            XCTAssert(tag.artists == value)

            guard let item = tag["Artist"] else {
                return XCTFail()
            }

            guard let itemValue = item.stringListValue else {
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

                XCTAssert(other.artists == value)
            }

            do {
                tag.version = APEVersion.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.artists == value)
            }

            item.stringListValue = value

            XCTAssert(tag.artists == value)
        }

        do {
            let value = ["Абв 123"]

            tag.artists = value

            XCTAssert(tag.artists == value)

            guard let item = tag["Artist"] else {
                return XCTFail()
            }

            guard let itemValue = item.stringListValue else {
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

                XCTAssert(other.artists == value)
            }

            do {
                tag.version = APEVersion.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.artists == value)
            }

            item.stringListValue = value

            XCTAssert(tag.artists == value)
        }

        do {
            let value = ["Abc 1", "Abc 2"]

            tag.artists = value

            XCTAssert(tag.artists == value)

            guard let item = tag["Artist"] else {
                return XCTFail()
            }

            guard let itemValue = item.stringListValue else {
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

                XCTAssert(other.artists == value)
            }

            do {
                tag.version = APEVersion.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.artists == value)
            }

            item.stringListValue = value

            XCTAssert(tag.artists == value)
        }

        do {
            let value = ["", "Abc 2"]

            tag.artists = value

            XCTAssert(tag.artists == ["Abc 2"])

            guard let item = tag["Artist"] else {
                return XCTFail()
            }

            guard let itemValue = item.stringListValue else {
                return XCTFail()
            }

            XCTAssert(itemValue == ["Abc 2"])

            do {
                tag.version = APEVersion.v1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.artists == ["Abc 2"])
            }

            do {
                tag.version = APEVersion.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.artists == ["Abc 2"])
            }

            item.stringListValue = value

            XCTAssert(tag.artists == ["Abc 2"])
        }

        do {
            let value = ["Abc 1", ""]

            tag.artists = value

            XCTAssert(tag.artists == ["Abc 1"])

            guard let item = tag["Artist"] else {
                return XCTFail()
            }

            guard let itemValue = item.stringListValue else {
                return XCTFail()
            }

            XCTAssert(itemValue == ["Abc 1"])

            do {
                tag.version = APEVersion.v1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.artists == ["Abc 1"])
            }

            do {
                tag.version = APEVersion.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.artists == ["Abc 1"])
            }

            item.stringListValue = value

            XCTAssert(tag.artists == ["Abc 1"])
        }

        do {
            let value = ["", ""]

            tag.artists = value

            XCTAssert(tag.artists == [])

            XCTAssert(tag["Artist"] == nil)

            do {
                tag.version = APEVersion.v1

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = APEVersion.v2

                XCTAssert(tag.toData() == nil)
            }

            guard let item = tag.appendItem("Artist") else {
                return XCTFail()
            }

            item.stringListValue = value

            XCTAssert(tag.artists == [])
        }

        do {
            let value = [Array<String>(repeating: "Abc", count: 123).joined(separator: "\n")]

            tag.artists = value

            XCTAssert(tag.artists == value)

            guard let item = tag["Artist"] else {
                return XCTFail()
            }

            guard let itemValue = item.stringListValue else {
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

                XCTAssert(other.artists == value)
            }

            do {
                tag.version = APEVersion.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.artists == value)
            }

            item.stringListValue = value

            XCTAssert(tag.artists == value)
        }

        do {
            let value = Array<String>(repeating: "Abc", count: 123)

            tag.artists = value

            XCTAssert(tag.artists == value)

            guard let item = tag["Artist"] else {
                return XCTFail()
            }

            guard let itemValue = item.stringListValue else {
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

                XCTAssert(other.artists == value)
            }

            do {
                tag.version = APEVersion.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.artists == value)
            }

            item.stringListValue = value

            XCTAssert(tag.artists == value)
        }

        guard let item = tag.appendItem("Artist") else {
            return XCTFail()
        }

        do {
            item.value = [UInt8](String("Abc 1\0Abc 2").utf8)

            XCTAssert(tag.artists == ["Abc 1", "Abc 2"])
        }

        do {
            item.value = [UInt8](String("\0Abc 2").utf8)

            XCTAssert(tag.artists == ["Abc 2"])
        }

        do {
            item.value = [UInt8](String("Abc 1\0").utf8)

            XCTAssert(tag.artists == ["Abc 1"])
        }

        do {
            item.value = [0]

            XCTAssert(tag.artists == [])
        }
    }
}
