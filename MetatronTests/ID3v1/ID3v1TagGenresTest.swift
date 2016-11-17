//
//  ID3v1TagGenresTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 16.09.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class ID3v1TagGenresTest: XCTestCase {

    // MARK: Instance Methods

    func test() {
        let textEncoding = ID3v1Latin1TextEncoding.regular

        let tag = ID3v1Tag()

        do {
            let value: [String] = []

            tag.genres = value

            XCTAssert(tag.genres == [])
            XCTAssert(tag.genre == "")

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

            tag.genres = value

            XCTAssert(tag.genres == [])
            XCTAssert(tag.genre == "")

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

            tag.genres = value

            XCTAssert(tag.genres == [value[0]])
            XCTAssert(tag.genre == value[0])

            do {
                tag.version = ID3v1Version.v0

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genre == "")
            }

            do {
                tag.version = ID3v1Version.v1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genre == "")
            }

            do {
                tag.version = ID3v1Version.vExt0

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genre == value[0].deencoded(with: textEncoding).prefix(30))
            }

            do {
                tag.version = ID3v1Version.vExt1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genre == value[0].deencoded(with: textEncoding).prefix(30))
            }
        }

        do {
            let value = ["Абв 123"]

            tag.genres = value

            XCTAssert(tag.genres == [value[0]])
            XCTAssert(tag.genre == value[0])

            do {
                tag.version = ID3v1Version.v0

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genre == "")
            }

            do {
                tag.version = ID3v1Version.v1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genre == "")
            }

            do {
                tag.version = ID3v1Version.vExt0

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genre == value[0].deencoded(with: textEncoding).prefix(30))
            }

            do {
                tag.version = ID3v1Version.vExt1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genre == value[0].deencoded(with: textEncoding).prefix(30))
            }
        }

        do {
            let value = ["Abc 1", "Abc 2"]

            tag.genres = value

            XCTAssert(tag.genres == [value[0]])
            XCTAssert(tag.genre == value[0])

            do {
                tag.version = ID3v1Version.v0

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genre == "")
            }

            do {
                tag.version = ID3v1Version.v1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genre == "")
            }

            do {
                tag.version = ID3v1Version.vExt0

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genre == value[0].deencoded(with: textEncoding).prefix(30))
            }

            do {
                tag.version = ID3v1Version.vExt1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genre == value[0].deencoded(with: textEncoding).prefix(30))
            }
        }

        do {
            let value = ["", "Abc 2"]

            tag.genres = value

            XCTAssert(tag.genres == ["Abc 2"])
            XCTAssert(tag.genre == "Abc 2")

            do {
                tag.version = ID3v1Version.v0

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genre == "")
            }

            do {
                tag.version = ID3v1Version.v1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genre == "")
            }

            do {
                tag.version = ID3v1Version.vExt0

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genre == String("Abc 2").deencoded(with: textEncoding).prefix(30))
            }

            do {
                tag.version = ID3v1Version.vExt1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genre == String("Abc 2").deencoded(with: textEncoding).prefix(30))
            }
        }

        do {
            let value = ["Abc 1", ""]

            tag.genres = value

            XCTAssert(tag.genres == ["Abc 1"])
            XCTAssert(tag.genre == "Abc 1")

            do {
                tag.version = ID3v1Version.v0

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genre == "")
            }

            do {
                tag.version = ID3v1Version.v1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genre == "")
            }

            do {
                tag.version = ID3v1Version.vExt0

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genre == String("Abc 1").deencoded(with: textEncoding).prefix(30))
            }

            do {
                tag.version = ID3v1Version.vExt1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genre == String("Abc 1").deencoded(with: textEncoding).prefix(30))
            }
        }

        do {
            let value: [String] = ["", ""]

            tag.genres = value

            XCTAssert(tag.genres == [])
            XCTAssert(tag.genre == "")

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

            tag.genres = value

            XCTAssert(tag.genres == [value[0]])
            XCTAssert(tag.genre == value[0])

            do {
                tag.version = ID3v1Version.v0

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genre == "")
            }

            do {
                tag.version = ID3v1Version.v1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genre == "")
            }

            do {
                tag.version = ID3v1Version.vExt0

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genre == value[0].deencoded(with: textEncoding).prefix(30))
            }

            do {
                tag.version = ID3v1Version.vExt1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genre == value[0].deencoded(with: textEncoding).prefix(30))
            }
        }

        do {
            let value = Array<String>(repeating: "Abc", count: 123)

            tag.genres = value

            XCTAssert(tag.genres == [value[0]])
            XCTAssert(tag.genre == value[0])

            do {
                tag.version = ID3v1Version.v0

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genre == "")
            }

            do {
                tag.version = ID3v1Version.v1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genre == "")
            }

            do {
                tag.version = ID3v1Version.vExt0

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genre == value[0].deencoded(with: textEncoding).prefix(30))
            }

            do {
                tag.version = ID3v1Version.vExt1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genre == value[0].deencoded(with: textEncoding).prefix(30))
            }
        }

        do {
            let value = ["Classic Rock"]

            tag.genres = value

            XCTAssert(tag.genres == [value[0]])
            XCTAssert(tag.genre == value[0])

            do {
                tag.version = ID3v1Version.v0

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genre == value[0].deencoded(with: textEncoding).prefix(30))
            }

            do {
                tag.version = ID3v1Version.v1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genre == value[0].deencoded(with: textEncoding).prefix(30))
            }

            do {
                tag.version = ID3v1Version.vExt0

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genre == value[0].deencoded(with: textEncoding).prefix(30))
            }

            do {
                tag.version = ID3v1Version.vExt1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genre == value[0].deencoded(with: textEncoding).prefix(30))
            }
        }


        do {
            tag.genre = ""

            XCTAssert(tag.genres == [])
        }

        do {
            tag.genre = "Abc 1, Abc 2"

            XCTAssert(tag.genres == ["Abc 1, Abc 2"])
        }
    }

}
