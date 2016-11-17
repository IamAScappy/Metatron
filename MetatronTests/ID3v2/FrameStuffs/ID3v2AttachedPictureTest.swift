//
//  ID3v2AttachedPictureTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 05.09.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class ID3v2AttachedPictureTest: XCTestCase {

    // MARK: Instance Methods

    func testCreateClone() {
        let stuff = ID3v2AttachedPicture()

        stuff.textEncoding = ID3v2TextEncoding.utf16

        stuff.description = "Abc 123"

        stuff.imageFormat = ID3v2AttachedPicture.ImageFormat.jpg
        stuff.pictureType = ID3v2AttachedPicture.PictureType.backCover

        stuff.pictureData = [0, 1, 2, 3, 0, 4, 5, 6]

        let other = ID3v2AttachedPictureFormat.regular.createStuffSubclass(fromOther: stuff)

        XCTAssert(other.textEncoding == stuff.textEncoding)

        XCTAssert(other.description == stuff.description)

        XCTAssert(other.imageFormat == stuff.imageFormat)
        XCTAssert(other.pictureType == stuff.pictureType)

        XCTAssert(other.pictureData == stuff.pictureData)
    }

    func testImposeStuff() {
        let frame = ID3v2Frame(identifier: ID3v2FrameID.apic)

        let stuff1 = frame.imposeStuff(format: ID3v2AttachedPictureFormat.regular)
        let stuff2 = frame.imposeStuff(format: ID3v2AttachedPictureFormat.regular)

        XCTAssert(frame.stuff is ID3v2AttachedPicture)

        XCTAssert(frame.stuff === stuff1)
        XCTAssert(frame.stuff === stuff2)
    }

    // MARK:

    func testVersion2CaseA() {
        let stuff = ID3v2AttachedPicture()

        stuff.textEncoding = ID3v2TextEncoding.latin1

        stuff.description = "Abc 123"

        stuff.imageFormat = ID3v2AttachedPicture.ImageFormat.jpg
        stuff.pictureType = ID3v2AttachedPicture.PictureType.backCover

        stuff.pictureData = [0, 1, 2, 3, 0, 4, 5, 6]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v2) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        let other = ID3v2AttachedPicture(fromData: data, version: ID3v2Version.v2)

        XCTAssert(!other.isEmpty)

        XCTAssert(other.textEncoding == stuff.textEncoding)

        XCTAssert(other.description == stuff.description)

        XCTAssert(other.imageFormat == stuff.imageFormat)
        XCTAssert(other.pictureType == stuff.pictureType)

        XCTAssert(other.pictureData == stuff.pictureData)
    }

    func testVersion2CaseB() {
        let stuff = ID3v2AttachedPicture()

        stuff.textEncoding = ID3v2TextEncoding.latin1

        stuff.description = "Абв 123"

        stuff.imageFormat = ID3v2AttachedPicture.ImageFormat.jpg
        stuff.pictureType = ID3v2AttachedPicture.PictureType.frontCover

        stuff.pictureData = [0, 1, 2, 3, 0, 4, 5, 6]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v2) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        let other = ID3v2AttachedPicture(fromData: data, version: ID3v2Version.v2)

        XCTAssert(!other.isEmpty)

        XCTAssert(other.textEncoding == stuff.textEncoding)

        XCTAssert(other.description != stuff.description)

        XCTAssert(other.imageFormat == stuff.imageFormat)
        XCTAssert(other.pictureType == stuff.pictureType)

        XCTAssert(other.pictureData == stuff.pictureData)
    }

    func testVersion2CaseC() {
        let stuff = ID3v2AttachedPicture()

        stuff.textEncoding = ID3v2TextEncoding.utf16LE

        stuff.description = "Абв 123"

        stuff.imageFormat = ID3v2AttachedPicture.ImageFormat.png
        stuff.pictureType = ID3v2AttachedPicture.PictureType.bandLogo

        stuff.pictureData = [3, 2, 1, 0, 6, 5, 4, 0]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v2) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        let other = ID3v2AttachedPicture(fromData: data, version: ID3v2Version.v2)

        XCTAssert(!other.isEmpty)

        XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)

        XCTAssert(other.description == stuff.description)

        XCTAssert(other.imageFormat == stuff.imageFormat)
        XCTAssert(other.pictureType == stuff.pictureType)

        XCTAssert(other.pictureData == stuff.pictureData)
    }

    func testVersion2CaseD() {
        let stuff = ID3v2AttachedPicture()

        stuff.textEncoding = ID3v2TextEncoding.utf16BE

        stuff.description = ""

        stuff.imageFormat = ID3v2AttachedPicture.ImageFormat.link
        stuff.pictureType = ID3v2AttachedPicture.PictureType.fileIcon

        stuff.pictureData = ID3v2TextEncoding.latin1.encode("http://bla-bla-bla.com", termination: false)

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v2) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        let other = ID3v2AttachedPicture(fromData: data, version: ID3v2Version.v2)

        XCTAssert(!other.isEmpty)

        XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)

        XCTAssert(other.description == stuff.description)

        XCTAssert(other.imageFormat == stuff.imageFormat)
        XCTAssert(other.pictureType == stuff.pictureType)

        XCTAssert(other.pictureData == stuff.pictureData)
    }

    func testVersion2CaseE() {
        let stuff = ID3v2AttachedPicture()

        stuff.textEncoding = ID3v2TextEncoding.utf8

        stuff.description = "Abc 123"

        stuff.imageFormat = ID3v2AttachedPicture.ImageFormat.other(mimeType: "image/bmp")
        stuff.pictureType = ID3v2AttachedPicture.PictureType.illustration

        stuff.pictureData = [0, 1, 2, 3, 0, 4, 5, 6]

        XCTAssert(!stuff.isEmpty)

        XCTAssert(stuff.toData(version: ID3v2Version.v2) == nil)
    }

    func testVersion2CaseF() {
        let stuff = ID3v2AttachedPicture()

        stuff.textEncoding = ID3v2TextEncoding.utf16

        stuff.description = "Abc 123"

        stuff.imageFormat = ID3v2AttachedPicture.ImageFormat.jpg
        stuff.pictureType = ID3v2AttachedPicture.PictureType.artist

        stuff.pictureData = []

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.toData(version: ID3v2Version.v2) == nil)
    }

    func testVersion2CaseG() {
        let stuff = ID3v2AttachedPicture(fromData: [], version: ID3v2Version.v2)

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.textEncoding == ID3v2TextEncoding.utf8)

        XCTAssert(stuff.description == "")

        XCTAssert(stuff.imageFormat == ID3v2AttachedPicture.ImageFormat.other(mimeType: "application/octet-stream"))
        XCTAssert(stuff.pictureType == ID3v2AttachedPicture.PictureType.other)

        XCTAssert(stuff.pictureData == [])

        XCTAssert(stuff.toData(version: ID3v2Version.v2) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v3) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v4) == nil)
    }

    // MARK:

    func testVersion3CaseA() {
        let stuff = ID3v2AttachedPicture()

        stuff.textEncoding = ID3v2TextEncoding.latin1

        stuff.description = "Abc 123"

        stuff.imageFormat = ID3v2AttachedPicture.ImageFormat.jpg
        stuff.pictureType = ID3v2AttachedPicture.PictureType.backCover

        stuff.pictureData = [0, 1, 2, 3, 0, 4, 5, 6]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        let other = ID3v2AttachedPicture(fromData: data, version: ID3v2Version.v3)

        XCTAssert(!other.isEmpty)

        XCTAssert(other.textEncoding == stuff.textEncoding)

        XCTAssert(other.description == stuff.description)

        XCTAssert(other.imageFormat == stuff.imageFormat)
        XCTAssert(other.pictureType == stuff.pictureType)

        XCTAssert(other.pictureData == stuff.pictureData)
    }

    func testVersion3CaseB() {
        let stuff = ID3v2AttachedPicture()

        stuff.textEncoding = ID3v2TextEncoding.latin1

        stuff.description = "Абв 123"

        stuff.imageFormat = ID3v2AttachedPicture.ImageFormat.jpg
        stuff.pictureType = ID3v2AttachedPicture.PictureType.frontCover

        stuff.pictureData = [0, 1, 2, 3, 0, 4, 5, 6]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        let other = ID3v2AttachedPicture(fromData: data, version: ID3v2Version.v3)

        XCTAssert(!other.isEmpty)

        XCTAssert(other.textEncoding == stuff.textEncoding)

        XCTAssert(other.description != stuff.description)

        XCTAssert(other.imageFormat == stuff.imageFormat)
        XCTAssert(other.pictureType == stuff.pictureType)

        XCTAssert(other.pictureData == stuff.pictureData)
    }

    func testVersion3CaseC() {
        let stuff = ID3v2AttachedPicture()

        stuff.textEncoding = ID3v2TextEncoding.utf16LE

        stuff.description = "Абв 123"

        stuff.imageFormat = ID3v2AttachedPicture.ImageFormat.png
        stuff.pictureType = ID3v2AttachedPicture.PictureType.bandLogo

        stuff.pictureData = [3, 2, 1, 0, 6, 5, 4, 0]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        let other = ID3v2AttachedPicture(fromData: data, version: ID3v2Version.v3)

        XCTAssert(!other.isEmpty)

        XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)

        XCTAssert(other.description == stuff.description)

        XCTAssert(other.imageFormat == stuff.imageFormat)
        XCTAssert(other.pictureType == stuff.pictureType)

        XCTAssert(other.pictureData == stuff.pictureData)
    }

    func testVersion3CaseD() {
        let stuff = ID3v2AttachedPicture()

        stuff.textEncoding = ID3v2TextEncoding.utf16BE

        stuff.description = ""

        stuff.imageFormat = ID3v2AttachedPicture.ImageFormat.link
        stuff.pictureType = ID3v2AttachedPicture.PictureType.fileIcon

        stuff.pictureData = ID3v2TextEncoding.latin1.encode("http://bla-bla-bla.com", termination: false)

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        let other = ID3v2AttachedPicture(fromData: data, version: ID3v2Version.v3)

        XCTAssert(!other.isEmpty)

        XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)

        XCTAssert(other.description == stuff.description)

        XCTAssert(other.imageFormat == stuff.imageFormat)
        XCTAssert(other.pictureType == stuff.pictureType)

        XCTAssert(other.pictureData == stuff.pictureData)
    }

    func testVersion3CaseE() {
        let stuff = ID3v2AttachedPicture()

        stuff.textEncoding = ID3v2TextEncoding.utf8

        stuff.description = "Abc 123"

        stuff.imageFormat = ID3v2AttachedPicture.ImageFormat.other(mimeType: "image/bmp")
        stuff.pictureType = ID3v2AttachedPicture.PictureType.illustration

        stuff.pictureData = [0, 1, 2, 3, 0, 4, 5, 6]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v3) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        let other = ID3v2AttachedPicture(fromData: data, version: ID3v2Version.v3)

        XCTAssert(!other.isEmpty)

        XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)

        XCTAssert(other.description == stuff.description)

        XCTAssert(other.imageFormat == stuff.imageFormat)
        XCTAssert(other.pictureType == stuff.pictureType)

        XCTAssert(other.pictureData == stuff.pictureData)
    }

    func testVersion3CaseF() {
        let stuff = ID3v2AttachedPicture()

        stuff.textEncoding = ID3v2TextEncoding.utf16

        stuff.description = "Abc 123"

        stuff.imageFormat = ID3v2AttachedPicture.ImageFormat.jpg
        stuff.pictureType = ID3v2AttachedPicture.PictureType.artist

        stuff.pictureData = []

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.toData(version: ID3v2Version.v3) == nil)
    }

    func testVersion3CaseG() {
        let stuff = ID3v2AttachedPicture(fromData: [], version: ID3v2Version.v3)

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.textEncoding == ID3v2TextEncoding.utf8)

        XCTAssert(stuff.description == "")

        XCTAssert(stuff.imageFormat == ID3v2AttachedPicture.ImageFormat.other(mimeType: "application/octet-stream"))
        XCTAssert(stuff.pictureType == ID3v2AttachedPicture.PictureType.other)

        XCTAssert(stuff.pictureData == [])

        XCTAssert(stuff.toData(version: ID3v2Version.v3) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v2) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v4) == nil)
    }

    // MARK:

    func testVersion4CaseA() {
        let stuff = ID3v2AttachedPicture()

        stuff.textEncoding = ID3v2TextEncoding.latin1

        stuff.description = "Abc 123"

        stuff.imageFormat = ID3v2AttachedPicture.ImageFormat.jpg
        stuff.pictureType = ID3v2AttachedPicture.PictureType.backCover

        stuff.pictureData = [0, 1, 2, 3, 0, 4, 5, 6]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v4) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        let other = ID3v2AttachedPicture(fromData: data, version: ID3v2Version.v4)

        XCTAssert(!other.isEmpty)

        XCTAssert(other.textEncoding == stuff.textEncoding)

        XCTAssert(other.description == stuff.description)

        XCTAssert(other.imageFormat == stuff.imageFormat)
        XCTAssert(other.pictureType == stuff.pictureType)

        XCTAssert(other.pictureData == stuff.pictureData)
    }

    func testVersion4CaseB() {
        let stuff = ID3v2AttachedPicture()

        stuff.textEncoding = ID3v2TextEncoding.latin1

        stuff.description = "Абв 123"

        stuff.imageFormat = ID3v2AttachedPicture.ImageFormat.jpg
        stuff.pictureType = ID3v2AttachedPicture.PictureType.frontCover

        stuff.pictureData = [0, 1, 2, 3, 0, 4, 5, 6]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v4) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        let other = ID3v2AttachedPicture(fromData: data, version: ID3v2Version.v4)

        XCTAssert(!other.isEmpty)

        XCTAssert(other.textEncoding == stuff.textEncoding)

        XCTAssert(other.description != stuff.description)

        XCTAssert(other.imageFormat == stuff.imageFormat)
        XCTAssert(other.pictureType == stuff.pictureType)

        XCTAssert(other.pictureData == stuff.pictureData)
    }

    func testVersion4CaseC() {
        let stuff = ID3v2AttachedPicture()

        stuff.textEncoding = ID3v2TextEncoding.utf16LE

        stuff.description = "Абв 123"

        stuff.imageFormat = ID3v2AttachedPicture.ImageFormat.png
        stuff.pictureType = ID3v2AttachedPicture.PictureType.bandLogo

        stuff.pictureData = [3, 2, 1, 0, 6, 5, 4, 0]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v4) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        let other = ID3v2AttachedPicture(fromData: data, version: ID3v2Version.v4)

        XCTAssert(!other.isEmpty)

        XCTAssert(other.textEncoding == ID3v2TextEncoding.utf16)

        XCTAssert(other.description == stuff.description)

        XCTAssert(other.imageFormat == stuff.imageFormat)
        XCTAssert(other.pictureType == stuff.pictureType)

        XCTAssert(other.pictureData == stuff.pictureData)
    }

    func testVersion4CaseD() {
        let stuff = ID3v2AttachedPicture()

        stuff.textEncoding = ID3v2TextEncoding.utf16BE

        stuff.description = ""

        stuff.imageFormat = ID3v2AttachedPicture.ImageFormat.link
        stuff.pictureType = ID3v2AttachedPicture.PictureType.fileIcon

        stuff.pictureData = ID3v2TextEncoding.latin1.encode("http://bla-bla-bla.com", termination: false)

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v4) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        let other = ID3v2AttachedPicture(fromData: data, version: ID3v2Version.v4)

        XCTAssert(!other.isEmpty)

        XCTAssert(other.textEncoding == stuff.textEncoding)

        XCTAssert(other.description == stuff.description)

        XCTAssert(other.imageFormat == stuff.imageFormat)
        XCTAssert(other.pictureType == stuff.pictureType)

        XCTAssert(other.pictureData == stuff.pictureData)
    }

    func testVersion4CaseE() {
        let stuff = ID3v2AttachedPicture()

        stuff.textEncoding = ID3v2TextEncoding.utf8

        stuff.description = "Abc 123"

        stuff.imageFormat = ID3v2AttachedPicture.ImageFormat.other(mimeType: "image/bmp")
        stuff.pictureType = ID3v2AttachedPicture.PictureType.illustration

        stuff.pictureData = [0, 1, 2, 3, 0, 4, 5, 6]

        XCTAssert(!stuff.isEmpty)

        guard let data = stuff.toData(version: ID3v2Version.v4) else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        let other = ID3v2AttachedPicture(fromData: data, version: ID3v2Version.v4)

        XCTAssert(!other.isEmpty)

        XCTAssert(other.textEncoding == stuff.textEncoding)

        XCTAssert(other.description == stuff.description)

        XCTAssert(other.imageFormat == stuff.imageFormat)
        XCTAssert(other.pictureType == stuff.pictureType)

        XCTAssert(other.pictureData == stuff.pictureData)
    }

    func testVersion4CaseF() {
        let stuff = ID3v2AttachedPicture()

        stuff.textEncoding = ID3v2TextEncoding.utf16

        stuff.description = "Abc 123"

        stuff.imageFormat = ID3v2AttachedPicture.ImageFormat.jpg
        stuff.pictureType = ID3v2AttachedPicture.PictureType.artist

        stuff.pictureData = []

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.toData(version: ID3v2Version.v4) == nil)
    }

    func testVersion4CaseG() {
        let stuff = ID3v2AttachedPicture(fromData: [], version: ID3v2Version.v4)

        XCTAssert(stuff.isEmpty)

        XCTAssert(stuff.textEncoding == ID3v2TextEncoding.utf8)

        XCTAssert(stuff.description == "")

        XCTAssert(stuff.imageFormat == ID3v2AttachedPicture.ImageFormat.other(mimeType: "application/octet-stream"))
        XCTAssert(stuff.pictureType == ID3v2AttachedPicture.PictureType.other)

        XCTAssert(stuff.pictureData == [])

        XCTAssert(stuff.toData(version: ID3v2Version.v4) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v2) == nil)
        XCTAssert(stuff.toData(version: ID3v2Version.v3) == nil)
    }
}
