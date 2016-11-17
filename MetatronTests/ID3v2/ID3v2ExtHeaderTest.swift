//
//  ID3v2ExtHeaderTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 27.08.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
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
