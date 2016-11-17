//
//  ID3v2FrameTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 30.08.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class ID3v2FrameTest: XCTestCase {

    // MARK: Instance Properties

    func testStuff() {
        let frame = ID3v2Frame(identifier: ID3v2FrameID.tit1)

        let stuff1 = frame.stuff(format: ID3v2UnknownValueFormat.regular)
        let stuff2 = frame.stuff(format: ID3v2UnknownValueFormat.regular)

        XCTAssert(frame.stuff !== stuff1)
        XCTAssert(frame.stuff !== stuff2)

        XCTAssert(stuff1 !== stuff2)
    }

    func testImposeStuff() {
        let frame = ID3v2Frame(identifier: ID3v2FrameID.tit1)

        let stuff1 = frame.imposeStuff(format: ID3v2UnknownValueFormat.regular)
        let stuff2 = frame.imposeStuff(format: ID3v2UnknownValueFormat.regular)

        XCTAssert(frame.stuff === stuff1)
        XCTAssert(frame.stuff === stuff2)

        XCTAssert(stuff1 === stuff2)
    }

    func testRevokeStuff() {
        let frame = ID3v2Frame(identifier: ID3v2FrameID.tit2)

        frame.tagAlterPreservation = true
        frame.fileAlterPreservation = true

        frame.readOnly = true

        frame.unsynchronisation = true
        frame.dataLengthIndicator = true

        frame.compression = 6

        frame.group = 128

        let stuff = frame.imposeStuff(format: ID3v2UnknownValueFormat.regular)

        for _ in 0..<123 {
            stuff.content.append(UInt8(arc4random_uniform(256)))
        }

        XCTAssert(!frame.isEmpty)

        XCTAssert(frame.revokeStuff() === stuff)
        XCTAssert(frame.revokeStuff() == nil)

        XCTAssert(frame.isEmpty)

        XCTAssert(frame.tagAlterPreservation == true)
        XCTAssert(frame.fileAlterPreservation == true)

        XCTAssert(frame.readOnly == true)

        XCTAssert(frame.unsynchronisation == true)
        XCTAssert(frame.dataLengthIndicator == true)

        XCTAssert(frame.compression == 6)

        XCTAssert(frame.encryption == nil)
        XCTAssert(frame.group == 128)

        XCTAssert(frame.stuff !== stuff)

        let otherStuff = frame.imposeStuff(format: ID3v2UnknownValueFormat.regular)

        XCTAssert(otherStuff.content.isEmpty)
    }

    func testReset() {
        let frame = ID3v2Frame(identifier: ID3v2FrameID.tit3)

        frame.tagAlterPreservation = true
        frame.fileAlterPreservation = true

        frame.readOnly = true

        frame.unsynchronisation = true
        frame.dataLengthIndicator = true

        frame.compression = 6

        frame.group = 128

        let stuff = frame.imposeStuff(format: ID3v2UnknownValueFormat.regular)

        for _ in 0..<123 {
            stuff.content.append(UInt8(arc4random_uniform(256)))
        }

        XCTAssert(!frame.isEmpty)

        frame.reset()

        XCTAssert(frame.isEmpty)

        XCTAssert(frame.tagAlterPreservation == false)
        XCTAssert(frame.fileAlterPreservation == false)

        XCTAssert(frame.readOnly == false)

        XCTAssert(frame.unsynchronisation == false)
        XCTAssert(frame.dataLengthIndicator == false)

        XCTAssert(frame.compression == 0)

        XCTAssert(frame.encryption == nil)
        XCTAssert(frame.group == nil)

        XCTAssert(frame.stuff !== stuff)

        let otherStuff = frame.imposeStuff(format: ID3v2UnknownValueFormat.regular)

        XCTAssert(otherStuff.content.isEmpty)
    }

    // MARK:

    func testVersion2CaseA() {
        let frame = ID3v2Frame(identifier: ID3v2FrameID.tmed)

        frame.tagAlterPreservation = true
        frame.fileAlterPreservation = true

        frame.readOnly = true

        frame.unsynchronisation = true
        frame.dataLengthIndicator = true

        frame.compression = 6

        frame.group = 128

        XCTAssert(frame.isEmpty)

        XCTAssert(frame.toData(version: ID3v2Version.v2) == nil)

        let stuff = frame.imposeStuff(format: ID3v2UnknownValueFormat.regular)

        for _ in 0..<123 {
            stuff.content.append(UInt8(arc4random_uniform(256)))
        }

        XCTAssert(!frame.isEmpty)

        guard let data = frame.toData(version: ID3v2Version.v2) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            var offset = 0

            guard let other = ID3v2Frame(fromBodyData: data, offset: &offset, version: ID3v2Version.v2) else {
                return XCTFail()
            }

            XCTAssert(offset == data.count)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.identifier == frame.identifier)

            XCTAssert(other.tagAlterPreservation == false)
            XCTAssert(other.fileAlterPreservation == false)

            XCTAssert(other.readOnly == false)

            XCTAssert(other.unsynchronisation == false)
            XCTAssert(other.dataLengthIndicator == false)

            XCTAssert(other.compression == 0)

            XCTAssert(other.encryption == nil)
            XCTAssert(other.group == nil)

            let otherStuff = other.imposeStuff(format: ID3v2UnknownValueFormat.regular)

            XCTAssert(otherStuff.content == stuff.content)
        }

        do {
            var offset = 0

            XCTAssert(ID3v2Frame(fromBodyData: data, offset: &offset, version: ID3v2Version.v3) == nil)
        }

        do {
            var offset = 0

            XCTAssert(ID3v2Frame(fromBodyData: data, offset: &offset, version: ID3v2Version.v4) == nil)
        }
    }

    func testVersion2CaseB() {
        let frame = ID3v2Frame(identifier: ID3v2FrameID.toal)

        frame.tagAlterPreservation = false
        frame.fileAlterPreservation = false

        frame.readOnly = false

        frame.unsynchronisation = false
        frame.dataLengthIndicator = false

        frame.compression = 0

        frame.group = nil

        XCTAssert(frame.isEmpty)

        XCTAssert(frame.toData(version: ID3v2Version.v2) == nil)

        let stuff = frame.imposeStuff(format: ID3v2UnknownValueFormat.regular)

        for _ in 0..<123 {
            stuff.content.append(UInt8(arc4random_uniform(256)))
        }

        XCTAssert(!frame.isEmpty)

        guard let data = frame.toData(version: ID3v2Version.v2) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            var offset = 0

            guard let other = ID3v2Frame(fromBodyData: data, offset: &offset, version: ID3v2Version.v2) else {
                return XCTFail()
            }

            XCTAssert(offset == data.count)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.identifier == frame.identifier)

            XCTAssert(other.tagAlterPreservation == false)
            XCTAssert(other.fileAlterPreservation == false)

            XCTAssert(other.readOnly == false)

            XCTAssert(other.unsynchronisation == false)
            XCTAssert(other.dataLengthIndicator == false)

            XCTAssert(other.compression == 0)

            XCTAssert(other.encryption == nil)
            XCTAssert(other.group == nil)

            let otherStuff = other.imposeStuff(format: ID3v2UnknownValueFormat.regular)

            XCTAssert(otherStuff.content == stuff.content)
        }

        do {
            var offset = 0

            XCTAssert(ID3v2Frame(fromBodyData: data, offset: &offset, version: ID3v2Version.v3) == nil)
        }

        do {
            var offset = 0

            XCTAssert(ID3v2Frame(fromBodyData: data, offset: &offset, version: ID3v2Version.v4) == nil)
        }
    }

    func testVersion2CaseC() {
        let frame = ID3v2Frame(identifier: ID3v2FrameID.tofn)

        let stuff = frame.imposeStuff(format: ID3v2UnknownValueFormat.regular)

        for _ in 0..<123 {
            stuff.content.append(UInt8(arc4random_uniform(256)))
        }

        frame.tagAlterPreservation = true
        frame.fileAlterPreservation = true

        frame.readOnly = true

        frame.unsynchronisation = true
        frame.dataLengthIndicator = true

        frame.compression = 6

        frame.group = 128

        XCTAssert(!frame.isEmpty)

        guard let data = frame.toData(version: ID3v2Version.v2) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            var offset = 0

            guard let other = ID3v2Frame(fromBodyData: data, offset: &offset, version: ID3v2Version.v2) else {
                return XCTFail()
            }

            XCTAssert(offset == data.count)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.identifier == frame.identifier)

            XCTAssert(other.tagAlterPreservation == false)
            XCTAssert(other.fileAlterPreservation == false)

            XCTAssert(other.readOnly == false)

            XCTAssert(other.unsynchronisation == false)
            XCTAssert(other.dataLengthIndicator == false)

            XCTAssert(other.compression == 0)

            XCTAssert(other.encryption == nil)
            XCTAssert(other.group == nil)

            let otherStuff = other.imposeStuff(format: ID3v2UnknownValueFormat.regular)

            XCTAssert(otherStuff.content == stuff.content)
        }

        do {
            var offset = 0

            XCTAssert(ID3v2Frame(fromBodyData: data, offset: &offset, version: ID3v2Version.v3) == nil)
        }

        do {
            var offset = 0

            XCTAssert(ID3v2Frame(fromBodyData: data, offset: &offset, version: ID3v2Version.v4) == nil)
        }
    }

    func testVersion2CaseD() {
        let frame = ID3v2Frame(identifier: ID3v2FrameID.comr)

        frame.tagAlterPreservation = false
        frame.fileAlterPreservation = false

        frame.readOnly = false

        frame.unsynchronisation = false
        frame.dataLengthIndicator = false

        frame.compression = 0

        frame.group = nil

        let stuff = frame.imposeStuff(format: ID3v2UnknownValueFormat.regular)

        for _ in 0..<123 {
            stuff.content.append(UInt8(arc4random_uniform(256)))
        }

        XCTAssert(!frame.isEmpty)

        XCTAssert(frame.toData(version: ID3v2Version.v2) == nil)
    }

    // MARK:

    func testVersion3CaseA() {
        let frame = ID3v2Frame(identifier: ID3v2FrameID.tmed)

        frame.tagAlterPreservation = true
        frame.fileAlterPreservation = true

        frame.readOnly = true

        frame.unsynchronisation = true
        frame.dataLengthIndicator = true

        frame.compression = 6

        frame.group = 128

        XCTAssert(frame.isEmpty)

        XCTAssert(frame.toData(version: ID3v2Version.v3) == nil)

        let stuff = frame.imposeStuff(format: ID3v2UnknownValueFormat.regular)

        for _ in 0..<123 {
            stuff.content.append(UInt8(arc4random_uniform(256)))
        }

        XCTAssert(!frame.isEmpty)

        guard let data = frame.toData(version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            var offset = 0

            guard let other = ID3v2Frame(fromBodyData: data, offset: &offset, version: ID3v2Version.v3) else {
                return XCTFail()
            }

            XCTAssert(offset == data.count)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.identifier == frame.identifier)

            XCTAssert(other.tagAlterPreservation == frame.tagAlterPreservation)
            XCTAssert(other.fileAlterPreservation == frame.fileAlterPreservation)

            XCTAssert(other.readOnly == frame.readOnly)

            XCTAssert(other.unsynchronisation == false)
            XCTAssert(other.dataLengthIndicator == false)

            XCTAssert(other.compression == -1)

            XCTAssert(other.encryption == nil)
            XCTAssert(other.group == frame.group)

            let otherStuff = other.imposeStuff(format: ID3v2UnknownValueFormat.regular)

            XCTAssert(otherStuff.content == stuff.content)
        }

        do {
            var offset = 0

            XCTAssert(ID3v2Frame(fromBodyData: data, offset: &offset, version: ID3v2Version.v2) == nil)
        }
    }

    func testVersion3CaseB() {
        let frame = ID3v2Frame(identifier: ID3v2FrameID.toal)

        frame.tagAlterPreservation = false
        frame.fileAlterPreservation = false

        frame.readOnly = false

        frame.unsynchronisation = false
        frame.dataLengthIndicator = false

        frame.compression = 0

        frame.group = nil

        XCTAssert(frame.isEmpty)

        XCTAssert(frame.toData(version: ID3v2Version.v3) == nil)

        let stuff = frame.imposeStuff(format: ID3v2UnknownValueFormat.regular)

        for _ in 0..<123 {
            stuff.content.append(UInt8(arc4random_uniform(256)))
        }

        XCTAssert(!frame.isEmpty)

        guard let data = frame.toData(version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            var offset = 0

            guard let other = ID3v2Frame(fromBodyData: data, offset: &offset, version: ID3v2Version.v3) else {
                return XCTFail()
            }

            XCTAssert(offset == data.count)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.identifier == frame.identifier)

            XCTAssert(other.tagAlterPreservation == frame.tagAlterPreservation)
            XCTAssert(other.fileAlterPreservation == frame.fileAlterPreservation)

            XCTAssert(other.readOnly == frame.readOnly)

            XCTAssert(other.unsynchronisation == false)
            XCTAssert(other.dataLengthIndicator == false)

            XCTAssert(other.compression == frame.compression)

            XCTAssert(other.encryption == nil)
            XCTAssert(other.group == frame.group)

            let otherStuff = other.imposeStuff(format: ID3v2UnknownValueFormat.regular)

            XCTAssert(otherStuff.content == stuff.content)
        }

        do {
            var offset = 0

            XCTAssert(ID3v2Frame(fromBodyData: data, offset: &offset, version: ID3v2Version.v2) == nil)
        }
    }

    func testVersion3CaseC() {
        let frame = ID3v2Frame(identifier: ID3v2FrameID.tofn)

        let stuff = frame.imposeStuff(format: ID3v2UnknownValueFormat.regular)

        for _ in 0..<123 {
            stuff.content.append(UInt8(arc4random_uniform(256)))
        }

        frame.tagAlterPreservation = true
        frame.fileAlterPreservation = true

        frame.readOnly = true

        frame.unsynchronisation = true
        frame.dataLengthIndicator = true

        frame.compression = 6

        frame.group = 128

        XCTAssert(!frame.isEmpty)

        guard let data = frame.toData(version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            var offset = 0

            guard let other = ID3v2Frame(fromBodyData: data, offset: &offset, version: ID3v2Version.v3) else {
                return XCTFail()
            }

            XCTAssert(offset == data.count)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.identifier == frame.identifier)

            XCTAssert(other.tagAlterPreservation == frame.tagAlterPreservation)
            XCTAssert(other.fileAlterPreservation == frame.fileAlterPreservation)

            XCTAssert(other.readOnly == frame.readOnly)

            XCTAssert(other.unsynchronisation == false)
            XCTAssert(other.dataLengthIndicator == false)

            XCTAssert(other.compression == -1)

            XCTAssert(other.encryption == nil)
            XCTAssert(other.group == frame.group)

            let otherStuff = other.imposeStuff(format: ID3v2UnknownValueFormat.regular)

            XCTAssert(otherStuff.content == stuff.content)
        }

        do {
            var offset = 0

            XCTAssert(ID3v2Frame(fromBodyData: data, offset: &offset, version: ID3v2Version.v2) == nil)
        }
    }

    func testVersion3CaseD() {
        let frame = ID3v2Frame(identifier: ID3v2FrameID.crm)

        frame.tagAlterPreservation = false
        frame.fileAlterPreservation = false

        frame.readOnly = false

        frame.unsynchronisation = false
        frame.dataLengthIndicator = false

        frame.compression = 0

        frame.group = nil

        let stuff = frame.imposeStuff(format: ID3v2UnknownValueFormat.regular)

        for _ in 0..<123 {
            stuff.content.append(UInt8(arc4random_uniform(256)))
        }

        XCTAssert(!frame.isEmpty)

        XCTAssert(frame.toData(version: ID3v2Version.v3) == nil)
    }

    // MARK:

    func testVersion4CaseA() {
        let frame = ID3v2Frame(identifier: ID3v2FrameID.tmed)

        frame.tagAlterPreservation = true
        frame.fileAlterPreservation = true

        frame.readOnly = true

        frame.unsynchronisation = true
        frame.dataLengthIndicator = true

        frame.compression = 6

        frame.group = 128

        XCTAssert(frame.isEmpty)

        XCTAssert(frame.toData(version: ID3v2Version.v4) == nil)

        let stuff = frame.imposeStuff(format: ID3v2UnknownValueFormat.regular)

        for _ in 0..<123 {
            stuff.content.append(UInt8(arc4random_uniform(256)))
        }

        XCTAssert(!frame.isEmpty)

        guard let data = frame.toData(version: ID3v2Version.v4) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            var offset = 0

            guard let other = ID3v2Frame(fromBodyData: data, offset: &offset, version: ID3v2Version.v4) else {
                return XCTFail()
            }

            XCTAssert(offset == data.count)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.identifier == frame.identifier)

            XCTAssert(other.tagAlterPreservation == frame.tagAlterPreservation)
            XCTAssert(other.fileAlterPreservation == frame.fileAlterPreservation)

            XCTAssert(other.readOnly == frame.readOnly)

            XCTAssert(other.unsynchronisation == frame.unsynchronisation)
            XCTAssert(other.dataLengthIndicator == frame.dataLengthIndicator)

            XCTAssert(other.compression == -1)

            XCTAssert(other.encryption == nil)
            XCTAssert(other.group == frame.group)

            let otherStuff = other.imposeStuff(format: ID3v2UnknownValueFormat.regular)

            XCTAssert(otherStuff.content == stuff.content)
        }

        do {
            var offset = 0

            XCTAssert(ID3v2Frame(fromBodyData: data, offset: &offset, version: ID3v2Version.v2) == nil)
        }
    }

    func testVersion4CaseB() {
        let frame = ID3v2Frame(identifier: ID3v2FrameID.toal)

        frame.tagAlterPreservation = false
        frame.fileAlterPreservation = false

        frame.readOnly = false

        frame.unsynchronisation = false
        frame.dataLengthIndicator = false

        frame.compression = 0

        frame.group = nil

        XCTAssert(frame.isEmpty)

        XCTAssert(frame.toData(version: ID3v2Version.v4) == nil)

        let stuff = frame.imposeStuff(format: ID3v2UnknownValueFormat.regular)

        for _ in 0..<123 {
            stuff.content.append(UInt8(arc4random_uniform(256)))
        }

        XCTAssert(!frame.isEmpty)

        guard let data = frame.toData(version: ID3v2Version.v4) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            var offset = 0

            guard let other = ID3v2Frame(fromBodyData: data, offset: &offset, version: ID3v2Version.v4) else {
                return XCTFail()
            }

            XCTAssert(offset == data.count)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.identifier == frame.identifier)

            XCTAssert(other.tagAlterPreservation == frame.tagAlterPreservation)
            XCTAssert(other.fileAlterPreservation == frame.fileAlterPreservation)

            XCTAssert(other.readOnly == frame.readOnly)

            XCTAssert(other.unsynchronisation == frame.unsynchronisation)
            XCTAssert(other.dataLengthIndicator == frame.dataLengthIndicator)

            XCTAssert(other.compression == frame.compression)

            XCTAssert(other.encryption == nil)
            XCTAssert(other.group == frame.group)

            let otherStuff = other.imposeStuff(format: ID3v2UnknownValueFormat.regular)

            XCTAssert(otherStuff.content == stuff.content)
        }

        do {
            var offset = 0

            XCTAssert(ID3v2Frame(fromBodyData: data, offset: &offset, version: ID3v2Version.v2) == nil)
        }
    }

    func testVersion4CaseC() {
        let frame = ID3v2Frame(identifier: ID3v2FrameID.tofn)

        let stuff = frame.imposeStuff(format: ID3v2UnknownValueFormat.regular)

        for _ in 0..<123 {
            stuff.content.append(UInt8(arc4random_uniform(256)))
        }

        frame.tagAlterPreservation = true
        frame.fileAlterPreservation = true

        frame.readOnly = true

        frame.unsynchronisation = true
        frame.dataLengthIndicator = true

        frame.compression = 6

        frame.group = 128

        XCTAssert(!frame.isEmpty)

        guard let data = frame.toData(version: ID3v2Version.v4) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        do {
            var offset = 0

            guard let other = ID3v2Frame(fromBodyData: data, offset: &offset, version: ID3v2Version.v4) else {
                return XCTFail()
            }

            XCTAssert(offset == data.count)

            XCTAssert(!other.isEmpty)

            XCTAssert(other.identifier == frame.identifier)

            XCTAssert(other.tagAlterPreservation == frame.tagAlterPreservation)
            XCTAssert(other.fileAlterPreservation == frame.fileAlterPreservation)

            XCTAssert(other.readOnly == frame.readOnly)

            XCTAssert(other.unsynchronisation == frame.unsynchronisation)
            XCTAssert(other.dataLengthIndicator == frame.dataLengthIndicator)

            XCTAssert(other.compression == -1)

            XCTAssert(other.encryption == nil)
            XCTAssert(other.group == frame.group)

            let otherStuff = other.imposeStuff(format: ID3v2UnknownValueFormat.regular)

            XCTAssert(otherStuff.content == stuff.content)
        }

        do {
            var offset = 0

            XCTAssert(ID3v2Frame(fromBodyData: data, offset: &offset, version: ID3v2Version.v2) == nil)
        }
    }

    func testVersion4CaseD() {
        let frame = ID3v2Frame(identifier: ID3v2FrameID.crm)

        frame.tagAlterPreservation = false
        frame.fileAlterPreservation = false

        frame.readOnly = false

        frame.unsynchronisation = false
        frame.dataLengthIndicator = false

        frame.compression = 0

        frame.group = nil

        let stuff = frame.imposeStuff(format: ID3v2UnknownValueFormat.regular)

        for _ in 0..<123 {
            stuff.content.append(UInt8(arc4random_uniform(256)))
        }

        XCTAssert(!frame.isEmpty)

        XCTAssert(frame.toData(version: ID3v2Version.v4) == nil)
    }
}
