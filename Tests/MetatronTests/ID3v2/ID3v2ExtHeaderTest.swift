//
//  ID3v2ExtHeaderTest.swift
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

class ID3v2ExtHeaderTest: XCTestCase {

    // MARK: Instance Methods

    func testVersion2CaseA() {
        let extHeader = ID3v2ExtHeader()

        extHeader.padding = 1234

        XCTAssert(extHeader.toData(version: ID3v2Version.v2) == nil)
    }

    func testVersion2CaseB() {
        let extHeader = ID3v2ExtHeader()

        extHeader.padding = 0

        XCTAssert(extHeader.toData(version: ID3v2Version.v2) == nil)
    }

    // MARK:

    func testVersion3CaseA() {
        let extHeader = ID3v2ExtHeader()

        extHeader.padding = 1234

        guard let data = extHeader.toData(version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        guard let other = ID3v2ExtHeader(fromData: data, version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(other.ownDataLength == 10)
        XCTAssert(other.padding == 1234)
    }

    func testVersion3CaseB() {
        let extHeader = ID3v2ExtHeader()

        extHeader.padding = 0

        guard let data = extHeader.toData(version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        guard let other = ID3v2ExtHeader(fromData: data, version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(other.ownDataLength == 10)
        XCTAssert(other.padding == 0)
    }

    // MARK:

    func testVersion4CaseA() {
        let extHeader = ID3v2ExtHeader()

        extHeader.padding = 1234

        guard let data = extHeader.toData(version: ID3v2Version.v4) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        guard let other = ID3v2ExtHeader(fromData: data, version: ID3v2Version.v4) else {
            return XCTFail()
        }

        XCTAssert(other.ownDataLength == 6)
        XCTAssert(other.padding == 0)
    }

    func testVersion4CaseB() {
        let extHeader = ID3v2ExtHeader()

        extHeader.padding = 0

        guard let data = extHeader.toData(version: ID3v2Version.v4) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        guard let other = ID3v2ExtHeader(fromData: data, version: ID3v2Version.v4) else {
            return XCTFail()
        }

        XCTAssert(other.ownDataLength == 6)
        XCTAssert(other.padding == 0)
    }
}
