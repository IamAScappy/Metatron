//
//  ID3v2TagExtensionTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 11.10.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class ID3v2TagExtensionTest: XCTestCase {

    // MARK: Instance Methods

    func testSupports() {
        let tag = ID3v2Tag()

        XCTAssert(tag.identifier == "ID3v2Tag")

        XCTAssert(tag.supportsTitle == true)
        XCTAssert(tag.supportsArtists == true)

        XCTAssert(tag.supportsAlbum == true)
        XCTAssert(tag.supportsGenres == true)

        XCTAssert(tag.supportsReleaseDate == true)

        XCTAssert(tag.supportsTrackNumber == true)
        XCTAssert(tag.supportsDiscNumber == true)

        XCTAssert(tag.supportsCoverArt == true)

        XCTAssert(tag.supportsCopyrights == true)
        XCTAssert(tag.supportsComments == true)

        XCTAssert(tag.supportsLyrics == true)
    }
}
