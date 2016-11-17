//
//  ID3v2HeaderTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 27.08.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class ID3v2HeaderTest: XCTestCase {

    // MARK: Instance Methods

    func testVersion2CaseA() {
        let header = ID3v2Header(version: ID3v2Version.v2)

        header.revision = 123

        header.unsynchronisation = true
        header.compression = true

        header.experimentalIndicator = true

        header.extHeaderPresent = true
        header.footerPresent = true

        header.bodyLength = 1234

        XCTAssert(header.isValid)

        guard let data = header.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.header.isEmpty)
        XCTAssert(data.footer.isEmpty)

        guard let otherHeader = ID3v2Header(fromData: data.header) else {
            return XCTFail()
        }

        XCTAssert(otherHeader.isValid)

        XCTAssert(otherHeader.version == header.version)
        XCTAssert(otherHeader.revision == header.revision)

        XCTAssert(otherHeader.position == ID3v2Header.Position.header)

        XCTAssert(otherHeader.unsynchronisation == header.unsynchronisation)
        XCTAssert(otherHeader.compression == header.compression)

        XCTAssert(otherHeader.experimentalIndicator == false)

        XCTAssert(otherHeader.extHeaderPresent == false)
        XCTAssert(otherHeader.footerPresent == false)

        XCTAssert(otherHeader.bodyLength == header.bodyLength)
    }

    func testVersion2CaseB() {
        let header = ID3v2Header(version: ID3v2Version.v2)

        header.revision = 0

        header.unsynchronisation = false
        header.compression = false

        header.experimentalIndicator = false

        header.extHeaderPresent = false
        header.footerPresent = false

        header.bodyLength = 4321

        XCTAssert(header.isValid)

        guard let data = header.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.header.isEmpty)
        XCTAssert(data.footer.isEmpty)

        guard let otherHeader = ID3v2Header(fromData: data.header) else {
            return XCTFail()
        }

        XCTAssert(otherHeader.isValid)

        XCTAssert(otherHeader.version == header.version)
        XCTAssert(otherHeader.revision == header.revision)

        XCTAssert(otherHeader.position == ID3v2Header.Position.header)

        XCTAssert(otherHeader.unsynchronisation == header.unsynchronisation)
        XCTAssert(otherHeader.compression == header.compression)

        XCTAssert(otherHeader.experimentalIndicator == false)

        XCTAssert(otherHeader.extHeaderPresent == false)
        XCTAssert(otherHeader.footerPresent == false)

        XCTAssert(otherHeader.bodyLength == header.bodyLength)
    }

    func testVersion2CaseC() {
        let header = ID3v2Header(version: ID3v2Version.v2)

        header.revision = 123

        header.unsynchronisation = true
        header.compression = true

        header.experimentalIndicator = true

        header.extHeaderPresent = true
        header.footerPresent = true

        header.bodyLength = 0

        XCTAssert(header.isValid)

        XCTAssert(header.toData() == nil)
    }

    func testVersion2CaseD() {
        let header = ID3v2Header(version: ID3v2Version.v2)

        header.revision = 255

        header.unsynchronisation = false
        header.compression = false

        header.experimentalIndicator = false

        header.extHeaderPresent = false
        header.footerPresent = false

        header.bodyLength = 1234

        XCTAssert(!header.isValid)

        XCTAssert(header.toData() == nil)
    }

    // MARK:

    func testVersion3CaseA() {
        let header = ID3v2Header(version: ID3v2Version.v3)

        header.revision = 123

        header.unsynchronisation = true
        header.compression = true

        header.experimentalIndicator = true

        header.extHeaderPresent = true
        header.footerPresent = true

        header.bodyLength = 1234

        XCTAssert(header.isValid)

        guard let data = header.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.header.isEmpty)
        XCTAssert(data.footer.isEmpty)

        guard let otherHeader = ID3v2Header(fromData: data.header) else {
            return XCTFail()
        }

        XCTAssert(otherHeader.isValid)

        XCTAssert(otherHeader.version == header.version)
        XCTAssert(otherHeader.revision == header.revision)

        XCTAssert(otherHeader.position == ID3v2Header.Position.header)

        XCTAssert(otherHeader.unsynchronisation == header.unsynchronisation)
        XCTAssert(otherHeader.compression == false)

        XCTAssert(otherHeader.experimentalIndicator == header.experimentalIndicator)

        XCTAssert(otherHeader.extHeaderPresent == header.extHeaderPresent)
        XCTAssert(otherHeader.footerPresent == false)

        XCTAssert(otherHeader.bodyLength == header.bodyLength)
    }

    func testVersion3CaseB() {
        let header = ID3v2Header(version: ID3v2Version.v3)

        header.revision = 0

        header.unsynchronisation = false
        header.compression = false

        header.experimentalIndicator = false

        header.extHeaderPresent = false
        header.footerPresent = false

        header.bodyLength = 4321

        XCTAssert(header.isValid)

        guard let data = header.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.header.isEmpty)
        XCTAssert(data.footer.isEmpty)

        guard let otherHeader = ID3v2Header(fromData: data.header) else {
            return XCTFail()
        }

        XCTAssert(otherHeader.isValid)

        XCTAssert(otherHeader.version == header.version)
        XCTAssert(otherHeader.revision == header.revision)

        XCTAssert(otherHeader.position == ID3v2Header.Position.header)

        XCTAssert(otherHeader.unsynchronisation == header.unsynchronisation)
        XCTAssert(otherHeader.compression == false)

        XCTAssert(otherHeader.experimentalIndicator == header.experimentalIndicator)

        XCTAssert(otherHeader.extHeaderPresent == header.extHeaderPresent)
        XCTAssert(otherHeader.footerPresent == false)

        XCTAssert(otherHeader.bodyLength == header.bodyLength)
    }

    func testVersion3CaseC() {
        let header = ID3v2Header(version: ID3v2Version.v3)

        header.revision = 123

        header.unsynchronisation = true
        header.compression = true

        header.experimentalIndicator = true

        header.extHeaderPresent = true
        header.footerPresent = true

        header.bodyLength = 0

        XCTAssert(header.isValid)

        XCTAssert(header.toData() == nil)
    }

    func testVersion3CaseD() {
        let header = ID3v2Header(version: ID3v2Version.v3)

        header.revision = 255

        header.unsynchronisation = false
        header.compression = false

        header.experimentalIndicator = false

        header.extHeaderPresent = false
        header.footerPresent = false

        header.bodyLength = 1234

        XCTAssert(!header.isValid)

        XCTAssert(header.toData() == nil)
    }

    // MARK:

    func testVersion4CaseA() {
        let header = ID3v2Header(version: ID3v2Version.v4)

        header.revision = 123

        header.unsynchronisation = true
        header.compression = true

        header.experimentalIndicator = true

        header.extHeaderPresent = true
        header.footerPresent = true

        header.bodyLength = 1234

        XCTAssert(header.isValid)

        guard let data = header.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.header.isEmpty)
        XCTAssert(!data.footer.isEmpty)

        guard let otherHeader = ID3v2Header(fromData: data.header) else {
            return XCTFail()
        }

        XCTAssert(otherHeader.isValid)

        XCTAssert(otherHeader.version == header.version)
        XCTAssert(otherHeader.revision == header.revision)

        XCTAssert(otherHeader.position == ID3v2Header.Position.header)

        XCTAssert(otherHeader.unsynchronisation == header.unsynchronisation)
        XCTAssert(otherHeader.compression == false)

        XCTAssert(otherHeader.experimentalIndicator == header.experimentalIndicator)

        XCTAssert(otherHeader.extHeaderPresent == header.extHeaderPresent)
        XCTAssert(otherHeader.footerPresent == header.footerPresent)

        XCTAssert(otherHeader.bodyLength == header.bodyLength)

        guard let otherFooter = ID3v2Header(fromData: data.footer) else {
            return XCTFail()
        }

        XCTAssert(otherFooter.isValid)

        XCTAssert(otherFooter.version == header.version)
        XCTAssert(otherFooter.revision == header.revision)

        XCTAssert(otherFooter.position == ID3v2Header.Position.footer)

        XCTAssert(otherFooter.unsynchronisation == header.unsynchronisation)
        XCTAssert(otherFooter.compression == false)

        XCTAssert(otherFooter.experimentalIndicator == header.experimentalIndicator)

        XCTAssert(otherFooter.extHeaderPresent == header.extHeaderPresent)
        XCTAssert(otherFooter.footerPresent == header.footerPresent)

        XCTAssert(otherFooter.bodyLength == header.bodyLength)
    }

    func testVersion4CaseB() {
        let header = ID3v2Header(version: ID3v2Version.v4)

        header.revision = 0

        header.unsynchronisation = false
        header.compression = false

        header.experimentalIndicator = false

        header.extHeaderPresent = false
        header.footerPresent = false

        header.bodyLength = 4321

        XCTAssert(header.isValid)

        guard let data = header.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.header.isEmpty)
        XCTAssert(data.footer.isEmpty)

        guard let otherHeader = ID3v2Header(fromData: data.header) else {
            return XCTFail()
        }

        XCTAssert(otherHeader.isValid)

        XCTAssert(otherHeader.version == header.version)
        XCTAssert(otherHeader.revision == header.revision)

        XCTAssert(otherHeader.position == ID3v2Header.Position.header)

        XCTAssert(otherHeader.unsynchronisation == header.unsynchronisation)
        XCTAssert(otherHeader.compression == false)

        XCTAssert(otherHeader.experimentalIndicator == header.experimentalIndicator)

        XCTAssert(otherHeader.extHeaderPresent == header.extHeaderPresent)
        XCTAssert(otherHeader.footerPresent == header.footerPresent)

        XCTAssert(otherHeader.bodyLength == header.bodyLength)
    }

    func testVersion4CaseC() {
        let header = ID3v2Header(version: ID3v2Version.v4)

        header.revision = 123

        header.unsynchronisation = true
        header.compression = true

        header.experimentalIndicator = true

        header.extHeaderPresent = true
        header.footerPresent = true

        header.bodyLength = 0

        XCTAssert(header.isValid)

        XCTAssert(header.toData() == nil)
    }

    func testVersion4CaseD() {
        let header = ID3v2Header(version: ID3v2Version.v4)

        header.revision = 255

        header.unsynchronisation = false
        header.compression = false

        header.experimentalIndicator = false

        header.extHeaderPresent = false
        header.footerPresent = false

        header.bodyLength = 1234

        XCTAssert(!header.isValid)

        XCTAssert(header.toData() == nil)
    }
}
