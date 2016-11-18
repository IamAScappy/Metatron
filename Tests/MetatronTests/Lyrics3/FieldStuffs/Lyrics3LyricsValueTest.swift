//
//  Lyrics3LyricsValueTest.swift
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

class Lyrics3LyricsValueTest: XCTestCase {

    // MARK: Instance Methods

    func test() {
    	let stuff = Lyrics3TextInformation()

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

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("Abc 1"),
                                                              TagLyrics.Piece("Abc 2")]))

            XCTAssert(stuff.content == "[00:00]Abc 1\n[00:00]Abc 2\n")
        }

        do {
            stuff.lyricsValue = TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 123456),
                                                   TagLyrics.Piece("Abc 2", timeStamp: 654321)])

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 123000),
                                                              TagLyrics.Piece("Abc 2", timeStamp: 654000)]))

            XCTAssert(stuff.content == "[02:03]Abc 1\n[10:54]Abc 2\n")
        }

        do {
            stuff.lyricsValue = TagLyrics(pieces: [TagLyrics.Piece("Abc 1"),
                                                   TagLyrics.Piece("Abc 2", timeStamp: 654321)])

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("Abc 1"),
                                                              TagLyrics.Piece("Abc 2", timeStamp: 654000)]))

            XCTAssert(stuff.content == "[00:00]Abc 1\n[10:54]Abc 2\n")
        }

        do {
            stuff.lyricsValue = TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 123456),
                                                   TagLyrics.Piece("Abc 2")])

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 123000),
                                                              TagLyrics.Piece("Abc 2")]))

            XCTAssert(stuff.content == "[02:03]Abc 1\n[00:00]Abc 2\n")
        }

        do {
            stuff.lyricsValue = TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 654321),
                                                   TagLyrics.Piece("Abc 2", timeStamp: 123456)])

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 654000),
                                                              TagLyrics.Piece("Abc 2", timeStamp: 123000)]))

            XCTAssert(stuff.content == "[10:54]Abc 1\n[02:03]Abc 2\n")
        }

        do {
            stuff.lyricsValue = TagLyrics(pieces: [TagLyrics.Piece("", timeStamp: 123456),
                                                   TagLyrics.Piece("Abc 2", timeStamp: 654321)])

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("", timeStamp: 123000),
                                                              TagLyrics.Piece("Abc 2", timeStamp: 654000)]))

            XCTAssert(stuff.content == "[02:03]\n[10:54]Abc 2\n")
        }

        do {
            stuff.lyricsValue = TagLyrics(pieces: [TagLyrics.Piece("", timeStamp: 654321),
                                                   TagLyrics.Piece("Abc 2", timeStamp: 123456)])

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("", timeStamp: 654000),
                                                              TagLyrics.Piece("Abc 2", timeStamp: 123000)]))

            XCTAssert(stuff.content == "[10:54]\n[02:03]Abc 2\n")
        }

        do {
            stuff.lyricsValue = TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 123456),
                                                   TagLyrics.Piece("", timeStamp: 654321)])

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 123000),
                                                              TagLyrics.Piece("", timeStamp: 654000)]))

            XCTAssert(stuff.content == "[02:03]Abc 1\n[10:54]\n")
        }

        do {
            stuff.lyricsValue = TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 654321),
                                                   TagLyrics.Piece("", timeStamp: 123456)])

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 654000),
                                                              TagLyrics.Piece("", timeStamp: 123000)]))

            XCTAssert(stuff.content == "[10:54]Abc 1\n[02:03]\n")
        }

        do {
            stuff.lyricsValue = TagLyrics(pieces: [TagLyrics.Piece("", timeStamp: 123456),
                                                   TagLyrics.Piece("", timeStamp: 654321)])

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("", timeStamp: 123000),
                                                              TagLyrics.Piece("", timeStamp: 654000)]))

            XCTAssert(stuff.content == "[02:03]\n[10:54]\n")
        }

        do {
            stuff.lyricsValue = TagLyrics(pieces: [TagLyrics.Piece("", timeStamp: 654321),
                                                   TagLyrics.Piece("", timeStamp: 123456)])

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("", timeStamp: 654000),
                                                              TagLyrics.Piece("", timeStamp: 123000)]))

            XCTAssert(stuff.content == "[10:54]\n[02:03]\n")
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
        	stuff.content = "[12:34] Abc 1[56:78] Abc 2"

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 754000),
                                                              TagLyrics.Piece("Abc 2", timeStamp: 3438000)]))
        }

        do {
        	stuff.content = "[12:34]Abc 1\n[56:78]Abc 2\n"

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 754000),
                                                              TagLyrics.Piece("Abc 2", timeStamp: 3438000)]))
        }

        do {
            stuff.content = "[56:78]Abc 1\n[12:34]Abc 2\n"

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 3438000),
                                                              TagLyrics.Piece("Abc 2", timeStamp: 754000)]))
        }

        do {
        	stuff.content = "[12:34][56:78]Abc 2\n"

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("", timeStamp: 754000),
                                                              TagLyrics.Piece("Abc 2", timeStamp: 3438000)]))
        }

        do {
        	stuff.content = "[12:34]Abc 1\n[56:78]"

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("Abc 1", timeStamp: 754000),
                                                              TagLyrics.Piece("", timeStamp: 3438000)]))
        }

        do {
        	stuff.content = "[12:34][56:78]"

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("", timeStamp: 754000),
                                                              TagLyrics.Piece("", timeStamp: 3438000)]))
        }

        do {
        	stuff.content = "[]Abc 1\n[56:78]Abc 2\n"

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("[]Abc 1"),
                                                              TagLyrics.Piece("Abc 2", timeStamp: 3438000)]))
        }

        do {
        	stuff.content = "[12:34]Abc 1\n[]Abc 2\n"

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("Abc 1\n[]Abc 2", timeStamp: 754000)]))
        }

        do {
        	stuff.content = "[]Abc 1\n[]Abc 2\n"

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("[]Abc 1\n[]Abc 2")]))
        }

        do {
        	stuff.content = "[][]Abc 2\n"

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("[][]Abc 2")]))
        }

        do {
        	stuff.content = "[]Abc 1\n[]"

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("[]Abc 1\n[]")]))
        }

        do {
        	stuff.content = "[][]"

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("[][]")]))
        }

        do {
        	stuff.content = "[[12:34]]Abc 1\n[56:78]Abc 2\n"

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("["),
                                                              TagLyrics.Piece("]Abc 1", timeStamp: 754000),
                                                              TagLyrics.Piece("Abc 2", timeStamp: 3438000)]))
        }

        do {
        	stuff.content = "[12:34]Abc 1\n[[56:78]]Abc 2\n"

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("Abc 1\n[", timeStamp: 754000),
                                                              TagLyrics.Piece("]Abc 2", timeStamp: 3438000)]))
        }

        do {
        	stuff.content = "[[12:34]]Abc 1\n[[56:78]]Abc 2\n"

            XCTAssert(stuff.lyricsValue == TagLyrics(pieces: [TagLyrics.Piece("["),
                                                              TagLyrics.Piece("]Abc 1\n[", timeStamp: 754000),
                                                              TagLyrics.Piece("]Abc 2", timeStamp: 3438000)]))
        }
    }
}
