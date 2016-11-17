//
//  Lyrics3TagArtistsTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 27.10.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class Lyrics3TagArtistsTest: XCTestCase {

    // MARK: Instance Methods

    func test() {
        let textEncoding = ID3v1Latin1TextEncoding.regular

        let tag = Lyrics3Tag()

        do {
            let value: [String] = []

            let joined = value.joined(separator: ", ")

            tag.artists = value

            XCTAssert(tag.artists == [])

            let field = tag.appendField(Lyrics3FieldID.ear)

            XCTAssert(field.stuff == nil)

            do {
                tag.version = Lyrics3Version.v1

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = Lyrics3Version.v2

                XCTAssert(tag.toData() == nil)
            }

            field.imposeStuff(format: Lyrics3TextInformationFormat.regular).content = joined

            XCTAssert(tag.artists == [])
        }

        do {
            let value = [""]

            let joined = value.joined(separator: ", ")

            tag.artists = value

            XCTAssert(tag.artists == [])

            let field = tag.appendField(Lyrics3FieldID.ear)

            XCTAssert(field.stuff == nil)

            do {
                tag.version = Lyrics3Version.v1

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = Lyrics3Version.v2

                XCTAssert(tag.toData() == nil)
            }

            field.imposeStuff(format: Lyrics3TextInformationFormat.regular).content = joined

            XCTAssert(tag.artists == [])
        }

        do {
            let value = ["Abc 123"]

            let joined = value.joined(separator: ", ")

            tag.artists = value

            XCTAssert(tag.artists == [joined.prefix(250)])

            let field = tag.appendField(Lyrics3FieldID.ear)

            XCTAssert(field.stuff(format: Lyrics3TextInformationFormat.regular).content == joined.prefix(250))

            do {
                tag.version = Lyrics3Version.v1

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = Lyrics3Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = Lyrics3Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.artists == [joined.deencoded(with: textEncoding).prefix(250)])
            }

            field.imposeStuff(format: Lyrics3TextInformationFormat.regular).content = joined

            XCTAssert(tag.artists == [joined.prefix(250)])
        }

        do {
            let value = ["Абв 123"]

            let joined = value.joined(separator: ", ")

            tag.artists = value

            XCTAssert(tag.artists == [joined.prefix(250)])

            let field = tag.appendField(Lyrics3FieldID.ear)

            XCTAssert(field.stuff(format: Lyrics3TextInformationFormat.regular).content == joined.prefix(250))

            do {
                tag.version = Lyrics3Version.v1

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = Lyrics3Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = Lyrics3Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.artists == [joined.deencoded(with: textEncoding).prefix(250)])
            }

            field.imposeStuff(format: Lyrics3TextInformationFormat.regular).content = joined

            XCTAssert(tag.artists == [joined.prefix(250)])
        }

        do {
            let value = ["Abc 1", "Abc 2"]

            let joined = value.joined(separator: ", ")

            tag.artists = value

            XCTAssert(tag.artists == [joined.prefix(250)])

            let field = tag.appendField(Lyrics3FieldID.ear)

            XCTAssert(field.stuff(format: Lyrics3TextInformationFormat.regular).content == joined.prefix(250))

            do {
                tag.version = Lyrics3Version.v1

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = Lyrics3Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = Lyrics3Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.artists == [joined.deencoded(with: textEncoding).prefix(250)])
            }

            field.imposeStuff(format: Lyrics3TextInformationFormat.regular).content = joined

            XCTAssert(tag.artists == [joined.prefix(250)])
        }

        do {
            let value = ["", "Abc 2"]

            let joined = value.joined(separator: ", ")

            tag.artists = value

            XCTAssert(tag.artists == ["Abc 2"])

            let field = tag.appendField(Lyrics3FieldID.ear)

            XCTAssert(field.stuff(format: Lyrics3TextInformationFormat.regular).content == "Abc 2")

            do {
                tag.version = Lyrics3Version.v1

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = Lyrics3Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = Lyrics3Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.artists == [String("Abc 2").deencoded(with: textEncoding).prefix(250)])
            }

            field.imposeStuff(format: Lyrics3TextInformationFormat.regular).content = joined

            XCTAssert(tag.artists == [joined.prefix(250)])
        }

        do {
            let value = ["Abc 1", ""]

            let joined = value.joined(separator: ", ")

            tag.artists = value

            XCTAssert(tag.artists == ["Abc 1"])

            let field = tag.appendField(Lyrics3FieldID.ear)

            XCTAssert(field.stuff(format: Lyrics3TextInformationFormat.regular).content == "Abc 1")

            do {
                tag.version = Lyrics3Version.v1

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = Lyrics3Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = Lyrics3Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.artists == [String("Abc 1").deencoded(with: textEncoding).prefix(250)])
            }

            field.imposeStuff(format: Lyrics3TextInformationFormat.regular).content = joined

            XCTAssert(tag.artists == [joined.prefix(250)])
        }

        do {
            let value = ["", ""]

            let joined = value.joined(separator: ", ")

            tag.artists = value

            XCTAssert(tag.artists == [])

            let field = tag.appendField(Lyrics3FieldID.ear)

            XCTAssert(field.stuff(format: Lyrics3TextInformationFormat.regular).content == "")

            do {
                tag.version = Lyrics3Version.v1

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = Lyrics3Version.v2

                XCTAssert(tag.toData() == nil)
            }

            field.imposeStuff(format: Lyrics3TextInformationFormat.regular).content = joined

            XCTAssert(tag.artists == [joined.prefix(250)])
        }

        do {
            let value = [Array<String>(repeating: "Abc", count: 123).joined(separator: "\n")]

            let joined = value.joined(separator: ", ")

            tag.artists = value

            XCTAssert(tag.artists == [joined.prefix(250)])

            let field = tag.appendField(Lyrics3FieldID.ear)

            XCTAssert(field.stuff(format: Lyrics3TextInformationFormat.regular).content == joined.prefix(250))

            do {
                tag.version = Lyrics3Version.v1

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = Lyrics3Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = Lyrics3Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.artists == [joined.deencoded(with: textEncoding).prefix(250)])
            }

            field.imposeStuff(format: Lyrics3TextInformationFormat.regular).content = joined

            XCTAssert(tag.artists == [joined.prefix(250)])
        }

        do {
            let value = Array<String>(repeating: "Abc", count: 123)

            let joined = value.joined(separator: ", ")

            tag.artists = value

            XCTAssert(tag.artists == [joined.prefix(250)])

            let field = tag.appendField(Lyrics3FieldID.ear)

            XCTAssert(field.stuff(format: Lyrics3TextInformationFormat.regular).content == joined.prefix(250))

            do {
                tag.version = Lyrics3Version.v1

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = Lyrics3Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = Lyrics3Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.artists == [joined.deencoded(with: textEncoding).prefix(250)])
            }

            field.imposeStuff(format: Lyrics3TextInformationFormat.regular).content = joined

            XCTAssert(tag.artists == [joined.prefix(250)])
        }
    }
}
