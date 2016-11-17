//
//  Lyrics3TagCommentsTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 27.10.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class Lyrics3TagCommentsTest: XCTestCase {

    // MARK: Instance Methods

    func test() {
        let textEncoding = ID3v1Latin1TextEncoding.regular

        let tag = Lyrics3Tag()

        do {
            let value: [String] = []

            let joined = value.joined(separator: "\n")

            tag.comments = value

            XCTAssert(tag.comments == [])

            let field = tag.appendField(Lyrics3FieldID.inf)

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

            XCTAssert(tag.comments == [])
        }

        do {
            let value = [""]

            let joined = value.joined(separator: "\n")

            tag.comments = value

            XCTAssert(tag.comments == [])

            let field = tag.appendField(Lyrics3FieldID.inf)

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

            XCTAssert(tag.comments == [])
        }

        do {
            let value = ["Abc 123"]

            let joined = value.joined(separator: "\n")

            tag.comments = value

            XCTAssert(tag.comments == [joined])

            let field = tag.appendField(Lyrics3FieldID.inf)

            XCTAssert(field.stuff(format: Lyrics3TextInformationFormat.regular).content == joined)

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

                XCTAssert(other.comments == [joined.deencoded(with: textEncoding)])
            }

            field.imposeStuff(format: Lyrics3TextInformationFormat.regular).content = joined

            XCTAssert(tag.comments == [joined])
        }

        do {
            let value = ["Абв 123"]

            let joined = value.joined(separator: "\n")

            tag.comments = value

            XCTAssert(tag.comments == [joined])

            let field = tag.appendField(Lyrics3FieldID.inf)

            XCTAssert(field.stuff(format: Lyrics3TextInformationFormat.regular).content == joined)

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

                XCTAssert(other.comments == [joined.deencoded(with: textEncoding)])
            }

            field.imposeStuff(format: Lyrics3TextInformationFormat.regular).content = joined

            XCTAssert(tag.comments == [joined])
        }

        do {
            let value = ["Abc 1", "Abc 2"]

            let joined = value.joined(separator: "\n")

            tag.comments = value

            XCTAssert(tag.comments == [joined])

            let field = tag.appendField(Lyrics3FieldID.inf)

            XCTAssert(field.stuff(format: Lyrics3TextInformationFormat.regular).content == joined)

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

                XCTAssert(other.comments == [joined.deencoded(with: textEncoding)])
            }

            field.imposeStuff(format: Lyrics3TextInformationFormat.regular).content = joined

            XCTAssert(tag.comments == [joined])
        }

        do {
            let value = ["", "Abc 2"]

            let joined = value.joined(separator: "\n")

            tag.comments = value

            XCTAssert(tag.comments == [joined])

            let field = tag.appendField(Lyrics3FieldID.inf)

            XCTAssert(field.stuff(format: Lyrics3TextInformationFormat.regular).content == joined)

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

                XCTAssert(other.comments == [joined.deencoded(with: textEncoding)])
            }

            field.imposeStuff(format: Lyrics3TextInformationFormat.regular).content = joined

            XCTAssert(tag.comments == [joined])
        }

        do {
            let value = ["Abc 1", ""]

            let joined = value.joined(separator: "\n")

            tag.comments = value

            XCTAssert(tag.comments == [joined])

            let field = tag.appendField(Lyrics3FieldID.inf)

            XCTAssert(field.stuff(format: Lyrics3TextInformationFormat.regular).content == joined)

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

                XCTAssert(other.comments == [joined.deencoded(with: textEncoding)])
            }

            field.imposeStuff(format: Lyrics3TextInformationFormat.regular).content = joined

            XCTAssert(tag.comments == [joined])
        }

        do {
            let value = ["", ""]

            let joined = value.joined(separator: "\n")

            tag.comments = value

            XCTAssert(tag.comments == [joined])

            let field = tag.appendField(Lyrics3FieldID.inf)

            XCTAssert(field.stuff(format: Lyrics3TextInformationFormat.regular).content == joined)

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

                XCTAssert(other.comments == [joined.deencoded(with: textEncoding)])
            }

            field.imposeStuff(format: Lyrics3TextInformationFormat.regular).content = joined

            XCTAssert(tag.comments == [joined])
        }

        do {
            let value = [Array<String>(repeating: "Abc", count: 123).joined(separator: "\n")]

            let joined = value.joined(separator: "\n")

            tag.comments = value

            XCTAssert(tag.comments == [joined])

            let field = tag.appendField(Lyrics3FieldID.inf)

            XCTAssert(field.stuff(format: Lyrics3TextInformationFormat.regular).content == joined)

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

                XCTAssert(other.comments == [joined.deencoded(with: textEncoding)])
            }

            field.imposeStuff(format: Lyrics3TextInformationFormat.regular).content = joined

            XCTAssert(tag.comments == [joined])
        }

        do {
            let value = Array<String>(repeating: "Abc", count: 123)

            let joined = value.joined(separator: "\n")

            tag.comments = value

            XCTAssert(tag.comments == [joined])

            let field = tag.appendField(Lyrics3FieldID.inf)

            XCTAssert(field.stuff(format: Lyrics3TextInformationFormat.regular).content == joined)

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

                XCTAssert(other.comments == [joined.deencoded(with: textEncoding)])
            }

            field.imposeStuff(format: Lyrics3TextInformationFormat.regular).content = joined

            XCTAssert(tag.comments == [joined])
        }
    }
}
