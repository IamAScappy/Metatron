//
//  ID3v2UnsynchronisationTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 27.08.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
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
