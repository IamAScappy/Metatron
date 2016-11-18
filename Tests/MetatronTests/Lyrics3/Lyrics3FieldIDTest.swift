//
//  Lyrics3FieldIDTest.swift
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

class Lyrics3FieldIDTest: XCTestCase {

    // MARK: Instance Methods

    func testCheckSignature() {
        XCTAssert(Lyrics3FieldID.checkSignature([]) == false)

        XCTAssert(Lyrics3FieldID.checkSignature([1]) == false)
        XCTAssert(Lyrics3FieldID.checkSignature([1, 2]) == false)
        XCTAssert(Lyrics3FieldID.checkSignature([1, 2, 3]) == false)
        XCTAssert(Lyrics3FieldID.checkSignature([1, 2, 3, 4]) == false)

        XCTAssert(Lyrics3FieldID.checkSignature([65]) == false)
        XCTAssert(Lyrics3FieldID.checkSignature([65, 66]) == false)
        XCTAssert(Lyrics3FieldID.checkSignature([65, 66, 67]) == true)
        XCTAssert(Lyrics3FieldID.checkSignature([65, 66, 67, 68]) == false)
    }

    func testHashable() {
        do {
            let nativeID1 = Lyrics3FieldID.ind
            let nativeID2 = Lyrics3FieldID.ind

            XCTAssert((nativeID1 == nativeID2) && (nativeID1.hashValue == nativeID2.hashValue))
        }

        do {
            let nativeID1 = Lyrics3FieldID.ind
            let nativeID2 = Lyrics3FieldID.lyr

            XCTAssert(nativeID1 != nativeID2)
        }

        do {
            let nativeID = Lyrics3FieldID.inf

            guard let customID = Lyrics3FieldID(customID: "Custom INF", signature: [73, 78, 70]) else {
                return XCTFail()
            }

            XCTAssert((nativeID == customID) && (nativeID.hashValue == customID.hashValue))
        }

        do {
            let nativeID = Lyrics3FieldID.inf

            guard let customID = Lyrics3FieldID(customID: "Custom AUT", signature: [65, 85, 84]) else {
                return XCTFail()
            }

            XCTAssert(nativeID != customID)
        }

        do {
            guard let customID1 = Lyrics3FieldID(customID: "Custom EAL1", signature: [69, 65, 76]) else {
                return XCTFail()
            }

            guard let customID2 = Lyrics3FieldID(customID: "Custom EAL2", signature: [69, 65, 76]) else {
                return XCTFail()
            }

            XCTAssert((customID1 == customID2) && (customID1.hashValue == customID2.hashValue))
        }

        do {
            guard let customID1 = Lyrics3FieldID(customID: "Custom EAL", signature: [69, 65, 76]) else {
                return XCTFail()
            }

            guard let customID2 = Lyrics3FieldID(customID: "Custom EAR", signature: [69, 65, 82]) else {
                return XCTFail()
            }

            XCTAssert(customID1 != customID2)
        }
    }
}
