//
//  MPEGXingHeaderTest.swift
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

extension MPEGXingHeader {

    // MARK: Initializers

    fileprivate init?(fromData data: [UInt8], range: inout Range<UInt64>) {
        let stream = MemoryStream(data: data)

        guard stream.openForReading() else {
            return nil
        }

        self.init(fromStream: stream, range: &range)
    }
}

class MPEGXingHeaderTest: XCTestCase {

    // MARK: Instance Methods

    func testCaseA() {
    	var header = MPEGXingHeader()

        XCTAssert(!header.isValid)

        header.bitRateMode = MPEGBitRateMode.variable

        header.framesCount = 123
        header.bytesCount = 123

        header.tableOfContent = Array<UInt8>(repeating: 123, count: 100)

        header.quality = 123

        XCTAssert(header.isValid)

        guard let data = header.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        let prefixData = Array<UInt8>(repeating: 123, count: 123)
        let suffixData = Array<UInt8>(repeating: 231, count: 231)

        var range = Range<UInt64>(123..<(123 + UInt64(data.count)))

        guard let otherHeader = MPEGXingHeader(fromData: prefixData + data + suffixData, range: &range) else {
            return XCTFail()
        }

        XCTAssert(range.lowerBound == 123)
        XCTAssert(range.upperBound == 123 + UInt64(data.count))

        XCTAssert(otherHeader.isValid)

        XCTAssert(otherHeader.bitRateMode == header.bitRateMode)

        XCTAssert(otherHeader.framesCount == header.framesCount!)
        XCTAssert(otherHeader.bytesCount == header.bytesCount!)

        guard let otherTableOfContent = otherHeader.tableOfContent else {
            return XCTFail()
        }

        XCTAssert(otherTableOfContent == header.tableOfContent!)

        XCTAssert(otherHeader.quality == header.quality!)
    }

    func testCaseB() {
        var header = MPEGXingHeader()

        XCTAssert(!header.isValid)

        header.bitRateMode = MPEGBitRateMode.constant

        header.framesCount = 123
        header.bytesCount = 123

        header.tableOfContent = Array<UInt8>(repeating: 123, count: 100)

        header.quality = 0

        XCTAssert(header.isValid)

        guard let data = header.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        let prefixData = Array<UInt8>(repeating: 123, count: 123)
        let suffixData = Array<UInt8>(repeating: 231, count: 231)

        var range = Range<UInt64>(123..<(354 + UInt64(data.count)))

        guard let otherHeader = MPEGXingHeader(fromData: prefixData + data + suffixData, range: &range) else {
            return XCTFail()
        }

        XCTAssert(range.lowerBound == 123)
        XCTAssert(range.upperBound == 123 + UInt64(data.count))

        XCTAssert(otherHeader.isValid)

        XCTAssert(otherHeader.bitRateMode == header.bitRateMode)

        XCTAssert(otherHeader.framesCount == header.framesCount!)
        XCTAssert(otherHeader.bytesCount == header.bytesCount!)

        guard let otherTableOfContent = otherHeader.tableOfContent else {
            return XCTFail()
        }

        XCTAssert(otherTableOfContent == header.tableOfContent!)

        XCTAssert(otherHeader.quality == header.quality!)
    }

    func testCaseC() {
        var header = MPEGXingHeader()

        XCTAssert(!header.isValid)

        header.bitRateMode = MPEGBitRateMode.variable

        header.framesCount = 1
        header.bytesCount = 1

        header.tableOfContent = Array<UInt8>(repeating: 123, count: 100)

        header.quality = 123

        XCTAssert(header.isValid)

        guard let data = header.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        guard let otherHeader = MPEGXingHeader(fromData: data) else {
            return XCTFail()
        }

        XCTAssert(otherHeader.isValid)

        XCTAssert(otherHeader.bitRateMode == header.bitRateMode)

        XCTAssert(otherHeader.framesCount == header.framesCount!)
        XCTAssert(otherHeader.bytesCount == header.bytesCount!)

        guard let otherTableOfContent = otherHeader.tableOfContent else {
            return XCTFail()
        }

        XCTAssert(otherTableOfContent == header.tableOfContent!)

        XCTAssert(otherHeader.quality == header.quality!)
    }

    func testCaseD() {
        var header = MPEGXingHeader()

        XCTAssert(!header.isValid)

        header.bitRateMode = MPEGBitRateMode.variable

        header.framesCount = nil
        header.bytesCount = nil

        header.tableOfContent = nil

        header.quality = nil

        XCTAssert(header.isValid)

        guard let data = header.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        guard let otherHeader = MPEGXingHeader(fromData: data) else {
            return XCTFail()
        }

        XCTAssert(otherHeader.isValid)

        XCTAssert(otherHeader.bitRateMode == header.bitRateMode)

        XCTAssert(otherHeader.framesCount == nil)
        XCTAssert(otherHeader.bytesCount == nil)

        XCTAssert(otherHeader.tableOfContent == nil)

        XCTAssert(otherHeader.quality == nil)
    }

    func testCaseE() {
        var header = MPEGXingHeader()

        XCTAssert(!header.isValid)

        header.bitRateMode = MPEGBitRateMode.constant

        header.framesCount = nil
        header.bytesCount = nil

        header.tableOfContent = nil

        header.quality = nil

        XCTAssert(!header.isValid)

        XCTAssert(header.toData() == nil)
    }

    func testCaseF() {
        var header = MPEGXingHeader()

        XCTAssert(!header.isValid)

        header.bitRateMode = MPEGBitRateMode.variable

        header.framesCount = 123
        header.bytesCount = 123

        header.tableOfContent = [1, 2, 3]

        header.quality = 123

        XCTAssert(!header.isValid)

        XCTAssert(header.toData() == nil)
    }

    func testCaseG() {
        var header = MPEGXingHeader()

        XCTAssert(!header.isValid)

        header.bitRateMode = MPEGBitRateMode.variable

        header.framesCount = 0
        header.bytesCount = 0

        header.tableOfContent = Array<UInt8>(repeating: 123, count: 100)

        header.quality = 123

        XCTAssert(!header.isValid)

        XCTAssert(header.toData() == nil)
    }
}
