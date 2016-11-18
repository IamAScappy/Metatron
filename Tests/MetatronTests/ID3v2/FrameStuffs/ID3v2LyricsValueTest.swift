//
//  ID3v2LyricsValueTest.swift
//  Metatron
//
//  Copyright (c) 2016 Almaz Ibragimov
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
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
