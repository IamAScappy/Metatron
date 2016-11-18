//
//  ID3v2LanguageTest.swift
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
