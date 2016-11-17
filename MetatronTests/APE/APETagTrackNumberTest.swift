//
//  APETagTrackNumberTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 15.09.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class APETagTrackNumberTest: XCTestCase {

    // MARK: Instance Methods

    func test() {
        let tag = APETag()

        do {
            let value = TagNumber()

            tag.trackNumber = value

            XCTAssert(tag.trackNumber == value.revised)

            XCTAssert(tag["Track"] == nil)

            do {
                tag.version = APEVersion.v1

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = APEVersion.v2

                XCTAssert(tag.toData() == nil)
            }

            guard let item = tag.appendItem("Track") else {
                return XCTFail()
            }

            item.numberValue = value

            XCTAssert(tag.trackNumber == TagNumber())
        }

        do {
            let value = TagNumber(0, total: 12)

            tag.trackNumber = value

            XCTAssert(tag.trackNumber == value.revised)

            XCTAssert(tag["Track"] == nil)

            do {
                tag.version = APEVersion.v1

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = APEVersion.v2

                XCTAssert(tag.toData() == nil)
            }

            guard let item = tag.appendItem("Track") else {
                return XCTFail()
            }

            item.numberValue = value

            XCTAssert(tag.trackNumber == TagNumber())
        }

        do {
            let value = TagNumber(34, total: 12)

            tag.trackNumber = value

            XCTAssert(tag.trackNumber == value.revised)

            guard let item = tag["Track"] else {
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

                XCTAssert(other.trackNumber == value.revised)
            }

            do {
                tag.version = APEVersion.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.trackNumber == value.revised)
            }

            item.numberValue = value

            XCTAssert(tag.trackNumber == TagNumber())
        }

        do {
            let value = TagNumber(-12, total: 34)

            tag.trackNumber = value

            XCTAssert(tag.trackNumber == value.revised)

            XCTAssert(tag["Track"] == nil)

            do {
                tag.version = APEVersion.v1

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = APEVersion.v2

                XCTAssert(tag.toData() == nil)
            }

            guard let item = tag.appendItem("Track") else {
                return XCTFail()
            }

            item.numberValue = value

            XCTAssert(tag.trackNumber == TagNumber())
        }

        do {
            let value = TagNumber(12, total: -34)

            tag.trackNumber = value

            XCTAssert(tag.trackNumber == value.revised)

            guard let item = tag["Track"] else {
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

                XCTAssert(other.trackNumber == value.revised)
            }

            do {
                tag.version = APEVersion.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.trackNumber == value.revised)
            }

            item.numberValue = value

            XCTAssert(tag.trackNumber == TagNumber())
        }

        do {
            let value = TagNumber(-12, total: -34)

            tag.trackNumber = value

            XCTAssert(tag.trackNumber == value.revised)

            XCTAssert(tag["Track"] == nil)

            do {
                tag.version = APEVersion.v1

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = APEVersion.v2

                XCTAssert(tag.toData() == nil)
            }

            guard let item = tag.appendItem("Track") else {
                return XCTFail()
            }

            item.numberValue = value

            XCTAssert(tag.trackNumber == TagNumber())
        }

        do {
            let value = TagNumber(12)

            tag.trackNumber = value

            XCTAssert(tag.trackNumber == value.revised)

            guard let item = tag["Track"] else {
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

                XCTAssert(other.trackNumber == value.revised)
            }

            do {
                tag.version = APEVersion.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.trackNumber == value.revised)
            }

            item.numberValue = value

            XCTAssert(tag.trackNumber == value)
        }

        do {
            let value = TagNumber(12, total: 34)

            tag.trackNumber = value

            XCTAssert(tag.trackNumber == value.revised)

            guard let item = tag["Track"] else {
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

                XCTAssert(other.trackNumber == value.revised)
            }

            do {
                tag.version = APEVersion.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.trackNumber == value.revised)
            }

            item.numberValue = value

            XCTAssert(tag.trackNumber == value)
        }

        guard let item = tag.appendItem("Track") else {
            return XCTFail()
        }

        do {
            item.stringValue = "0"

            XCTAssert(tag.trackNumber == TagNumber())
        }

        do {
            item.stringValue = "12"

            XCTAssert(tag.trackNumber == TagNumber(12))
        }

        do {
            item.stringValue = "12/34"

            XCTAssert(tag.trackNumber == TagNumber(12, total: 34))
        }

        do {
            item.stringValue = "12/0"

            XCTAssert(tag.trackNumber == TagNumber(12))
        }

        do {
            item.stringValue = "0/12"

            XCTAssert(tag.trackNumber == TagNumber())
        }

        do {
            item.stringValue = "34/12"

            XCTAssert(tag.trackNumber == TagNumber(34))
        }

        do {
            item.stringValue = "-12/34"

            XCTAssert(tag.trackNumber == TagNumber())
        }

        do {
            item.stringValue = "12/-34"

            XCTAssert(tag.trackNumber == TagNumber(12))
        }

        do {
            item.stringValue = "-12/-34"

            XCTAssert(tag.trackNumber == TagNumber())
        }
    }
}
