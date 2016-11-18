//
//  ZLibTest.swift
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

class ZLibTest: XCTestCase {

    // MARK: Instance Methods

    func testCaseA() {
        for level in 1..<10 {
            do {
                guard let compressed = ZLib.deflate([], level: level) else {
                    return XCTFail()
                }

                XCTAssert(compressed == [])

                XCTAssert(ZLib.inflate(compressed) == nil)
            }

            do {
                var data: [UInt8] = []

                for _ in 0..<1234 {
                    if arc4random_uniform(2) > 0 {
                        data.append(UInt8(arc4random_uniform(256)))
                    } else {
                        data.append(0)
                    }
                }

                guard let compressed = ZLib.deflate(data, level: level) else {
                    return XCTFail()
                }

                XCTAssert((!compressed.isEmpty) && (compressed.count < data.count))

                guard let decompressed = ZLib.inflate(compressed) else {
                    return XCTFail()
                }

                XCTAssert(decompressed == data)
            }
        }
    }

    func testCaseB() {
        do {
            guard let compressed = ZLib.deflate([], level: -1) else {
                return XCTFail()
            }

            XCTAssert(compressed == [])

            XCTAssert(ZLib.inflate(compressed) == nil)
        }

        do {
            var data: [UInt8] = []

            for _ in 0..<1234 {
                if arc4random_uniform(2) > 0 {
                    data.append(UInt8(arc4random_uniform(256)))
                } else {
                    data.append(0)
                }
            }

            guard let compressed = ZLib.deflate(data, level: -1) else {
                return XCTFail()
            }

            XCTAssert((!compressed.isEmpty) && (compressed.count < data.count))

            guard let decompressed = ZLib.inflate(compressed) else {
                return XCTFail()
            }

            XCTAssert(decompressed == data)
        }
    }

    func testCaseC() {
        do {
            guard let compressed = ZLib.deflate([], level: 0) else {
                return XCTFail()
            }

            XCTAssert(compressed == [])

            XCTAssert(ZLib.inflate(compressed) == nil)
        }

        do {
            var data: [UInt8] = []

            for _ in 0..<1234 {
                if arc4random_uniform(2) > 0 {
                    data.append(UInt8(arc4random_uniform(256)))
                } else {
                    data.append(0)
                }
            }

            guard let compressed = ZLib.deflate(data, level: 0) else {
                return XCTFail()
            }

            XCTAssert(!compressed.isEmpty)

            guard let decompressed = ZLib.inflate(compressed) else {
                return XCTFail()
            }

            XCTAssert(decompressed == data)
        }
    }
}
