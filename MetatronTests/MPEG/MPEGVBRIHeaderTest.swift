//
//  MPEGVBRIHeaderTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 31.10.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

extension MPEGVBRIHeader {

    // MARK: Initializers

    fileprivate init?(fromData data: [UInt8], range: inout Range<UInt64>) {
        let stream = MemoryStream(data: data)

        guard stream.openForReading() else {
            return nil
        }

        self.init(fromStream: stream, range: &range)
    }
}

class MPEGVBRIHeaderTest: XCTestCase {

    // MARK: Instance Methods

    func testCaseA() {
        var header = MPEGVBRIHeader()

        XCTAssert(!header.isValid)

        header.version = 123

        header.delay = 123
        header.quality = 123

        header.bytesCount = 123
        header.framesCount = 123

        header.scaleFactor = 123

        header.bytesPerEntry = 2
        header.framesPerEntry = 3

        header.tableOfContent = [1, 2, 3]

        XCTAssert(header.isValid)

        guard let data = header.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        let prefixData = Array<UInt8>(repeating: 123, count: 123)
        let suffixData = Array<UInt8>(repeating: 231, count: 231)

        var range = Range<UInt64>(123..<(123 + UInt64(data.count)))

        guard let otherHeader = MPEGVBRIHeader(fromData: prefixData + data + suffixData, range: &range) else {
            return XCTFail()
        }

        XCTAssert(range.lowerBound == 123)
        XCTAssert(range.upperBound == 123 + UInt64(data.count))

        XCTAssert(otherHeader.isValid)

        XCTAssert(otherHeader.version == header.version)

        XCTAssert(otherHeader.delay == header.delay)
        XCTAssert(otherHeader.quality == header.quality)

        XCTAssert(otherHeader.bytesCount == header.bytesCount)
        XCTAssert(otherHeader.framesCount == header.framesCount)

        XCTAssert(otherHeader.scaleFactor == header.scaleFactor)

        XCTAssert(otherHeader.bytesPerEntry == header.bytesPerEntry)
        XCTAssert(otherHeader.framesPerEntry == header.framesPerEntry)

        XCTAssert(otherHeader.tableOfContent == header.tableOfContent)
    }

    func testCaseB() {
        var header = MPEGVBRIHeader()

        XCTAssert(!header.isValid)

        header.version = 0

        header.delay = 0
        header.quality = 0

        header.bytesCount = 123
        header.framesCount = 123

        header.scaleFactor = 0

        header.bytesPerEntry = 2
        header.framesPerEntry = 3

        header.tableOfContent = [1, 2, 3]

        XCTAssert(header.isValid)

        guard let data = header.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        let prefixData = Array<UInt8>(repeating: 123, count: 123)
        let suffixData = Array<UInt8>(repeating: 231, count: 231)

        var range = Range<UInt64>(123..<(354 + UInt64(data.count)))

        guard let otherHeader = MPEGVBRIHeader(fromData: prefixData + data + suffixData, range: &range) else {
            return XCTFail()
        }

        XCTAssert(range.lowerBound == 123)
        XCTAssert(range.upperBound == 123 + UInt64(data.count))

        XCTAssert(otherHeader.isValid)

        XCTAssert(otherHeader.version == header.version)

        XCTAssert(otherHeader.delay == header.delay)
        XCTAssert(otherHeader.quality == header.quality)

        XCTAssert(otherHeader.bytesCount == header.bytesCount)
        XCTAssert(otherHeader.framesCount == header.framesCount)

        XCTAssert(otherHeader.scaleFactor == header.scaleFactor)

        XCTAssert(otherHeader.bytesPerEntry == header.bytesPerEntry)
        XCTAssert(otherHeader.framesPerEntry == header.framesPerEntry)

        XCTAssert(otherHeader.tableOfContent == header.tableOfContent)
    }

    func testCaseC() {
        var header = MPEGVBRIHeader()

        XCTAssert(!header.isValid)

        header.version = 123

        header.delay = 123
        header.quality = 123

        header.bytesCount = 1
        header.framesCount = 1

        header.scaleFactor = 1

        header.bytesPerEntry = 1
        header.framesPerEntry = 1

        header.tableOfContent = [123, 456, 789]

        XCTAssert(header.isValid)

        guard let data = header.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        guard let otherHeader = MPEGVBRIHeader(fromData: data) else {
            return XCTFail()
        }

        XCTAssert(otherHeader.isValid)

        XCTAssert(otherHeader.version == header.version)

        XCTAssert(otherHeader.delay == header.delay)
        XCTAssert(otherHeader.quality == header.quality)

        XCTAssert(otherHeader.bytesCount == header.bytesCount)
        XCTAssert(otherHeader.framesCount == header.framesCount)

        XCTAssert(otherHeader.scaleFactor == header.scaleFactor)

        XCTAssert(otherHeader.bytesPerEntry == header.bytesPerEntry)
        XCTAssert(otherHeader.framesPerEntry == header.framesPerEntry)

        XCTAssert(otherHeader.tableOfContent == [123, 200, 21])
    }

    func testCaseD() {
        var header = MPEGVBRIHeader()

        XCTAssert(!header.isValid)

        header.version = 123

        header.delay = 123
        header.quality = 123

        header.bytesCount = 0
        header.framesCount = 0

        header.scaleFactor = 1

        header.bytesPerEntry = 2
        header.framesPerEntry = 3

        header.tableOfContent = [1, 2, 3]

        XCTAssert(!header.isValid)

        XCTAssert(header.toData() == nil)
    }

    func testCaseE() {
        var header = MPEGVBRIHeader()

        XCTAssert(!header.isValid)

        header.version = 123

        header.delay = 123
        header.quality = 123

        header.bytesCount = 123
        header.framesCount = 123

        header.scaleFactor = 0

        header.bytesPerEntry = 0
        header.framesPerEntry = 0

        header.tableOfContent = [1, 2, 3]

        XCTAssert(!header.isValid)

        XCTAssert(header.toData() == nil)
    }

    func testCaseF() {
        var header = MPEGVBRIHeader()

        XCTAssert(!header.isValid)

        header.version = 123

        header.delay = 123
        header.quality = 123

        header.bytesCount = 123
        header.framesCount = 123

        header.scaleFactor = 1

        header.bytesPerEntry = 2
        header.framesPerEntry = 3

        header.tableOfContent = []

        XCTAssert(!header.isValid)

        XCTAssert(header.toData() == nil)
    }
}
