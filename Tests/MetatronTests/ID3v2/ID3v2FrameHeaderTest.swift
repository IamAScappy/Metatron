//
//  ID3v2FrameHeaderTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 29.08.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class ID3v2FrameHeaderTest: XCTestCase {

    // MARK: Instance Methods

    func testReset() {
        let header = ID3v2FrameHeader(identifier: ID3v2FrameID.mllt)

        header.tagAlterPreservation = true
        header.fileAlterPreservation = true

        header.readOnly = true

        header.unsynchronisation = true
        header.dataLengthIndicator = true

        header.compression = true

        header.encryption = true
        header.group = true

        header.valueLength = 1234

        header.reset()

        XCTAssert(header.tagAlterPreservation == false)
        XCTAssert(header.fileAlterPreservation == false)

        XCTAssert(header.readOnly == false)

        XCTAssert(header.unsynchronisation == false)
        XCTAssert(header.dataLengthIndicator == false)

        XCTAssert(header.compression == false)

        XCTAssert(header.encryption == false)
        XCTAssert(header.group == false)

        XCTAssert(header.valueLength == 0)
    }

    // MARK:

    func testVersion2CaseA() {
        let header = ID3v2FrameHeader(identifier: ID3v2FrameID.mcdi)

        header.tagAlterPreservation = true
        header.fileAlterPreservation = true

        header.readOnly = true

        header.unsynchronisation = true
        header.dataLengthIndicator = true

        header.compression = true

        header.encryption = true
        header.group = true

        XCTAssert(header.toData(version: ID3v2Version.v2) == nil)

        header.valueLength = 1234

        guard let data = header.toData(version: ID3v2Version.v2) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        guard let other = ID3v2FrameHeader(fromData: data, version: ID3v2Version.v2) else {
            return XCTFail()
        }

        XCTAssert(other.identifier == header.identifier)

        XCTAssert(other.tagAlterPreservation == false)
        XCTAssert(other.fileAlterPreservation == false)

        XCTAssert(other.readOnly == false)

        XCTAssert(other.unsynchronisation == false)
        XCTAssert(other.dataLengthIndicator == false)

        XCTAssert(other.compression == false)

        XCTAssert(other.encryption == false)
        XCTAssert(other.group == false)

        XCTAssert(other.valueLength == header.valueLength)
    }

    func testVersion2CaseB() {
        let header = ID3v2FrameHeader(identifier: ID3v2FrameID.pcnt)

        header.tagAlterPreservation = false
        header.fileAlterPreservation = false

        header.readOnly = false

        header.unsynchronisation = false
        header.dataLengthIndicator = false

        header.compression = false

        header.encryption = false
        header.group = false

        XCTAssert(header.toData(version: ID3v2Version.v2) == nil)

        header.valueLength = 4321

        guard let data = header.toData(version: ID3v2Version.v2) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        guard let other = ID3v2FrameHeader(fromData: data, version: ID3v2Version.v2) else {
            return XCTFail()
        }

        XCTAssert(other.identifier == header.identifier)

        XCTAssert(other.tagAlterPreservation == false)
        XCTAssert(other.fileAlterPreservation == false)

        XCTAssert(other.readOnly == false)

        XCTAssert(other.unsynchronisation == false)
        XCTAssert(other.dataLengthIndicator == false)

        XCTAssert(other.compression == false)

        XCTAssert(other.encryption == false)
        XCTAssert(other.group == false)

        XCTAssert(other.valueLength == header.valueLength)
    }

    func testVersion2CaseC() {
        let header = ID3v2FrameHeader(identifier: ID3v2FrameID.aspi)

        header.tagAlterPreservation = false
        header.fileAlterPreservation = false

        header.readOnly = false

        header.unsynchronisation = false
        header.dataLengthIndicator = false

        header.compression = false

        header.encryption = false
        header.group = false

        XCTAssert(header.toData(version: ID3v2Version.v2) == nil)

        header.valueLength = 1234

        XCTAssert(header.toData(version: ID3v2Version.v2) == nil)
    }

    // MARK:

    func testVersion3CaseA() {
        let header = ID3v2FrameHeader(identifier: ID3v2FrameID.mcdi)

        header.tagAlterPreservation = true
        header.fileAlterPreservation = true

        header.readOnly = true

        header.unsynchronisation = true
        header.dataLengthIndicator = true

        header.compression = true

        header.encryption = true
        header.group = true

        XCTAssert(header.toData(version: ID3v2Version.v3) == nil)

        header.valueLength = 1234

        guard let data = header.toData(version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        guard let other = ID3v2FrameHeader(fromData: data, version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(other.identifier == header.identifier)

        XCTAssert(other.tagAlterPreservation == header.tagAlterPreservation)
        XCTAssert(other.fileAlterPreservation == header.fileAlterPreservation)

        XCTAssert(other.readOnly == header.readOnly)

        XCTAssert(other.unsynchronisation == false)
        XCTAssert(other.dataLengthIndicator == false)

        XCTAssert(other.compression == header.compression)

        XCTAssert(other.encryption == header.encryption)
        XCTAssert(other.group == header.group)

        XCTAssert(other.valueLength == header.valueLength)
    }

    func testVersion3CaseB() {
        let header = ID3v2FrameHeader(identifier: ID3v2FrameID.pcnt)

        header.tagAlterPreservation = false
        header.fileAlterPreservation = false

        header.readOnly = false

        header.unsynchronisation = false
        header.dataLengthIndicator = false

        header.compression = false

        header.encryption = false
        header.group = false

        XCTAssert(header.toData(version: ID3v2Version.v3) == nil)

        header.valueLength = 4321

        guard let data = header.toData(version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        guard let other = ID3v2FrameHeader(fromData: data, version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(other.identifier == header.identifier)

        XCTAssert(other.tagAlterPreservation == header.tagAlterPreservation)
        XCTAssert(other.fileAlterPreservation == header.fileAlterPreservation)

        XCTAssert(other.readOnly == header.readOnly)

        XCTAssert(other.unsynchronisation == false)
        XCTAssert(other.dataLengthIndicator == false)

        XCTAssert(other.compression == header.compression)

        XCTAssert(other.encryption == header.encryption)
        XCTAssert(other.group == header.group)

        XCTAssert(other.valueLength == header.valueLength)
    }

    func testVersion3CaseC() {
        let header = ID3v2FrameHeader(identifier: ID3v2FrameID.aspi)

        header.tagAlterPreservation = false
        header.fileAlterPreservation = false

        header.readOnly = false

        header.unsynchronisation = false
        header.dataLengthIndicator = false

        header.compression = false

        header.encryption = false
        header.group = false

        XCTAssert(header.toData(version: ID3v2Version.v3) == nil)

        header.valueLength = 1234

        XCTAssert(header.toData(version: ID3v2Version.v3) == nil)
    }

    // MARK:

    func testVersion4CaseA() {
        let header = ID3v2FrameHeader(identifier: ID3v2FrameID.mcdi)

        header.tagAlterPreservation = true
        header.fileAlterPreservation = true

        header.readOnly = true

        header.unsynchronisation = true
        header.dataLengthIndicator = true

        header.compression = true

        header.encryption = true
        header.group = true

        XCTAssert(header.toData(version: ID3v2Version.v4) == nil)

        header.valueLength = 1234

        guard let data = header.toData(version: ID3v2Version.v4) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        guard let other = ID3v2FrameHeader(fromData: data, version: ID3v2Version.v4) else {
            return XCTFail()
        }

        XCTAssert(other.identifier == header.identifier)

        XCTAssert(other.tagAlterPreservation == header.tagAlterPreservation)
        XCTAssert(other.fileAlterPreservation == header.fileAlterPreservation)

        XCTAssert(other.readOnly == header.readOnly)

        XCTAssert(other.unsynchronisation == header.unsynchronisation)
        XCTAssert(other.dataLengthIndicator == header.dataLengthIndicator)

        XCTAssert(other.compression == header.compression)

        XCTAssert(other.encryption == header.encryption)
        XCTAssert(other.group == header.group)

        XCTAssert(other.valueLength == header.valueLength)
    }

    func testVersion4CaseB() {
        let header = ID3v2FrameHeader(identifier: ID3v2FrameID.pcnt)

        header.tagAlterPreservation = false
        header.fileAlterPreservation = false

        header.readOnly = false

        header.unsynchronisation = false
        header.dataLengthIndicator = false

        header.compression = false

        header.encryption = false
        header.group = false

        XCTAssert(header.toData(version: ID3v2Version.v4) == nil)

        header.valueLength = 4321

        guard let data = header.toData(version: ID3v2Version.v4) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        guard let other = ID3v2FrameHeader(fromData: data, version: ID3v2Version.v4) else {
            return XCTFail()
        }

        XCTAssert(other.identifier == header.identifier)

        XCTAssert(other.tagAlterPreservation == header.tagAlterPreservation)
        XCTAssert(other.fileAlterPreservation == header.fileAlterPreservation)

        XCTAssert(other.readOnly == header.readOnly)

        XCTAssert(other.unsynchronisation == header.unsynchronisation)
        XCTAssert(other.dataLengthIndicator == header.dataLengthIndicator)

        XCTAssert(other.compression == header.compression)

        XCTAssert(other.encryption == header.encryption)
        XCTAssert(other.group == header.group)

        XCTAssert(other.valueLength == header.valueLength)
    }

    func testVersion4CaseC() {
        let header = ID3v2FrameHeader(identifier: ID3v2FrameID.crm)

        header.tagAlterPreservation = false
        header.fileAlterPreservation = false

        header.readOnly = false

        header.unsynchronisation = false
        header.dataLengthIndicator = false

        header.compression = false

        header.encryption = false
        header.group = false

        XCTAssert(header.toData(version: ID3v2Version.v4) == nil)

        header.valueLength = 1234

        XCTAssert(header.toData(version: ID3v2Version.v4) == nil)
    }
}
