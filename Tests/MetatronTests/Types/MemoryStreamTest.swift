//
//  MemoryStreamTest.swift
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

class MemoryStreamTest: XCTestCase {

    // MARK: Instance Methods

    func testInit() {
        do {
            let stream = MemoryStream()

            XCTAssert(stream.data == [])

            XCTAssert(stream.isOpen == false)

            XCTAssert(stream.isReadable == false)
            XCTAssert(stream.isWritable == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            let stream = MemoryStream(data: [])

            XCTAssert(stream.data == [])

            XCTAssert(stream.isOpen == false)

            XCTAssert(stream.isReadable == false)
            XCTAssert(stream.isWritable == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            XCTAssert(stream.data == [1, 2, 3])

            XCTAssert(stream.isOpen == false)

            XCTAssert(stream.isReadable == false)
            XCTAssert(stream.isWritable == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 3)
        }
    }

    // MARK:

    func testOpenForReading() {
        do {
            let stream = MemoryStream()

            XCTAssert(stream.openForReading() == true)
            XCTAssert(stream.openForReading() == false)

            XCTAssert(stream.data == [])

            XCTAssert(stream.isOpen == true)

            XCTAssert(stream.isReadable == true)
            XCTAssert(stream.isWritable == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            let stream = MemoryStream(data: [])

            XCTAssert(stream.openForReading() == true)
            XCTAssert(stream.openForReading() == false)

            XCTAssert(stream.data == [])

            XCTAssert(stream.isOpen == true)

            XCTAssert(stream.isReadable == true)
            XCTAssert(stream.isWritable == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            XCTAssert(stream.openForReading() == true)
            XCTAssert(stream.openForReading() == false)

            XCTAssert(stream.data == [1, 2, 3])

            XCTAssert(stream.isOpen == true)

            XCTAssert(stream.isReadable == true)
            XCTAssert(stream.isWritable == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 3)
        }
    }

    func testOpenForUpdating() {
        do {
            let stream = MemoryStream()

            XCTAssert(stream.openForUpdating(truncate: false) == true)
            XCTAssert(stream.openForUpdating(truncate: false) == false)

            XCTAssert(stream.data == [])

            XCTAssert(stream.isOpen == true)

            XCTAssert(stream.isReadable == true)
            XCTAssert(stream.isWritable == true)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            let stream = MemoryStream()

            XCTAssert(stream.openForUpdating(truncate: true) == true)
            XCTAssert(stream.openForUpdating(truncate: true) == false)

            XCTAssert(stream.data == [])

            XCTAssert(stream.isOpen == true)

            XCTAssert(stream.isReadable == true)
            XCTAssert(stream.isWritable == true)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            let stream = MemoryStream(data: [])

            XCTAssert(stream.openForUpdating(truncate: false) == true)
            XCTAssert(stream.openForUpdating(truncate: false) == false)

            XCTAssert(stream.data == [])

            XCTAssert(stream.isOpen == true)

            XCTAssert(stream.isReadable == true)
            XCTAssert(stream.isWritable == true)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            let stream = MemoryStream(data: [])

            XCTAssert(stream.openForUpdating(truncate: true) == true)
            XCTAssert(stream.openForUpdating(truncate: true) == false)

            XCTAssert(stream.data == [])

            XCTAssert(stream.isOpen == true)

            XCTAssert(stream.isReadable == true)
            XCTAssert(stream.isWritable == true)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            XCTAssert(stream.openForUpdating(truncate: false) == true)
            XCTAssert(stream.openForUpdating(truncate: false) == false)

            XCTAssert(stream.data == [1, 2, 3])

            XCTAssert(stream.isOpen == true)

            XCTAssert(stream.isReadable == true)
            XCTAssert(stream.isWritable == true)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 3)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            XCTAssert(stream.openForUpdating(truncate: true) == true)
            XCTAssert(stream.openForUpdating(truncate: true) == false)

            XCTAssert(stream.data == [])

            XCTAssert(stream.isOpen == true)

            XCTAssert(stream.isReadable == true)
            XCTAssert(stream.isWritable == true)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }
    }

    func testOpenForWriting() {
        do {
            let stream = MemoryStream()

            XCTAssert(stream.openForWriting(truncate: false) == true)
            XCTAssert(stream.openForWriting(truncate: false) == false)

            XCTAssert(stream.data == [])

            XCTAssert(stream.isOpen == true)

            XCTAssert(stream.isReadable == false)
            XCTAssert(stream.isWritable == true)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            let stream = MemoryStream()

            XCTAssert(stream.openForWriting(truncate: true) == true)
            XCTAssert(stream.openForWriting(truncate: true) == false)

            XCTAssert(stream.data == [])

            XCTAssert(stream.isOpen == true)

            XCTAssert(stream.isReadable == false)
            XCTAssert(stream.isWritable == true)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            let stream = MemoryStream(data: [])

            XCTAssert(stream.openForWriting(truncate: false) == true)
            XCTAssert(stream.openForWriting(truncate: false) == false)

            XCTAssert(stream.data == [])

            XCTAssert(stream.isOpen == true)

            XCTAssert(stream.isReadable == false)
            XCTAssert(stream.isWritable == true)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            let stream = MemoryStream(data: [])

            XCTAssert(stream.openForWriting(truncate: true) == true)
            XCTAssert(stream.openForWriting(truncate: true) == false)

            XCTAssert(stream.data == [])

            XCTAssert(stream.isOpen == true)

            XCTAssert(stream.isReadable == false)
            XCTAssert(stream.isWritable == true)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            XCTAssert(stream.openForWriting(truncate: false) == true)
            XCTAssert(stream.openForWriting(truncate: false) == false)

            XCTAssert(stream.data == [1, 2, 3])

            XCTAssert(stream.isOpen == true)

            XCTAssert(stream.isReadable == false)
            XCTAssert(stream.isWritable == true)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 3)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            XCTAssert(stream.openForWriting(truncate: true) == true)
            XCTAssert(stream.openForWriting(truncate: true) == false)

            XCTAssert(stream.data == [])

            XCTAssert(stream.isOpen == true)

            XCTAssert(stream.isReadable == false)
            XCTAssert(stream.isWritable == true)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }
    }

    func testClose() {
        do {
            let stream = MemoryStream()

            stream.close()

            XCTAssert(stream.data == [])

            XCTAssert(stream.isOpen == false)

            XCTAssert(stream.isReadable == false)
            XCTAssert(stream.isWritable == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            let stream = MemoryStream()

            stream.openForReading()
            stream.close()

            XCTAssert(stream.data == [])

            XCTAssert(stream.isOpen == false)

            XCTAssert(stream.isReadable == false)
            XCTAssert(stream.isWritable == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            let stream = MemoryStream()

            stream.openForWriting(truncate: false)
            stream.close()

            XCTAssert(stream.data == [])

            XCTAssert(stream.isOpen == false)

            XCTAssert(stream.isReadable == false)
            XCTAssert(stream.isWritable == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            let stream = MemoryStream()

            stream.openForWriting(truncate: true)
            stream.close()

            XCTAssert(stream.data == [])

            XCTAssert(stream.isOpen == false)

            XCTAssert(stream.isReadable == false)
            XCTAssert(stream.isWritable == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            let stream = MemoryStream()

            stream.openForUpdating(truncate: true)
            stream.close()

            XCTAssert(stream.data == [])

            XCTAssert(stream.isOpen == false)

            XCTAssert(stream.isReadable == false)
            XCTAssert(stream.isWritable == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            stream.close()

            XCTAssert(stream.data == [1, 2, 3])

            XCTAssert(stream.isOpen == false)

            XCTAssert(stream.isReadable == false)
            XCTAssert(stream.isWritable == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 3)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            stream.openForReading()
            stream.close()

            XCTAssert(stream.data == [1, 2, 3])

            XCTAssert(stream.isOpen == false)

            XCTAssert(stream.isReadable == false)
            XCTAssert(stream.isWritable == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 3)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            stream.openForWriting(truncate: false)
            stream.close()

            XCTAssert(stream.data == [1, 2, 3])

            XCTAssert(stream.isOpen == false)

            XCTAssert(stream.isReadable == false)
            XCTAssert(stream.isWritable == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 3)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            stream.openForWriting(truncate: true)
            stream.close()

            XCTAssert(stream.data == [])

            XCTAssert(stream.isOpen == false)

            XCTAssert(stream.isReadable == false)
            XCTAssert(stream.isWritable == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            stream.openForUpdating(truncate: false)
            stream.close()

            XCTAssert(stream.data == [1, 2, 3])

            XCTAssert(stream.isOpen == false)

            XCTAssert(stream.isReadable == false)
            XCTAssert(stream.isWritable == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 3)
        }
    }

    // MARK:

    func testSeek() {
        do {
            let stream = MemoryStream()

            XCTAssert(stream.seek(offset: 0) == false)
            XCTAssert(stream.seek(offset: 1) == false)

            XCTAssert(stream.offset == 0)
        }

        do {
            let stream = MemoryStream()

            stream.openForReading()

            XCTAssert(stream.seek(offset: 0) == true)
            XCTAssert(stream.seek(offset: 0) == true)

            XCTAssert(stream.offset == 0)
        }

        do {
            let stream = MemoryStream()

            stream.openForReading()

            XCTAssert(stream.seek(offset: 1) == false)
            XCTAssert(stream.seek(offset: 1) == false)

            XCTAssert(stream.offset == 0)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            XCTAssert(stream.seek(offset: 0) == false)
            XCTAssert(stream.seek(offset: 1) == false)
            XCTAssert(stream.seek(offset: 3) == false)
            XCTAssert(stream.seek(offset: 4) == false)

            XCTAssert(stream.offset == 0)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            stream.openForReading()

            XCTAssert(stream.seek(offset: 0) == true)
            XCTAssert(stream.seek(offset: 0) == true)

            XCTAssert(stream.offset == 0)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            stream.openForReading()

            XCTAssert(stream.seek(offset: 1) == true)
            XCTAssert(stream.seek(offset: 1) == true)

            XCTAssert(stream.offset == 1)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            stream.openForReading()

            XCTAssert(stream.seek(offset: 3) == true)
            XCTAssert(stream.seek(offset: 3) == true)

            XCTAssert(stream.offset == 3)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            stream.openForReading()

            XCTAssert(stream.seek(offset: 4) == false)
            XCTAssert(stream.seek(offset: 4) == false)

            XCTAssert(stream.offset == 0)
        }
    }

    func testRead() {
        do {
            let stream = MemoryStream()

            XCTAssert(stream.read(maxLength: -1) == [])
            XCTAssert(stream.read(maxLength: 0) == [])
            XCTAssert(stream.read(maxLength: 1) == [])

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            let stream = MemoryStream()

            stream.openForWriting(truncate: false)

            XCTAssert(stream.read(maxLength: -1) == [])
            XCTAssert(stream.read(maxLength: 0) == [])
            XCTAssert(stream.read(maxLength: 1) == [])

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            let stream = MemoryStream()

            stream.openForReading()

            XCTAssert(stream.read(maxLength: -1) == [])
            XCTAssert(stream.read(maxLength: 0) == [])
            XCTAssert(stream.read(maxLength: 1) == [])

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            XCTAssert(stream.read(maxLength: -1) == [])
            XCTAssert(stream.read(maxLength: 0) == [])
            XCTAssert(stream.read(maxLength: 1) == [])
            XCTAssert(stream.read(maxLength: 3) == [])
            XCTAssert(stream.read(maxLength: 4) == [])

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 3)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            stream.openForWriting(truncate: false)

            XCTAssert(stream.read(maxLength: -1) == [])
            XCTAssert(stream.read(maxLength: 0) == [])
            XCTAssert(stream.read(maxLength: 1) == [])
            XCTAssert(stream.read(maxLength: 3) == [])
            XCTAssert(stream.read(maxLength: 4) == [])

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 3)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            stream.openForReading()

            XCTAssert(stream.read(maxLength: -1) == [])

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 3)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            stream.openForReading()

            XCTAssert(stream.read(maxLength: 0) == [])

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 3)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            stream.openForReading()

            XCTAssert(stream.read(maxLength: 1) == [1])

            XCTAssert(stream.offset == 1)
            XCTAssert(stream.length == 3)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            stream.openForReading()

            XCTAssert(stream.read(maxLength: 3) == [1, 2, 3])

            XCTAssert(stream.offset == 3)
            XCTAssert(stream.length == 3)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            stream.openForReading()

            XCTAssert(stream.read(maxLength: 4) == [1, 2, 3])

            XCTAssert(stream.offset == 3)
            XCTAssert(stream.length == 3)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            stream.openForReading()
            stream.seek(offset: 1)

            XCTAssert(stream.read(maxLength: -1) == [])

            XCTAssert(stream.offset == 1)
            XCTAssert(stream.length == 3)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            stream.openForReading()
            stream.seek(offset: 1)

            XCTAssert(stream.read(maxLength: 0) == [])

            XCTAssert(stream.offset == 1)
            XCTAssert(stream.length == 3)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            stream.openForReading()
            stream.seek(offset: 1)

            XCTAssert(stream.read(maxLength: 1) == [2])

            XCTAssert(stream.offset == 2)
            XCTAssert(stream.length == 3)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            stream.openForReading()
            stream.seek(offset: 1)

            XCTAssert(stream.read(maxLength: 3) == [2, 3])

            XCTAssert(stream.offset == 3)
            XCTAssert(stream.length == 3)
        }
    }

    func testWrite() {
        do {
            let stream = MemoryStream()

            XCTAssert(stream.write(data: []) == 0)
            XCTAssert(stream.write(data: [4]) == 0)
            XCTAssert(stream.write(data: [4, 5, 6]) == 0)

            XCTAssert(stream.data == [])

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            let stream = MemoryStream()

            stream.openForReading()

            XCTAssert(stream.write(data: []) == 0)
            XCTAssert(stream.write(data: [4]) == 0)
            XCTAssert(stream.write(data: [4, 5, 6]) == 0)

            XCTAssert(stream.data == [])

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            let stream = MemoryStream()

            stream.openForWriting(truncate: false)

            XCTAssert(stream.write(data: []) == 0)

            XCTAssert(stream.data == [])

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            let stream = MemoryStream()

            stream.openForWriting(truncate: false)

            XCTAssert(stream.write(data: [4]) == 1)

            XCTAssert(stream.data == [4])

            XCTAssert(stream.offset == 1)
            XCTAssert(stream.length == 1)
        }

        do {
            let stream = MemoryStream()

            stream.openForWriting(truncate: false)

            XCTAssert(stream.write(data: [4, 5, 6]) == 3)

            XCTAssert(stream.data == [4, 5, 6])

            XCTAssert(stream.offset == 3)
            XCTAssert(stream.length == 3)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            XCTAssert(stream.write(data: []) == 0)
            XCTAssert(stream.write(data: [4]) == 0)
            XCTAssert(stream.write(data: [4, 5, 6]) == 0)

            XCTAssert(stream.data == [1, 2, 3])

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 3)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            stream.openForReading()

            XCTAssert(stream.write(data: []) == 0)
            XCTAssert(stream.write(data: [4]) == 0)
            XCTAssert(stream.write(data: [4, 5, 6]) == 0)

            XCTAssert(stream.data == [1, 2, 3])

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 3)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            stream.openForWriting(truncate: false)

            XCTAssert(stream.write(data: []) == 0)

            XCTAssert(stream.data == [1, 2, 3])

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 3)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            stream.openForWriting(truncate: false)

            XCTAssert(stream.write(data: [4]) == 1)

            XCTAssert(stream.data == [4, 2, 3])

            XCTAssert(stream.offset == 1)
            XCTAssert(stream.length == 3)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            stream.openForWriting(truncate: false)

            XCTAssert(stream.write(data: [4, 5, 6]) == 3)

            XCTAssert(stream.data == [4, 5, 6])

            XCTAssert(stream.offset == 3)
            XCTAssert(stream.length == 3)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            stream.openForWriting(truncate: false)
            stream.seek(offset: 2)

            XCTAssert(stream.write(data: []) == 0)

            XCTAssert(stream.data == [1, 2, 3])

            XCTAssert(stream.offset == 2)
            XCTAssert(stream.length == 3)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            stream.openForWriting(truncate: false)
            stream.seek(offset: 2)

            XCTAssert(stream.write(data: [4]) == 1)

            XCTAssert(stream.data == [1, 2, 4])

            XCTAssert(stream.offset == 3)
            XCTAssert(stream.length == 3)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            stream.openForWriting(truncate: false)
            stream.seek(offset: 2)

            XCTAssert(stream.write(data: [4, 5, 6]) == 3)

            XCTAssert(stream.data == [1, 2, 4, 5, 6])

            XCTAssert(stream.offset == 5)
            XCTAssert(stream.length == 5)
        }
    }

    func testTruncate() {
        do {
            let stream = MemoryStream()

            XCTAssert(stream.truncate(length: 0) == false)
            XCTAssert(stream.truncate(length: 1) == false)

            XCTAssert(stream.data == [])

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            let stream = MemoryStream()

            stream.openForReading()

            XCTAssert(stream.truncate(length: 0) == false)
            XCTAssert(stream.truncate(length: 1) == false)

            XCTAssert(stream.data == [])

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            let stream = MemoryStream()

            stream.openForWriting(truncate: false)

            XCTAssert(stream.truncate(length: 0) == false)
            XCTAssert(stream.truncate(length: 1) == false)

            XCTAssert(stream.data == [])

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            XCTAssert(stream.truncate(length: 0) == false)
            XCTAssert(stream.truncate(length: 1) == false)
            XCTAssert(stream.truncate(length: 3) == false)
            XCTAssert(stream.truncate(length: 4) == false)

            XCTAssert(stream.data == [1, 2, 3])

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 3)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            stream.openForReading()

            XCTAssert(stream.truncate(length: 0) == false)
            XCTAssert(stream.truncate(length: 1) == false)
            XCTAssert(stream.truncate(length: 3) == false)
            XCTAssert(stream.truncate(length: 4) == false)

            XCTAssert(stream.data == [1, 2, 3])

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 3)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            stream.openForWriting(truncate: false)

            XCTAssert(stream.truncate(length: 0) == true)
            XCTAssert(stream.truncate(length: 0) == false)

            XCTAssert(stream.data == [])

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            stream.openForWriting(truncate: false)

            XCTAssert(stream.truncate(length: 1) == true)
            XCTAssert(stream.truncate(length: 1) == false)

            XCTAssert(stream.data == [1])

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 1)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            stream.openForWriting(truncate: false)

            XCTAssert(stream.truncate(length: 3) == false)
            XCTAssert(stream.truncate(length: 3) == false)

            XCTAssert(stream.data == [1, 2, 3])

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 3)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            stream.openForWriting(truncate: false)

            XCTAssert(stream.truncate(length: 4) == false)
            XCTAssert(stream.truncate(length: 4) == false)

            XCTAssert(stream.data == [1, 2, 3])

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 3)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            stream.openForWriting(truncate: false)
            stream.seek(offset: 2)

            XCTAssert(stream.truncate(length: 0) == true)
            XCTAssert(stream.truncate(length: 0) == false)

            XCTAssert(stream.data == [])

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            stream.openForWriting(truncate: false)
            stream.seek(offset: 2)

            XCTAssert(stream.truncate(length: 1) == true)
            XCTAssert(stream.truncate(length: 1) == false)

            XCTAssert(stream.data == [1])

            XCTAssert(stream.offset == 1)
            XCTAssert(stream.length == 1)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            stream.openForWriting(truncate: false)
            stream.seek(offset: 2)

            XCTAssert(stream.truncate(length: 3) == false)
            XCTAssert(stream.truncate(length: 3) == false)

            XCTAssert(stream.data == [1, 2, 3])

            XCTAssert(stream.offset == 2)
            XCTAssert(stream.length == 3)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            stream.openForWriting(truncate: false)
            stream.seek(offset: 2)

            XCTAssert(stream.truncate(length: 4) == false)
            XCTAssert(stream.truncate(length: 4) == false)

            XCTAssert(stream.data == [1, 2, 3])

            XCTAssert(stream.offset == 2)
            XCTAssert(stream.length == 3)
        }
    }

    func testInsert() {
        do {
            let stream = MemoryStream()

            XCTAssert(stream.insert(data: []) == false)
            XCTAssert(stream.insert(data: [4]) == false)
            XCTAssert(stream.insert(data: [4, 5, 6]) == false)

            XCTAssert(stream.data == [])

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            let stream = MemoryStream()

            stream.openForReading()

            XCTAssert(stream.insert(data: []) == false)
            XCTAssert(stream.insert(data: [4]) == false)
            XCTAssert(stream.insert(data: [4, 5, 6]) == false)

            XCTAssert(stream.data == [])

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            let stream = MemoryStream()

            stream.openForWriting(truncate: false)

            XCTAssert(stream.insert(data: []) == false)
            XCTAssert(stream.insert(data: [4]) == false)
            XCTAssert(stream.insert(data: [4, 5, 6]) == false)

            XCTAssert(stream.data == [])

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            let stream = MemoryStream()

            stream.openForUpdating(truncate: false)

            XCTAssert(stream.insert(data: []) == true)

            XCTAssert(stream.data == [])

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            let stream = MemoryStream()

            stream.openForUpdating(truncate: false)

            XCTAssert(stream.insert(data: [4]) == true)

            XCTAssert(stream.data == [4])

            XCTAssert(stream.offset == 1)
            XCTAssert(stream.length == 1)
        }

        do {
            let stream = MemoryStream()

            stream.openForUpdating(truncate: false)

            XCTAssert(stream.insert(data: [4, 5, 6]) == true)

            XCTAssert(stream.data == [4, 5, 6])

            XCTAssert(stream.offset == 3)
            XCTAssert(stream.length == 3)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            XCTAssert(stream.insert(data: []) == false)
            XCTAssert(stream.insert(data: [4]) == false)
            XCTAssert(stream.insert(data: [4, 5, 6]) == false)

            XCTAssert(stream.data == [1, 2, 3])

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 3)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            stream.openForReading()

            XCTAssert(stream.insert(data: []) == false)
            XCTAssert(stream.insert(data: [4]) == false)
            XCTAssert(stream.insert(data: [4, 5, 6]) == false)

            XCTAssert(stream.data == [1, 2, 3])

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 3)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            stream.openForWriting(truncate: false)

            XCTAssert(stream.insert(data: []) == false)
            XCTAssert(stream.insert(data: [4]) == false)
            XCTAssert(stream.insert(data: [4, 5, 6]) == false)

            XCTAssert(stream.data == [1, 2, 3])

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 3)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            stream.openForUpdating(truncate: false)

            XCTAssert(stream.insert(data: []) == true)

            XCTAssert(stream.data == [1, 2, 3])

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 3)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            stream.openForUpdating(truncate: false)

            XCTAssert(stream.insert(data: [4]) == true)

            XCTAssert(stream.data == [4, 1, 2, 3])

            XCTAssert(stream.offset == 1)
            XCTAssert(stream.length == 4)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            stream.openForUpdating(truncate: false)

            XCTAssert(stream.insert(data: [4, 5, 6]) == true)

            XCTAssert(stream.data == [4, 5, 6, 1, 2, 3])

            XCTAssert(stream.offset == 3)
            XCTAssert(stream.length == 6)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            stream.openForUpdating(truncate: false)
            stream.seek(offset: 1)

            XCTAssert(stream.insert(data: []) == true)

            XCTAssert(stream.data == [1, 2, 3])

            XCTAssert(stream.offset == 1)
            XCTAssert(stream.length == 3)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            stream.openForUpdating(truncate: false)
            stream.seek(offset: 1)

            XCTAssert(stream.insert(data: [4]) == true)

            XCTAssert(stream.data == [1, 4, 2, 3])

            XCTAssert(stream.offset == 2)
            XCTAssert(stream.length == 4)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            stream.openForUpdating(truncate: false)
            stream.seek(offset: 1)

            XCTAssert(stream.insert(data: [4, 5, 6]) == true)

            XCTAssert(stream.data == [1, 4, 5, 6, 2, 3])

            XCTAssert(stream.offset == 4)
            XCTAssert(stream.length == 6)
        }
    }

    func testRemove() {
        do {
            let stream = MemoryStream()

            XCTAssert(stream.remove(length: 0) == false)
            XCTAssert(stream.remove(length: 1) == false)

            XCTAssert(stream.data == [])

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            let stream = MemoryStream()

            stream.openForReading()

            XCTAssert(stream.remove(length: 0) == false)
            XCTAssert(stream.remove(length: 1) == false)

            XCTAssert(stream.data == [])

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            let stream = MemoryStream()

            stream.openForWriting(truncate: false)

            XCTAssert(stream.remove(length: 0) == false)
            XCTAssert(stream.remove(length: 1) == false)

            XCTAssert(stream.data == [])

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            let stream = MemoryStream()

            stream.openForUpdating(truncate: false)

            XCTAssert(stream.remove(length: 0) == true)
            XCTAssert(stream.remove(length: 0) == true)

            XCTAssert(stream.data == [])

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            let stream = MemoryStream()

            stream.openForUpdating(truncate: false)

            XCTAssert(stream.remove(length: 1) == false)
            XCTAssert(stream.remove(length: 1) == false)

            XCTAssert(stream.data == [])

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            XCTAssert(stream.remove(length: 0) == false)
            XCTAssert(stream.remove(length: 2) == false)
            XCTAssert(stream.remove(length: 3) == false)
            XCTAssert(stream.remove(length: 4) == false)

            XCTAssert(stream.data == [1, 2, 3])

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 3)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            stream.openForReading()

            XCTAssert(stream.remove(length: 0) == false)
            XCTAssert(stream.remove(length: 2) == false)
            XCTAssert(stream.remove(length: 3) == false)
            XCTAssert(stream.remove(length: 4) == false)

            XCTAssert(stream.data == [1, 2, 3])

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 3)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            stream.openForWriting(truncate: false)

            XCTAssert(stream.remove(length: 0) == false)
            XCTAssert(stream.remove(length: 2) == false)
            XCTAssert(stream.remove(length: 3) == false)
            XCTAssert(stream.remove(length: 4) == false)

            XCTAssert(stream.data == [1, 2, 3])

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 3)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            stream.openForUpdating(truncate: false)

            XCTAssert(stream.remove(length: 0) == true)
            XCTAssert(stream.remove(length: 0) == true)

            XCTAssert(stream.data == [1, 2, 3])

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 3)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            stream.openForUpdating(truncate: false)

            XCTAssert(stream.remove(length: 2) == true)
            XCTAssert(stream.remove(length: 2) == false)

            XCTAssert(stream.data == [3])

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 1)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            stream.openForUpdating(truncate: false)

            XCTAssert(stream.remove(length: 3) == true)
            XCTAssert(stream.remove(length: 3) == false)

            XCTAssert(stream.data == [])

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            stream.openForUpdating(truncate: false)

            XCTAssert(stream.remove(length: 4) == false)
            XCTAssert(stream.remove(length: 4) == false)

            XCTAssert(stream.data == [1, 2, 3])

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 3)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            stream.openForUpdating(truncate: false)
            stream.seek(offset: 1)

            XCTAssert(stream.remove(length: 0) == true)
            XCTAssert(stream.remove(length: 0) == true)

            XCTAssert(stream.data == [1, 2, 3])

            XCTAssert(stream.offset == 1)
            XCTAssert(stream.length == 3)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            stream.openForUpdating(truncate: false)
            stream.seek(offset: 1)

            XCTAssert(stream.remove(length: 2) == true)
            XCTAssert(stream.remove(length: 2) == false)

            XCTAssert(stream.data == [1])

            XCTAssert(stream.offset == 1)
            XCTAssert(stream.length == 1)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            stream.openForUpdating(truncate: false)
            stream.seek(offset: 1)

            XCTAssert(stream.remove(length: 3) == false)
            XCTAssert(stream.remove(length: 3) == false)

            XCTAssert(stream.data == [1, 2, 3])

            XCTAssert(stream.offset == 1)
            XCTAssert(stream.length == 3)
        }

        do {
            let stream = MemoryStream(data: [1, 2, 3])

            stream.openForUpdating(truncate: false)
            stream.seek(offset: 1)

            XCTAssert(stream.remove(length: 4) == false)
            XCTAssert(stream.remove(length: 4) == false)

            XCTAssert(stream.data == [1, 2, 3])

            XCTAssert(stream.offset == 1)
            XCTAssert(stream.length == 3)
        }
    }
}
