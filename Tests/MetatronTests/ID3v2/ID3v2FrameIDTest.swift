//
//  ID3v2FrameIDTest.swift
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

class ID3v2FrameIDTest: XCTestCase {

    // MARK: Instance Methods

    func testCheckSignature() {
        XCTAssert(ID3v2FrameID.checkSignature([1, 2, 3], version: ID3v2Version.v2) == false)
        XCTAssert(ID3v2FrameID.checkSignature([1, 2, 3], version: ID3v2Version.v3) == false)
        XCTAssert(ID3v2FrameID.checkSignature([1, 2, 3], version: ID3v2Version.v4) == false)

        XCTAssert(ID3v2FrameID.checkSignature([1, 2, 3, 4], version: ID3v2Version.v2) == false)
        XCTAssert(ID3v2FrameID.checkSignature([1, 2, 3, 4], version: ID3v2Version.v3) == false)
        XCTAssert(ID3v2FrameID.checkSignature([1, 2, 3, 4], version: ID3v2Version.v4) == false)

        XCTAssert(ID3v2FrameID.checkSignature([65, 66, 67], version: ID3v2Version.v2) == true)
        XCTAssert(ID3v2FrameID.checkSignature([65, 66, 67], version: ID3v2Version.v3) == false)
        XCTAssert(ID3v2FrameID.checkSignature([65, 66, 67], version: ID3v2Version.v4) == false)

        XCTAssert(ID3v2FrameID.checkSignature([65, 66, 67, 68], version: ID3v2Version.v2) == false)
        XCTAssert(ID3v2FrameID.checkSignature([65, 66, 67, 68], version: ID3v2Version.v3) == true)
        XCTAssert(ID3v2FrameID.checkSignature([65, 66, 67, 68], version: ID3v2Version.v4) == true)
    }

    func testHashable() {
        do {
            let nativeID1 = ID3v2FrameID.aenc
            let nativeID2 = ID3v2FrameID.aenc

            XCTAssert((nativeID1 == nativeID2) && (nativeID1.hashValue == nativeID2.hashValue))
        }

        do {
            let nativeID1 = ID3v2FrameID.aenc
            let nativeID2 = ID3v2FrameID.apic

            XCTAssert(nativeID1 != nativeID2)
        }

        do {
            let nativeID = ID3v2FrameID.comm

            guard let customID = ID3v2FrameID(customID: "Custom COMM", signatures: [ID3v2Version.v2: [67, 79, 77],
                                                                                    ID3v2Version.v3: [67, 79, 77, 77],
                                                                                    ID3v2Version.v4: [67, 79, 77, 77]]) else {
                return XCTFail()
            }

            XCTAssert((nativeID == customID) && (nativeID.hashValue == customID.hashValue))
        }

        do {
            let nativeID = ID3v2FrameID.comm

            guard let customID = ID3v2FrameID(customID: "Custom ETCO", signatures: [ID3v2Version.v2: [69, 84, 67],
                                                                                    ID3v2Version.v3: [69, 84, 67, 79],
                                                                                    ID3v2Version.v4: [69, 84, 67, 79]]) else {
                return XCTFail()
            }

            XCTAssert(nativeID != customID)
        }

        do {
            guard let customID1 = ID3v2FrameID(customID: "Custom GEOB1", signatures: [ID3v2Version.v2: [71, 69, 79],
                                                                                      ID3v2Version.v3: [71, 69, 79, 66],
                                                                                      ID3v2Version.v4: [71, 69, 79, 66]]) else {
                return XCTFail()
            }

            guard let customID2 = ID3v2FrameID(customID: "Custom GEOB2", signatures: [ID3v2Version.v2: [71, 69, 79],
                                                                                      ID3v2Version.v3: [71, 69, 79, 66],
                                                                                      ID3v2Version.v4: [71, 69, 79, 66]]) else {
                return XCTFail()
            }

            XCTAssert((customID1 == customID2) && (customID1.hashValue == customID2.hashValue))
        }

        do {
            guard let customID1 = ID3v2FrameID(customID: "Custom GEOB", signatures: [ID3v2Version.v2: [71, 69, 79],
                                                                                     ID3v2Version.v3: [71, 69, 79, 66],
                                                                                     ID3v2Version.v4: [71, 69, 79, 66]]) else {
                return XCTFail()
            }

            guard let customID2 = ID3v2FrameID(customID: "Custom LINK", signatures: [ID3v2Version.v2: [76, 78, 75],
                                                                                     ID3v2Version.v3: [76, 73, 78, 75],
                                                                                     ID3v2Version.v4: [76, 73, 78, 75]]) else {
                return XCTFail()
            }

            XCTAssert(customID1 != customID2)
        }
    }
}
