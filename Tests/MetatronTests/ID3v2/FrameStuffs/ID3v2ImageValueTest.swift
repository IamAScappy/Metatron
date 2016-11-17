//
//  ID3v2ImageValueTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 12.10.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class ID3v2ImageValueTest: XCTestCase {

    // MARK: Instance Methods

    func test() {
        let stuff = ID3v2AttachedPicture()

        do {
            stuff.imageValue = TagImage()

            XCTAssert(stuff.imageValue == TagImage())

            XCTAssert(stuff.imageFormat == ID3v2AttachedPicture.ImageFormat(mimeType: "application/octet-stream"))

            XCTAssert(stuff.description == "")
            XCTAssert(stuff.pictureData == [])
        }

        do {
            stuff.imageValue = TagImage(data: [], mainMimeType: "image/jpeg", description: "Abc 123")

            XCTAssert(stuff.imageValue == TagImage())

            XCTAssert(stuff.imageFormat == ID3v2AttachedPicture.ImageFormat(mimeType: "application/octet-stream"))

            XCTAssert(stuff.description == "")
            XCTAssert(stuff.pictureData == [])
        }

        do {
            stuff.imageValue = TagImage(data: [1, 2, 3])

            XCTAssert(stuff.imageValue == TagImage(data: [1, 2, 3]))

            XCTAssert(stuff.imageFormat == ID3v2AttachedPicture.ImageFormat(mimeType: "application/octet-stream"))

            XCTAssert(stuff.description == "")
            XCTAssert(stuff.pictureData == [1, 2, 3])
        }

        do {
            stuff.imageValue = TagImage(data: [1, 2, 3], mainMimeType: "image/jpeg")

            XCTAssert(stuff.imageValue == TagImage(data: [1, 2, 3], mainMimeType: "image/jpeg"))

            XCTAssert(stuff.imageFormat == ID3v2AttachedPicture.ImageFormat.jpg)

            XCTAssert(stuff.description == "")
            XCTAssert(stuff.pictureData == [1, 2, 3])
        }

        do {
            stuff.imageValue = TagImage(data: [1, 2, 3], description: "Abc 123")

            XCTAssert(stuff.imageValue == TagImage(data: [1, 2, 3], description: "Abc 123"))

            XCTAssert(stuff.imageFormat == ID3v2AttachedPicture.ImageFormat(mimeType: "application/octet-stream"))

            XCTAssert(stuff.description == "Abc 123")
            XCTAssert(stuff.pictureData == [1, 2, 3])
        }

        do {
            stuff.imageValue = TagImage(data: [1, 2, 3], description: "Абв 123")

            XCTAssert(stuff.imageValue == TagImage(data: [1, 2, 3], description: "Абв 123"))

            XCTAssert(stuff.imageFormat == ID3v2AttachedPicture.ImageFormat(mimeType: "application/octet-stream"))

            XCTAssert(stuff.description == "Абв 123")
            XCTAssert(stuff.pictureData == [1, 2, 3])
        }

        do {
            stuff.imageValue = TagImage(data: [1, 2, 3], mainMimeType: "image/jpeg", description: "Abc 123")

            XCTAssert(stuff.imageValue == TagImage(data: [1, 2, 3], mainMimeType: "image/jpeg", description: "Abc 123"))

            XCTAssert(stuff.imageFormat == ID3v2AttachedPicture.ImageFormat.jpg)

            XCTAssert(stuff.description == "Abc 123")
            XCTAssert(stuff.pictureData == [1, 2, 3])
        }

        do {
            stuff.imageValue = TagImage(data: [0, 0, 0], mainMimeType: "image/jpeg", description: "Abc 123")

            XCTAssert(stuff.imageValue == TagImage(data: [0, 0, 0], mainMimeType: "image/jpeg", description: "Abc 123"))

            XCTAssert(stuff.imageFormat == ID3v2AttachedPicture.ImageFormat.jpg)

            XCTAssert(stuff.description == "Abc 123")
            XCTAssert(stuff.pictureData == [0, 0, 0])
        }

        do {
            stuff.imageFormat = ID3v2AttachedPicture.ImageFormat(mimeType: "application/octet-stream")

            stuff.description = ""
            stuff.pictureData = []

            XCTAssert(stuff.imageValue == TagImage())
        }

        do {
            stuff.imageFormat = ID3v2AttachedPicture.ImageFormat.jpg

            stuff.description = ""
            stuff.pictureData = []

            XCTAssert(stuff.imageValue == TagImage(data: [], mainMimeType: "image/jpeg"))
        }

        do {
            stuff.imageFormat = ID3v2AttachedPicture.ImageFormat(mimeType: "application/octet-stream")

            stuff.description = "Abc 123"
            stuff.pictureData = []

            XCTAssert(stuff.imageValue == TagImage(data: [], description: "Abc 123"))
        }

        do {
            stuff.imageFormat = ID3v2AttachedPicture.ImageFormat.jpg

            stuff.description = "Abc 123"
            stuff.pictureData = []

            XCTAssert(stuff.imageValue == TagImage(data: [], mainMimeType: "image/jpeg", description: "Abc 123"))
        }

        do {
            stuff.imageFormat = ID3v2AttachedPicture.ImageFormat(mimeType: "application/octet-stream")

            stuff.description = ""
            stuff.pictureData = [1, 2, 3]

            XCTAssert(stuff.imageValue == TagImage(data: [1, 2, 3]))
        }

        do {
            stuff.imageFormat = ID3v2AttachedPicture.ImageFormat.jpg

            stuff.description = ""
            stuff.pictureData = [1, 2, 3]

            XCTAssert(stuff.imageValue == TagImage(data: [1, 2, 3], mainMimeType: "image/jpeg"))
        }

        do {
            stuff.imageFormat = ID3v2AttachedPicture.ImageFormat(mimeType: "application/octet-stream")

            stuff.description = "Abc 123"
            stuff.pictureData = [1, 2, 3]

            XCTAssert(stuff.imageValue == TagImage(data: [1, 2, 3], description: "Abc 123"))
        }

        do {
            stuff.imageFormat = ID3v2AttachedPicture.ImageFormat(mimeType: "application/octet-stream")

            stuff.description = "Абв 123"
            stuff.pictureData = [1, 2, 3]

            XCTAssert(stuff.imageValue == TagImage(data: [1, 2, 3], description: "Абв 123"))
        }

        do {
            stuff.imageFormat = ID3v2AttachedPicture.ImageFormat.jpg

            stuff.description = "Abc 123"
            stuff.pictureData = [1, 2, 3]

            XCTAssert(stuff.imageValue == TagImage(data: [1, 2, 3], mainMimeType: "image/jpeg", description: "Abc 123"))
        }

        do {
            stuff.imageFormat = ID3v2AttachedPicture.ImageFormat.jpg

            stuff.description = "Abc 123"
            stuff.pictureData = [0, 0, 0]

            XCTAssert(stuff.imageValue == TagImage(data: [0, 0, 0], mainMimeType: "image/jpeg", description: "Abc 123"))
        }
    }
}
