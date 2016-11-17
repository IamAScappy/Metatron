//
//  APETagLyricsTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 15.09.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class APETagLyricsTest: XCTestCase {

    // MARK: Instance Methods

    func test() {
        let tag = APETag()

        do {
            let value = TagLyrics()

            tag.lyrics = value

            XCTAssert(tag.lyrics == value.revised)

            XCTAssert(tag["Lyrics"] == nil)

            do {
                tag.version = APEVersion.v1

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = APEVersion.v2

                XCTAssert(tag.toData() == nil)
            }

            guard let item = tag.appendItem("Lyrics") else {
                return XCTFail()
            }

            item.lyricsValue = value

            XCTAssert(tag.lyrics == TagLyrics())
        }

        do {
            let value = TagLyrics(pieces: [TagLyrics.Piece("Abc 123")])

            tag.lyrics = value

            XCTAssert(tag.lyrics == value.revised)

            guard let item = tag["Lyrics"] else {
                return XCTFail()
            }

            guard let itemValue = item.lyricsValue else {
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

                XCTAssert(other.lyrics == value.revised)
            }

            do {
                tag.version = APEVersion.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.lyrics == value.revised)
            }

            item.lyricsValue = value

            XCTAssert(tag.lyrics == value.revised)
        }

        do {
            let value = TagLyrics(pieces: [TagLyrics.Piece("Абв 123")])

            tag.lyrics = value

            XCTAssert(tag.lyrics == value.revised)

            guard let item = tag["Lyrics"] else {
                return XCTFail()
            }

            guard let itemValue = item.lyricsValue else {
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

                XCTAssert(other.lyrics == value.revised)
            }

            do {
                tag.version = APEVersion.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.lyrics == value.revised)
            }

            item.lyricsValue = value

            XCTAssert(tag.lyrics == value.revised)
        }

        do {
            let value = TagLyrics(pieces: [TagLyrics.Piece("Abc 1"),
                                           TagLyrics.Piece("Abc 2")])

            tag.lyrics = value

            XCTAssert(tag.lyrics == value.revised)

            guard let item = tag["Lyrics"] else {
                return XCTFail()
            }

            guard let itemValue = item.lyricsValue else {
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

                XCTAssert(other.lyrics == value.revised)
            }

            do {
                tag.version = APEVersion.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.lyrics == value.revised)
            }

            item.lyricsValue = value

            XCTAssert(tag.lyrics == value.revised)
        }

        do {
            let value = TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 1230),
                                           TagLyrics.Piece("Abc 2", timeStamp: 4560)])

            tag.lyrics = value

            XCTAssert(tag.lyrics == value.revised)

            guard let item = tag["Lyrics"] else {
                return XCTFail()
            }

            guard let itemValue = item.lyricsValue else {
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

                XCTAssert(other.lyrics == value.revised)
            }

            do {
                tag.version = APEVersion.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.lyrics == value.revised)
            }

            item.lyricsValue = value

            XCTAssert(tag.lyrics == value.revised)
        }

        do {
            let value = TagLyrics(pieces: [TagLyrics.Piece("Abc 1"),
                                           TagLyrics.Piece("Abc 2", timeStamp: 4560)])

            tag.lyrics = value

            XCTAssert(tag.lyrics == value.revised)

            guard let item = tag["Lyrics"] else {
                return XCTFail()
            }

            guard let itemValue = item.lyricsValue else {
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

                XCTAssert(other.lyrics == value.revised)
            }

            do {
                tag.version = APEVersion.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.lyrics == value.revised)
            }

            item.lyricsValue = value

            XCTAssert(tag.lyrics == value.revised)
        }

        do {
            let value = TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 1230),
                                           TagLyrics.Piece("Abc 2")])

            tag.lyrics = value

            XCTAssert(tag.lyrics == value.revised)

            guard let item = tag["Lyrics"] else {
                return XCTFail()
            }

            guard let itemValue = item.lyricsValue else {
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

                XCTAssert(other.lyrics == value.revised)
            }

            do {
                tag.version = APEVersion.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.lyrics == value.revised)
            }

            item.lyricsValue = value

            XCTAssert(tag.lyrics == value.revised)
        }

        do {
            let value = TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 4560),
                                           TagLyrics.Piece("Abc 2", timeStamp: 1230)])

            tag.lyrics = value

            XCTAssert(tag.lyrics == value.revised)

            guard let item = tag["Lyrics"] else {
                return XCTFail()
            }

            guard let itemValue = item.lyricsValue else {
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

                XCTAssert(other.lyrics == value.revised)
            }

            do {
                tag.version = APEVersion.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.lyrics == value.revised)
            }

            item.lyricsValue = value

            XCTAssert(tag.lyrics == value.revised)
        }

        do {
            let value = TagLyrics(pieces: [TagLyrics.Piece("", timeStamp: 1230),
                                           TagLyrics.Piece("Abc 2", timeStamp: 4560)])

            tag.lyrics = value

            XCTAssert(tag.lyrics == value.revised)

            guard let item = tag["Lyrics"] else {
                return XCTFail()
            }

            guard let itemValue = item.lyricsValue else {
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

                XCTAssert(other.lyrics == value.revised)
            }

            do {
                tag.version = APEVersion.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.lyrics == value.revised)
            }

            item.lyricsValue = value

            XCTAssert(tag.lyrics == value.revised)
        }

        do {
            let value = TagLyrics(pieces: [TagLyrics.Piece("", timeStamp: 4560),
                                           TagLyrics.Piece("Abc 2", timeStamp: 1230)])

            tag.lyrics = value

            XCTAssert(tag.lyrics == value.revised)

            guard let item = tag["Lyrics"] else {
                return XCTFail()
            }

            guard let itemValue = item.lyricsValue else {
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

                XCTAssert(other.lyrics == value.revised)
            }

            do {
                tag.version = APEVersion.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.lyrics == value.revised)
            }

            item.lyricsValue = value

            XCTAssert(tag.lyrics == value.revised)
        }

        do {
            let value = TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 1230),
                                           TagLyrics.Piece("", timeStamp: 4560)])

            tag.lyrics = value

            XCTAssert(tag.lyrics == value.revised)

            guard let item = tag["Lyrics"] else {
                return XCTFail()
            }

            guard let itemValue = item.lyricsValue else {
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

                XCTAssert(other.lyrics == value.revised)
            }

            do {
                tag.version = APEVersion.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.lyrics == value.revised)
            }

            item.lyricsValue = value

            XCTAssert(tag.lyrics == value.revised)
        }

        do {
            let value = TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 4560),
                                           TagLyrics.Piece("", timeStamp: 1230)])

            tag.lyrics = value

            XCTAssert(tag.lyrics == value.revised)

            guard let item = tag["Lyrics"] else {
                return XCTFail()
            }

            guard let itemValue = item.lyricsValue else {
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

                XCTAssert(other.lyrics == value.revised)
            }

            do {
                tag.version = APEVersion.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = APETag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.lyrics == value.revised)
            }

            item.lyricsValue = value

            XCTAssert(tag.lyrics == value.revised)
        }

        do {
            let value = TagLyrics(pieces: [TagLyrics.Piece("", timeStamp: 1230),
                                           TagLyrics.Piece("", timeStamp: 4560)])

            tag.lyrics = value

            XCTAssert(tag.lyrics == value.revised)

            XCTAssert(tag["Lyrics"] == nil)

            do {
                tag.version = APEVersion.v1

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = APEVersion.v2

                XCTAssert(tag.toData() == nil)
            }

            guard let item = tag.appendItem("Lyrics") else {
                return XCTFail()
            }

            item.lyricsValue = value

            XCTAssert(tag.lyrics == value.revised)
        }

        do {
            let value = TagLyrics(pieces: [TagLyrics.Piece("", timeStamp: 4560),
                                           TagLyrics.Piece("", timeStamp: 1230)])

            tag.lyrics = value

            XCTAssert(tag.lyrics == value.revised)

            XCTAssert(tag["Lyrics"] == nil)

            do {
                tag.version = APEVersion.v1

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = APEVersion.v2

                XCTAssert(tag.toData() == nil)
            }

            guard let item = tag.appendItem("Lyrics") else {
                return XCTFail()
            }

            item.lyricsValue = value

            XCTAssert(tag.lyrics == value.revised)
        }

        guard let item = tag.appendItem("Lyrics") else {
            return XCTFail()
        }

        do {
            item.value = [0]

            XCTAssert(tag.lyrics == TagLyrics())
        }

        do {
            item.stringValue = "[1.23]Abc 1[4.56]Abc 2"

            XCTAssert(tag.lyrics == TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 1230),
                                                       TagLyrics.Piece("Abc 2", timeStamp: 4560)]))
        }

        do {
            item.stringValue = "[1.23] Abc 1\n[4.56] Abc 2\n"

            XCTAssert(tag.lyrics == TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 1230),
                                                       TagLyrics.Piece("Abc 2", timeStamp: 4560)]))
        }

        do {
            item.stringValue = "[4.56] Abc 1\n[1.23] Abc 2\n"

            XCTAssert(tag.lyrics == TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 4560),
                                                       TagLyrics.Piece("Abc 2", timeStamp: 4560)]))
        }

        do {
            item.stringValue = "[1.23][4.56] Abc 2\n"

            XCTAssert(tag.lyrics == TagLyrics(pieces: [TagLyrics.Piece("Abc 2", timeStamp: 4560)]))
        }

        do {
            item.stringValue = "[1.23] Abc 1\n[4.56]"

            XCTAssert(tag.lyrics == TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 1230)]))
        }

        do {
            item.stringValue = "[1.23][4.56]"

            XCTAssert(tag.lyrics == TagLyrics())
        }

        do {
            item.stringValue = "[] Abc 1\n[4.56] Abc 2\n"

            XCTAssert(tag.lyrics == TagLyrics(pieces: [TagLyrics.Piece("[] Abc 1\n[4.56] Abc 2\n")]))
        }

        do {
            item.stringValue = "[1.23] Abc 1\n[] Abc 2\n"

            XCTAssert(tag.lyrics == TagLyrics(pieces: [TagLyrics.Piece("Abc 1\n[] Abc 2", timeStamp: 1230)]))
        }

        do {
            item.stringValue = "[] Abc 1\n[] Abc 2\n"

            XCTAssert(tag.lyrics == TagLyrics(pieces: [TagLyrics.Piece("[] Abc 1\n[] Abc 2\n")]))
        }

        do {
            item.stringValue = "[][] Abc 2\n"

            XCTAssert(tag.lyrics == TagLyrics(pieces: [TagLyrics.Piece("[][] Abc 2\n")]))
        }

        do {
            item.stringValue = "[] Abc 1\n[]"

            XCTAssert(tag.lyrics == TagLyrics(pieces: [TagLyrics.Piece("[] Abc 1\n[]")]))
        }

        do {
            item.stringValue = "[][]"

            XCTAssert(tag.lyrics == TagLyrics(pieces: [TagLyrics.Piece("[][]")]))
        }

        do {
            item.stringValue = "[1.23] Abc\0 1\n[4.56] Abc\0 2\n"

            XCTAssert(tag.lyrics == TagLyrics(pieces: [TagLyrics.Piece("Abc", timeStamp: 1230),
                                                       TagLyrics.Piece("Abc", timeStamp: 4560)]))
        }

        do {
            item.stringValue = "[[1.23]] Abc 1\n[4.56] Abc 2\n"

            XCTAssert(tag.lyrics == TagLyrics(pieces: [TagLyrics.Piece("[[1.23]] Abc 1\n[4.56] Abc 2\n")]))
        }

        do {
            item.stringValue = "[1.23] Abc 1\n[[4.56]] Abc 2\n"

            XCTAssert(tag.lyrics == TagLyrics(pieces: [TagLyrics.Piece("Abc 1\n[", timeStamp: 1230),
                                                       TagLyrics.Piece("] Abc 2", timeStamp: 4560)]))
        }

        do {
            item.stringValue = "[[1.23]] Abc 1\n[[4.56]] Abc 2\n"

            XCTAssert(tag.lyrics == TagLyrics(pieces: [TagLyrics.Piece("[[1.23]] Abc 1\n[[4.56]] Abc 2\n")]))
        }

        do {
            item.stringValue = "[Abc 1] Abc 2\n"

            XCTAssert(tag.lyrics == TagLyrics(pieces: [TagLyrics.Piece("[Abc 1] Abc 2\n")]))
        }

        do {
            item.stringValue = "[\0] Abc 123\n"

            XCTAssert(tag.lyrics == TagLyrics(pieces: [TagLyrics.Piece("[")]))
        }
    }
}
