//
//  ID3v2TextEncodingTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 27.08.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class ID3v2TextEncodingTest: XCTestCase {

    // MARK: Instance Methods

    func testLatin1() {
        let textEncoding = ID3v2TextEncoding.latin1

        XCTAssert(textEncoding.encode("", termination: true) == [0])
        XCTAssert(textEncoding.encode("", termination: false) == [])

        do {
            let text = "Abc 123"

            let data = textEncoding.encode(text, termination: true)

            XCTAssert(!data.isEmpty)

            guard let other = textEncoding.decode(data) else {
                return XCTFail()
            }

            XCTAssert(other.text == text)
            XCTAssert(other.endIndex == data.count)
            XCTAssert(other.terminated == true)
        }

        do {
            let text = "Abc 123"

            let data = textEncoding.encode(text, termination: false)

            XCTAssert(!data.isEmpty)

            guard let other = textEncoding.decode(data) else {
                return XCTFail()
            }

            XCTAssert(other.text == text)
            XCTAssert(other.endIndex == data.count)
            XCTAssert(other.terminated == false)
        }

        do {
            let text = "Абв 123"

            let data = textEncoding.encode(text, termination: true)

            XCTAssert(!data.isEmpty)

            guard let other = textEncoding.decode(data) else {
                return XCTFail()
            }

            XCTAssert(other.text != text)
            XCTAssert(other.endIndex == data.count)
            XCTAssert(other.terminated == true)
        }

        do {
            let text = "Абв 123"

            let data = textEncoding.encode(text, termination: false)

            XCTAssert(!data.isEmpty)

            guard let other = textEncoding.decode(data) else {
                return XCTFail()
            }

            XCTAssert(other.text != text)
            XCTAssert(other.endIndex == data.count)
            XCTAssert(other.terminated == false)
        }

        do {
            let text = "<>,./?!@#$%^&*() _-+={}[];:\"\'\\|"

            let data = textEncoding.encode(text, termination: true)

            XCTAssert(!data.isEmpty)

            guard let other = textEncoding.decode(data) else {
                return XCTFail()
            }

            XCTAssert(other.text == text)
            XCTAssert(other.endIndex == data.count)
            XCTAssert(other.terminated == true)
        }

        do {
            let text = "<>,./?!@#$%^&*() _-+={}[];:\"\'\\|"

            let data = textEncoding.encode(text, termination: false)

            XCTAssert(!data.isEmpty)

            guard let other = textEncoding.decode(data) else {
                return XCTFail()
            }

            XCTAssert(other.text == text)
            XCTAssert(other.endIndex == data.count)
            XCTAssert(other.terminated == false)
        }

        do {
            let text = "Abc 123"

            var data = textEncoding.encode(text, termination: true)

            XCTAssert(!data.isEmpty)

            let dataLength = data.count

            data.append(contentsOf: [1, 2, 3, 4])

            guard let other = textEncoding.decode(data) else {
                return XCTFail()
            }

            XCTAssert(other.text == text)
            XCTAssert(other.endIndex == dataLength)
            XCTAssert(other.terminated == true)
        }

        do {
            let text = "Abc 123"

            var data = textEncoding.encode(text, termination: false)

            XCTAssert(!data.isEmpty)

            data.append(contentsOf: [1, 2, 3, 4])

            guard let other = textEncoding.decode(data) else {
                return XCTFail()
            }

            XCTAssert(other.text != text)
            XCTAssert(other.endIndex == data.count)
            XCTAssert(other.terminated == false)
        }

        do {
            guard let other = textEncoding.decode([]) else {
                return XCTFail()
            }

            XCTAssert(other.text == "")
            XCTAssert(other.endIndex == 0)
            XCTAssert(other.terminated == false)
        }

        do {
            guard let other = textEncoding.decode([0]) else {
                return XCTFail()
            }

            XCTAssert(other.text == "")
            XCTAssert(other.endIndex == 1)
            XCTAssert(other.terminated == true)
        }

        do {
            guard let other = textEncoding.decode([0, 0]) else {
                return XCTFail()
            }

            XCTAssert(other.text == "")
            XCTAssert(other.endIndex == 1)
            XCTAssert(other.terminated == true)
        }
    }

    func testUTF16() {
        let textEncoding = ID3v2TextEncoding.utf16

        XCTAssert(textEncoding.encode("", termination: true) == [254, 255, 0, 0])
        XCTAssert(textEncoding.encode("", termination: false) == [254, 255])

        XCTAssert(textEncoding.decode([0]) == nil)

        do {
            let text = "Abc 123"

            let data = textEncoding.encode(text, termination: true)

            XCTAssert(!data.isEmpty)

            guard let other = textEncoding.decode(data) else {
                return XCTFail()
            }

            XCTAssert(other.text == text)
            XCTAssert(other.endIndex == data.count)
            XCTAssert(other.terminated == true)
        }

        do {
            let text = "Abc 123"

            let data = textEncoding.encode(text, termination: false)

            XCTAssert(!data.isEmpty)

            guard let other = textEncoding.decode(data) else {
                return XCTFail()
            }

            XCTAssert(other.text == text)
            XCTAssert(other.endIndex == data.count)
            XCTAssert(other.terminated == false)
        }

        do {
            let text = "Абв 123"

            let data = textEncoding.encode(text, termination: true)

            XCTAssert(!data.isEmpty)

            guard let other = textEncoding.decode(data) else {
                return XCTFail()
            }

            XCTAssert(other.text == text)
            XCTAssert(other.endIndex == data.count)
            XCTAssert(other.terminated == true)
        }

        do {
            let text = "Абв 123"

            let data = textEncoding.encode(text, termination: false)

            XCTAssert(!data.isEmpty)

            guard let other = textEncoding.decode(data) else {
                return XCTFail()
            }

            XCTAssert(other.text == text)
            XCTAssert(other.endIndex == data.count)
            XCTAssert(other.terminated == false)
        }

        do {
            let text = "<>,./?!@#$%^&*() _-+={}[];:\"\'\\|"

            let data = textEncoding.encode(text, termination: true)

            XCTAssert(!data.isEmpty)

            guard let other = textEncoding.decode(data) else {
                return XCTFail()
            }

            XCTAssert(other.text == text)
            XCTAssert(other.endIndex == data.count)
            XCTAssert(other.terminated == true)
        }

        do {
            let text = "<>,./?!@#$%^&*() _-+={}[];:\"\'\\|"

            let data = textEncoding.encode(text, termination: false)

            XCTAssert(!data.isEmpty)

            guard let other = textEncoding.decode(data) else {
                return XCTFail()
            }

            XCTAssert(other.text == text)
            XCTAssert(other.endIndex == data.count)
            XCTAssert(other.terminated == false)
        }

        do {
            let text = "Abc 123"

            var data = textEncoding.encode(text, termination: true)

            XCTAssert(!data.isEmpty)

            let dataLength = data.count

            data.append(contentsOf: [1, 2, 3, 4])

            guard let other = textEncoding.decode(data) else {
                return XCTFail()
            }

            XCTAssert(other.text == text)
            XCTAssert(other.endIndex == dataLength)
            XCTAssert(other.terminated == true)
        }

        do {
            let text = "Abc 123"

            var data = textEncoding.encode(text, termination: false)

            XCTAssert(!data.isEmpty)

            data.append(contentsOf: [1, 2, 3, 4])

            guard let other = textEncoding.decode(data) else {
                return XCTFail()
            }

            XCTAssert(other.text != text)
            XCTAssert(other.endIndex == data.count)
            XCTAssert(other.terminated == false)
        }

        do {
            guard let other = textEncoding.decode([]) else {
                return XCTFail()
            }

            XCTAssert(other.text == "")
            XCTAssert(other.endIndex == 0)
            XCTAssert(other.terminated == false)
        }

        do {
            guard let other = textEncoding.decode([0, 0]) else {
                return XCTFail()
            }

            XCTAssert(other.text == "")
            XCTAssert(other.endIndex == 2)
            XCTAssert(other.terminated == true)
        }

        do {
            guard let other = textEncoding.decode([0, 0, 0]) else {
                return XCTFail()
            }

            XCTAssert(other.text == "")
            XCTAssert(other.endIndex == 2)
            XCTAssert(other.terminated == true)
        }

        do {
            guard let other = textEncoding.decode([254, 255]) else {
                return XCTFail()
            }

            XCTAssert(other.text == "")
            XCTAssert(other.endIndex == 2)
            XCTAssert(other.terminated == false)
        }

        do {
            guard let other = textEncoding.decode([254, 255, 0]) else {
                return XCTFail()
            }

            XCTAssert(other.text == "")
            XCTAssert(other.endIndex == 3)
            XCTAssert(other.terminated == false)
        }

        do {
            guard let other = textEncoding.decode([254, 255, 0, 0]) else {
                return XCTFail()
            }

            XCTAssert(other.text == "")
            XCTAssert(other.endIndex == 4)
            XCTAssert(other.terminated == true)
        }

        do {
            guard let other = textEncoding.decode([254, 255, 0, 0, 0]) else {
                return XCTFail()
            }

            XCTAssert(other.text == "")
            XCTAssert(other.endIndex == 4)
            XCTAssert(other.terminated == true)
        }
    }

    func testUTF16BE() {
        let textEncoding = ID3v2TextEncoding.utf16BE

        XCTAssert(textEncoding.encode("", termination: true) == [0, 0])
        XCTAssert(textEncoding.encode("", termination: false) == [])

        XCTAssert(textEncoding.decode([0]) == nil)

        do {
            let text = "Abc 123"

            let data = textEncoding.encode(text, termination: true)

            XCTAssert(!data.isEmpty)

            guard let other = textEncoding.decode(data) else {
                return XCTFail()
            }

            XCTAssert(other.text == text)
            XCTAssert(other.endIndex == data.count)
            XCTAssert(other.terminated == true)
        }

        do {
            let text = "Abc 123"

            let data = textEncoding.encode(text, termination: false)

            XCTAssert(!data.isEmpty)

            guard let other = textEncoding.decode(data) else {
                return XCTFail()
            }

            XCTAssert(other.text == text)
            XCTAssert(other.endIndex == data.count)
            XCTAssert(other.terminated == false)
        }

        do {
            let text = "Абв 123"

            let data = textEncoding.encode(text, termination: true)

            XCTAssert(!data.isEmpty)

            guard let other = textEncoding.decode(data) else {
                return XCTFail()
            }

            XCTAssert(other.text == text)
            XCTAssert(other.endIndex == data.count)
            XCTAssert(other.terminated == true)
        }

        do {
            let text = "Абв 123"

            let data = textEncoding.encode(text, termination: false)

            XCTAssert(!data.isEmpty)

            guard let other = textEncoding.decode(data) else {
                return XCTFail()
            }

            XCTAssert(other.text == text)
            XCTAssert(other.endIndex == data.count)
            XCTAssert(other.terminated == false)
        }

        do {
            let text = "<>,./?!@#$%^&*() _-+={}[];:\"\'\\|"

            let data = textEncoding.encode(text, termination: true)

            XCTAssert(!data.isEmpty)

            guard let other = textEncoding.decode(data) else {
                return XCTFail()
            }

            XCTAssert(other.text == text)
            XCTAssert(other.endIndex == data.count)
            XCTAssert(other.terminated == true)
        }

        do {
            let text = "<>,./?!@#$%^&*() _-+={}[];:\"\'\\|"

            let data = textEncoding.encode(text, termination: false)

            XCTAssert(!data.isEmpty)

            guard let other = textEncoding.decode(data) else {
                return XCTFail()
            }

            XCTAssert(other.text == text)
            XCTAssert(other.endIndex == data.count)
            XCTAssert(other.terminated == false)
        }

        do {
            let text = "Abc 123"

            var data = textEncoding.encode(text, termination: true)

            XCTAssert(!data.isEmpty)

            let dataLength = data.count

            data.append(contentsOf: [1, 2, 3, 4])

            guard let other = textEncoding.decode(data) else {
                return XCTFail()
            }

            XCTAssert(other.text == text)
            XCTAssert(other.endIndex == dataLength)
            XCTAssert(other.terminated == true)
        }

        do {
            let text = "Abc 123"

            var data = textEncoding.encode(text, termination: false)

            XCTAssert(!data.isEmpty)

            data.append(contentsOf: [1, 2, 3, 4])

            guard let other = textEncoding.decode(data) else {
                return XCTFail()
            }

            XCTAssert(other.text != text)
            XCTAssert(other.endIndex == data.count)
            XCTAssert(other.terminated == false)
        }

        do {
            guard let other = textEncoding.decode([]) else {
                return XCTFail()
            }

            XCTAssert(other.text == "")
            XCTAssert(other.endIndex == 0)
            XCTAssert(other.terminated == false)
        }

        do {
            guard let other = textEncoding.decode([0, 0]) else {
                return XCTFail()
            }

            XCTAssert(other.text == "")
            XCTAssert(other.endIndex == 2)
            XCTAssert(other.terminated == true)
        }

        do {
            guard let other = textEncoding.decode([0, 0, 0]) else {
                return XCTFail()
            }

            XCTAssert(other.text == "")
            XCTAssert(other.endIndex == 2)
            XCTAssert(other.terminated == true)
        }

        do {
            guard let other = textEncoding.decode([254, 255]) else {
                return XCTFail()
            }

            XCTAssert(other.text == "")
            XCTAssert(other.endIndex == 2)
            XCTAssert(other.terminated == false)
        }

        do {
            guard let other = textEncoding.decode([254, 255, 0]) else {
                return XCTFail()
            }

            XCTAssert(other.text == "")
            XCTAssert(other.endIndex == 3)
            XCTAssert(other.terminated == false)
        }

        do {
            guard let other = textEncoding.decode([254, 255, 0, 0]) else {
                return XCTFail()
            }

            XCTAssert(other.text == "")
            XCTAssert(other.endIndex == 4)
            XCTAssert(other.terminated == true)
        }

        do {
            guard let other = textEncoding.decode([254, 255, 0, 0, 0]) else {
                return XCTFail()
            }

            XCTAssert(other.text == "")
            XCTAssert(other.endIndex == 4)
            XCTAssert(other.terminated == true)
        }

        do {
            guard let other = textEncoding.decode([255, 254]) else {
                return XCTFail()
            }

            XCTAssert(other.text == "")
            XCTAssert(other.endIndex == 2)
            XCTAssert(other.terminated == false)
        }

        do {
            guard let other = textEncoding.decode([255, 254, 0]) else {
                return XCTFail()
            }

            XCTAssert(other.text == "")
            XCTAssert(other.endIndex == 3)
            XCTAssert(other.terminated == false)
        }

        do {
            guard let other = textEncoding.decode([255, 254, 0, 0]) else {
                return XCTFail()
            }

            XCTAssert(other.text == "")
            XCTAssert(other.endIndex == 4)
            XCTAssert(other.terminated == true)
        }

        do {
            guard let other = textEncoding.decode([255, 254, 0, 0, 0]) else {
                return XCTFail()
            }

            XCTAssert(other.text == "")
            XCTAssert(other.endIndex == 4)
            XCTAssert(other.terminated == true)
        }
    }

    func testUTF16LE() {
        let textEncoding = ID3v2TextEncoding.utf16LE

        XCTAssert(textEncoding.encode("", termination: true) == [255, 254, 0, 0])
        XCTAssert(textEncoding.encode("", termination: false) == [255, 254])

        XCTAssert(textEncoding.decode([0]) == nil)

        do {
            let text = "Abc 123"

            let data = textEncoding.encode(text, termination: true)

            XCTAssert(!data.isEmpty)

            guard let other = textEncoding.decode(data) else {
                return XCTFail()
            }

            XCTAssert(other.text == text)
            XCTAssert(other.endIndex == data.count)
            XCTAssert(other.terminated == true)
        }

        do {
            let text = "Abc 123"

            let data = textEncoding.encode(text, termination: false)

            XCTAssert(!data.isEmpty)

            guard let other = textEncoding.decode(data) else {
                return XCTFail()
            }

            XCTAssert(other.text == text)
            XCTAssert(other.endIndex == data.count)
            XCTAssert(other.terminated == false)
        }

        do {
            let text = "Абв 123"

            let data = textEncoding.encode(text, termination: true)

            XCTAssert(!data.isEmpty)

            guard let other = textEncoding.decode(data) else {
                return XCTFail()
            }

            XCTAssert(other.text == text)
            XCTAssert(other.endIndex == data.count)
            XCTAssert(other.terminated == true)
        }

        do {
            let text = "Абв 123"

            let data = textEncoding.encode(text, termination: false)

            XCTAssert(!data.isEmpty)

            guard let other = textEncoding.decode(data) else {
                return XCTFail()
            }

            XCTAssert(other.text == text)
            XCTAssert(other.endIndex == data.count)
            XCTAssert(other.terminated == false)
        }

        do {
            let text = "<>,./?!@#$%^&*() _-+={}[];:\"\'\\|"

            let data = textEncoding.encode(text, termination: true)

            XCTAssert(!data.isEmpty)

            guard let other = textEncoding.decode(data) else {
                return XCTFail()
            }

            XCTAssert(other.text == text)
            XCTAssert(other.endIndex == data.count)
            XCTAssert(other.terminated == true)
        }

        do {
            let text = "<>,./?!@#$%^&*() _-+={}[];:\"\'\\|"

            let data = textEncoding.encode(text, termination: false)

            XCTAssert(!data.isEmpty)

            guard let other = textEncoding.decode(data) else {
                return XCTFail()
            }

            XCTAssert(other.text == text)
            XCTAssert(other.endIndex == data.count)
            XCTAssert(other.terminated == false)
        }

        do {
            let text = "Abc 123"

            var data = textEncoding.encode(text, termination: true)

            XCTAssert(!data.isEmpty)

            let dataLength = data.count

            data.append(contentsOf: [1, 2, 3, 4])

            guard let other = textEncoding.decode(data) else {
                return XCTFail()
            }

            XCTAssert(other.text == text)
            XCTAssert(other.endIndex == dataLength)
            XCTAssert(other.terminated == true)
        }

        do {
            let text = "Abc 123"

            var data = textEncoding.encode(text, termination: false)

            XCTAssert(!data.isEmpty)

            data.append(contentsOf: [1, 2, 3, 4])

            guard let other = textEncoding.decode(data) else {
                return XCTFail()
            }

            XCTAssert(other.text != text)
            XCTAssert(other.endIndex == data.count)
            XCTAssert(other.terminated == false)
        }

        do {
            guard let other = textEncoding.decode([]) else {
                return XCTFail()
            }

            XCTAssert(other.text == "")
            XCTAssert(other.endIndex == 0)
            XCTAssert(other.terminated == false)
        }

        do {
            guard let other = textEncoding.decode([0, 0]) else {
                return XCTFail()
            }

            XCTAssert(other.text == "")
            XCTAssert(other.endIndex == 2)
            XCTAssert(other.terminated == true)
        }

        do {
            guard let other = textEncoding.decode([0, 0, 0]) else {
                return XCTFail()
            }

            XCTAssert(other.text == "")
            XCTAssert(other.endIndex == 2)
            XCTAssert(other.terminated == true)
        }

        do {
            guard let other = textEncoding.decode([254, 255]) else {
                return XCTFail()
            }

            XCTAssert(other.text == "")
            XCTAssert(other.endIndex == 2)
            XCTAssert(other.terminated == false)
        }

        do {
            guard let other = textEncoding.decode([254, 255, 0]) else {
                return XCTFail()
            }

            XCTAssert(other.text == "")
            XCTAssert(other.endIndex == 3)
            XCTAssert(other.terminated == false)
        }

        do {
            guard let other = textEncoding.decode([254, 255, 0, 0]) else {
                return XCTFail()
            }

            XCTAssert(other.text == "")
            XCTAssert(other.endIndex == 4)
            XCTAssert(other.terminated == true)
        }

        do {
            guard let other = textEncoding.decode([254, 255, 0, 0, 0]) else {
                return XCTFail()
            }

            XCTAssert(other.text == "")
            XCTAssert(other.endIndex == 4)
            XCTAssert(other.terminated == true)
        }

        do {
            guard let other = textEncoding.decode([255, 254]) else {
                return XCTFail()
            }

            XCTAssert(other.text == "")
            XCTAssert(other.endIndex == 2)
            XCTAssert(other.terminated == false)
        }

        do {
            guard let other = textEncoding.decode([255, 254, 0]) else {
                return XCTFail()
            }

            XCTAssert(other.text == "")
            XCTAssert(other.endIndex == 3)
            XCTAssert(other.terminated == false)
        }

        do {
            guard let other = textEncoding.decode([255, 254, 0, 0]) else {
                return XCTFail()
            }

            XCTAssert(other.text == "")
            XCTAssert(other.endIndex == 4)
            XCTAssert(other.terminated == true)
        }

        do {
            guard let other = textEncoding.decode([255, 254, 0, 0, 0]) else {
                return XCTFail()
            }

            XCTAssert(other.text == "")
            XCTAssert(other.endIndex == 4)
            XCTAssert(other.terminated == true)
        }
    }

    func testUTF8() {
        let textEncoding = ID3v2TextEncoding.utf8

        XCTAssert(textEncoding.encode("", termination: true) == [0])
        XCTAssert(textEncoding.encode("", termination: false) == [])

        do {
            let text = "Abc 123"

            let data = textEncoding.encode(text, termination: true)

            XCTAssert(!data.isEmpty)

            guard let other = textEncoding.decode(data) else {
                return XCTFail()
            }

            XCTAssert(other.text == text)
            XCTAssert(other.endIndex == data.count)
            XCTAssert(other.terminated == true)
        }

        do {
            let text = "Abc 123"

            let data = textEncoding.encode(text, termination: false)

            XCTAssert(!data.isEmpty)

            guard let other = textEncoding.decode(data) else {
                return XCTFail()
            }

            XCTAssert(other.text == text)
            XCTAssert(other.endIndex == data.count)
            XCTAssert(other.terminated == false)
        }

        do {
            let text = "Абв 123"

            let data = textEncoding.encode(text, termination: true)

            XCTAssert(!data.isEmpty)

            guard let other = textEncoding.decode(data) else {
                return XCTFail()
            }

            XCTAssert(other.text == text)
            XCTAssert(other.endIndex == data.count)
            XCTAssert(other.terminated == true)
        }

        do {
            let text = "Абв 123"

            let data = textEncoding.encode(text, termination: false)

            XCTAssert(!data.isEmpty)

            guard let other = textEncoding.decode(data) else {
                return XCTFail()
            }

            XCTAssert(other.text == text)
            XCTAssert(other.endIndex == data.count)
            XCTAssert(other.terminated == false)
        }

        do {
            let text = "<>,./?!@#$%^&*() _-+={}[];:\"\'\\|"

            let data = textEncoding.encode(text, termination: true)

            XCTAssert(!data.isEmpty)

            guard let other = textEncoding.decode(data) else {
                return XCTFail()
            }

            XCTAssert(other.text == text)
            XCTAssert(other.endIndex == data.count)
            XCTAssert(other.terminated == true)
        }

        do {
            let text = "<>,./?!@#$%^&*() _-+={}[];:\"\'\\|"

            let data = textEncoding.encode(text, termination: false)

            XCTAssert(!data.isEmpty)

            guard let other = textEncoding.decode(data) else {
                return XCTFail()
            }

            XCTAssert(other.text == text)
            XCTAssert(other.endIndex == data.count)
            XCTAssert(other.terminated == false)
        }

        do {
            let text = "Abc 123"

            var data = textEncoding.encode(text, termination: true)

            XCTAssert(!data.isEmpty)

            let dataLength = data.count

            data.append(contentsOf: [1, 2, 3, 4])

            guard let other = textEncoding.decode(data) else {
                return XCTFail()
            }

            XCTAssert(other.text == text)
            XCTAssert(other.endIndex == dataLength)
            XCTAssert(other.terminated == true)
        }

        do {
            let text = "Abc 123"

            var data = textEncoding.encode(text, termination: false)

            XCTAssert(!data.isEmpty)

            data.append(contentsOf: [1, 2, 3, 4])

            guard let other = textEncoding.decode(data) else {
                return XCTFail()
            }

            XCTAssert(other.text != text)
            XCTAssert(other.endIndex == data.count)
            XCTAssert(other.terminated == false)
        }

        do {
            guard let other = textEncoding.decode([]) else {
                return XCTFail()
            }

            XCTAssert(other.text == "")
            XCTAssert(other.endIndex == 0)
            XCTAssert(other.terminated == false)
        }

        do {
            guard let other = textEncoding.decode([0]) else {
                return XCTFail()
            }

            XCTAssert(other.text == "")
            XCTAssert(other.endIndex == 1)
            XCTAssert(other.terminated == true)
        }

        do {
            guard let other = textEncoding.decode([0, 0]) else {
                return XCTFail()
            }

            XCTAssert(other.text == "")
            XCTAssert(other.endIndex == 1)
            XCTAssert(other.terminated == true)
        }
    }
}
