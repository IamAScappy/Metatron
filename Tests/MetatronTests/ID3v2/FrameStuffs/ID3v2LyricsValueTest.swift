//
//  ID3v2LyricsValueTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 12.10.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class ID3v2LyricsValueTest: XCTestCase {

    // MARK: Instance Methods

    func testSyncedLyrics() {
        let stuff = ID3v2SyncedLyrics()

        do {
            stuff.lyricsValue = TagLyrics()

            XCTAssert(stuff.lyricsValue == TagLyrics())

            XCTAssert(stuff.timeStampFormat == ID3v2TimeStampFormat.absoluteMilliseconds)

            XCTAssert(stuff.syllables == [])
        }

        do {
            stuff.lyricsValue = TagLyrics(pieces: [TagLyrics.Piece("Abc 123")])

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("Abc 123")]))

            XCTAssert(stuff.timeStampFormat == ID3v2TimeStampFormat.absoluteMilliseconds)

            XCTAssert(stuff.syllables == [ID3v2SyncedLyrics.Syllable("Abc 123", timeStamp: 0)])
        }

        do {
            stuff.lyricsValue = TagLyrics(pieces: [TagLyrics.Piece("Абв 123")])

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("Абв 123")]))

            XCTAssert(stuff.timeStampFormat == ID3v2TimeStampFormat.absoluteMilliseconds)

            XCTAssert(stuff.syllables == [ID3v2SyncedLyrics.Syllable("Абв 123", timeStamp: 0)])
        }

        do {
            stuff.lyricsValue = TagLyrics(pieces: [TagLyrics.Piece("Abc 1"),
                                                   TagLyrics.Piece("Abc 2")])

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("Abc 1"),
                                                              TagLyrics.Piece("Abc 2")]))

            XCTAssert(stuff.timeStampFormat == ID3v2TimeStampFormat.absoluteMilliseconds)

            XCTAssert(stuff.syllables == [ID3v2SyncedLyrics.Syllable("Abc 1", timeStamp: 0),
                                          ID3v2SyncedLyrics.Syllable("Abc 2", timeStamp: 0)])
        }

        do {
            stuff.lyricsValue = TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 1230),
                                                   TagLyrics.Piece("Abc 2", timeStamp: 4560)])

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 1230),
                                                              TagLyrics.Piece("Abc 2", timeStamp: 4560)]))

            XCTAssert(stuff.timeStampFormat == ID3v2TimeStampFormat.absoluteMilliseconds)

            XCTAssert(stuff.syllables == [ID3v2SyncedLyrics.Syllable("Abc 1", timeStamp: 1230),
                                          ID3v2SyncedLyrics.Syllable("Abc 2", timeStamp: 4560)])
        }

        do {
            stuff.lyricsValue = TagLyrics(pieces: [TagLyrics.Piece("Abc 1"),
                                                   TagLyrics.Piece("Abc 2", timeStamp: 4560)])

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("Abc 1"),
                                                              TagLyrics.Piece("Abc 2", timeStamp: 4560)]))

            XCTAssert(stuff.timeStampFormat == ID3v2TimeStampFormat.absoluteMilliseconds)

            XCTAssert(stuff.syllables == [ID3v2SyncedLyrics.Syllable("Abc 1", timeStamp: 0),
                                          ID3v2SyncedLyrics.Syllable("Abc 2", timeStamp: 4560)])
        }

        do {
            stuff.lyricsValue = TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 1230),
                                                   TagLyrics.Piece("Abc 2")])

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 1230),
                                                              TagLyrics.Piece("Abc 2")]))

            XCTAssert(stuff.timeStampFormat == ID3v2TimeStampFormat.absoluteMilliseconds)

            XCTAssert(stuff.syllables == [ID3v2SyncedLyrics.Syllable("Abc 1", timeStamp: 1230),
                                          ID3v2SyncedLyrics.Syllable("Abc 2", timeStamp: 0)])
        }

        do {
            stuff.lyricsValue = TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 4560),
                                                   TagLyrics.Piece("Abc 2", timeStamp: 1230)])

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 4560),
                                                              TagLyrics.Piece("Abc 2", timeStamp: 1230)]))

            XCTAssert(stuff.timeStampFormat == ID3v2TimeStampFormat.absoluteMilliseconds)

            XCTAssert(stuff.syllables == [ID3v2SyncedLyrics.Syllable("Abc 1", timeStamp: 4560),
                                          ID3v2SyncedLyrics.Syllable("Abc 2", timeStamp: 1230)])
        }

        do {
            stuff.lyricsValue = TagLyrics(pieces: [TagLyrics.Piece("", timeStamp: 1230),
                                                   TagLyrics.Piece("Abc 2", timeStamp: 4560)])

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("", timeStamp: 1230),
                                                              TagLyrics.Piece("Abc 2", timeStamp: 4560)]))

            XCTAssert(stuff.timeStampFormat == ID3v2TimeStampFormat.absoluteMilliseconds)

            XCTAssert(stuff.syllables == [ID3v2SyncedLyrics.Syllable("", timeStamp: 1230),
                                          ID3v2SyncedLyrics.Syllable("Abc 2", timeStamp: 4560)])
        }

        do {
            stuff.lyricsValue = TagLyrics(pieces: [TagLyrics.Piece("", timeStamp: 4560),
                                                   TagLyrics.Piece("Abc 2", timeStamp: 1230)])

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("", timeStamp: 4560),
                                                              TagLyrics.Piece("Abc 2", timeStamp: 1230)]))

            XCTAssert(stuff.timeStampFormat == ID3v2TimeStampFormat.absoluteMilliseconds)

            XCTAssert(stuff.syllables == [ID3v2SyncedLyrics.Syllable("", timeStamp: 4560),
                                          ID3v2SyncedLyrics.Syllable("Abc 2", timeStamp: 1230)])
        }

        do {
            stuff.lyricsValue = TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 1230),
                                                   TagLyrics.Piece("", timeStamp: 4560)])

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 1230),
                                                              TagLyrics.Piece("", timeStamp: 4560)]))

            XCTAssert(stuff.timeStampFormat == ID3v2TimeStampFormat.absoluteMilliseconds)

            XCTAssert(stuff.syllables == [ID3v2SyncedLyrics.Syllable("Abc 1", timeStamp: 1230),
                                          ID3v2SyncedLyrics.Syllable("", timeStamp: 4560)])
        }

        do {
            stuff.lyricsValue = TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 4560),
                                                   TagLyrics.Piece("", timeStamp: 1230)])

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 4560),
                                                              TagLyrics.Piece("", timeStamp: 1230)]))

            XCTAssert(stuff.timeStampFormat == ID3v2TimeStampFormat.absoluteMilliseconds)

            XCTAssert(stuff.syllables == [ID3v2SyncedLyrics.Syllable("Abc 1", timeStamp: 4560),
                                          ID3v2SyncedLyrics.Syllable("", timeStamp: 1230)])
        }

        do {
            stuff.lyricsValue = TagLyrics(pieces: [TagLyrics.Piece("", timeStamp: 1230),
                                                   TagLyrics.Piece("", timeStamp: 4560)])

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("", timeStamp: 1230),
                                                              TagLyrics.Piece("", timeStamp: 4560)]))

            XCTAssert(stuff.timeStampFormat == ID3v2TimeStampFormat.absoluteMilliseconds)

            XCTAssert(stuff.syllables == [ID3v2SyncedLyrics.Syllable("", timeStamp: 1230),
                                          ID3v2SyncedLyrics.Syllable("", timeStamp: 4560)])
        }

        do {
            stuff.lyricsValue = TagLyrics(pieces: [TagLyrics.Piece("", timeStamp: 4560),
                                                   TagLyrics.Piece("", timeStamp: 1230)])

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("", timeStamp: 4560),
                                                              TagLyrics.Piece("", timeStamp: 1230)]))

            XCTAssert(stuff.timeStampFormat == ID3v2TimeStampFormat.absoluteMilliseconds)

            XCTAssert(stuff.syllables == [ID3v2SyncedLyrics.Syllable("", timeStamp: 4560),
                                          ID3v2SyncedLyrics.Syllable("", timeStamp: 1230)])
        }

        do {
            stuff.timeStampFormat = ID3v2TimeStampFormat.absoluteMPEGFrames

            stuff.syllables = []

            XCTAssert(stuff.lyricsValue == TagLyrics())
        }

        do {
            stuff.timeStampFormat = ID3v2TimeStampFormat.absoluteMilliseconds

            stuff.syllables = []

            XCTAssert(stuff.lyricsValue == TagLyrics())
        }

        do {
            stuff.timeStampFormat = ID3v2TimeStampFormat.absoluteMPEGFrames

            stuff.syllables = [ID3v2SyncedLyrics.Syllable("Abc 1", timeStamp: 1230),
                               ID3v2SyncedLyrics.Syllable("Abc 2", timeStamp: 4560)]

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("Abc 1"),
                                                              TagLyrics.Piece("Abc 2")]))
        }

        do {
            stuff.timeStampFormat = ID3v2TimeStampFormat.absoluteMPEGFrames

            stuff.syllables = [ID3v2SyncedLyrics.Syllable("Abc 1", timeStamp: 4560),
                               ID3v2SyncedLyrics.Syllable("Abc 2", timeStamp: 1230)]

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("Abc 1"),
                                                              TagLyrics.Piece("Abc 2")]))
        }

        do {
            stuff.timeStampFormat = ID3v2TimeStampFormat.absoluteMilliseconds

            stuff.syllables = [ID3v2SyncedLyrics.Syllable("Abc 123", timeStamp: 0)]

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("Abc 123")]))
        }

        do {
            stuff.timeStampFormat = ID3v2TimeStampFormat.absoluteMilliseconds

            stuff.syllables = [ID3v2SyncedLyrics.Syllable("Абв 123", timeStamp: 0)]

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("Абв 123")]))
        }

        do {
            stuff.timeStampFormat = ID3v2TimeStampFormat.absoluteMilliseconds

            stuff.syllables = [ID3v2SyncedLyrics.Syllable("Abc 1", timeStamp: 0),
                               ID3v2SyncedLyrics.Syllable("Abc 2", timeStamp: 0)]

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("Abc 1"),
                                                              TagLyrics.Piece("Abc 2")]))
        }

        do {
            stuff.timeStampFormat = ID3v2TimeStampFormat.absoluteMilliseconds

            stuff.syllables = [ID3v2SyncedLyrics.Syllable("Abc 1", timeStamp: 1230),
                               ID3v2SyncedLyrics.Syllable("Abc 2", timeStamp: 4560)]

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 1230),
                                                              TagLyrics.Piece("Abc 2", timeStamp: 4560)]))
        }

        do {
            stuff.timeStampFormat = ID3v2TimeStampFormat.absoluteMilliseconds

            stuff.syllables = [ID3v2SyncedLyrics.Syllable("Abc 1", timeStamp: 0),
                               ID3v2SyncedLyrics.Syllable("Abc 2", timeStamp: 4560)]

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("Abc 1"),
                                                              TagLyrics.Piece("Abc 2", timeStamp: 4560)]))
        }

        do {
            stuff.timeStampFormat = ID3v2TimeStampFormat.absoluteMilliseconds

            stuff.syllables = [ID3v2SyncedLyrics.Syllable("Abc 1", timeStamp: 1230),
                               ID3v2SyncedLyrics.Syllable("Abc 2", timeStamp: 0)]

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 1230),
                                                              TagLyrics.Piece("Abc 2")]))
        }

        do {
            stuff.timeStampFormat = ID3v2TimeStampFormat.absoluteMilliseconds

            stuff.syllables = [ID3v2SyncedLyrics.Syllable("Abc 1", timeStamp: 4560),
                               ID3v2SyncedLyrics.Syllable("Abc 2", timeStamp: 1230)]

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 4560),
                                                              TagLyrics.Piece("Abc 2", timeStamp: 1230)]))
        }

        do {
            stuff.timeStampFormat = ID3v2TimeStampFormat.absoluteMilliseconds

            stuff.syllables = [ID3v2SyncedLyrics.Syllable("", timeStamp: 1230),
                               ID3v2SyncedLyrics.Syllable("Abc 2", timeStamp: 4560)]

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("", timeStamp: 1230),
                                                              TagLyrics.Piece("Abc 2", timeStamp: 4560)]))
        }

        do {
            stuff.timeStampFormat = ID3v2TimeStampFormat.absoluteMilliseconds

            stuff.syllables = [ID3v2SyncedLyrics.Syllable("", timeStamp: 4560),
                               ID3v2SyncedLyrics.Syllable("Abc 2", timeStamp: 1230)]

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("", timeStamp: 4560),
                                                              TagLyrics.Piece("Abc 2", timeStamp: 1230)]))
        }

        do {
            stuff.timeStampFormat = ID3v2TimeStampFormat.absoluteMilliseconds

            stuff.syllables = [ID3v2SyncedLyrics.Syllable("Abc 1", timeStamp: 1230),
                               ID3v2SyncedLyrics.Syllable("", timeStamp: 4560)]

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 1230),
                                                              TagLyrics.Piece("", timeStamp: 4560)]))
        }

        do {
            stuff.timeStampFormat = ID3v2TimeStampFormat.absoluteMilliseconds

            stuff.syllables = [ID3v2SyncedLyrics.Syllable("Abc 1", timeStamp: 4560),
                               ID3v2SyncedLyrics.Syllable("", timeStamp: 1230)]

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 4560),
                                                              TagLyrics.Piece("", timeStamp: 1230)]))
        }

        do {
            stuff.timeStampFormat = ID3v2TimeStampFormat.absoluteMilliseconds

            stuff.syllables = [ID3v2SyncedLyrics.Syllable("", timeStamp: 1230),
                               ID3v2SyncedLyrics.Syllable("", timeStamp: 4560)]

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("", timeStamp: 1230),
                                                              TagLyrics.Piece("", timeStamp: 4560)]))
        }

        do {
            stuff.timeStampFormat = ID3v2TimeStampFormat.absoluteMilliseconds

            stuff.syllables = [ID3v2SyncedLyrics.Syllable("", timeStamp: 4560),
                               ID3v2SyncedLyrics.Syllable("", timeStamp: 1230)]

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("", timeStamp: 4560),
                                                              TagLyrics.Piece("", timeStamp: 1230)]))
        }
    }

    func testUnsyncedLyrics() {
        let stuff = ID3v2UnsyncedLyrics()

        do {
            stuff.lyricsValue = TagLyrics()

            XCTAssert(stuff.lyricsValue == TagLyrics())
            XCTAssert(stuff.content == "")
        }

        do {
            stuff.lyricsValue = TagLyrics(pieces: [TagLyrics.Piece("Abc 123")])

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("Abc 123")]))
            XCTAssert(stuff.content == "Abc 123")
        }

        do {
            stuff.lyricsValue = TagLyrics(pieces: [TagLyrics.Piece("Абв 123")])

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("Абв 123")]))
            XCTAssert(stuff.content == "Абв 123")
        }

        do {
            stuff.lyricsValue = TagLyrics(pieces: [TagLyrics.Piece("Abc 1"),
                                                   TagLyrics.Piece("Abc 2")])

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("Abc 1\nAbc 2")]))
            XCTAssert(stuff.content == "Abc 1\nAbc 2")
        }

        do {
            stuff.lyricsValue = TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 1230),
                                                   TagLyrics.Piece("Abc 2", timeStamp: 4560)])

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("Abc 1\nAbc 2")]))
            XCTAssert(stuff.content == "Abc 1\nAbc 2")
        }

        do {
            stuff.lyricsValue = TagLyrics(pieces: [TagLyrics.Piece("Abc 1"),
                                                   TagLyrics.Piece("Abc 2", timeStamp: 4560)])

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("Abc 1\nAbc 2")]))
            XCTAssert(stuff.content == "Abc 1\nAbc 2")
        }

        do {
            stuff.lyricsValue = TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 1230),
                                                   TagLyrics.Piece("Abc 2")])

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("Abc 1\nAbc 2")]))
            XCTAssert(stuff.content == "Abc 1\nAbc 2")
        }

        do {
            stuff.lyricsValue = TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 4560),
                                                   TagLyrics.Piece("Abc 2", timeStamp: 1230)])

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("Abc 1\nAbc 2")]))
            XCTAssert(stuff.content == "Abc 1\nAbc 2")
        }

        do {
            stuff.lyricsValue = TagLyrics(pieces: [TagLyrics.Piece("", timeStamp: 1230),
                                                   TagLyrics.Piece("Abc 2", timeStamp: 4560)])

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("\nAbc 2")]))
            XCTAssert(stuff.content == "\nAbc 2")
        }

        do {
            stuff.lyricsValue = TagLyrics(pieces: [TagLyrics.Piece("", timeStamp: 4560),
                                                   TagLyrics.Piece("Abc 2", timeStamp: 1230)])

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("\nAbc 2")]))
            XCTAssert(stuff.content == "\nAbc 2")
        }

        do {
            stuff.lyricsValue = TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 1230),
                                                   TagLyrics.Piece("", timeStamp: 4560)])

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("Abc 1\n")]))
            XCTAssert(stuff.content == "Abc 1\n")
        }

        do {
            stuff.lyricsValue = TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 4560),
                                                   TagLyrics.Piece("", timeStamp: 1230)])

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("Abc 1\n")]))
            XCTAssert(stuff.content == "Abc 1\n")
        }

        do {
            stuff.lyricsValue = TagLyrics(pieces: [TagLyrics.Piece("", timeStamp: 4560),
                                                   TagLyrics.Piece("", timeStamp: 1230)])

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("\n")]))
            XCTAssert(stuff.content == "\n")
        }

        do {
            stuff.lyricsValue = TagLyrics(pieces: [TagLyrics.Piece("", timeStamp: 1230),
                                                   TagLyrics.Piece("", timeStamp: 4560)])

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("\n")]))
            XCTAssert(stuff.content == "\n")
        }

        do {
            stuff.content = ""

            XCTAssert(stuff.lyricsValue == TagLyrics())
        }

        do {
            stuff.content = "Abc 123"

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("Abc 123")]))
        }

        do {
            stuff.content = "Абв 123"

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("Абв 123")]))
        }

        do {
            stuff.content = "Abc 1\nAbc 2"

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("Abc 1\nAbc 2")]))
        }

        do {
            stuff.content = "\nAbc 2"

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("\nAbc 2")]))
        }

        do {
            stuff.content = "Abc 1\n"

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("Abc 1\n")]))
        }

        do {
            stuff.content = "\n"

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("\n")]))
        }
    }
}
