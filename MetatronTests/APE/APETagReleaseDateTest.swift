//
//  APETagReleaseDateTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 15.09.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class APETagReleaseDateTest: XCTestCase {

    // MARK: Instance Methods

    func test() {
        let tag = APETag()

        do {
            let value = TagDate()

            tag.releaseDate = value

            XCTAssert(tag.releaseDate == value.revised)

            XCTAssert(tag["Year"] == nil)

            do {
                tag.version = APEVersion.v1

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = APEVersion.v2

                XCTAssert(tag.toData() == nil)
            }

            guard let item = tag.appendItem("Year") else {
                return XCTFail()
            }

            item.dateValue = value

            XCTAssert(tag.releaseDate == TagDate())
        }

        do {
            let value = TagDate(year: 10000)

            tag.releaseDate = value

            XCTAssert(tag.releaseDate == value.revised)

            XCTAssert(tag["Year"] == nil)

            do {
                tag.version = APEVersion.v1

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = APEVersion.v2

                XCTAssert(tag.toData() == nil)
            }

            guard let item = tag.appendItem("Year") else {
                return XCTFail()
            }

            item.dateValue = value

            XCTAssert(tag.releaseDate == TagDate())
        }

        do {
            let value = TagDate(year: 1998, month: 0)

            tag.releaseDate = value

            XCTAssert(tag.releaseDate == value.revised)

            guard let item = tag["Year"] else {
                return XCTFail()
            }

            guard let itemValue = item.dateValue else {
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

                XCTAssert(other.releaseDate == value.revised)
            }

            do {
                tag.version = APEVersion.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.releaseDate == value.revised)
            }

            item.dateValue = value

            XCTAssert(tag.releaseDate == TagDate())
        }

        do {
            let value = TagDate(year: 1998, month: 13)

            tag.releaseDate = value

            XCTAssert(tag.releaseDate == value.revised)

            guard let item = tag["Year"] else {
                return XCTFail()
            }

            guard let itemValue = item.dateValue else {
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

                XCTAssert(other.releaseDate == value.revised)
            }

            do {
                tag.version = APEVersion.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.releaseDate == value.revised)
            }

            item.dateValue = value

            XCTAssert(tag.releaseDate == TagDate())
        }

        do {
            let value = TagDate(year: 1998, month: 12, day: 0)

            tag.releaseDate = value

            XCTAssert(tag.releaseDate == value.revised)

            guard let item = tag["Year"] else {
                return XCTFail()
            }

            guard let itemValue = item.dateValue else {
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

                XCTAssert(other.releaseDate == value.revised)
            }

            do {
                tag.version = APEVersion.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.releaseDate == value.revised)
            }

            item.dateValue = value

            XCTAssert(tag.releaseDate == TagDate())
        }

        do {
            let value = TagDate(year: 1998, month: 12, day: 32)

            tag.releaseDate = value

            XCTAssert(tag.releaseDate == value.revised)

            guard let item = tag["Year"] else {
                return XCTFail()
            }

            guard let itemValue = item.dateValue else {
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

                XCTAssert(other.releaseDate == value.revised)
            }

            do {
                tag.version = APEVersion.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.releaseDate == value.revised)
            }

            item.dateValue = value

            XCTAssert(tag.releaseDate == TagDate())
        }

        do {
            let value = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: -1))

            tag.releaseDate = value

            XCTAssert(tag.releaseDate == value.revised)

            guard let item = tag["Year"] else {
                return XCTFail()
            }

            guard let itemValue = item.dateValue else {
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

                XCTAssert(other.releaseDate == value.revised)
            }

            do {
                tag.version = APEVersion.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.releaseDate == value.revised)
            }

            item.dateValue = value

            XCTAssert(tag.releaseDate == TagDate())
        }

        do {
            let value = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 24))

            tag.releaseDate = value

            XCTAssert(tag.releaseDate == value.revised)

            guard let item = tag["Year"] else {
                return XCTFail()
            }

            guard let itemValue = item.dateValue else {
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

                XCTAssert(other.releaseDate == value.revised)
            }

            do {
                tag.version = APEVersion.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.releaseDate == value.revised)
            }

            item.dateValue = value

            XCTAssert(tag.releaseDate == TagDate())
        }

        do {
            let value = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: -1))

            tag.releaseDate = value

            XCTAssert(tag.releaseDate == value.revised)

            guard let item = tag["Year"] else {
                return XCTFail()
            }

            guard let itemValue = item.dateValue else {
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

                XCTAssert(other.releaseDate == value.revised)
            }

            do {
                tag.version = APEVersion.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.releaseDate == value.revised)
            }

            item.dateValue = value

            XCTAssert(tag.releaseDate == TagDate())
        }

        do {
            let value = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: 60))

            tag.releaseDate = value

            XCTAssert(tag.releaseDate == value.revised)

            guard let item = tag["Year"] else {
                return XCTFail()
            }

            guard let itemValue = item.dateValue else {
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

                XCTAssert(other.releaseDate == value.revised)
            }

            do {
                tag.version = APEVersion.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.releaseDate == value.revised)
            }

            item.dateValue = value

            XCTAssert(tag.releaseDate == TagDate())
        }

        do {
            let value = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: 34, second: -1))

            tag.releaseDate = value

            XCTAssert(tag.releaseDate == value.revised)

            guard let item = tag["Year"] else {
                return XCTFail()
            }

            guard let itemValue = item.dateValue else {
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

                XCTAssert(other.releaseDate == value.revised)
            }

            do {
                tag.version = APEVersion.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.releaseDate == value.revised)
            }

            item.dateValue = value

            XCTAssert(tag.releaseDate == TagDate())
        }

        do {
            let value = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: 34, second: 60))

            tag.releaseDate = value

            XCTAssert(tag.releaseDate == value.revised)

            guard let item = tag["Year"] else {
                return XCTFail()
            }

            guard let itemValue = item.dateValue else {
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

                XCTAssert(other.releaseDate == value.revised)
            }

            do {
                tag.version = APEVersion.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.releaseDate == value.revised)
            }

            item.dateValue = value

            XCTAssert(tag.releaseDate == TagDate())
        }

        do {
        	let value = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: 34, second: 56))

            tag.releaseDate = value

            XCTAssert(tag.releaseDate == value.revised)

            guard let item = tag["Year"] else {
                return XCTFail()
            }

            guard let itemValue = item.dateValue else {
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

                XCTAssert(other.releaseDate == value.revised)
            }

            do {
                tag.version = APEVersion.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.releaseDate == value.revised)
            }

            item.dateValue = value

            XCTAssert(tag.releaseDate == value)
		}

        guard let item = tag.appendItem("Year") else {
            return XCTFail()
        }

		do {
            item.stringValue = "1998"

            XCTAssert(tag.releaseDate == TagDate(year: 1998))
        }

        do {
            item.stringValue = "1998-W34"

            XCTAssert(tag.releaseDate == TagDate(year: 1998))
        }

        do {
            item.stringValue = "1998-12"

            XCTAssert(tag.releaseDate == TagDate(year: 1998, month: 12))
        }

        do {
            item.stringValue = "1998-12-31"

            XCTAssert(tag.releaseDate == TagDate(year: 1998, month: 12, day: 31))
        }

        do {
            item.stringValue = "1998-12-31 12"

            let time = TagTime(hour: 12)

            XCTAssert(tag.releaseDate == TagDate(year: 1998, month: 12, day: 31, time: time))
        }

        do {
            item.stringValue = "1998-12-31 12:34"

            let time = TagTime(hour: 12, minute: 34)

            XCTAssert(tag.releaseDate == TagDate(year: 1998, month: 12, day: 31, time: time))
        }

        do {
            item.stringValue = "1998-12-31 12:34:56"

            let time = TagTime(hour: 12, minute: 34, second: 56)

            XCTAssert(tag.releaseDate == TagDate(year: 1998, month: 12, day: 31, time: time))
        }

        do {
            item.stringValue = "1998-12-31T12"

            let time = TagTime(hour: 12)

            XCTAssert(tag.releaseDate == TagDate(year: 1998, month: 12, day: 31, time: time))
        }

        do {
            item.stringValue = "1998-12-31T12:34"

            let time = TagTime(hour: 12, minute: 34)

            XCTAssert(tag.releaseDate == TagDate(year: 1998, month: 12, day: 31, time: time))
        }

        do {
            item.stringValue = "1998-12-31T12:34:56"

            let time = TagTime(hour: 12, minute: 34, second: 56)

            XCTAssert(tag.releaseDate == TagDate(year: 1998, month: 12, day: 31, time: time))
        }

        do {
            item.stringValue = "1998-99"

            XCTAssert(tag.releaseDate == TagDate(year: 1998))
        }

        do {
            item.stringValue = "1998-12-99"

            XCTAssert(tag.releaseDate == TagDate(year: 1998, month: 12))
        }

        do {
            item.stringValue = "1998-12-31 99"

            XCTAssert(tag.releaseDate == TagDate(year: 1998, month: 12, day: 31))
        }

        do {
            item.stringValue = "1998-12-31 12:99"

            let time = TagTime(hour: 12)

            XCTAssert(tag.releaseDate == TagDate(year: 1998, month: 12, day: 31, time: time))
        }

        do {
            item.stringValue = "1998-12-31 12:34:99"

            let time = TagTime(hour: 12, minute: 34)

            XCTAssert(tag.releaseDate == TagDate(year: 1998, month: 12, day: 31, time: time))
        }

        do {
            item.stringValue = "9999-99-99 99:99:99"

            XCTAssert(tag.releaseDate == TagDate(year: 9999))
        }
    }
}
