//
//  Lyrics3IndicationsTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 24.10.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class Lyrics3IndicationsTest: XCTestCase {

    // MARK: Instance Methods

    func testCreateClone() {
        let stuff = Lyrics3Indications()

        stuff.lyricsFieldPresent = true
        stuff.lyricsSynchronized = true

        stuff.randomSelectable = true

        let other = Lyrics3IndicationsFormat.regular.createStuffSubclass(fromOther: stuff)

        XCTAssert(other.lyricsFieldPresent == stuff.lyricsFieldPresent)
        XCTAssert(other.lyricsSynchronized == stuff.lyricsSynchronized)

        XCTAssert(other.randomSelectable == stuff.randomSelectable)
    }

    func testImposeStuff() {
        let field = Lyrics3Field(identifier: Lyrics3FieldID.ind)

        let stuff1 = field.imposeStuff(format: Lyrics3IndicationsFormat.regular)
        let stuff2 = field.imposeStuff(format: Lyrics3IndicationsFormat.regular)

        XCTAssert(field.stuff is Lyrics3Indications)

        XCTAssert(field.stuff === stuff1)
        XCTAssert(field.stuff === stuff2)
    }

    // MARK:

    func testCaseA() {
        let stuff = Lyrics3Indications()

        stuff.lyricsFieldPresent = true
        stuff.lyricsSynchronized = true

        stuff.randomSelectable = true

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        let other = Lyrics3Indications(fromData: data)

        XCTAssert(!stuff.isEmpty)

        XCTAssert(other.lyricsFieldPresent == stuff.lyricsFieldPresent)
        XCTAssert(other.lyricsSynchronized == stuff.lyricsSynchronized)

        XCTAssert(other.randomSelectable == stuff.randomSelectable)
    }

    func testCaseB() {
        let stuff = Lyrics3Indications()

        stuff.lyricsFieldPresent = false
        stuff.lyricsSynchronized = true

        stuff.randomSelectable = false

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        let other = Lyrics3Indications(fromData: data)

        XCTAssert(!stuff.isEmpty)

        XCTAssert(other.lyricsFieldPresent == stuff.lyricsFieldPresent)
        XCTAssert(other.lyricsSynchronized == stuff.lyricsSynchronized)

        XCTAssert(other.randomSelectable == stuff.randomSelectable)
    }

    func testCaseC() {
        let stuff = Lyrics3Indications()

        stuff.lyricsFieldPresent = true
        stuff.lyricsSynchronized = false

        stuff.randomSelectable = false

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        let other = Lyrics3Indications(fromData: data)

        XCTAssert(!stuff.isEmpty)

        XCTAssert(other.lyricsFieldPresent == stuff.lyricsFieldPresent)
        XCTAssert(other.lyricsSynchronized == stuff.lyricsSynchronized)

        XCTAssert(other.randomSelectable == stuff.randomSelectable)
    }

    func testCaseD() {
        let stuff = Lyrics3Indications()

        stuff.lyricsFieldPresent = false
        stuff.lyricsSynchronized = false

        stuff.randomSelectable = false

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        let other = Lyrics3Indications(fromData: data)

        XCTAssert(!stuff.isEmpty)

        XCTAssert(other.lyricsFieldPresent == stuff.lyricsFieldPresent)
        XCTAssert(other.lyricsSynchronized == stuff.lyricsSynchronized)

        XCTAssert(other.randomSelectable == stuff.randomSelectable)
    }
}
