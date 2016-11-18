//
//  ID3v2UnsynchronisationTest.swift
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

class ID3v2UnsynchronisationTest: XCTestCase {

    // MARK: Instance Methods

    func testUInt14() {
        for i: UInt16 in 0..<16384 {
            let data = ID3v2Unsynchronisation.dataFromUInt14(i)

            XCTAssert(ID3v2Unsynchronisation.uint14FromData(data) == i)
        }
    }

    func testUInt28() {
        for i: UInt32 in 0..<16384 {
            let data = ID3v2Unsynchronisation.dataFromUInt28(i)

            XCTAssert(ID3v2Unsynchronisation.uint28FromData(data) == i)
        }
    }

    func testUInt56() {
        for i: UInt64 in 0..<16384 {
            let data = ID3v2Unsynchronisation.dataFromUInt56(i)

            XCTAssert(ID3v2Unsynchronisation.uint56FromData(data) == i)
        }
    }

    func testCaseA() {
        var data: [UInt8] = [255]

        for i in 0..<16384 {
            data.append(UInt8(i % 256))
        }

        let encoded = ID3v2Unsynchronisation.encode(data)

        XCTAssert(encoded.count > data.count)

        let decoded = ID3v2Unsynchronisation.decode(encoded)

        XCTAssert(decoded == data)
    }

    func testCaseB() {
        for i: UInt8 in 0...255 {
            for j: UInt8 in 0...255 {
                let encoded1 = ID3v2Unsynchronisation.encode([i, j, 0, 0])
                var encoded2 = ID3v2Unsynchronisation.encode([i, j])

                encoded2.append(contentsOf: [0, 0])

                guard encoded1 == encoded2 else {
                    return XCTFail()
                }
            }
        }
    }

    func testCaseC() {
        var data: [UInt8] = [255]

        for _ in 0..<16384 {
            data.append(UInt8(arc4random_uniform(256)))
        }

        let encoded = ID3v2Unsynchronisation.encode(data)

        XCTAssert(encoded.count > data.count)

        let decoded = ID3v2Unsynchronisation.decode(encoded)

        XCTAssert(decoded == data)
    }

    func testCaseD() {
        XCTAssert(ID3v2Unsynchronisation.encode([]) == [])
        XCTAssert(ID3v2Unsynchronisation.decode([]) == [])
    }
}
