//
//  TagLyricsTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 15.09.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class TagLyricsTest: XCTestCase {

    // MARK: Instance Methods

    func testInit() {
        do {
            let lyrics = TagLyrics()

            XCTAssert(lyrics.pieces == [])

            XCTAssert(lyrics.isEmpty == true)

            let revised = lyrics.revised

            XCTAssert(revised.pieces == [])

            XCTAssert(revised.isEmpty == true)
        }

        do {
            let lyrics = TagLyrics(pieces: [TagLyrics.Piece("Abc 123")])

            guard lyrics.pieces.count == 1 else {
                return XCTFail()
            }

            XCTAssert(lyrics.pieces[0].text == "Abc 123")
            XCTAssert(lyrics.pieces[0].timeStamp == 0)

            XCTAssert(lyrics.isEmpty == false)

            let revised = lyrics.revised

            guard revised.pieces.count == 1 else {
                return XCTFail()
            }

            XCTAssert(revised.pieces[0].text == "Abc 123")
            XCTAssert(revised.pieces[0].timeStamp == 0)

            XCTAssert(revised.isEmpty == false)
        }

        do {
            let lyrics = TagLyrics(pieces: [TagLyrics.Piece("Abc 1"),
                                            TagLyrics.Piece("Abc 2")])

            guard lyrics.pieces.count == 2 else {
                return XCTFail()
            }

            XCTAssert(lyrics.pieces[0].text == "Abc 1")
            XCTAssert(lyrics.pieces[0].timeStamp == 0)

            XCTAssert(lyrics.pieces[1].text == "Abc 2")
            XCTAssert(lyrics.pieces[1].timeStamp == 0)

            XCTAssert(lyrics.isEmpty == false)

            let revised = lyrics.revised

            guard revised.pieces.count == 2 else {
                return XCTFail()
            }

            XCTAssert(revised.pieces[0].text == "Abc 1")
            XCTAssert(revised.pieces[0].timeStamp == 0)

            XCTAssert(revised.pieces[1].text == "Abc 2")
            XCTAssert(revised.pieces[1].timeStamp == 0)

            XCTAssert(revised.isEmpty == false)
        }

        do {
            let lyrics = TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 1230),
                                            TagLyrics.Piece("Abc 2")])

            guard lyrics.pieces.count == 2 else {
                return XCTFail()
            }

            XCTAssert(lyrics.pieces[0].text == "Abc 1")
            XCTAssert(lyrics.pieces[0].timeStamp == 1230)

            XCTAssert(lyrics.pieces[1].text == "Abc 2")
            XCTAssert(lyrics.pieces[1].timeStamp == 0)

            XCTAssert(lyrics.isEmpty == false)

            let revised = lyrics.revised

            guard revised.pieces.count == 2 else {
                return XCTFail()
            }

            XCTAssert(revised.pieces[0].text == "Abc 1")
            XCTAssert(revised.pieces[0].timeStamp == 1230)

            XCTAssert(revised.pieces[1].text == "Abc 2")
            XCTAssert(revised.pieces[1].timeStamp == 1230)

            XCTAssert(revised.isEmpty == false)
        }

        do {
            let lyrics = TagLyrics(pieces: [TagLyrics.Piece("Abc 1"),
                                            TagLyrics.Piece("Abc 2", timeStamp: 4560)])

            guard lyrics.pieces.count == 2 else {
                return XCTFail()
            }

            XCTAssert(lyrics.pieces[0].text == "Abc 1")
            XCTAssert(lyrics.pieces[0].timeStamp == 0)

            XCTAssert(lyrics.pieces[1].text == "Abc 2")
            XCTAssert(lyrics.pieces[1].timeStamp == 4560)

            XCTAssert(lyrics.isEmpty == false)

            let revised = lyrics.revised

            guard revised.pieces.count == 2 else {
                return XCTFail()
            }

            XCTAssert(revised.pieces[0].text == "Abc 1")
            XCTAssert(revised.pieces[0].timeStamp == 0)

            XCTAssert(revised.pieces[1].text == "Abc 2")
            XCTAssert(revised.pieces[1].timeStamp == 4560)

            XCTAssert(revised.isEmpty == false)
        }

        do {
            let lyrics = TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 1230),
                                            TagLyrics.Piece("Abc 2", timeStamp: 4560)])

            guard lyrics.pieces.count == 2 else {
                return XCTFail()
            }

            XCTAssert(lyrics.pieces[0].text == "Abc 1")
            XCTAssert(lyrics.pieces[0].timeStamp == 1230)

            XCTAssert(lyrics.pieces[1].text == "Abc 2")
            XCTAssert(lyrics.pieces[1].timeStamp == 4560)

            XCTAssert(lyrics.isEmpty == false)

            let revised = lyrics.revised

            guard revised.pieces.count == 2 else {
                return XCTFail()
            }

            XCTAssert(revised.pieces[0].text == "Abc 1")
            XCTAssert(revised.pieces[0].timeStamp == 1230)

            XCTAssert(revised.pieces[1].text == "Abc 2")
            XCTAssert(revised.pieces[1].timeStamp == 4560)

            XCTAssert(revised.isEmpty == false)
        }

        do {
            let lyrics = TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 4560),
                                            TagLyrics.Piece("Abc 2", timeStamp: 1230)])

            guard lyrics.pieces.count == 2 else {
                return XCTFail()
            }

            XCTAssert(lyrics.pieces[0].text == "Abc 1")
            XCTAssert(lyrics.pieces[0].timeStamp == 4560)

            XCTAssert(lyrics.pieces[1].text == "Abc 2")
            XCTAssert(lyrics.pieces[1].timeStamp == 1230)

            XCTAssert(lyrics.isEmpty == false)

            let revised = lyrics.revised

            guard revised.pieces.count == 2 else {
                return XCTFail()
            }

            XCTAssert(revised.pieces[0].text == "Abc 1")
            XCTAssert(revised.pieces[0].timeStamp == 4560)

            XCTAssert(revised.pieces[1].text == "Abc 2")
            XCTAssert(revised.pieces[1].timeStamp == 4560)

            XCTAssert(revised.isEmpty == false)
        }

        do {
            let lyrics = TagLyrics(pieces: [TagLyrics.Piece("", timeStamp: 1230),
                                            TagLyrics.Piece("Abc 2", timeStamp: 4560)])

            guard lyrics.pieces.count == 2 else {
                return XCTFail()
            }

            XCTAssert(lyrics.pieces[0].text == "")
            XCTAssert(lyrics.pieces[0].timeStamp == 1230)

            XCTAssert(lyrics.pieces[1].text == "Abc 2")
            XCTAssert(lyrics.pieces[1].timeStamp == 4560)

            XCTAssert(lyrics.isEmpty == false)

            let revised = lyrics.revised

            guard revised.pieces.count == 1 else {
                return XCTFail()
            }

            XCTAssert(revised.pieces[0].text == "Abc 2")
            XCTAssert(revised.pieces[0].timeStamp == 4560)

            XCTAssert(revised.isEmpty == false)
        }

        do {
            let lyrics = TagLyrics(pieces: [TagLyrics.Piece("", timeStamp: 4560),
                                            TagLyrics.Piece("Abc 2", timeStamp: 1230)])

            guard lyrics.pieces.count == 2 else {
                return XCTFail()
            }

            XCTAssert(lyrics.pieces[0].text == "")
            XCTAssert(lyrics.pieces[0].timeStamp == 4560)

            XCTAssert(lyrics.pieces[1].text == "Abc 2")
            XCTAssert(lyrics.pieces[1].timeStamp == 1230)

            XCTAssert(lyrics.isEmpty == false)

            let revised = lyrics.revised

            guard revised.pieces.count == 1 else {
                return XCTFail()
            }

            XCTAssert(revised.pieces[0].text == "Abc 2")
            XCTAssert(revised.pieces[0].timeStamp == 4560)

            XCTAssert(revised.isEmpty == false)
        }

        do {
            let lyrics = TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 1230),
                                            TagLyrics.Piece("", timeStamp: 4560)])

            guard lyrics.pieces.count == 2 else {
                return XCTFail()
            }

            XCTAssert(lyrics.pieces[0].text == "Abc 1")
            XCTAssert(lyrics.pieces[0].timeStamp == 1230)

            XCTAssert(lyrics.pieces[1].text == "")
            XCTAssert(lyrics.pieces[1].timeStamp == 4560)

            XCTAssert(lyrics.isEmpty == false)

            let revised = lyrics.revised

            guard revised.pieces.count == 1 else {
                return XCTFail()
            }

            XCTAssert(revised.pieces[0].text == "Abc 1")
            XCTAssert(revised.pieces[0].timeStamp == 1230)

            XCTAssert(revised.isEmpty == false)
        }

        do {
            let lyrics = TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 4560),
                                            TagLyrics.Piece("", timeStamp: 1230)])

            guard lyrics.pieces.count == 2 else {
                return XCTFail()
            }

            XCTAssert(lyrics.pieces[0].text == "Abc 1")
            XCTAssert(lyrics.pieces[0].timeStamp == 4560)

            XCTAssert(lyrics.pieces[1].text == "")
            XCTAssert(lyrics.pieces[1].timeStamp == 1230)

            XCTAssert(lyrics.isEmpty == false)

            let revised = lyrics.revised

            guard revised.pieces.count == 1 else {
                return XCTFail()
            }

            XCTAssert(revised.pieces[0].text == "Abc 1")
            XCTAssert(revised.pieces[0].timeStamp == 4560)

            XCTAssert(revised.isEmpty == false)
        }

        do {
            let lyrics = TagLyrics(pieces: [TagLyrics.Piece("", timeStamp: 1230),
                                            TagLyrics.Piece("", timeStamp: 4560)])

            guard lyrics.pieces.count == 2 else {
                return XCTFail()
            }

            XCTAssert(lyrics.pieces[0].text == "")
            XCTAssert(lyrics.pieces[0].timeStamp == 1230)

            XCTAssert(lyrics.pieces[1].text == "")
            XCTAssert(lyrics.pieces[1].timeStamp == 4560)

            XCTAssert(lyrics.isEmpty == false)

            let revised = lyrics.revised

            XCTAssert(revised.pieces == [])

            XCTAssert(revised.isEmpty == true)
        }
    }

    // MARK:

    func testEquatable() {
        do {
            let lyrics1 = TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 1230),
                                             TagLyrics.Piece("Abc 2", timeStamp: 4560)])

            let lyrics2 = TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 1230),
                                             TagLyrics.Piece("Abc 2", timeStamp: 4560)])

            XCTAssert(lyrics1 == lyrics2)
        }

        do {
            let lyrics1 = TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 1230)])

            let lyrics2 = TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 1230),
                                             TagLyrics.Piece("Abc 2", timeStamp: 4560)])

            XCTAssert(lyrics1 != lyrics2)
        }

        do {
            let lyrics1 = TagLyrics(pieces: [TagLyrics.Piece("Abc 123", timeStamp: 1230)])
            let lyrics2 = TagLyrics(pieces: [TagLyrics.Piece("Abc 456", timeStamp: 1230)])

            XCTAssert(lyrics1 != lyrics2)
        }

        do {
            let lyrics1 = TagLyrics(pieces: [TagLyrics.Piece("Abc 123", timeStamp: 1230)])
            let lyrics2 = TagLyrics(pieces: [TagLyrics.Piece("Abc 123", timeStamp: 4560)])

            XCTAssert(lyrics1 != lyrics2)
        }

        do {
            let lyrics1 = TagLyrics(pieces: [TagLyrics.Piece("Abc 123", timeStamp: 1230)])
            let lyrics2 = TagLyrics(pieces: [TagLyrics.Piece("Abc 456", timeStamp: 4560)])

            XCTAssert(lyrics1 != lyrics2)
        }
    }

    // MARK:

    func testReset() {
        var lyrics = TagLyrics()

        lyrics.reset()

        XCTAssert(lyrics.pieces == [])

        XCTAssert(lyrics.isEmpty == true)
    }
}
