//
//  ID3v2ImageValueTest.swift
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
