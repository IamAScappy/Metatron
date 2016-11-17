//
//  ID3v2AudioEncryptionTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 05.09.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class ID3v2AudioEncryptionTest: XCTestCase {

    // MARK: Instance Methods

    func testCreateClone() {
        let stuff = ID3v2AudioEncryption()

        stuff.ownerIdentifier = "Abc 123"

        stuff.previewStart = 123
        stuff.previewLength = 456

        stuff.encryptionInfo = [0, 1, 2, 3, 0, 4, 5, 6]

        let other = ID3v2AudioEncryptionFormat.regular.createStuffSubclass(fromOther: stuff)

        XCTAssert(other.ownerIdentifier == stuff.ownerIdentifier)

        XCTAssert(other.previewStart == stuff.previewStart)
        XCTAssert(other.previewLength == stuff.previewLength)

        XCTAssert(other.encryptionInfo == stuff.encryptionInfo)
    }

    func testImposeStuff() {
        let frame = ID3v2Frame(identifier: ID3v2FrameID.aenc)

        let stuff1 = frame.imposeStuff(format: ID3v2AudioEncryptionFormat.regular)
        let stuff2 = frame.imposeStuff(format: ID3v2AudioEncryptionFormat.regular)

        XCTAssert(frame.stuff is ID3v2AudioEncryption)

        XCTAssert(frame.stuff === stuff1)
        XCTAssert(frame.stuff === stuff2)
    }

    // MARK:

    func testVersion2CaseA() {
        let stuff = ID3v2AudioEncryption()

        stuff.ownerIdentifier = "Abc 123"

        stuff.previewStart = 123
        stuff.previewLength = 456

        stuff.encryptionInfo = [0, 1, 2, 3, 0, 4, 5, 6]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v2) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2AudioEncryption(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.ownerIdentifier == stuff.ownerIdentifier)

            XCTAssert(other.previewStart == stuff.previewStart)
            XCTAssert(other.previewLength == stuff.previewLength)

            XCTAssert(other.encryptionInfo == stuff.encryptionInfo)
        }

        do {
            let other = ID3v2AudioEncryption(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.ownerIdentifier == stuff.ownerIdentifier)

            XCTAssert(other.previewStart == stuff.previewStart)
            XCTAssert(other.previewLength == stuff.previewLength)

            XCTAssert(other.encryptionInfo == stuff.encryptionInfo)
        }

        do {
            let other = ID3v2AudioEncryption(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.ownerIdentifier == stuff.ownerIdentifier)

            XCTAssert(other.previewStart == stuff.previewStart)
            XCTAssert(other.previewLength == stuff.previewLength)

            XCTAssert(other.encryptionInfo == stuff.encryptionInfo)
        }
    }

    func testVersion2CaseB() {
        let stuff = ID3v2AudioEncryption()

        stuff.ownerIdentifier = "Абв 123"

        stuff.previewStart = 123
        stuff.previewLength = 456

        stuff.encryptionInfo = [0, 1, 2, 3, 0, 4, 5, 6]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v2) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2AudioEncryption(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.ownerIdentifier != stuff.ownerIdentifier)

            XCTAssert(other.previewStart == stuff.previewStart)
            XCTAssert(other.previewLength == stuff.previewLength)

            XCTAssert(other.encryptionInfo == stuff.encryptionInfo)
        }

        do {
            let other = ID3v2AudioEncryption(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.ownerIdentifier != stuff.ownerIdentifier)

            XCTAssert(other.previewStart == stuff.previewStart)
            XCTAssert(other.previewLength == stuff.previewLength)

            XCTAssert(other.encryptionInfo == stuff.encryptionInfo)
        }

        do {
            let other = ID3v2AudioEncryption(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.ownerIdentifier != stuff.ownerIdentifier)

            XCTAssert(other.previewStart == stuff.previewStart)
            XCTAssert(other.previewLength == stuff.previewLength)

            XCTAssert(other.encryptionInfo == stuff.encryptionInfo)
        }
    }

    func testVersion2CaseC() {
        let stuff = ID3v2AudioEncryption()

        stuff.ownerIdentifier = "Abc 123"

        stuff.previewStart = 654
        stuff.previewLength = 321

        stuff.encryptionInfo = []

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v2) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2AudioEncryption(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.ownerIdentifier == stuff.ownerIdentifier)

            XCTAssert(other.previewStart == stuff.previewStart)
            XCTAssert(other.previewLength == stuff.previewLength)

            XCTAssert(other.encryptionInfo == stuff.encryptionInfo)
        }

        do {
            let other = ID3v2AudioEncryption(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.ownerIdentifier == stuff.ownerIdentifier)

            XCTAssert(other.previewStart == stuff.previewStart)
            XCTAssert(other.previewLength == stuff.previewLength)

            XCTAssert(other.encryptionInfo == stuff.encryptionInfo)
        }

        do {
            let other = ID3v2AudioEncryption(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.ownerIdentifier == stuff.ownerIdentifier)

            XCTAssert(other.previewStart == stuff.previewStart)
            XCTAssert(other.previewLength == stuff.previewLength)

            XCTAssert(other.encryptionInfo == stuff.encryptionInfo)
        }
    }

    func testVersion2CaseD() {
        let stuff = ID3v2AudioEncryption()

        stuff.ownerIdentifier = ""

        stuff.previewStart = 123
        stuff.previewLength = 456

        stuff.encryptionInfo = [6, 5, 4, 0, 3, 2, 1, 0]

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.toData(version: ID3v2Version.v2) == nil)
    }

    func testVersion2CaseE() {
        let stuff = ID3v2AudioEncryption(fromData: [], version: ID3v2Version.v2)

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.ownerIdentifier == "")

        XCTAssert(stuff.previewStart == 0)
        XCTAssert(stuff.previewLength == 0)

        XCTAssert(stuff.encryptionInfo == [])

        XCTAssert(stuff.toData(version: ID3v2Version.v2) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v3) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v4) == nil)
    }

    // MARK:

    func testVersion3CaseA() {
        let stuff = ID3v2AudioEncryption()

        stuff.ownerIdentifier = "Abc 123"

        stuff.previewStart = 123
        stuff.previewLength = 456

        stuff.encryptionInfo = [0, 1, 2, 3, 0, 4, 5, 6]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2AudioEncryption(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.ownerIdentifier == stuff.ownerIdentifier)

            XCTAssert(other.previewStart == stuff.previewStart)
            XCTAssert(other.previewLength == stuff.previewLength)

            XCTAssert(other.encryptionInfo == stuff.encryptionInfo)
        }

        do {
            let other = ID3v2AudioEncryption(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.ownerIdentifier == stuff.ownerIdentifier)

            XCTAssert(other.previewStart == stuff.previewStart)
            XCTAssert(other.previewLength == stuff.previewLength)

            XCTAssert(other.encryptionInfo == stuff.encryptionInfo)
        }

        do {
            let other = ID3v2AudioEncryption(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.ownerIdentifier == stuff.ownerIdentifier)

            XCTAssert(other.previewStart == stuff.previewStart)
            XCTAssert(other.previewLength == stuff.previewLength)

            XCTAssert(other.encryptionInfo == stuff.encryptionInfo)
        }
    }

    func testVersion3CaseB() {
        let stuff = ID3v2AudioEncryption()

        stuff.ownerIdentifier = "Абв 123"

        stuff.previewStart = 123
        stuff.previewLength = 456

        stuff.encryptionInfo = [0, 1, 2, 3, 0, 4, 5, 6]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2AudioEncryption(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.ownerIdentifier != stuff.ownerIdentifier)

            XCTAssert(other.previewStart == stuff.previewStart)
            XCTAssert(other.previewLength == stuff.previewLength)

            XCTAssert(other.encryptionInfo == stuff.encryptionInfo)
        }

        do {
            let other = ID3v2AudioEncryption(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.ownerIdentifier != stuff.ownerIdentifier)

            XCTAssert(other.previewStart == stuff.previewStart)
            XCTAssert(other.previewLength == stuff.previewLength)

            XCTAssert(other.encryptionInfo == stuff.encryptionInfo)
        }

        do {
            let other = ID3v2AudioEncryption(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.ownerIdentifier != stuff.ownerIdentifier)

            XCTAssert(other.previewStart == stuff.previewStart)
            XCTAssert(other.previewLength == stuff.previewLength)

            XCTAssert(other.encryptionInfo == stuff.encryptionInfo)
        }
    }

    func testVersion3CaseC() {
        let stuff = ID3v2AudioEncryption()

        stuff.ownerIdentifier = "Abc 123"

        stuff.previewStart = 654
        stuff.previewLength = 321

        stuff.encryptionInfo = []

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2AudioEncryption(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.ownerIdentifier == stuff.ownerIdentifier)

            XCTAssert(other.previewStart == stuff.previewStart)
            XCTAssert(other.previewLength == stuff.previewLength)

            XCTAssert(other.encryptionInfo == stuff.encryptionInfo)
        }

        do {
            let other = ID3v2AudioEncryption(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.ownerIdentifier == stuff.ownerIdentifier)

            XCTAssert(other.previewStart == stuff.previewStart)
            XCTAssert(other.previewLength == stuff.previewLength)

            XCTAssert(other.encryptionInfo == stuff.encryptionInfo)
        }

        do {
            let other = ID3v2AudioEncryption(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.ownerIdentifier == stuff.ownerIdentifier)

            XCTAssert(other.previewStart == stuff.previewStart)
            XCTAssert(other.previewLength == stuff.previewLength)

            XCTAssert(other.encryptionInfo == stuff.encryptionInfo)
        }
    }

    func testVersion3CaseD() {
        let stuff = ID3v2AudioEncryption()

        stuff.ownerIdentifier = ""

        stuff.previewStart = 123
        stuff.previewLength = 456

        stuff.encryptionInfo = [6, 5, 4, 0, 3, 2, 1, 0]

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.toData(version: ID3v2Version.v3) == nil)
    }

    func testVersion3CaseE() {
        let stuff = ID3v2AudioEncryption(fromData: [], version: ID3v2Version.v3)

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.ownerIdentifier == "")

        XCTAssert(stuff.previewStart == 0)
        XCTAssert(stuff.previewLength == 0)

        XCTAssert(stuff.encryptionInfo == [])

        XCTAssert(stuff.toData(version: ID3v2Version.v3) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v2) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v4) == nil)
    }

    // MARK:

    func testVersion4CaseA() {
        let stuff = ID3v2AudioEncryption()

        stuff.ownerIdentifier = "Abc 123"

        stuff.previewStart = 123
        stuff.previewLength = 456

        stuff.encryptionInfo = [0, 1, 2, 3, 0, 4, 5, 6]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v4) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2AudioEncryption(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.ownerIdentifier == stuff.ownerIdentifier)

            XCTAssert(other.previewStart == stuff.previewStart)
            XCTAssert(other.previewLength == stuff.previewLength)

            XCTAssert(other.encryptionInfo == stuff.encryptionInfo)
        }

        do {
            let other = ID3v2AudioEncryption(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.ownerIdentifier == stuff.ownerIdentifier)

            XCTAssert(other.previewStart == stuff.previewStart)
            XCTAssert(other.previewLength == stuff.previewLength)

            XCTAssert(other.encryptionInfo == stuff.encryptionInfo)
        }

        do {
            let other = ID3v2AudioEncryption(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.ownerIdentifier == stuff.ownerIdentifier)

            XCTAssert(other.previewStart == stuff.previewStart)
            XCTAssert(other.previewLength == stuff.previewLength)

            XCTAssert(other.encryptionInfo == stuff.encryptionInfo)
        }
    }

    func testVersion4CaseB() {
        let stuff = ID3v2AudioEncryption()

        stuff.ownerIdentifier = "Абв 123"

        stuff.previewStart = 123
        stuff.previewLength = 456

        stuff.encryptionInfo = [0, 1, 2, 3, 0, 4, 5, 6]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v4) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2AudioEncryption(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.ownerIdentifier != stuff.ownerIdentifier)

            XCTAssert(other.previewStart == stuff.previewStart)
            XCTAssert(other.previewLength == stuff.previewLength)

            XCTAssert(other.encryptionInfo == stuff.encryptionInfo)
        }

        do {
            let other = ID3v2AudioEncryption(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.ownerIdentifier != stuff.ownerIdentifier)

            XCTAssert(other.previewStart == stuff.previewStart)
            XCTAssert(other.previewLength == stuff.previewLength)

            XCTAssert(other.encryptionInfo == stuff.encryptionInfo)
        }

        do {
            let other = ID3v2AudioEncryption(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.ownerIdentifier != stuff.ownerIdentifier)

            XCTAssert(other.previewStart == stuff.previewStart)
            XCTAssert(other.previewLength == stuff.previewLength)

            XCTAssert(other.encryptionInfo == stuff.encryptionInfo)
        }
    }

    func testVersion4CaseС() {
        let stuff = ID3v2AudioEncryption()

        stuff.ownerIdentifier = "Abc 123"

        stuff.previewStart = 654
        stuff.previewLength = 321

        stuff.encryptionInfo = []

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v4) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            let other = ID3v2AudioEncryption(fromData: data, version: ID3v2Version.v4)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.ownerIdentifier == stuff.ownerIdentifier)

            XCTAssert(other.previewStart == stuff.previewStart)
            XCTAssert(other.previewLength == stuff.previewLength)

            XCTAssert(other.encryptionInfo == stuff.encryptionInfo)
        }

        do {
            let other = ID3v2AudioEncryption(fromData: data, version: ID3v2Version.v2)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.ownerIdentifier == stuff.ownerIdentifier)

            XCTAssert(other.previewStart == stuff.previewStart)
            XCTAssert(other.previewLength == stuff.previewLength)

            XCTAssert(other.encryptionInfo == stuff.encryptionInfo)
        }

        do {
            let other = ID3v2AudioEncryption(fromData: data, version: ID3v2Version.v3)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.ownerIdentifier == stuff.ownerIdentifier)

            XCTAssert(other.previewStart == stuff.previewStart)
            XCTAssert(other.previewLength == stuff.previewLength)

            XCTAssert(other.encryptionInfo == stuff.encryptionInfo)
        }
    }

    func testVersion4CaseD() {
        let stuff = ID3v2AudioEncryption()

        stuff.ownerIdentifier = ""

        stuff.previewStart = 123
        stuff.previewLength = 456

        stuff.encryptionInfo = [6, 5, 4, 0, 3, 2, 1, 0]

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.toData(version: ID3v2Version.v4) == nil)
    }

    func testVersion4CaseE() {
        let stuff = ID3v2AudioEncryption(fromData: [], version: ID3v2Version.v4)

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.ownerIdentifier == "")

        XCTAssert(stuff.previewStart == 0)
        XCTAssert(stuff.previewLength == 0)

        XCTAssert(stuff.encryptionInfo == [])

        XCTAssert(stuff.toData(version: ID3v2Version.v4) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v2) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v3) == nil)
    }
}
