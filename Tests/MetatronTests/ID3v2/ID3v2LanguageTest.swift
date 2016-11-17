//
//  ID3v2LanguageTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 07.09.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class ID3v2LanguageTest: XCTestCase {

    // MARK: Instance Methods

    func testInit() {
        XCTAssert(ID3v2Language(code: [1, 2, 3]) == nil)
        XCTAssert(ID3v2Language(code: []) == nil)

        XCTAssert(ID3v2Language(code: [65, 66, 67]) != nil)
        XCTAssert(ID3v2Language(code: [97, 98, 99]) != nil)

        XCTAssert(ID3v2Language(code: [65, 66, 67, 68]) == nil)
        XCTAssert(ID3v2Language(code: [65, 66]) == nil)
    }

    func testHashable() {
        do {
            let language1 = ID3v2Language.eng
            let language2 = ID3v2Language.eng

            XCTAssert((language1 == language2) && (language1.hashValue == language2.hashValue))
        }

        do {
            let language1 = ID3v2Language.eng
            let language2 = ID3v2Language.deu

            XCTAssert(language1 != language2)
        }

        do {
            let language1 = ID3v2Language.fra

            guard let language2 = ID3v2Language(code: [102, 114, 97]) else {
                return XCTFail()
            }

            XCTAssert((language1 == language2) && (language1.hashValue == language2.hashValue))
        }

        do {
            let language1 = ID3v2Language.fra

            guard let language2 = ID3v2Language(code: [105, 116, 97]) else {
                return XCTFail()
            }

            XCTAssert(language1 != language2)
        }

        do {
            guard let language1 = ID3v2Language(code: [114, 117, 115]) else {
                return XCTFail()
            }

            guard let language2 = ID3v2Language(code: [114, 117, 115]) else {
                return XCTFail()
            }

            XCTAssert((language1 == language2) && (language1.hashValue == language2.hashValue))
        }

        do {
            guard let language1 = ID3v2Language(code: [114, 117, 115]) else {
                return XCTFail()
            }

            guard let language2 = ID3v2Language(code: [116, 97, 116]) else {
                return XCTFail()
            }

            XCTAssert(language1 != language2)
        }
    }
}
