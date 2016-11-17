//
//  APEHeaderTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 26.08.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class APEHeaderTest: XCTestCase {

    // MARK: Instance Methods

    func testVersion1CaseA() {
        let header = APEHeader(version: APEVersion.v1)

        header.headerPresent = true
        header.footerPresent = true

        header.bodyLength = 1234
        header.itemCount = 56

        XCTAssert(header.isValid)

        guard let data = header.toData() else {
            return XCTFail()
        }

        XCTAssert(data.header.isEmpty)
        XCTAssert(!data.footer.isEmpty)

        guard let otherFooter = APEHeader(fromData: data.footer) else {
            return XCTFail()
        }

        XCTAssert(otherFooter.isValid)

        XCTAssert(otherFooter.version == header.version)

        XCTAssert(otherFooter.position == APEHeader.Position.footer)

        XCTAssert(otherFooter.headerPresent == false)
        XCTAssert(otherFooter.footerPresent == header.footerPresent)

        XCTAssert(otherFooter.bodyLength == header.bodyLength)
        XCTAssert(otherFooter.itemCount == header.itemCount)
    }

    func testVersion1CaseB() {
        let header = APEHeader(version: APEVersion.v1)

        header.headerPresent = false
        header.footerPresent = true

        header.bodyLength = 4321
        header.itemCount = 65

        XCTAssert(header.isValid)

        guard let data = header.toData() else {
            return XCTFail()
        }

        XCTAssert(data.header.isEmpty)
        XCTAssert(!data.footer.isEmpty)

        guard let otherFooter = APEHeader(fromData: data.footer) else {
            return XCTFail()
        }

        XCTAssert(otherFooter.isValid)

        XCTAssert(otherFooter.version == header.version)

        XCTAssert(otherFooter.position == APEHeader.Position.footer)

        XCTAssert(otherFooter.headerPresent == false)
        XCTAssert(otherFooter.footerPresent == header.footerPresent)

        XCTAssert(otherFooter.bodyLength == header.bodyLength)
        XCTAssert(otherFooter.itemCount == header.itemCount)
    }

    func testVersion1CaseC() {
        let header = APEHeader(version: APEVersion.v1)

        header.headerPresent = true
        header.footerPresent = false

        header.bodyLength = 1234
        header.itemCount = 56

        XCTAssert(!header.isValid)

        XCTAssert(header.toData() == nil)
    }

    func testVersion1CaseD() {
        let header = APEHeader(version: APEVersion.v1)

        header.headerPresent = false
        header.footerPresent = false

        header.bodyLength = 1234
        header.itemCount = 56

        XCTAssert(!header.isValid)

        XCTAssert(header.toData() == nil)
    }

    func testVersion1CaseE() {
        let header = APEHeader(version: APEVersion.v1)

        header.headerPresent = true
        header.footerPresent = true

        header.bodyLength = 0
        header.itemCount = 0

        XCTAssert(header.isValid)

        XCTAssert(header.toData() == nil)
    }

    // MARK:

    func testVersion2CaseA() {
        let header = APEHeader(version: APEVersion.v2)

        header.headerPresent = true
        header.footerPresent = true

        header.bodyLength = 1234
        header.itemCount = 56

        XCTAssert(header.isValid)

        guard let data = header.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.header.isEmpty)
        XCTAssert(!data.footer.isEmpty)

        guard let otherHeader = APEHeader(fromData: data.header) else {
            return XCTFail()
        }

        XCTAssert(otherHeader.isValid)

        XCTAssert(otherHeader.version == header.version)

        XCTAssert(otherHeader.position == APEHeader.Position.header)

        XCTAssert(otherHeader.headerPresent == header.headerPresent)
        XCTAssert(otherHeader.footerPresent == header.footerPresent)

        XCTAssert(otherHeader.bodyLength == header.bodyLength)
        XCTAssert(otherHeader.itemCount == header.itemCount)

        guard let otherFooter = APEHeader(fromData: data.footer) else {
            return XCTFail()
        }

        XCTAssert(otherFooter.isValid)

        XCTAssert(otherFooter.version == header.version)

        XCTAssert(otherFooter.position == APEHeader.Position.footer)

        XCTAssert(otherFooter.headerPresent == header.headerPresent)
        XCTAssert(otherFooter.footerPresent == header.footerPresent)

        XCTAssert(otherFooter.bodyLength == header.bodyLength)
        XCTAssert(otherFooter.itemCount == header.itemCount)
    }

    func testVersion2CaseB() {
        let header = APEHeader(version: APEVersion.v2)

        header.headerPresent = false
        header.footerPresent = true

        header.bodyLength = 4321
        header.itemCount = 65

        XCTAssert(header.isValid)

        guard let data = header.toData() else {
            return XCTFail()
        }

        XCTAssert(data.header.isEmpty)
        XCTAssert(!data.footer.isEmpty)

        guard let otherFooter = APEHeader(fromData: data.footer) else {
            return XCTFail()
        }

        XCTAssert(otherFooter.isValid)

        XCTAssert(otherFooter.version == header.version)

        XCTAssert(otherFooter.position == APEHeader.Position.footer)

        XCTAssert(otherFooter.headerPresent == header.headerPresent)
        XCTAssert(otherFooter.footerPresent == header.footerPresent)

        XCTAssert(otherFooter.bodyLength == header.bodyLength)
        XCTAssert(otherFooter.itemCount == header.itemCount)
    }

    func testVersion2CaseC() {
        let header = APEHeader(version: APEVersion.v2)

        header.headerPresent = true
        header.footerPresent = false

        header.bodyLength = 1234
        header.itemCount = 56

        XCTAssert(header.isValid)

        guard let data = header.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.header.isEmpty)
        XCTAssert(data.footer.isEmpty)

        guard let otherHeader = APEHeader(fromData: data.header) else {
            return XCTFail()
        }

        XCTAssert(otherHeader.isValid)

        XCTAssert(otherHeader.version == header.version)

        XCTAssert(otherHeader.position == APEHeader.Position.header)

        XCTAssert(otherHeader.headerPresent == header.headerPresent)
        XCTAssert(otherHeader.footerPresent == header.footerPresent)

        XCTAssert(otherHeader.bodyLength == header.bodyLength)
        XCTAssert(otherHeader.itemCount == header.itemCount)
    }

    func testVersion2CaseD() {
        let header = APEHeader(version: APEVersion.v2)

        header.headerPresent = false
        header.footerPresent = false

        header.bodyLength = 1234
        header.itemCount = 56

        XCTAssert(!header.isValid)

        XCTAssert(header.toData() == nil)
    }

    func testVersion2CaseE() {
        let header = APEHeader(version: APEVersion.v2)

        header.headerPresent = true
        header.footerPresent = true

        header.bodyLength = 0
        header.itemCount = 0

        XCTAssert(header.isValid)

        XCTAssert(header.toData() == nil)
    }
}
