//
//  TagImageTest.swift
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

class TagImageTest: XCTestCase {

    // MARK: Instance Methods

    func testInit() {
        do {
            let image = TagImage()

            XCTAssert(image.data == [])

            XCTAssert(image.mainMimeType == "")
            XCTAssert(image.description == "")

            XCTAssert(image.mimeType == "application/octet-stream")

            XCTAssert(image.isEmpty == true)
        }

        do {
            let image = TagImage(data: [1, 2, 3])

            XCTAssert(image.data == [1, 2, 3])

            XCTAssert(image.mainMimeType == "")
            XCTAssert(image.description == "")

            XCTAssert(image.mimeType == "application/octet-stream")

            XCTAssert(image.isEmpty == false)
        }

        do {
            let image = TagImage(data: [1, 2, 3], mainMimeType: "image/jpeg")

            XCTAssert(image.data == [1, 2, 3])

            XCTAssert(image.mainMimeType == "image/jpeg")
            XCTAssert(image.description == "")

            XCTAssert(image.mimeType == "image/jpeg")

            XCTAssert(image.isEmpty == false)
        }

        do {
            let image = TagImage(data: [1, 2, 3], description: "Abc 123")

            XCTAssert(image.data == [1, 2, 3])

            XCTAssert(image.mainMimeType == "")
            XCTAssert(image.description == "Abc 123")

            XCTAssert(image.mimeType == "application/octet-stream")

            XCTAssert(image.isEmpty == false)
        }

        do {
            let image = TagImage(data: [1, 2, 3], mainMimeType: "image/jpeg", description: "Abc 123")

            XCTAssert(image.data == [1, 2, 3])

            XCTAssert(image.mainMimeType == "image/jpeg")
            XCTAssert(image.description == "Abc 123")

            XCTAssert(image.mimeType == "image/jpeg")

            XCTAssert(image.isEmpty == false)
        }

        do {
            let image = TagImage(data: [], mainMimeType: "image/jpeg", description: "Abc 123")

            XCTAssert(image.data == [])

            XCTAssert(image.mainMimeType == "image/jpeg")
            XCTAssert(image.description == "Abc 123")

            XCTAssert(image.mimeType == "image/jpeg")

            XCTAssert(image.isEmpty == true)
        }

        do {
            let image = TagImage(data: [255], description: "Abc 123")

            XCTAssert(image.data == [255])

            XCTAssert(image.mainMimeType == "")
            XCTAssert(image.description == "Abc 123")

            XCTAssert(image.mimeType == "image/jpeg")

            XCTAssert(image.isEmpty == false)
        }

        do {
            let image = TagImage(data: [137], description: "Abc 123")

            XCTAssert(image.data == [137])

            XCTAssert(image.mainMimeType == "")
            XCTAssert(image.description == "Abc 123")

            XCTAssert(image.mimeType == "image/png")

            XCTAssert(image.isEmpty == false)
        }
    }

    // MARK:

    func testEquatable() {
        do {
            let image1 = TagImage(data: [1, 2, 3], mainMimeType: "image/jpeg", description: "Abc 123")
            let image2 = TagImage(data: [1, 2, 3], mainMimeType: "image/jpeg", description: "Abc 123")

            XCTAssert(image1 == image2)
        }

        do {
            let image1 = TagImage(data: [1, 2, 3], mainMimeType: "image/jpeg", description: "Abc 123")
            let image2 = TagImage(data: [4, 5, 6], mainMimeType: "image/jpeg", description: "Abc 123")

            XCTAssert(image1 != image2)
        }

        do {
            let image1 = TagImage(data: [1, 2, 3], mainMimeType: "image/jpeg")
            let image2 = TagImage(data: [1, 2, 3], mainMimeType: "image/png")

            XCTAssert(image1 != image2)
        }

        do {
            let image1 = TagImage(data: [1, 2, 3], mainMimeType: "image/jpeg")
            let image2 = TagImage(data: [4, 5, 6], mainMimeType: "image/png")

            XCTAssert(image1 != image2)
        }

        do {
            let image1 = TagImage(data: [1, 2, 3], description: "Abc 123")
            let image2 = TagImage(data: [1, 2, 3], description: "Abc 456")

            XCTAssert(image1 != image2)
        }

        do {
            let image1 = TagImage(data: [1, 2, 3], description: "Abc 123")
            let image2 = TagImage(data: [4, 5, 6], description: "Abc 456")

            XCTAssert(image1 != image2)
        }
    }

    // MARK:

    func testReset() {
        var image = TagImage(data: [1, 2, 3], mainMimeType: "image/jpeg", description: "Abc 123")

        image.reset()

        XCTAssert(image.data == [])

        XCTAssert(image.mainMimeType == "")
        XCTAssert(image.description == "")

        XCTAssert(image.mimeType == "application/octet-stream")

        XCTAssert(image.isEmpty == true)
    }
}
