//
//  ID3v2SyncedLyricsTest.swift
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

class ID3v2SyncedLyricsTest: XCTestCase {

    // MARK: Instance Methods

    func testCreateClone() {
        let stuff = ID3v2SyncedLyrics()

        stuff.textEncoding = ID3v2TextEncoding.latin1
        stuff.language = ID3v2Language.eng

        stuff.timeStampFormat = ID3v2TimeStampFormat.absoluteMPEGFrames
        stuff.contentType = ID3v2SyncedLyrics.ContentType.transcription

        stuff.description = "Abc 123"

        stuff.syllables = [ID3v2SyncedLyrics.Syllable("Abc 1", timeStamp: 12300),
                           ID3v2SyncedLyrics.Syllable("Abc 2", timeStamp: 45600),
                           ID3v2SyncedLyrics.Syllable("Abc 3", timeStamp: 78900)]

        let other = ID3v2SyncedLyricsFormat.regular.createStuffSubclass(fromOther: stuff)

        XCTAssert(other.textEncoding == stuff.textEncoding)
        XCTAssert(other.language == stuff.language)

        XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
        XCTAssert(other.contentType == stuff.contentType)

        XCTAssert(other.description == stuff.description)

        XCTAssert(other.syllables == stuff.syllables)
    }

    func testImposeStuff() {
        let frame = ID3v2Frame(identifier: ID3v2FrameID.sylt)

        let stuff1 = frame.imposeStuff(format: ID3v2SyncedLyricsFormat.regular)
        let stuff2 = frame.imposeStuff(format: ID3v2SyncedLyricsFormat.regular)

        XCTAssert(frame.stuff is ID3v2SyncedLyrics)

        XCTAssert(frame.stuff === stuff1)
        XCTAssert(frame.stuff === stuff2)
    }

    // MARK:

    func testVersion2CaseA() {
        let stuff = ID3v2SyncedLyrics()

        stuff.textEncoding = ID3v2TextEncoding.latin1
        stuff.language = ID3v2Language.eng

        stuff.timeStampFormat = ID3v2TimeStampFormat.absoluteMilliseconds
        stuff.contentType = ID3v2SyncedLyrics.ContentType.transcription

        stuff.description = "Abc 123"

        stuff.syllables = [ID3v2SyncedLyrics.Syllable("Abc 1", timeStamp: 12300),
                           ID3v2SyncedLyrics.Syllable("Abc 2", timeStamp: 45600),
                           ID3v2SyncedLyrics.Syllable("Abc 3", timeStamp: 78900)]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v2) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2SyncedLyrics(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
            XCTAssert(other.contentType == stuff.contentType)

            XCTAssert(other.description == stuff.description)

            XCTAssert(other.syllables == stuff.syllables)
        }

        do {
            let other = ID3v2SyncedLyrics(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
            XCTAssert(other.contentType == stuff.contentType)

            XCTAssert(other.description == stuff.description)

            XCTAssert(other.syllables == stuff.syllables)
        }

        do {
            let other = ID3v2SyncedLyrics(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
            XCTAssert(other.contentType == stuff.contentType)

            XCTAssert(other.description == stuff.description)

            XCTAssert(other.syllables == stuff.syllables)
        }
    }

    func testVersion2CaseB() {
        let stuff = ID3v2SyncedLyrics()

        stuff.textEncoding = ID3v2TextEncoding.latin1
        stuff.language = ID3v2Language.eng

        stuff.timeStampFormat = ID3v2TimeStampFormat.absoluteMilliseconds
        stuff.contentType = ID3v2SyncedLyrics.ContentType.lyrics

        stuff.description = "Абв 123"

        stuff.syllables = [ID3v2SyncedLyrics.Syllable("Абв 1", timeStamp: 12300),
                           ID3v2SyncedLyrics.Syllable("Абв 2", timeStamp: 45600),
                           ID3v2SyncedLyrics.Syllable("Абв 3", timeStamp: 78900)]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v2) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2SyncedLyrics(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
            XCTAssert(other.contentType == stuff.contentType)

            XCTAssert(other.description != stuff.description)

            guard other.syllables.count == stuff.syllables.count else {
                return XCTFail()
            }

            XCTAssert(other.syllables[0].text != stuff.syllables[0].text)
            XCTAssert(other.syllables[1].text != stuff.syllables[1].text)
            XCTAssert(other.syllables[2].text != stuff.syllables[2].text)

            XCTAssert(other.syllables[0].timeStamp == stuff.syllables[0].timeStamp)
            XCTAssert(other.syllables[1].timeStamp == stuff.syllables[1].timeStamp)
            XCTAssert(other.syllables[2].timeStamp == stuff.syllables[2].timeStamp)
        }

        do {
            let other = ID3v2SyncedLyrics(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
            XCTAssert(other.contentType == stuff.contentType)

            XCTAssert(other.description != stuff.description)

            guard other.syllables.count == stuff.syllables.count else {
                return XCTFail()
            }

            XCTAssert(other.syllables[0].text != stuff.syllables[0].text)
            XCTAssert(other.syllables[1].text != stuff.syllables[1].text)
            XCTAssert(other.syllables[2].text != stuff.syllables[2].text)

            XCTAssert(other.syllables[0].timeStamp == stuff.syllables[0].timeStamp)
            XCTAssert(other.syllables[1].timeStamp == stuff.syllables[1].timeStamp)
            XCTAssert(other.syllables[2].timeStamp == stuff.syllables[2].timeStamp)
        }

        do {
            let other = ID3v2SyncedLyrics(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
            XCTAssert(other.contentType == stuff.contentType)

            XCTAssert(other.description != stuff.description)

            guard other.syllables.count == stuff.syllables.count else {
                return XCTFail()
            }

            XCTAssert(other.syllables[0].text != stuff.syllables[0].text)
            XCTAssert(other.syllables[1].text != stuff.syllables[1].text)
            XCTAssert(other.syllables[2].text != stuff.syllables[2].text)

            XCTAssert(other.syllables[0].timeStamp == stuff.syllables[0].timeStamp)
            XCTAssert(other.syllables[1].timeStamp == stuff.syllables[1].timeStamp)
            XCTAssert(other.syllables[2].timeStamp == stuff.syllables[2].timeStamp)
        }
    }

    func testVersion2CaseC() {
        let stuff = ID3v2SyncedLyrics()

        stuff.textEncoding = ID3v2TextEncoding.utf16LE

        guard let language = ID3v2Language(code: [65, 66, 67]) else {
            return XCTFail()
        }

        stuff.language = language

        stuff.timeStampFormat = ID3v2TimeStampFormat.absoluteMilliseconds
        stuff.contentType = ID3v2SyncedLyrics.ContentType.events

        stuff.description = ""

        stuff.syllables = [ID3v2SyncedLyrics.Syllable("", timeStamp: 12300),
                           ID3v2SyncedLyrics.Syllable("Abc 1", timeStamp: 0),
                           ID3v2SyncedLyrics.Syllable("Abc 2", timeStamp: 45600)]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v2) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2SyncedLyrics(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
            XCTAssert(other.contentType == stuff.contentType)

            XCTAssert(other.description == stuff.description)

            XCTAssert(other.syllables == [ID3v2SyncedLyrics.Syllable("", timeStamp: 12300),
                                          ID3v2SyncedLyrics.Syllable("Abc 1", timeStamp: 12300),
                                          ID3v2SyncedLyrics.Syllable("Abc 2", timeStamp: 45600)])
        }

        do {
            let other = ID3v2SyncedLyrics(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
            XCTAssert(other.contentType == stuff.contentType)

            XCTAssert(other.description == stuff.description)

            XCTAssert(other.syllables == [ID3v2SyncedLyrics.Syllable("", timeStamp: 12300),
                                          ID3v2SyncedLyrics.Syllable("Abc 1", timeStamp: 12300),
                                          ID3v2SyncedLyrics.Syllable("Abc 2", timeStamp: 45600)])
        }

        do {
            let other = ID3v2SyncedLyrics(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
            XCTAssert(other.contentType == stuff.contentType)

            XCTAssert(other.description == stuff.description)

            XCTAssert(other.syllables == [ID3v2SyncedLyrics.Syllable("", timeStamp: 12300),
                                          ID3v2SyncedLyrics.Syllable("Abc 1", timeStamp: 12300),
                                          ID3v2SyncedLyrics.Syllable("Abc 2", timeStamp: 45600)])
        }
    }

    func testVersion2CaseD() {
        let stuff = ID3v2SyncedLyrics()

        stuff.textEncoding = ID3v2TextEncoding.utf16BE
        stuff.language = ID3v2Language.tat

        stuff.timeStampFormat = ID3v2TimeStampFormat.absoluteMPEGFrames
        stuff.contentType = ID3v2SyncedLyrics.ContentType.webpageURLs

        stuff.description = "Abc 123"

        stuff.syllables = [ID3v2SyncedLyrics.Syllable("Abc 1", timeStamp: 34),
                           ID3v2SyncedLyrics.Syllable("Abc 2", timeStamp: 0),
                           ID3v2SyncedLyrics.Syllable("Abc 3", timeStamp: 12)]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v2) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2SyncedLyrics(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
            XCTAssert(other.contentType == stuff.contentType)

            XCTAssert(other.description == stuff.description)

            XCTAssert(other.syllables == [ID3v2SyncedLyrics.Syllable("Abc 1", timeStamp: 34),
                                          ID3v2SyncedLyrics.Syllable("Abc 2", timeStamp: 34),
                                          ID3v2SyncedLyrics.Syllable("Abc 3", timeStamp: 34)])
        }

        do {
            let other = ID3v2SyncedLyrics(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
            XCTAssert(other.contentType == stuff.contentType)

            XCTAssert(other.description == stuff.description)

            XCTAssert(other.syllables == [ID3v2SyncedLyrics.Syllable("Abc 1", timeStamp: 34),
                                          ID3v2SyncedLyrics.Syllable("Abc 2", timeStamp: 34),
                                          ID3v2SyncedLyrics.Syllable("Abc 3", timeStamp: 34)])
        }

        do {
            let other = ID3v2SyncedLyrics(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
            XCTAssert(other.contentType == stuff.contentType)

            XCTAssert(other.description == stuff.description)

            XCTAssert(other.syllables == [ID3v2SyncedLyrics.Syllable("Abc 1", timeStamp: 34),
                                          ID3v2SyncedLyrics.Syllable("Abc 2", timeStamp: 34),
                                          ID3v2SyncedLyrics.Syllable("Abc 3", timeStamp: 34)])
        }
    }

    func testVersion2CaseE() {
        let stuff = ID3v2SyncedLyrics()

        stuff.textEncoding = ID3v2TextEncoding.utf8
        stuff.language = ID3v2Language.rus

        stuff.timeStampFormat = ID3v2TimeStampFormat.absoluteMilliseconds
        stuff.contentType = ID3v2SyncedLyrics.ContentType.other

        stuff.description = "Абв 123"

        stuff.syllables = [ID3v2SyncedLyrics.Syllable("Абв 123", timeStamp: 12345)]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v2) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2SyncedLyrics(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
            XCTAssert(other.contentType == stuff.contentType)

            XCTAssert(other.description == stuff.description)

            XCTAssert(other.syllables == stuff.syllables)
        }

        do {
            let other = ID3v2SyncedLyrics(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
            XCTAssert(other.contentType == stuff.contentType)

            XCTAssert(other.description == stuff.description)

            XCTAssert(other.syllables == stuff.syllables)
        }

        do {
            let other = ID3v2SyncedLyrics(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
            XCTAssert(other.contentType == stuff.contentType)

            XCTAssert(other.description == stuff.description)

            XCTAssert(other.syllables == stuff.syllables)
        }
    }

    func testVersion2CaseF() {
        let stuff = ID3v2SyncedLyrics()

        stuff.textEncoding = ID3v2TextEncoding.utf16
        stuff.language = ID3v2Language.und

        stuff.timeStampFormat = ID3v2TimeStampFormat.absoluteMilliseconds
        stuff.contentType = ID3v2SyncedLyrics.ContentType.other

        stuff.description = ""

        stuff.syllables = [ID3v2SyncedLyrics.Syllable("", timeStamp: 12345)]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v2) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2SyncedLyrics(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
            XCTAssert(other.contentType == stuff.contentType)

            XCTAssert(other.description == stuff.description)

            XCTAssert(other.syllables == stuff.syllables)
        }

        do {
            let other = ID3v2SyncedLyrics(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
            XCTAssert(other.contentType == stuff.contentType)

            XCTAssert(other.description == stuff.description)

            XCTAssert(other.syllables == stuff.syllables)
        }

        do {
            let other = ID3v2SyncedLyrics(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
            XCTAssert(other.contentType == stuff.contentType)

            XCTAssert(other.description == stuff.description)

            XCTAssert(other.syllables == stuff.syllables)
        }
    }

    func testVersion2CaseG() {
        let stuff = ID3v2SyncedLyrics()

        stuff.textEncoding = ID3v2TextEncoding.utf16
        stuff.language = ID3v2Language.und

        stuff.timeStampFormat = ID3v2TimeStampFormat.absoluteMilliseconds
        stuff.contentType = ID3v2SyncedLyrics.ContentType.other

        stuff.description = ""

        stuff.syllables = []

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.toData(version: ID3v2Version.v2) == nil)
    }

    func testVersion2CaseH() {
        let stuff = ID3v2SyncedLyrics(fromData: [], version: ID3v2Version.v2)

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.textEncoding == ID3v2TextEncoding.utf8)
        XCTAssert(stuff.language == ID3v2Language.und)

        XCTAssert(stuff.timeStampFormat == ID3v2TimeStampFormat.absoluteMilliseconds)
        XCTAssert(stuff.contentType == ID3v2SyncedLyrics.ContentType.other)

        XCTAssert(stuff.description == "")

        XCTAssert(stuff.syllables == [])

        XCTAssert(stuff.toData(version: ID3v2Version.v2) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v3) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v4) == nil)
    }

    // MARK:

    func testVersion3CaseA() {
        let stuff = ID3v2SyncedLyrics()

        stuff.textEncoding = ID3v2TextEncoding.latin1
        stuff.language = ID3v2Language.eng

        stuff.timeStampFormat = ID3v2TimeStampFormat.absoluteMilliseconds
        stuff.contentType = ID3v2SyncedLyrics.ContentType.transcription

        stuff.description = "Abc 123"

        stuff.syllables = [ID3v2SyncedLyrics.Syllable("Abc 1", timeStamp: 12300),
                           ID3v2SyncedLyrics.Syllable("Abc 2", timeStamp: 45600),
                           ID3v2SyncedLyrics.Syllable("Abc 3", timeStamp: 78900)]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2SyncedLyrics(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
            XCTAssert(other.contentType == stuff.contentType)

            XCTAssert(other.description == stuff.description)

            XCTAssert(other.syllables == stuff.syllables)
        }

        do {
            let other = ID3v2SyncedLyrics(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
            XCTAssert(other.contentType == stuff.contentType)

            XCTAssert(other.description == stuff.description)

            XCTAssert(other.syllables == stuff.syllables)
        }

        do {
            let other = ID3v2SyncedLyrics(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
            XCTAssert(other.contentType == stuff.contentType)

            XCTAssert(other.description == stuff.description)

            XCTAssert(other.syllables == stuff.syllables)
        }
    }

    func testVersion3CaseB() {
        let stuff = ID3v2SyncedLyrics()

        stuff.textEncoding = ID3v2TextEncoding.latin1
        stuff.language = ID3v2Language.eng

        stuff.timeStampFormat = ID3v2TimeStampFormat.absoluteMilliseconds
        stuff.contentType = ID3v2SyncedLyrics.ContentType.lyrics

        stuff.description = "Абв 123"

        stuff.syllables = [ID3v2SyncedLyrics.Syllable("Абв 1", timeStamp: 12300),
                           ID3v2SyncedLyrics.Syllable("Абв 2", timeStamp: 45600),
                           ID3v2SyncedLyrics.Syllable("Абв 3", timeStamp: 78900)]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2SyncedLyrics(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
            XCTAssert(other.contentType == stuff.contentType)

            XCTAssert(other.description != stuff.description)

            guard other.syllables.count == stuff.syllables.count else {
                return XCTFail()
            }

            XCTAssert(other.syllables[0].text != stuff.syllables[0].text)
            XCTAssert(other.syllables[1].text != stuff.syllables[1].text)
            XCTAssert(other.syllables[2].text != stuff.syllables[2].text)

            XCTAssert(other.syllables[0].timeStamp == stuff.syllables[0].timeStamp)
            XCTAssert(other.syllables[1].timeStamp == stuff.syllables[1].timeStamp)
            XCTAssert(other.syllables[2].timeStamp == stuff.syllables[2].timeStamp)
        }

        do {
            let other = ID3v2SyncedLyrics(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
            XCTAssert(other.contentType == stuff.contentType)

            XCTAssert(other.description != stuff.description)

            guard other.syllables.count == stuff.syllables.count else {
                return XCTFail()
            }

            XCTAssert(other.syllables[0].text != stuff.syllables[0].text)
            XCTAssert(other.syllables[1].text != stuff.syllables[1].text)
            XCTAssert(other.syllables[2].text != stuff.syllables[2].text)

            XCTAssert(other.syllables[0].timeStamp == stuff.syllables[0].timeStamp)
            XCTAssert(other.syllables[1].timeStamp == stuff.syllables[1].timeStamp)
            XCTAssert(other.syllables[2].timeStamp == stuff.syllables[2].timeStamp)
        }

        do {
            let other = ID3v2SyncedLyrics(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
            XCTAssert(other.contentType == stuff.contentType)

            XCTAssert(other.description != stuff.description)

            guard other.syllables.count == stuff.syllables.count else {
                return XCTFail()
            }

            XCTAssert(other.syllables[0].text != stuff.syllables[0].text)
            XCTAssert(other.syllables[1].text != stuff.syllables[1].text)
            XCTAssert(other.syllables[2].text != stuff.syllables[2].text)

            XCTAssert(other.syllables[0].timeStamp == stuff.syllables[0].timeStamp)
            XCTAssert(other.syllables[1].timeStamp == stuff.syllables[1].timeStamp)
            XCTAssert(other.syllables[2].timeStamp == stuff.syllables[2].timeStamp)
        }
    }

    func testVersion3CaseC() {
        let stuff = ID3v2SyncedLyrics()

        stuff.textEncoding = ID3v2TextEncoding.utf16LE

        guard let language = ID3v2Language(code: [65, 66, 67]) else {
            return XCTFail()
        }

        stuff.language = language

        stuff.timeStampFormat = ID3v2TimeStampFormat.absoluteMilliseconds
        stuff.contentType = ID3v2SyncedLyrics.ContentType.events

        stuff.description = ""

        stuff.syllables = [ID3v2SyncedLyrics.Syllable("", timeStamp: 12300),
                           ID3v2SyncedLyrics.Syllable("Abc 1", timeStamp: 0),
                           ID3v2SyncedLyrics.Syllable("Abc 2", timeStamp: 45600)]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2SyncedLyrics(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
            XCTAssert(other.contentType == stuff.contentType)

            XCTAssert(other.description == stuff.description)

            XCTAssert(other.syllables == [ID3v2SyncedLyrics.Syllable("", timeStamp: 12300),
                                          ID3v2SyncedLyrics.Syllable("Abc 1", timeStamp: 12300),
                                          ID3v2SyncedLyrics.Syllable("Abc 2", timeStamp: 45600)])
        }

        do {
            let other = ID3v2SyncedLyrics(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
            XCTAssert(other.contentType == stuff.contentType)

            XCTAssert(other.description == stuff.description)

            XCTAssert(other.syllables == [ID3v2SyncedLyrics.Syllable("", timeStamp: 12300),
                                          ID3v2SyncedLyrics.Syllable("Abc 1", timeStamp: 12300),
                                          ID3v2SyncedLyrics.Syllable("Abc 2", timeStamp: 45600)])
        }

        do {
            let other = ID3v2SyncedLyrics(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
            XCTAssert(other.contentType == stuff.contentType)

            XCTAssert(other.description == stuff.description)

            XCTAssert(other.syllables == [ID3v2SyncedLyrics.Syllable("", timeStamp: 12300),
                                          ID3v2SyncedLyrics.Syllable("Abc 1", timeStamp: 12300),
                                          ID3v2SyncedLyrics.Syllable("Abc 2", timeStamp: 45600)])
        }
    }

    func testVersion3CaseD() {
        let stuff = ID3v2SyncedLyrics()

        stuff.textEncoding = ID3v2TextEncoding.utf16BE
        stuff.language = ID3v2Language.tat

        stuff.timeStampFormat = ID3v2TimeStampFormat.absoluteMPEGFrames
        stuff.contentType = ID3v2SyncedLyrics.ContentType.webpageURLs

        stuff.description = "Abc 123"

        stuff.syllables = [ID3v2SyncedLyrics.Syllable("Abc 1", timeStamp: 34),
                           ID3v2SyncedLyrics.Syllable("Abc 2", timeStamp: 0),
                           ID3v2SyncedLyrics.Syllable("Abc 3", timeStamp: 12)]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2SyncedLyrics(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
            XCTAssert(other.contentType == stuff.contentType)

            XCTAssert(other.description == stuff.description)

            XCTAssert(other.syllables == [ID3v2SyncedLyrics.Syllable("Abc 1", timeStamp: 34),
                                          ID3v2SyncedLyrics.Syllable("Abc 2", timeStamp: 34),
                                          ID3v2SyncedLyrics.Syllable("Abc 3", timeStamp: 34)])
        }

        do {
            let other = ID3v2SyncedLyrics(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
            XCTAssert(other.contentType == stuff.contentType)

            XCTAssert(other.description == stuff.description)

            XCTAssert(other.syllables == [ID3v2SyncedLyrics.Syllable("Abc 1", timeStamp: 34),
                                          ID3v2SyncedLyrics.Syllable("Abc 2", timeStamp: 34),
                                          ID3v2SyncedLyrics.Syllable("Abc 3", timeStamp: 34)])
        }

        do {
            let other = ID3v2SyncedLyrics(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
            XCTAssert(other.contentType == stuff.contentType)

            XCTAssert(other.description == stuff.description)

            XCTAssert(other.syllables == [ID3v2SyncedLyrics.Syllable("Abc 1", timeStamp: 34),
                                          ID3v2SyncedLyrics.Syllable("Abc 2", timeStamp: 34),
                                          ID3v2SyncedLyrics.Syllable("Abc 3", timeStamp: 34)])
        }
    }

    func testVersion3CaseE() {
        let stuff = ID3v2SyncedLyrics()

        stuff.textEncoding = ID3v2TextEncoding.utf8
        stuff.language = ID3v2Language.rus

        stuff.timeStampFormat = ID3v2TimeStampFormat.absoluteMilliseconds
        stuff.contentType = ID3v2SyncedLyrics.ContentType.other

        stuff.description = "Абв 123"

        stuff.syllables = [ID3v2SyncedLyrics.Syllable("Абв 123", timeStamp: 12345)]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2SyncedLyrics(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
            XCTAssert(other.contentType == stuff.contentType)

            XCTAssert(other.description == stuff.description)

            XCTAssert(other.syllables == stuff.syllables)
        }

        do {
            let other = ID3v2SyncedLyrics(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
            XCTAssert(other.contentType == stuff.contentType)

            XCTAssert(other.description == stuff.description)

            XCTAssert(other.syllables == stuff.syllables)
        }

        do {
            let other = ID3v2SyncedLyrics(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
            XCTAssert(other.contentType == stuff.contentType)

            XCTAssert(other.description == stuff.description)

            XCTAssert(other.syllables == stuff.syllables)
        }
    }

    func testVersion3CaseF() {
        let stuff = ID3v2SyncedLyrics()

        stuff.textEncoding = ID3v2TextEncoding.utf16
        stuff.language = ID3v2Language.und

        stuff.timeStampFormat = ID3v2TimeStampFormat.absoluteMilliseconds
        stuff.contentType = ID3v2SyncedLyrics.ContentType.other

        stuff.description = ""

        stuff.syllables = [ID3v2SyncedLyrics.Syllable("", timeStamp: 12345)]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2SyncedLyrics(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
            XCTAssert(other.contentType == stuff.contentType)

            XCTAssert(other.description == stuff.description)

            XCTAssert(other.syllables == stuff.syllables)
        }

        do {
            let other = ID3v2SyncedLyrics(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
            XCTAssert(other.contentType == stuff.contentType)

            XCTAssert(other.description == stuff.description)

            XCTAssert(other.syllables == stuff.syllables)
        }

        do {
            let other = ID3v2SyncedLyrics(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
            XCTAssert(other.contentType == stuff.contentType)

            XCTAssert(other.description == stuff.description)

            XCTAssert(other.syllables == stuff.syllables)
        }
    }

    func testVersion3CaseG() {
        let stuff = ID3v2SyncedLyrics()

        stuff.textEncoding = ID3v2TextEncoding.utf16
        stuff.language = ID3v2Language.und

        stuff.timeStampFormat = ID3v2TimeStampFormat.absoluteMilliseconds
        stuff.contentType = ID3v2SyncedLyrics.ContentType.other

        stuff.description = ""

        stuff.syllables = []

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.toData(version: ID3v2Version.v3) == nil)
    }

    func testVersion3CaseH() {
        let stuff = ID3v2SyncedLyrics(fromData: [], version: ID3v2Version.v3)

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.textEncoding == ID3v2TextEncoding.utf8)
        XCTAssert(stuff.language == ID3v2Language.und)

        XCTAssert(stuff.timeStampFormat == ID3v2TimeStampFormat.absoluteMilliseconds)
        XCTAssert(stuff.contentType == ID3v2SyncedLyrics.ContentType.other)

        XCTAssert(stuff.description == "")

        XCTAssert(stuff.syllables == [])

        XCTAssert(stuff.toData(version: ID3v2Version.v3) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v2) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v4) == nil)
    }

    // MARK:

    func testVersion4CaseA() {
        let stuff = ID3v2SyncedLyrics()

        stuff.textEncoding = ID3v2TextEncoding.latin1
        stuff.language = ID3v2Language.eng

        stuff.timeStampFormat = ID3v2TimeStampFormat.absoluteMilliseconds
        stuff.contentType = ID3v2SyncedLyrics.ContentType.transcription

        stuff.description = "Abc 123"

        stuff.syllables = [ID3v2SyncedLyrics.Syllable("Abc 1", timeStamp: 12300),
                           ID3v2SyncedLyrics.Syllable("Abc 2", timeStamp: 45600),
                           ID3v2SyncedLyrics.Syllable("Abc 3", timeStamp: 78900)]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v4) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2SyncedLyrics(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
            XCTAssert(other.contentType == stuff.contentType)

            XCTAssert(other.description == stuff.description)

            XCTAssert(other.syllables == stuff.syllables)
        }

        do {
            let other = ID3v2SyncedLyrics(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
            XCTAssert(other.contentType == stuff.contentType)

            XCTAssert(other.description == stuff.description)

            XCTAssert(other.syllables == stuff.syllables)
        }

        do {
            let other = ID3v2SyncedLyrics(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
            XCTAssert(other.contentType == stuff.contentType)

            XCTAssert(other.description == stuff.description)

            XCTAssert(other.syllables == stuff.syllables)
        }
    }

    func testVersion4CaseB() {
        let stuff = ID3v2SyncedLyrics()

        stuff.textEncoding = ID3v2TextEncoding.latin1
        stuff.language = ID3v2Language.eng

        stuff.timeStampFormat = ID3v2TimeStampFormat.absoluteMilliseconds
        stuff.contentType = ID3v2SyncedLyrics.ContentType.lyrics

        stuff.description = "Абв 123"

        stuff.syllables = [ID3v2SyncedLyrics.Syllable("Абв 1", timeStamp: 12300),
                           ID3v2SyncedLyrics.Syllable("Абв 2", timeStamp: 45600),
                           ID3v2SyncedLyrics.Syllable("Абв 3", timeStamp: 78900)]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v4) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2SyncedLyrics(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
            XCTAssert(other.contentType == stuff.contentType)

            XCTAssert(other.description != stuff.description)

            guard other.syllables.count == stuff.syllables.count else {
                return XCTFail()
            }

            XCTAssert(other.syllables[0].text != stuff.syllables[0].text)
            XCTAssert(other.syllables[1].text != stuff.syllables[1].text)
            XCTAssert(other.syllables[2].text != stuff.syllables[2].text)

            XCTAssert(other.syllables[0].timeStamp == stuff.syllables[0].timeStamp)
            XCTAssert(other.syllables[1].timeStamp == stuff.syllables[1].timeStamp)
            XCTAssert(other.syllables[2].timeStamp == stuff.syllables[2].timeStamp)
        }

        do {
            let other = ID3v2SyncedLyrics(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
            XCTAssert(other.contentType == stuff.contentType)

            XCTAssert(other.description != stuff.description)

            guard other.syllables.count == stuff.syllables.count else {
                return XCTFail()
            }

            XCTAssert(other.syllables[0].text != stuff.syllables[0].text)
            XCTAssert(other.syllables[1].text != stuff.syllables[1].text)
            XCTAssert(other.syllables[2].text != stuff.syllables[2].text)

            XCTAssert(other.syllables[0].timeStamp == stuff.syllables[0].timeStamp)
            XCTAssert(other.syllables[1].timeStamp == stuff.syllables[1].timeStamp)
            XCTAssert(other.syllables[2].timeStamp == stuff.syllables[2].timeStamp)
        }

        do {
            let other = ID3v2SyncedLyrics(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
            XCTAssert(other.contentType == stuff.contentType)

            XCTAssert(other.description != stuff.description)

            guard other.syllables.count == stuff.syllables.count else {
                return XCTFail()
            }

            XCTAssert(other.syllables[0].text != stuff.syllables[0].text)
            XCTAssert(other.syllables[1].text != stuff.syllables[1].text)
            XCTAssert(other.syllables[2].text != stuff.syllables[2].text)

            XCTAssert(other.syllables[0].timeStamp == stuff.syllables[0].timeStamp)
            XCTAssert(other.syllables[1].timeStamp == stuff.syllables[1].timeStamp)
            XCTAssert(other.syllables[2].timeStamp == stuff.syllables[2].timeStamp)
        }
    }

    func testVersion4CaseC() {
        let stuff = ID3v2SyncedLyrics()

        stuff.textEncoding = ID3v2TextEncoding.utf16LE

        guard let language = ID3v2Language(code: [65, 66, 67]) else {
            return XCTFail()
        }

        stuff.language = language

        stuff.timeStampFormat = ID3v2TimeStampFormat.absoluteMilliseconds
        stuff.contentType = ID3v2SyncedLyrics.ContentType.events

        stuff.description = ""

        stuff.syllables = [ID3v2SyncedLyrics.Syllable("", timeStamp: 12300),
                           ID3v2SyncedLyrics.Syllable("Abc 1", timeStamp: 0),
                           ID3v2SyncedLyrics.Syllable("Abc 2", timeStamp: 45600)]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v4) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2SyncedLyrics(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
            XCTAssert(other.contentType == stuff.contentType)

            XCTAssert(other.description == stuff.description)

            XCTAssert(other.syllables == [ID3v2SyncedLyrics.Syllable("", timeStamp: 12300),
                                          ID3v2SyncedLyrics.Syllable("Abc 1", timeStamp: 12300),
                                          ID3v2SyncedLyrics.Syllable("Abc 2", timeStamp: 45600)])
        }

        do {
            let other = ID3v2SyncedLyrics(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
            XCTAssert(other.contentType == stuff.contentType)

            XCTAssert(other.description == stuff.description)

            XCTAssert(other.syllables == [ID3v2SyncedLyrics.Syllable("", timeStamp: 12300),
                                          ID3v2SyncedLyrics.Syllable("Abc 1", timeStamp: 12300),
                                          ID3v2SyncedLyrics.Syllable("Abc 2", timeStamp: 45600)])
        }

        do {
            let other = ID3v2SyncedLyrics(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
            XCTAssert(other.contentType == stuff.contentType)

            XCTAssert(other.description == stuff.description)

            XCTAssert(other.syllables == [ID3v2SyncedLyrics.Syllable("", timeStamp: 12300),
                                          ID3v2SyncedLyrics.Syllable("Abc 1", timeStamp: 12300),
                                          ID3v2SyncedLyrics.Syllable("Abc 2", timeStamp: 45600)])
        }
    }

    func testVersion4CaseD() {
        let stuff = ID3v2SyncedLyrics()

        stuff.textEncoding = ID3v2TextEncoding.utf16BE
        stuff.language = ID3v2Language.tat

        stuff.timeStampFormat = ID3v2TimeStampFormat.absoluteMPEGFrames
        stuff.contentType = ID3v2SyncedLyrics.ContentType.webpageURLs

        stuff.description = "Abc 123"

        stuff.syllables = [ID3v2SyncedLyrics.Syllable("Abc 1", timeStamp: 34),
                           ID3v2SyncedLyrics.Syllable("Abc 2", timeStamp: 0),
                           ID3v2SyncedLyrics.Syllable("Abc 3", timeStamp: 12)]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v4) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2SyncedLyrics(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
            XCTAssert(other.contentType == stuff.contentType)

            XCTAssert(other.description == stuff.description)

            XCTAssert(other.syllables == [ID3v2SyncedLyrics.Syllable("Abc 1", timeStamp: 34),
                                          ID3v2SyncedLyrics.Syllable("Abc 2", timeStamp: 34),
                                          ID3v2SyncedLyrics.Syllable("Abc 3", timeStamp: 34)])
        }

        do {
            let other = ID3v2SyncedLyrics(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
            XCTAssert(other.contentType == stuff.contentType)

            XCTAssert(other.description == stuff.description)

            XCTAssert(other.syllables == [ID3v2SyncedLyrics.Syllable("Abc 1", timeStamp: 34),
                                          ID3v2SyncedLyrics.Syllable("Abc 2", timeStamp: 34),
                                          ID3v2SyncedLyrics.Syllable("Abc 3", timeStamp: 34)])
        }

        do {
            let other = ID3v2SyncedLyrics(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
            XCTAssert(other.contentType == stuff.contentType)

            XCTAssert(other.description == stuff.description)

            XCTAssert(other.syllables == [ID3v2SyncedLyrics.Syllable("Abc 1", timeStamp: 34),
                                          ID3v2SyncedLyrics.Syllable("Abc 2", timeStamp: 34),
                                          ID3v2SyncedLyrics.Syllable("Abc 3", timeStamp: 34)])
        }
    }

    func testVersion4CaseE() {
        let stuff = ID3v2SyncedLyrics()

        stuff.textEncoding = ID3v2TextEncoding.utf8
        stuff.language = ID3v2Language.rus

        stuff.timeStampFormat = ID3v2TimeStampFormat.absoluteMilliseconds
        stuff.contentType = ID3v2SyncedLyrics.ContentType.other

        stuff.description = "Абв 123"

        stuff.syllables = [ID3v2SyncedLyrics.Syllable("Абв 123", timeStamp: 12345)]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v4) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2SyncedLyrics(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
            XCTAssert(other.contentType == stuff.contentType)

            XCTAssert(other.description == stuff.description)

            XCTAssert(other.syllables == stuff.syllables)
        }

        do {
            let other = ID3v2SyncedLyrics(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
            XCTAssert(other.contentType == stuff.contentType)

            XCTAssert(other.description == stuff.description)

            XCTAssert(other.syllables == stuff.syllables)
        }

        do {
            let other = ID3v2SyncedLyrics(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
            XCTAssert(other.contentType == stuff.contentType)

            XCTAssert(other.description == stuff.description)

            XCTAssert(other.syllables == stuff.syllables)
        }
    }

    func testVersion4CaseF() {
        let stuff = ID3v2SyncedLyrics()

        stuff.textEncoding = ID3v2TextEncoding.utf16
        stuff.language = ID3v2Language.und

        stuff.timeStampFormat = ID3v2TimeStampFormat.absoluteMilliseconds
        stuff.contentType = ID3v2SyncedLyrics.ContentType.other

        stuff.description = ""

        stuff.syllables = [ID3v2SyncedLyrics.Syllable("", timeStamp: 12345)]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v4) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2SyncedLyrics(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
            XCTAssert(other.contentType == stuff.contentType)

            XCTAssert(other.description == stuff.description)

            XCTAssert(other.syllables == stuff.syllables)
        }

        do {
            let other = ID3v2SyncedLyrics(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
            XCTAssert(other.contentType == stuff.contentType)

            XCTAssert(other.description == stuff.description)

            XCTAssert(other.syllables == stuff.syllables)
        }

        do {
            let other = ID3v2SyncedLyrics(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.textEncoding == stuff.textEncoding)
            XCTAssert(other.language == stuff.language)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)
            XCTAssert(other.contentType == stuff.contentType)

            XCTAssert(other.description == stuff.description)

            XCTAssert(other.syllables == stuff.syllables)
        }
    }

    func testVersion4CaseG() {
        let stuff = ID3v2SyncedLyrics()

        stuff.textEncoding = ID3v2TextEncoding.utf16
        stuff.language = ID3v2Language.und

        stuff.timeStampFormat = ID3v2TimeStampFormat.absoluteMilliseconds
        stuff.contentType = ID3v2SyncedLyrics.ContentType.other

        stuff.description = ""

        stuff.syllables = []

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.toData(version: ID3v2Version.v4) == nil)
    }

    func testVersion4CaseH() {
        let stuff = ID3v2SyncedLyrics(fromData: [], version: ID3v2Version.v4)

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.textEncoding == ID3v2TextEncoding.utf8)
        XCTAssert(stuff.language == ID3v2Language.und)

        XCTAssert(stuff.timeStampFormat == ID3v2TimeStampFormat.absoluteMilliseconds)
        XCTAssert(stuff.contentType == ID3v2SyncedLyrics.ContentType.other)

        XCTAssert(stuff.description == "")

        XCTAssert(stuff.syllables == [])

        XCTAssert(stuff.toData(version: ID3v2Version.v4) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v2) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v3) == nil)
    }
}
