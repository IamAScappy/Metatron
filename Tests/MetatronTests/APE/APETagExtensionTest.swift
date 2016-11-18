//
//  APETagExtensionTest.swift
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
