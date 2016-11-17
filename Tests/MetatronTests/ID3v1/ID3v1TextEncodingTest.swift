//
//  ID3v1TextEncodingTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 26.08.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class ID3v1TextEncodingTest: XCTestCase {

    // MARK: Instance Methods

    func testLatin1() {
        let textEncoding = ID3v1Latin1TextEncoding()

        do {
            let text = "Abc 123"

            let data = textEncoding.encode(text)

            XCTAssert(!data.isEmpty)

            guard let other = textEncoding.decode(data) else {
                return XCTFail()
            }

            XCTAssert(other == text)
        }

        do {
            let text = "Абв 123"

            let data = textEncoding.encode(text)

            XCTAssert(!data.isEmpty)

            guard let other = textEncoding.decode(data) else {
                return XCTFail()
            }

            XCTAssert(other != text)
        }

        do {
            let text = "<>,./?!@#$%^&*() _-+={}[];:\"\'\\|"

            let data = textEncoding.encode(text)

            XCTAssert(!data.isEmpty)

            guard let other = textEncoding.decode(data) else {
                return XCTFail()
            }

            XCTAssert(other == text)
        }

    }
}
