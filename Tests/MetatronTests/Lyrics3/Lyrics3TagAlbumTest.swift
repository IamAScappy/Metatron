//
//  Lyrics3TagAlbumTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 27.10.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class Lyrics3TagAlbumTest: XCTestCase {

    // MARK: Instance Methods

    func test() {
        let textEncoding = ID3v1Latin1TextEncoding.regular

        let tag = Lyrics3Tag()

        do {
            let value = ""

            tag.album = value

            XCTAssert(tag.album == value.prefix(250))

            let field = tag.appendField(Lyrics3FieldID.eal)

            XCTAssert(field.stuff == nil)

            do {
                tag.version = Lyrics3Version.v1

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = Lyrics3Version.v2

                XCTAssert(tag.toData() == nil)
            }

            field.imposeStuff(format: Lyrics3TextInformationFormat.regular).content = value

            XCTAssert(tag.album == value.prefix(250))
        }

        do {
            let value = "Abc 123"

            tag.album = value

            XCTAssert(tag.album == value.prefix(250))

            let field = tag.appendField(Lyrics3FieldID.eal)

            XCTAssert(field.stuff(format: Lyrics3TextInformationFormat.regular).content == value.prefix(250))

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

                XCTAssert(other.album == value.deencoded(with: textEncoding).prefix(250))
            }

            field.imposeStuff(format: Lyrics3TextInformationFormat.regular).content = value

            XCTAssert(tag.album == value.prefix(250))
        }

        do {
            let value = "Абв 123"

            tag.album = value

            XCTAssert(tag.album == value.prefix(250))

            let field = tag.appendField(Lyrics3FieldID.eal)

            XCTAssert(field.stuff(format: Lyrics3TextInformationFormat.regular).content == value.prefix(250))

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

                XCTAssert(other.album == value.deencoded(with: textEncoding).prefix(250))
            }

            field.imposeStuff(format: Lyrics3TextInformationFormat.regular).content = value

            XCTAssert(tag.album == value.prefix(250))
        }

        do {
            let value = Array<String>(repeating: "Abc", count: 123).joined(separator: "\n")

            tag.album = value

            XCTAssert(tag.album == value.prefix(250))

            let field = tag.appendField(Lyrics3FieldID.eal)

            XCTAssert(field.stuff(format: Lyrics3TextInformationFormat.regular).content == value.prefix(250))

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

                XCTAssert(other.album == value.deencoded(with: textEncoding).prefix(250))
            }

            field.imposeStuff(format: Lyrics3TextInformationFormat.regular).content = value

            XCTAssert(tag.album == value.prefix(250))
        }
    }
}

