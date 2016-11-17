//
//  ID3v1TagTrackNumberTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 16.09.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class ID3v1TagTrackNumberTest: XCTestCase {

    // MARK: Instance Methods

    func test() {
        let tag = ID3v1Tag()

        do {
            let value = TagNumber()

            tag.trackNumber = value

            do {
                tag.version = ID3v1Version.v0

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = ID3v1Version.v1

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = ID3v1Version.vExt0

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = ID3v1Version.vExt1

                XCTAssert(tag.toData() == nil)
            }
        }

        do {
            let value = TagNumber(999)

            tag.trackNumber = value

            do {
                tag.version = ID3v1Version.v0

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = ID3v1Version.v1

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = ID3v1Version.vExt0

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = ID3v1Version.vExt1

                XCTAssert(tag.toData() == nil)
            }
        }

        do {
            let value = TagNumber(0, total: 12)

            tag.trackNumber = value

            do {
                tag.version = ID3v1Version.v0

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = ID3v1Version.v1

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = ID3v1Version.vExt0

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = ID3v1Version.vExt1

                XCTAssert(tag.toData() == nil)
            }
        }

        do {
            let value = TagNumber(34, total: 12)

            tag.trackNumber = value

            do {
                tag.version = ID3v1Version.v0

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = ID3v1Version.v1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.trackNumber == TagNumber(value.value))
            }

            do {
                tag.version = ID3v1Version.vExt0

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = ID3v1Version.vExt1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.trackNumber == TagNumber(value.value))
            }
        }

        do {
            let value = TagNumber(-12, total: 34)

            tag.trackNumber = value

            do {
                tag.version = ID3v1Version.v0

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = ID3v1Version.v1

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = ID3v1Version.vExt0

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = ID3v1Version.vExt1

                XCTAssert(tag.toData() == nil)
            }
        }

        do {
            let value = TagNumber(12, total: -34)

            tag.trackNumber = value

            do {
                tag.version = ID3v1Version.v0

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = ID3v1Version.v1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.trackNumber == TagNumber(value.value))
            }

            do {
                tag.version = ID3v1Version.vExt0

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = ID3v1Version.vExt1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.trackNumber == TagNumber(value.value))
            }
        }

        do {
            let value = TagNumber(-12, total: -34)

            tag.trackNumber = value

            do {
                tag.version = ID3v1Version.v0

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = ID3v1Version.v1

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = ID3v1Version.vExt0

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = ID3v1Version.vExt1

                XCTAssert(tag.toData() == nil)
            }
        }

        do {
            let value = TagNumber(12)

            tag.trackNumber = value

            do {
                tag.version = ID3v1Version.v0

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = ID3v1Version.v1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.trackNumber == TagNumber(value.value))
            }

            do {
                tag.version = ID3v1Version.vExt0

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = ID3v1Version.vExt1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.trackNumber == TagNumber(value.value))
            }
        }

        do {
            let value = TagNumber(12, total: 34)

            tag.trackNumber = value

            do {
                tag.version = ID3v1Version.v0

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = ID3v1Version.v1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.trackNumber == TagNumber(value.value))
            }

            do {
                tag.version = ID3v1Version.vExt0

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = ID3v1Version.vExt1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.trackNumber == TagNumber(value.value))
            }
        }
    }
}
