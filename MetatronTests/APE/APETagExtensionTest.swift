//
//  APETagExtensionTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 11.09.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class APETagExtensionTest: XCTestCase {

    // MARK: Instance Methods

    func testSupports() {
        let tag = APETag()

        XCTAssert(tag.identifier == "APETag")

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
