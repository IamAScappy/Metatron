//
//  Lyrics3TagExtensionTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 11.10.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class Lyrics3TagExtensionTest: XCTestCase {

    // MARK: Instance Methods

    func testSupports() {
        let tag = Lyrics3Tag()

        XCTAssert(tag.identifier == "Lyrics3Tag")

        XCTAssert(tag.supportsTitle == true)
        XCTAssert(tag.supportsArtists == true)

        XCTAssert(tag.supportsAlbum == true)
        XCTAssert(tag.supportsGenres == false)

        XCTAssert(tag.supportsReleaseDate == false)

        XCTAssert(tag.supportsTrackNumber == false)
        XCTAssert(tag.supportsDiscNumber == false)

        XCTAssert(tag.supportsCoverArt == false)

        XCTAssert(tag.supportsCopyrights == false)
        XCTAssert(tag.supportsComments == true)

        XCTAssert(tag.supportsLyrics == true)
    }
}
