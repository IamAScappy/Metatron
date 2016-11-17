//
//  ID3v2SyncedTempoCodesTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 07.09.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class ID3v2SyncedTempoCodesTest: XCTestCase {

    // MARK: Instance Methods

    func testCreateClone() {
        let stuff = ID3v2SyncedTempoCodes()

        stuff.timeStampFormat = ID3v2TimeStampFormat.absoluteMPEGFrames

        stuff.tempos = [ID3v2SyncedTempoCodes.Tempo(123, timeStamp: 12300),
                        ID3v2SyncedTempoCodes.Tempo(1, timeStamp: 45600),
                        ID3v2SyncedTempoCodes.Tempo(456, timeStamp: 78900)]

        let other = ID3v2SyncedTempoCodesFormat.regular.createStuffSubclass(fromOther: stuff)

        XCTAssert(other.timeStampFormat == stuff.timeStampFormat)

        XCTAssert(other.tempos == stuff.tempos)
    }

    func testImposeStuff() {
        let frame = ID3v2Frame(identifier: ID3v2FrameID.sytc)

        let stuff1 = frame.imposeStuff(format: ID3v2SyncedTempoCodesFormat.regular)
        let stuff2 = frame.imposeStuff(format: ID3v2SyncedTempoCodesFormat.regular)

        XCTAssert(frame.stuff is ID3v2SyncedTempoCodes)

        XCTAssert(frame.stuff === stuff1)
        XCTAssert(frame.stuff === stuff2)
    }

    // MARK:

    func testVersion2CaseA() {
        let stuff = ID3v2SyncedTempoCodes()

        stuff.timeStampFormat = ID3v2TimeStampFormat.absoluteMilliseconds

        stuff.tempos = [ID3v2SyncedTempoCodes.Tempo(123, timeStamp: 12300),
                        ID3v2SyncedTempoCodes.Tempo(1, timeStamp: 45600),
                        ID3v2SyncedTempoCodes.Tempo(456, timeStamp: 78900)]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v2) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2SyncedTempoCodes(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)

            XCTAssert(other.tempos == stuff.tempos)
        }

        do {
            let other = ID3v2SyncedTempoCodes(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)

            XCTAssert(other.tempos == stuff.tempos)
        }

        do {
            let other = ID3v2SyncedTempoCodes(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)

            XCTAssert(other.tempos == stuff.tempos)
        }
    }

    func testVersion2CaseB() {
        let stuff = ID3v2SyncedTempoCodes()

        stuff.timeStampFormat = ID3v2TimeStampFormat.absoluteMilliseconds

        stuff.tempos = [ID3v2SyncedTempoCodes.Tempo(0, timeStamp: 654123)]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v2) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2SyncedTempoCodes(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)

            XCTAssert(other.tempos == stuff.tempos)
        }

        do {
            let other = ID3v2SyncedTempoCodes(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)

            XCTAssert(other.tempos == stuff.tempos)
        }

        do {
            let other = ID3v2SyncedTempoCodes(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)

            XCTAssert(other.tempos == stuff.tempos)
        }
    }

    func testVersion2CaseC() {
        let stuff = ID3v2SyncedTempoCodes()

        stuff.timeStampFormat = ID3v2TimeStampFormat.absoluteMPEGFrames

        stuff.tempos = [ID3v2SyncedTempoCodes.Tempo(510, timeStamp: 34),
                        ID3v2SyncedTempoCodes.Tempo(512, timeStamp: 0),
                        ID3v2SyncedTempoCodes.Tempo(255, timeStamp: 12)]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v2) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2SyncedTempoCodes(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)

            XCTAssert(other.tempos == [ID3v2SyncedTempoCodes.Tempo(510, timeStamp: 34),
                                       ID3v2SyncedTempoCodes.Tempo(510, timeStamp: 34),
                                       ID3v2SyncedTempoCodes.Tempo(255, timeStamp: 34)])
        }

        do {
            let other = ID3v2SyncedTempoCodes(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)

            XCTAssert(other.tempos == [ID3v2SyncedTempoCodes.Tempo(510, timeStamp: 34),
                                       ID3v2SyncedTempoCodes.Tempo(510, timeStamp: 34),
                                       ID3v2SyncedTempoCodes.Tempo(255, timeStamp: 34)])
        }

        do {
            let other = ID3v2SyncedTempoCodes(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)

            XCTAssert(other.tempos == [ID3v2SyncedTempoCodes.Tempo(510, timeStamp: 34),
                                       ID3v2SyncedTempoCodes.Tempo(510, timeStamp: 34),
                                       ID3v2SyncedTempoCodes.Tempo(255, timeStamp: 34)])
        }
    }

    func testVersion2CaseD() {
        let stuff = ID3v2SyncedTempoCodes()

        stuff.timeStampFormat = ID3v2TimeStampFormat.absoluteMilliseconds

        stuff.tempos = []

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.toData(version: ID3v2Version.v2) == nil)
    }

    func testVersion2CaseE() {
        let stuff = ID3v2SyncedTempoCodes(fromData: [], version: ID3v2Version.v2)

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.timeStampFormat == ID3v2TimeStampFormat.absoluteMilliseconds)

        XCTAssert(stuff.tempos == [])

        XCTAssert(stuff.toData(version: ID3v2Version.v2) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v3) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v4) == nil)
    }

    // MARK:

    func testVersion3CaseA() {
        let stuff = ID3v2SyncedTempoCodes()

        stuff.timeStampFormat = ID3v2TimeStampFormat.absoluteMilliseconds

        stuff.tempos = [ID3v2SyncedTempoCodes.Tempo(123, timeStamp: 12300),
                        ID3v2SyncedTempoCodes.Tempo(1, timeStamp: 45600),
                        ID3v2SyncedTempoCodes.Tempo(456, timeStamp: 78900)]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2SyncedTempoCodes(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)

            XCTAssert(other.tempos == stuff.tempos)
        }

        do {
            let other = ID3v2SyncedTempoCodes(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)

            XCTAssert(other.tempos == stuff.tempos)
        }

        do {
            let other = ID3v2SyncedTempoCodes(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)

            XCTAssert(other.tempos == stuff.tempos)
        }
    }

    func testVersion3CaseB() {
        let stuff = ID3v2SyncedTempoCodes()

        stuff.timeStampFormat = ID3v2TimeStampFormat.absoluteMilliseconds

        stuff.tempos = [ID3v2SyncedTempoCodes.Tempo(0, timeStamp: 654123)]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2SyncedTempoCodes(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)

            XCTAssert(other.tempos == stuff.tempos)
        }

        do {
            let other = ID3v2SyncedTempoCodes(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)

            XCTAssert(other.tempos == stuff.tempos)
        }

        do {
            let other = ID3v2SyncedTempoCodes(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)

            XCTAssert(other.tempos == stuff.tempos)
        }
    }

    func testVersion3CaseC() {
        let stuff = ID3v2SyncedTempoCodes()

        stuff.timeStampFormat = ID3v2TimeStampFormat.absoluteMPEGFrames

        stuff.tempos = [ID3v2SyncedTempoCodes.Tempo(510, timeStamp: 34),
                        ID3v2SyncedTempoCodes.Tempo(512, timeStamp: 0),
                        ID3v2SyncedTempoCodes.Tempo(255, timeStamp: 12)]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2SyncedTempoCodes(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)

            XCTAssert(other.tempos == [ID3v2SyncedTempoCodes.Tempo(510, timeStamp: 34),
                                       ID3v2SyncedTempoCodes.Tempo(510, timeStamp: 34),
                                       ID3v2SyncedTempoCodes.Tempo(255, timeStamp: 34)])
        }

        do {
            let other = ID3v2SyncedTempoCodes(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)

            XCTAssert(other.tempos == [ID3v2SyncedTempoCodes.Tempo(510, timeStamp: 34),
                                       ID3v2SyncedTempoCodes.Tempo(510, timeStamp: 34),
                                       ID3v2SyncedTempoCodes.Tempo(255, timeStamp: 34)])
        }

        do {
            let other = ID3v2SyncedTempoCodes(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)

            XCTAssert(other.tempos == [ID3v2SyncedTempoCodes.Tempo(510, timeStamp: 34),
                                       ID3v2SyncedTempoCodes.Tempo(510, timeStamp: 34),
                                       ID3v2SyncedTempoCodes.Tempo(255, timeStamp: 34)])
        }
    }

    func testVersion3CaseD() {
        let stuff = ID3v2SyncedTempoCodes()

        stuff.timeStampFormat = ID3v2TimeStampFormat.absoluteMilliseconds

        stuff.tempos = []

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.toData(version: ID3v2Version.v3) == nil)
    }

    func testVersion3CaseE() {
        let stuff = ID3v2SyncedTempoCodes(fromData: [], version: ID3v2Version.v3)

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.timeStampFormat == ID3v2TimeStampFormat.absoluteMilliseconds)

        XCTAssert(stuff.tempos == [])

        XCTAssert(stuff.toData(version: ID3v2Version.v3) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v2) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v4) == nil)
    }

    // MARK:

    func testVersion4CaseA() {
        let stuff = ID3v2SyncedTempoCodes()

        stuff.timeStampFormat = ID3v2TimeStampFormat.absoluteMilliseconds

        stuff.tempos = [ID3v2SyncedTempoCodes.Tempo(123, timeStamp: 12300),
                        ID3v2SyncedTempoCodes.Tempo(1, timeStamp: 45600),
                        ID3v2SyncedTempoCodes.Tempo(456, timeStamp: 78900)]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v4) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2SyncedTempoCodes(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)

            XCTAssert(other.tempos == stuff.tempos)
        }

        do {
            let other = ID3v2SyncedTempoCodes(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)

            XCTAssert(other.tempos == stuff.tempos)
        }

        do {
            let other = ID3v2SyncedTempoCodes(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)

            XCTAssert(other.tempos == stuff.tempos)
        }
    }

    func testVersion4CaseB() {
        let stuff = ID3v2SyncedTempoCodes()

        stuff.timeStampFormat = ID3v2TimeStampFormat.absoluteMilliseconds

        stuff.tempos = [ID3v2SyncedTempoCodes.Tempo(0, timeStamp: 654123)]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v4) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2SyncedTempoCodes(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)

            XCTAssert(other.tempos == stuff.tempos)
        }

        do {
            let other = ID3v2SyncedTempoCodes(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)

            XCTAssert(other.tempos == stuff.tempos)
        }

        do {
            let other = ID3v2SyncedTempoCodes(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)

            XCTAssert(other.tempos == stuff.tempos)
        }
    }

    func testVersion4CaseC() {
        let stuff = ID3v2SyncedTempoCodes()

        stuff.timeStampFormat = ID3v2TimeStampFormat.absoluteMPEGFrames

        stuff.tempos = [ID3v2SyncedTempoCodes.Tempo(510, timeStamp: 34),
                        ID3v2SyncedTempoCodes.Tempo(512, timeStamp: 0),
                        ID3v2SyncedTempoCodes.Tempo(255, timeStamp: 12)]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v4) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2SyncedTempoCodes(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)

            XCTAssert(other.tempos == [ID3v2SyncedTempoCodes.Tempo(510, timeStamp: 34),
                                       ID3v2SyncedTempoCodes.Tempo(510, timeStamp: 34),
                                       ID3v2SyncedTempoCodes.Tempo(255, timeStamp: 34)])
        }

        do {
            let other = ID3v2SyncedTempoCodes(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)

            XCTAssert(other.tempos == [ID3v2SyncedTempoCodes.Tempo(510, timeStamp: 34),
                                       ID3v2SyncedTempoCodes.Tempo(510, timeStamp: 34),
                                       ID3v2SyncedTempoCodes.Tempo(255, timeStamp: 34)])
        }

        do {
            let other = ID3v2SyncedTempoCodes(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.timeStampFormat == stuff.timeStampFormat)

            XCTAssert(other.tempos == [ID3v2SyncedTempoCodes.Tempo(510, timeStamp: 34),
                                       ID3v2SyncedTempoCodes.Tempo(510, timeStamp: 34),
                                       ID3v2SyncedTempoCodes.Tempo(255, timeStamp: 34)])
        }
    }

    func testVersion4CaseD() {
        let stuff = ID3v2SyncedTempoCodes()

        stuff.timeStampFormat = ID3v2TimeStampFormat.absoluteMilliseconds

        stuff.tempos = []

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.toData(version: ID3v2Version.v4) == nil)
    }

    func testVersion4CaseE() {
        let stuff = ID3v2SyncedTempoCodes(fromData: [], version: ID3v2Version.v4)

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.timeStampFormat == ID3v2TimeStampFormat.absoluteMilliseconds)

        XCTAssert(stuff.tempos == [])

        XCTAssert(stuff.toData(version: ID3v2Version.v4) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v2) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v3) == nil)
    }
}
