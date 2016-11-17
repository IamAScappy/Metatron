//
//  ZLibTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 03.10.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
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
