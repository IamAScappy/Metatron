//
//  ID3v2FrameCacheTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 03.10.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class ID3v2FrameCacheTest: XCTestCase {

    // MARK: Instance Properties

    func testReset() {
        let cache = ID3v2FrameCache(version: ID3v2Version.v2, dataBuffer: [1, 2, 3], dataLength: 3)

        XCTAssert(cache.version == ID3v2Version.v2)

        XCTAssert(cache.dataBuffer == [1, 2, 3])
        XCTAssert(cache.dataLength == 3)

        cache.compression = 6

        cache.encryption = 128
        cache.group = 128

        XCTAssert(!cache.isEmpty)

        cache.reset()

        XCTAssert(cache.isEmpty)

        XCTAssert(cache.version == ID3v2Version.v2)

        XCTAssert(cache.dataBuffer == [])
        XCTAssert(cache.dataLength == 0)

        XCTAssert(cache.compression == 0)

        XCTAssert(cache.encryption == nil)
        XCTAssert(cache.group == nil)
    }

    // MARK:

    func testVersion2CaseA() {
        let header = ID3v2FrameHeader(identifier: ID3v2FrameID.tmed)

        let cache = ID3v2FrameCache(version: ID3v2Version.v2, dataBuffer: [1, 2, 3], dataLength: 3)

        XCTAssert(cache.version == ID3v2Version.v2)

        XCTAssert(cache.dataBuffer == [1, 2, 3])
        XCTAssert(cache.dataLength == 3)

        cache.compression = 6

        cache.encryption = 128
        cache.group = 128

        XCTAssert(!cache.isEmpty)

        XCTAssert(cache.toData(header: header) == nil)
    }

    func testVersion2CaseB() {
        let header = ID3v2FrameHeader(identifier: ID3v2FrameID.tmed)

        let cache = ID3v2FrameCache(version: ID3v2Version.v2, dataBuffer: [1, 2, 3], dataLength: 3)

        XCTAssert(cache.version == ID3v2Version.v2)

        XCTAssert(cache.dataBuffer == [1, 2, 3])
        XCTAssert(cache.dataLength == 3)

        cache.compression = 0

        cache.encryption = nil
        cache.group = nil

        XCTAssert(!cache.isEmpty)

        guard let data = cache.toData(header: header) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        XCTAssert(header.tagAlterPreservation == false)
        XCTAssert(header.fileAlterPreservation == false)

        XCTAssert(header.readOnly == false)

        XCTAssert(header.unsynchronisation == false)
        XCTAssert(header.dataLengthIndicator == false)

        XCTAssert(header.compression == false)

        XCTAssert(header.encryption == false)
        XCTAssert(header.group == false)

        XCTAssert(header.valueLength == UInt32(data.count))

        guard let other = ID3v2FrameCache(fromData: data, version: ID3v2Version.v2, header: header) else {
            return XCTFail()
        }

        XCTAssert(!other.isEmpty)

        XCTAssert(other.version == cache.version)

        XCTAssert(other.dataBuffer == cache.dataBuffer)
        XCTAssert(other.dataLength == 0)

        XCTAssert(other.compression == cache.compression)

        XCTAssert(other.encryption == cache.encryption)
        XCTAssert(other.group == cache.group)

        XCTAssert(header.tagAlterPreservation == false)
        XCTAssert(header.fileAlterPreservation == false)

        XCTAssert(header.readOnly == false)

        XCTAssert(header.unsynchronisation == false)
        XCTAssert(header.dataLengthIndicator == false)

        XCTAssert(header.compression == false)

        XCTAssert(header.encryption == false)
        XCTAssert(header.group == false)

        XCTAssert(header.valueLength == UInt32(data.count))
    }

    func testVersion2CaseC() {
        let header = ID3v2FrameHeader(identifier: ID3v2FrameID.tmed)

        let cache = ID3v2FrameCache(version: ID3v2Version.v2, dataBuffer: [1, 2, 3])

        XCTAssert(cache.version == ID3v2Version.v2)

        XCTAssert(cache.dataBuffer == [1, 2, 3])
        XCTAssert(cache.dataLength == 0)

        cache.compression = 0

        cache.encryption = 128
        cache.group = nil

        XCTAssert(!cache.isEmpty)

        XCTAssert(cache.toData(header: header) == nil)
    }

    func testVersion2CaseD() {
        let header = ID3v2FrameHeader(identifier: ID3v2FrameID.tmed)

        let cache = ID3v2FrameCache(version: ID3v2Version.v2, dataBuffer: [1, 2, 3])

        XCTAssert(cache.version == ID3v2Version.v2)

        XCTAssert(cache.dataBuffer == [1, 2, 3])
        XCTAssert(cache.dataLength == 0)

        cache.compression = 6

        cache.encryption = 128
        cache.group = nil

        XCTAssert(!cache.isEmpty)

        XCTAssert(cache.toData(header: header) == nil)
    }

    func testVersion2CaseE() {
        let header = ID3v2FrameHeader(identifier: ID3v2FrameID.tmed)

        let cache = ID3v2FrameCache(version: ID3v2Version.v2)

        XCTAssert(cache.version == ID3v2Version.v2)

        XCTAssert(cache.dataBuffer == [])
        XCTAssert(cache.dataLength == 0)

        cache.compression = 0

        cache.encryption = nil
        cache.group = nil

        XCTAssert(cache.isEmpty)

        XCTAssert(cache.toData(header: header) == nil)
    }

    // MARK:

    func testVersion3CaseA() {
        let header = ID3v2FrameHeader(identifier: ID3v2FrameID.tmed)

        let cache = ID3v2FrameCache(version: ID3v2Version.v3, dataBuffer: [1, 2, 3], dataLength: 3)

        XCTAssert(cache.version == ID3v2Version.v3)

        XCTAssert(cache.dataBuffer == [1, 2, 3])
        XCTAssert(cache.dataLength == 3)

        cache.compression = 6

        cache.encryption = 128
        cache.group = 128

        XCTAssert(!cache.isEmpty)

        guard let data = cache.toData(header: header) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        XCTAssert(header.tagAlterPreservation == false)
        XCTAssert(header.fileAlterPreservation == false)

        XCTAssert(header.readOnly == false)

        XCTAssert(header.unsynchronisation == false)
        XCTAssert(header.dataLengthIndicator == false)

        XCTAssert(header.compression == true)

        XCTAssert(header.encryption == true)
        XCTAssert(header.group == true)

        XCTAssert(header.valueLength == UInt32(data.count))

        guard let other = ID3v2FrameCache(fromData: data, version: ID3v2Version.v3, header: header) else {
            return XCTFail()
        }

        XCTAssert(!other.isEmpty)

        XCTAssert(other.version == cache.version)

        XCTAssert(other.dataBuffer == cache.dataBuffer)
        XCTAssert(other.dataLength == cache.dataLength)

        XCTAssert(other.compression == -1)

        XCTAssert(other.encryption == cache.encryption)
        XCTAssert(other.group == cache.group)

        XCTAssert(header.tagAlterPreservation == false)
        XCTAssert(header.fileAlterPreservation == false)

        XCTAssert(header.readOnly == false)

        XCTAssert(header.unsynchronisation == false)
        XCTAssert(header.dataLengthIndicator == false)

        XCTAssert(header.compression == true)

        XCTAssert(header.encryption == true)
        XCTAssert(header.group == true)

        XCTAssert(header.valueLength == UInt32(data.count))
    }

    func testVersion3CaseB() {
        let header = ID3v2FrameHeader(identifier: ID3v2FrameID.tmed)

        let cache = ID3v2FrameCache(version: ID3v2Version.v3, dataBuffer: [1, 2, 3], dataLength: 3)

        XCTAssert(cache.version == ID3v2Version.v3)

        XCTAssert(cache.dataBuffer == [1, 2, 3])
        XCTAssert(cache.dataLength == 3)

        cache.compression = 0

        cache.encryption = nil
        cache.group = nil

        XCTAssert(!cache.isEmpty)

        guard let data = cache.toData(header: header) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        XCTAssert(header.tagAlterPreservation == false)
        XCTAssert(header.fileAlterPreservation == false)

        XCTAssert(header.readOnly == false)

        XCTAssert(header.unsynchronisation == false)
        XCTAssert(header.dataLengthIndicator == false)

        XCTAssert(header.compression == false)

        XCTAssert(header.encryption == false)
        XCTAssert(header.group == false)

        XCTAssert(header.valueLength == UInt32(data.count))

        guard let other = ID3v2FrameCache(fromData: data, version: ID3v2Version.v3, header: header) else {
            return XCTFail()
        }

        XCTAssert(!other.isEmpty)

        XCTAssert(other.version == cache.version)

        XCTAssert(other.dataBuffer == cache.dataBuffer)
        XCTAssert(other.dataLength == 0)

        XCTAssert(other.compression == cache.compression)

        XCTAssert(other.encryption == cache.encryption)
        XCTAssert(other.group == cache.group)

        XCTAssert(header.tagAlterPreservation == false)
        XCTAssert(header.fileAlterPreservation == false)

        XCTAssert(header.readOnly == false)

        XCTAssert(header.unsynchronisation == false)
        XCTAssert(header.dataLengthIndicator == false)

        XCTAssert(header.compression == false)

        XCTAssert(header.encryption == false)
        XCTAssert(header.group == false)

        XCTAssert(header.valueLength == UInt32(data.count))
    }

    func testVersion3CaseC() {
        let header = ID3v2FrameHeader(identifier: ID3v2FrameID.tmed)

        let cache = ID3v2FrameCache(version: ID3v2Version.v3, dataBuffer: [1, 2, 3])

        XCTAssert(cache.version == ID3v2Version.v3)

        XCTAssert(cache.dataBuffer == [1, 2, 3])
        XCTAssert(cache.dataLength == 0)

        cache.compression = 0

        cache.encryption = 128
        cache.group = nil

        XCTAssert(!cache.isEmpty)

        guard let data = cache.toData(header: header) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        XCTAssert(header.tagAlterPreservation == false)
        XCTAssert(header.fileAlterPreservation == false)

        XCTAssert(header.readOnly == false)

        XCTAssert(header.unsynchronisation == false)
        XCTAssert(header.dataLengthIndicator == false)

        XCTAssert(header.compression == false)

        XCTAssert(header.encryption == true)
        XCTAssert(header.group == false)

        XCTAssert(header.valueLength == UInt32(data.count))

        guard let other = ID3v2FrameCache(fromData: data, version: ID3v2Version.v3, header: header) else {
            return XCTFail()
        }

        XCTAssert(!other.isEmpty)

        XCTAssert(other.version == cache.version)

        XCTAssert(other.dataBuffer == cache.dataBuffer)
        XCTAssert(other.dataLength == cache.dataLength)

        XCTAssert(other.compression == cache.compression)

        XCTAssert(other.encryption == cache.encryption)
        XCTAssert(other.group == cache.group)

        XCTAssert(header.tagAlterPreservation == false)
        XCTAssert(header.fileAlterPreservation == false)

        XCTAssert(header.readOnly == false)

        XCTAssert(header.unsynchronisation == false)
        XCTAssert(header.dataLengthIndicator == false)

        XCTAssert(header.compression == false)

        XCTAssert(header.encryption == true)
        XCTAssert(header.group == false)

        XCTAssert(header.valueLength == UInt32(data.count))
    }

    func testVersion3CaseD() {
        let header = ID3v2FrameHeader(identifier: ID3v2FrameID.tmed)

        let cache = ID3v2FrameCache(version: ID3v2Version.v3, dataBuffer: [1, 2, 3])

        XCTAssert(cache.version == ID3v2Version.v3)

        XCTAssert(cache.dataBuffer == [1, 2, 3])
        XCTAssert(cache.dataLength == 0)

        cache.compression = 6

        cache.encryption = 128
        cache.group = nil

        XCTAssert(!cache.isEmpty)

        XCTAssert(cache.toData(header: header) == nil)
    }

    func testVersion3CaseE() {
        let header = ID3v2FrameHeader(identifier: ID3v2FrameID.tmed)

        let cache = ID3v2FrameCache(version: ID3v2Version.v3)

        XCTAssert(cache.version == ID3v2Version.v3)

        XCTAssert(cache.dataBuffer == [])
        XCTAssert(cache.dataLength == 0)

        cache.compression = 0

        cache.encryption = nil
        cache.group = nil

        XCTAssert(cache.isEmpty)

        XCTAssert(cache.toData(header: header) == nil)
    }

    // MARK:

    func testVersion4CaseA() {
        let header = ID3v2FrameHeader(identifier: ID3v2FrameID.tmed)

        let cache = ID3v2FrameCache(version: ID3v2Version.v4, dataBuffer: [1, 2, 3], dataLength: 3)

        XCTAssert(cache.version == ID3v2Version.v4)

        XCTAssert(cache.dataBuffer == [1, 2, 3])
        XCTAssert(cache.dataLength == 3)

        cache.compression = 6

        cache.encryption = 128
        cache.group = 128

        XCTAssert(!cache.isEmpty)

        guard let data = cache.toData(header: header) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        XCTAssert(header.tagAlterPreservation == false)
        XCTAssert(header.fileAlterPreservation == false)

        XCTAssert(header.readOnly == false)

        XCTAssert(header.unsynchronisation == false)
        XCTAssert(header.dataLengthIndicator == false)

        XCTAssert(header.compression == true)

        XCTAssert(header.encryption == true)
        XCTAssert(header.group == true)

        XCTAssert(header.valueLength == UInt32(data.count))

        guard let other = ID3v2FrameCache(fromData: data, version: ID3v2Version.v4, header: header) else {
            return XCTFail()
        }

        XCTAssert(!other.isEmpty)

        XCTAssert(other.version == cache.version)

        XCTAssert(other.dataBuffer == cache.dataBuffer)
        XCTAssert(other.dataLength == cache.dataLength)

        XCTAssert(other.compression == -1)

        XCTAssert(other.encryption == cache.encryption)
        XCTAssert(other.group == cache.group)

        XCTAssert(header.tagAlterPreservation == false)
        XCTAssert(header.fileAlterPreservation == false)

        XCTAssert(header.readOnly == false)

        XCTAssert(header.unsynchronisation == false)
        XCTAssert(header.dataLengthIndicator == false)

        XCTAssert(header.compression == true)

        XCTAssert(header.encryption == true)
        XCTAssert(header.group == true)

        XCTAssert(header.valueLength == UInt32(data.count))
    }

    func testVersion4CaseB() {
        let header = ID3v2FrameHeader(identifier: ID3v2FrameID.tmed)

        let cache = ID3v2FrameCache(version: ID3v2Version.v4, dataBuffer: [1, 2, 3], dataLength: 3)

        XCTAssert(cache.version == ID3v2Version.v4)

        XCTAssert(cache.dataBuffer == [1, 2, 3])
        XCTAssert(cache.dataLength == 3)

        cache.compression = 0

        cache.encryption = nil
        cache.group = nil

        XCTAssert(!cache.isEmpty)

        guard let data = cache.toData(header: header) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        XCTAssert(header.tagAlterPreservation == false)
        XCTAssert(header.fileAlterPreservation == false)

        XCTAssert(header.readOnly == false)

        XCTAssert(header.unsynchronisation == false)
        XCTAssert(header.dataLengthIndicator == false)

        XCTAssert(header.compression == false)

        XCTAssert(header.encryption == false)
        XCTAssert(header.group == false)

        XCTAssert(header.valueLength == UInt32(data.count))

        guard let other = ID3v2FrameCache(fromData: data, version: ID3v2Version.v4, header: header) else {
            return XCTFail()
        }

        XCTAssert(!other.isEmpty)

        XCTAssert(other.version == cache.version)

        XCTAssert(other.dataBuffer == cache.dataBuffer)
        XCTAssert(other.dataLength == 0)

        XCTAssert(other.compression == cache.compression)

        XCTAssert(other.encryption == cache.encryption)
        XCTAssert(other.group == cache.group)

        XCTAssert(header.tagAlterPreservation == false)
        XCTAssert(header.fileAlterPreservation == false)

        XCTAssert(header.readOnly == false)

        XCTAssert(header.unsynchronisation == false)
        XCTAssert(header.dataLengthIndicator == false)

        XCTAssert(header.compression == false)

        XCTAssert(header.encryption == false)
        XCTAssert(header.group == false)

        XCTAssert(header.valueLength == UInt32(data.count))
    }

    func testVersion4CaseC() {
        let header = ID3v2FrameHeader(identifier: ID3v2FrameID.tmed)

        let cache = ID3v2FrameCache(version: ID3v2Version.v4, dataBuffer: [1, 2, 3])

        XCTAssert(cache.version == ID3v2Version.v4)

        XCTAssert(cache.dataBuffer == [1, 2, 3])
        XCTAssert(cache.dataLength == 0)

        cache.compression = 0

        cache.encryption = 128
        cache.group = nil

        XCTAssert(!cache.isEmpty)

        guard let data = cache.toData(header: header) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        XCTAssert(header.tagAlterPreservation == false)
        XCTAssert(header.fileAlterPreservation == false)

        XCTAssert(header.readOnly == false)

        XCTAssert(header.unsynchronisation == false)
        XCTAssert(header.dataLengthIndicator == false)

        XCTAssert(header.compression == false)

        XCTAssert(header.encryption == true)
        XCTAssert(header.group == false)

        XCTAssert(header.valueLength == UInt32(data.count))

        guard let other = ID3v2FrameCache(fromData: data, version: ID3v2Version.v4, header: header) else {
            return XCTFail()
        }

        XCTAssert(!other.isEmpty)

        XCTAssert(other.version == cache.version)

        XCTAssert(other.dataBuffer == cache.dataBuffer)
        XCTAssert(other.dataLength == cache.dataLength)

        XCTAssert(other.compression == cache.compression)

        XCTAssert(other.encryption == cache.encryption)
        XCTAssert(other.group == cache.group)

        XCTAssert(header.tagAlterPreservation == false)
        XCTAssert(header.fileAlterPreservation == false)

        XCTAssert(header.readOnly == false)

        XCTAssert(header.unsynchronisation == false)
        XCTAssert(header.dataLengthIndicator == false)

        XCTAssert(header.compression == false)

        XCTAssert(header.encryption == true)
        XCTAssert(header.group == false)

        XCTAssert(header.valueLength == UInt32(data.count))
    }

    func testVersion4CaseD() {
        let header = ID3v2FrameHeader(identifier: ID3v2FrameID.tmed)

        let cache = ID3v2FrameCache(version: ID3v2Version.v4, dataBuffer: [1, 2, 3])

        XCTAssert(cache.version == ID3v2Version.v4)

        XCTAssert(cache.dataBuffer == [1, 2, 3])
        XCTAssert(cache.dataLength == 0)

        cache.compression = 6

        cache.encryption = 128
        cache.group = nil

        XCTAssert(!cache.isEmpty)

        XCTAssert(cache.toData(header: header) == nil)
    }

    func testVersion4CaseE() {
        let header = ID3v2FrameHeader(identifier: ID3v2FrameID.tmed)

        let cache = ID3v2FrameCache(version: ID3v2Version.v4)

        XCTAssert(cache.version == ID3v2Version.v4)

        XCTAssert(cache.dataBuffer == [])
        XCTAssert(cache.dataLength == 0)

        cache.compression = 0

        cache.encryption = nil
        cache.group = nil

        XCTAssert(cache.isEmpty)

        XCTAssert(cache.toData(header: header) == nil)
    }
}
