//
//  Lyrics3TagLyricsTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 27.10.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class Lyrics3TagLyricsTest: XCTestCase {

    // MARK: Instance Methods

    func test() {
        let tag = Lyrics3Tag()

        do {
            let value = TagLyrics()

            tag.lyrics = value

            XCTAssert(tag.lyrics == value.revised)

            let field = tag.appendField(Lyrics3FieldID.lyr)

            XCTAssert(field.stuff == nil)

            do {
                tag.version = Lyrics3Version.v1

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = Lyrics3Version.v2

                XCTAssert(tag.toData() == nil)
            }

            field.imposeStuff(format: Lyrics3TextInformationFormat.regular).lyricsValue = value

            XCTAssert(tag.lyrics == value.revised)
        }

        do {
            let value = TagLyrics(pieces: [TagLyrics.Piece("Abc 123")])

            tag.lyrics = value

            XCTAssert(tag.lyrics == value.revised)

            let field = tag.appendField(Lyrics3FieldID.lyr)

            XCTAssert(field.stuff(format: Lyrics3TextInformationFormat.regular).lyricsValue == value.revised)

            do {
                tag.version = Lyrics3Version.v1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = Lyrics3Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.lyrics == value.revised)
            }

            do {
                tag.version = Lyrics3Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = Lyrics3Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.lyrics == value.revised)
            }

            field.imposeStuff(format: Lyrics3TextInformationFormat.regular).lyricsValue = value

            XCTAssert(tag.lyrics == value.revised)
        }

        do {
            let value = TagLyrics(pieces: [TagLyrics.Piece("Абв 123")])

            tag.lyrics = value

            XCTAssert(tag.lyrics == value.revised)

            let field = tag.appendField(Lyrics3FieldID.lyr)

            XCTAssert(field.stuff(format: Lyrics3TextInformationFormat.regular).lyricsValue == value.revised)

            do {
                tag.version = Lyrics3Version.v1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = Lyrics3Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.lyrics != value.revised)
            }

            do {
                tag.version = Lyrics3Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = Lyrics3Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.lyrics != value.revised)
            }

            field.imposeStuff(format: Lyrics3TextInformationFormat.regular).lyricsValue = value

            XCTAssert(tag.lyrics == value.revised)
        }

        do {
            let value = TagLyrics(pieces: [TagLyrics.Piece("Abc 1"),
                                           TagLyrics.Piece("Abc 2")])

            tag.lyrics = value

            XCTAssert(tag.lyrics == value.revised)

            let field = tag.appendField(Lyrics3FieldID.lyr)

            XCTAssert(field.stuff(format: Lyrics3TextInformationFormat.regular).lyricsValue == value.revised)

            do {
                tag.version = Lyrics3Version.v1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = Lyrics3Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.lyrics == value.revised)
            }

            do {
                tag.version = Lyrics3Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = Lyrics3Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.lyrics == value.revised)
            }

            field.imposeStuff(format: Lyrics3TextInformationFormat.regular).lyricsValue = value

            XCTAssert(tag.lyrics == value.revised)
        }

        do {
            let value = TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 123000),
                                           TagLyrics.Piece("Abc 2", timeStamp: 456000)])

            tag.lyrics = value

            XCTAssert(tag.lyrics == value.revised)

            let field = tag.appendField(Lyrics3FieldID.lyr)

            XCTAssert(field.stuff(format: Lyrics3TextInformationFormat.regular).lyricsValue == value.revised)

            do {
                tag.version = Lyrics3Version.v1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = Lyrics3Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.lyrics == value.revised)
            }

            do {
                tag.version = Lyrics3Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = Lyrics3Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.lyrics == value.revised)
            }

            field.imposeStuff(format: Lyrics3TextInformationFormat.regular).lyricsValue = value

            XCTAssert(tag.lyrics == value.revised)
        }

        do {
            let value = TagLyrics(pieces: [TagLyrics.Piece("Abc 1"),
                                           TagLyrics.Piece("Abc 2", timeStamp: 456000)])

            tag.lyrics = value

            XCTAssert(tag.lyrics == value.revised)

            let field = tag.appendField(Lyrics3FieldID.lyr)

            XCTAssert(field.stuff(format: Lyrics3TextInformationFormat.regular).lyricsValue == value.revised)

            do {
                tag.version = Lyrics3Version.v1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = Lyrics3Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.lyrics == value.revised)
            }

            do {
                tag.version = Lyrics3Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = Lyrics3Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.lyrics == value.revised)
            }

            field.imposeStuff(format: Lyrics3TextInformationFormat.regular).lyricsValue = value

            XCTAssert(tag.lyrics == value.revised)
        }

        do {
            let value = TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 123000),
                                           TagLyrics.Piece("Abc 2")])

            tag.lyrics = value

            XCTAssert(tag.lyrics == value.revised)

            let field = tag.appendField(Lyrics3FieldID.lyr)

            XCTAssert(field.stuff(format: Lyrics3TextInformationFormat.regular).lyricsValue == value.revised)

            do {
                tag.version = Lyrics3Version.v1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = Lyrics3Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.lyrics == value.revised)
            }

            do {
                tag.version = Lyrics3Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = Lyrics3Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.lyrics == value.revised)
            }

            field.imposeStuff(format: Lyrics3TextInformationFormat.regular).lyricsValue = value

            XCTAssert(tag.lyrics == value.revised)
        }

        do {
            let value = TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 456000),
                                           TagLyrics.Piece("Abc 2", timeStamp: 123000)])

            tag.lyrics = value

            XCTAssert(tag.lyrics == value.revised)

            let field = tag.appendField(Lyrics3FieldID.lyr)

            XCTAssert(field.stuff(format: Lyrics3TextInformationFormat.regular).lyricsValue == value.revised)

            do {
                tag.version = Lyrics3Version.v1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = Lyrics3Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.lyrics == value.revised)
            }

            do {
                tag.version = Lyrics3Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = Lyrics3Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.lyrics == value.revised)
            }

            field.imposeStuff(format: Lyrics3TextInformationFormat.regular).lyricsValue = value

            XCTAssert(tag.lyrics == value.revised)
        }

        do {
            let value = TagLyrics(pieces: [TagLyrics.Piece("", timeStamp: 123000),
                                           TagLyrics.Piece("Abc 2", timeStamp: 456000)])

            tag.lyrics = value

            XCTAssert(tag.lyrics == value.revised)

            let field = tag.appendField(Lyrics3FieldID.lyr)

            XCTAssert(field.stuff(format: Lyrics3TextInformationFormat.regular).lyricsValue == value.revised)

            do {
                tag.version = Lyrics3Version.v1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = Lyrics3Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.lyrics == value.revised)
            }

            do {
                tag.version = Lyrics3Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = Lyrics3Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.lyrics == value.revised)
            }

            field.imposeStuff(format: Lyrics3TextInformationFormat.regular).lyricsValue = value

            XCTAssert(tag.lyrics == value.revised)
        }

        do {
            let value = TagLyrics(pieces: [TagLyrics.Piece("", timeStamp: 456000),
                                           TagLyrics.Piece("Abc 2", timeStamp: 123000)])

            tag.lyrics = value

            XCTAssert(tag.lyrics == value.revised)

            let field = tag.appendField(Lyrics3FieldID.lyr)

            XCTAssert(field.stuff(format: Lyrics3TextInformationFormat.regular).lyricsValue == value.revised)

            do {
                tag.version = Lyrics3Version.v1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = Lyrics3Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.lyrics == value.revised)
            }

            do {
                tag.version = Lyrics3Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = Lyrics3Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.lyrics == value.revised)
            }

            field.imposeStuff(format: Lyrics3TextInformationFormat.regular).lyricsValue = value

            XCTAssert(tag.lyrics == value.revised)
        }

        do {
            let value = TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 123000),
                                           TagLyrics.Piece("", timeStamp: 456000)])

            tag.lyrics = value

            XCTAssert(tag.lyrics == value.revised)

            let field = tag.appendField(Lyrics3FieldID.lyr)

            XCTAssert(field.stuff(format: Lyrics3TextInformationFormat.regular).lyricsValue == value.revised)

            do {
                tag.version = Lyrics3Version.v1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = Lyrics3Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.lyrics == value.revised)
            }

            do {
                tag.version = Lyrics3Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = Lyrics3Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.lyrics == value.revised)
            }

            field.imposeStuff(format: Lyrics3TextInformationFormat.regular).lyricsValue = value

            XCTAssert(tag.lyrics == value.revised)
        }

        do {
            let value = TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 456000),
                                           TagLyrics.Piece("", timeStamp: 123000)])

            tag.lyrics = value

            XCTAssert(tag.lyrics == value.revised)

            let field = tag.appendField(Lyrics3FieldID.lyr)

            XCTAssert(field.stuff(format: Lyrics3TextInformationFormat.regular).lyricsValue == value.revised)

            do {
                tag.version = Lyrics3Version.v1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = Lyrics3Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.lyrics == value.revised)
            }

            do {
                tag.version = Lyrics3Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = Lyrics3Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.lyrics == value.revised)
            }

            field.imposeStuff(format: Lyrics3TextInformationFormat.regular).lyricsValue = value

            XCTAssert(tag.lyrics == value.revised)
        }

        do {
            let value = TagLyrics(pieces: [TagLyrics.Piece("", timeStamp: 123000),
                                           TagLyrics.Piece("", timeStamp: 456000)])

            tag.lyrics = value

            XCTAssert(tag.lyrics == value.revised)

            let field = tag.appendField(Lyrics3FieldID.lyr)

            XCTAssert(field.stuff == nil)

            do {
                tag.version = Lyrics3Version.v1

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = Lyrics3Version.v2

                XCTAssert(tag.toData() == nil)
            }

            field.imposeStuff(format: Lyrics3TextInformationFormat.regular).lyricsValue = value

            XCTAssert(tag.lyrics == value.revised)
        }

        do {
            let value = TagLyrics(pieces: [TagLyrics.Piece("", timeStamp: 4560),
                                           TagLyrics.Piece("", timeStamp: 1230)])

            tag.lyrics = value

            XCTAssert(tag.lyrics == value.revised)

            let field = tag.appendField(Lyrics3FieldID.lyr)

            XCTAssert(field.stuff == nil)

            do {
                tag.version = Lyrics3Version.v1

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = Lyrics3Version.v2

                XCTAssert(tag.toData() == nil)
            }

            field.imposeStuff(format: Lyrics3TextInformationFormat.regular).lyricsValue = value

            XCTAssert(tag.lyrics == value.revised)
        }

        let stuff = tag.appendField(Lyrics3FieldID.lyr).imposeStuff(format: Lyrics3TextInformationFormat.regular)

        do {
            stuff.content = ""

            XCTAssert(tag.lyrics == TagLyrics())
        }

        do {
            stuff.content = "[02:03] Abc 1[10:54] Abc 2"

            XCTAssert(tag.lyrics == TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 123000),
                                                       TagLyrics.Piece("Abc 2", timeStamp: 654000)]))
        }

        do {
            stuff.content = "[02:03]Abc 1\n[10:54]Abc 2\n"

            XCTAssert(tag.lyrics == TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 123000),
                                                       TagLyrics.Piece("Abc 2", timeStamp: 654000)]))
        }

        do {
            stuff.content = "[10:54]Abc 1\n[02:03]Abc 2\n"

            XCTAssert(tag.lyrics == TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 654000),
                                                       TagLyrics.Piece("Abc 2", timeStamp: 654000)]))
        }

        do {
            stuff.content = "[02:03][10:54]Abc 2\n"

            XCTAssert(tag.lyrics == TagLyrics(pieces: [TagLyrics.Piece("Abc 2", timeStamp: 654000)]))
        }

        do {
            stuff.content = "[02:03]Abc 1\n[10:54]"

            XCTAssert(tag.lyrics == TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 123000)]))
        }

        do {
            stuff.content = "[02:03][10:54]"

            XCTAssert(tag.lyrics == TagLyrics())
        }

        do {
            stuff.content = "[]Abc 1\n[10:54]Abc 2\n"

            XCTAssert(tag.lyrics == TagLyrics(pieces: [TagLyrics.Piece("[]Abc 1"),
                                                       TagLyrics.Piece("Abc 2", timeStamp: 654000)]))
        }

        do {
            stuff.content = "[02:03]Abc 1\n[]Abc 2\n"

            XCTAssert(tag.lyrics == TagLyrics(pieces: [TagLyrics.Piece("Abc 1\n[]Abc 2", timeStamp: 123000)]))
        }

        do {
            stuff.content = "[]Abc 1\n[]Abc 2\n"

            XCTAssert(tag.lyrics == TagLyrics(pieces: [TagLyrics.Piece("[]Abc 1\n[]Abc 2")]))
        }

        do {
            stuff.content = "[][]Abc 2\n"

            XCTAssert(tag.lyrics == TagLyrics(pieces: [TagLyrics.Piece("[][]Abc 2")]))
        }

        do {
            stuff.content = "[]Abc 1\n[]"

            XCTAssert(tag.lyrics == TagLyrics(pieces: [TagLyrics.Piece("[]Abc 1\n[]")]))
        }

        do {
            stuff.content = "[][]"

            XCTAssert(tag.lyrics == TagLyrics(pieces: [TagLyrics.Piece("[][]")]))
        }

        do {
            stuff.content = "[[02:03]]Abc 1\n[10:54]Abc 2\n"

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("["),
                                                              TagLyrics.Piece("]Abc 1", timeStamp: 123000),
                                                              TagLyrics.Piece("Abc 2", timeStamp: 654000)]))
        }

        do {
            stuff.content = "[02:03]Abc 1\n[[10:54]]Abc 2\n"

            XCTAssert(tag.lyrics == TagLyrics(pieces: [TagLyrics.Piece("Abc 1\n[", timeStamp: 123000),
                                                       TagLyrics.Piece("]Abc 2", timeStamp: 654000)]))
        }

        do {
            stuff.content = "[[02:03]]Abc 1\n[[10:54]]Abc 2\n"

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("["),
                                                              TagLyrics.Piece("]Abc 1\n[", timeStamp: 123000),
                                                              TagLyrics.Piece("]Abc 2", timeStamp: 654000)]))
        }

        do {
            stuff.content = "[Abc 1] Abc 2\n"

            XCTAssert(tag.lyrics == TagLyrics(pieces: [TagLyrics.Piece("[Abc 1] Abc 2")]))
        }
    }
}
