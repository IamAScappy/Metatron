//
//  ID3v1TagArtistsTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 16.09.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class ID3v1TagArtistsTest: XCTestCase {

    // MARK: Instance Methods

    func test() {
        let textEncoding = ID3v1Latin1TextEncoding.regular

        let tag = ID3v1Tag()

        do {
            let value: [String] = []

            tag.artists = value

            XCTAssert(tag.artists == [])
            XCTAssert(tag.artist == "")

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
            let value = [""]

            tag.artists = value

            XCTAssert(tag.artists == [])
            XCTAssert(tag.artist == "")

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
            let value = ["Abc 123"]

            let joined = value.joined(separator: ", ")

            tag.artists = value

            XCTAssert(tag.artists == [joined])
            XCTAssert(tag.artist == joined)

            do {
                tag.version = ID3v1Version.v0

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.artist == joined.deencoded(with: textEncoding).prefix(30))
            }

            do {
                tag.version = ID3v1Version.v1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.artist == joined.deencoded(with: textEncoding).prefix(30))
            }

            do {
                tag.version = ID3v1Version.vExt0

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.artist == joined.deencoded(with: textEncoding).prefix(90))
            }

            do {
                tag.version = ID3v1Version.vExt1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.artist == joined.deencoded(with: textEncoding).prefix(90))
            }
        }

        do {
            let value = ["Абв 123"]

            let joined = value.joined(separator: ", ")

            tag.artists = value

            XCTAssert(tag.artists == [joined])
            XCTAssert(tag.artist == joined)

            do {
                tag.version = ID3v1Version.v0

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.artist == joined.deencoded(with: textEncoding).prefix(30))
            }

            do {
                tag.version = ID3v1Version.v1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.artist == joined.deencoded(with: textEncoding).prefix(30))
            }

            do {
                tag.version = ID3v1Version.vExt0

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.artist == joined.deencoded(with: textEncoding).prefix(90))
            }

            do {
                tag.version = ID3v1Version.vExt1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.artist == joined.deencoded(with: textEncoding).prefix(90))
            }
        }

        do {
            let value = ["Abc 1", "Abc 2"]

            let joined = value.joined(separator: ", ")

            tag.artists = value

            XCTAssert(tag.artists == [joined])
            XCTAssert(tag.artist == joined)

            do {
                tag.version = ID3v1Version.v0

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.artist == joined.deencoded(with: textEncoding).prefix(30))
            }

            do {
                tag.version = ID3v1Version.v1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.artist == joined.deencoded(with: textEncoding).prefix(30))
            }

            do {
                tag.version = ID3v1Version.vExt0

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.artist == joined.deencoded(with: textEncoding).prefix(90))
            }

            do {
                tag.version = ID3v1Version.vExt1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.artist == joined.deencoded(with: textEncoding).prefix(90))
            }
        }

        do {
            let value = ["", "Abc 2"]

            tag.artists = value

            XCTAssert(tag.artists == ["Abc 2"])
            XCTAssert(tag.artist == "Abc 2")

            do {
                tag.version = ID3v1Version.v0

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.artist == String("Abc 2").deencoded(with: textEncoding).prefix(30))
            }

            do {
                tag.version = ID3v1Version.v1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.artist == String("Abc 2").deencoded(with: textEncoding).prefix(30))
            }

            do {
                tag.version = ID3v1Version.vExt0

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.artist == String("Abc 2").deencoded(with: textEncoding).prefix(90))
            }

            do {
                tag.version = ID3v1Version.vExt1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.artist == String("Abc 2").deencoded(with: textEncoding).prefix(90))
            }
        }

        do {
            let value = ["Abc 1", ""]

            tag.artists = value

            XCTAssert(tag.artists == ["Abc 1"])
            XCTAssert(tag.artist == "Abc 1")

            do {
                tag.version = ID3v1Version.v0

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.artist == String("Abc 1").deencoded(with: textEncoding).prefix(30))
            }

            do {
                tag.version = ID3v1Version.v1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.artist == String("Abc 1").deencoded(with: textEncoding).prefix(30))
            }

            do {
                tag.version = ID3v1Version.vExt0

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.artist == String("Abc 1").deencoded(with: textEncoding).prefix(90))
            }

            do {
                tag.version = ID3v1Version.vExt1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.artist == String("Abc 1").deencoded(with: textEncoding).prefix(90))
            }
        }

        do {
            let value: [String] = ["", ""]

            tag.artists = value

            XCTAssert(tag.artists == [])
            XCTAssert(tag.artist == "")

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
            let value = [Array<String>(repeating: "Abc", count: 123).joined(separator: "\n")]

            let joined = value.joined(separator: ", ")

            tag.artists = value

            XCTAssert(tag.artists == [joined])
            XCTAssert(tag.artist == joined)

            do {
                tag.version = ID3v1Version.v0

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.artist == joined.deencoded(with: textEncoding).prefix(30))
            }

            do {
                tag.version = ID3v1Version.v1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.artist == joined.deencoded(with: textEncoding).prefix(30))
            }

            do {
                tag.version = ID3v1Version.vExt0

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.artist == joined.deencoded(with: textEncoding).prefix(90))
            }

            do {
                tag.version = ID3v1Version.vExt1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.artist == joined.deencoded(with: textEncoding).prefix(90))
            }
        }

        do {
            let value = Array<String>(repeating: "Abc", count: 123)

            let joined = value.joined(separator: ", ")

            tag.artists = value

            XCTAssert(tag.artists == [joined])
            XCTAssert(tag.artist == joined)

            do {
                tag.version = ID3v1Version.v0

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.artist == joined.deencoded(with: textEncoding).prefix(30))
            }

            do {
                tag.version = ID3v1Version.v1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.artist == joined.deencoded(with: textEncoding).prefix(30))
            }

            do {
                tag.version = ID3v1Version.vExt0

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.artist == joined.deencoded(with: textEncoding).prefix(90))
            }

            do {
                tag.version = ID3v1Version.vExt1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.artist == joined.deencoded(with: textEncoding).prefix(90))
            }
        }

        do {
            tag.artist = ""

            XCTAssert(tag.artists == [])
        }

        do {
            tag.artist = "Abc 1, Abc 2"

            XCTAssert(tag.artists == ["Abc 1, Abc 2"])
        }
    }
}
