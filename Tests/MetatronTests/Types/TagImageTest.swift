//
//  TagImageTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 15.09.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
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
