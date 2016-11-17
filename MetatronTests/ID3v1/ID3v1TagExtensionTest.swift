//
//  ID3v1TagExtensionTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 11.09.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class ID3v1TagExtensionTest: XCTestCase {

    // MARK: Instance Methods

    func testSupports() {
        let tag = ID3v1Tag()

        XCTAssert(tag.identifier == "ID3v1Tag")

        XCTAssert(tag.supportsTitle == true)
        XCTAssert(tag.supportsArtists == true)

        XCTAssert(tag.supportsAlbum == true)
        XCTAssert(tag.supportsGenres == true)

        XCTAssert(tag.supportsReleaseDate == true)

        XCTAssert(tag.supportsTrackNumber == true)
        XCTAssert(tag.supportsDiscNumber == false)

        XCTAssert(tag.supportsCopyrights == false)
        XCTAssert(tag.supportsComments == true)

        XCTAssert(tag.supportsLyrics == false)
    }
}
