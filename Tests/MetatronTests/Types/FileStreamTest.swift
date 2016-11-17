//
//  FileStreamTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 06.11.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class FileStreamTest: XCTestCase {

    // MARK: Instance Methods

    func testInit() {
        guard let emptyFilePath = Bundle(for: type(of: self)).path(forResource: "empty_file", ofType: "test") else {
            return XCTFail()
        }

        guard let sampleFilePath = Bundle(for: type(of: self)).path(forResource: "sample_file", ofType: "test") else {
            return XCTFail()
        }

        let newFilePath = FileManager.default.currentDirectoryPath + "/temp_file.test"

        do {
            let stream = FileStream(filePath: emptyFilePath)

            XCTAssert(stream.filePath == emptyFilePath)

            XCTAssert(stream.isOpen == false)

            XCTAssert(stream.isReadable == false)
            XCTAssert(stream.isWritable == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            let stream = FileStream(filePath: sampleFilePath)

            XCTAssert(stream.filePath == sampleFilePath)

            XCTAssert(stream.isOpen == false)

            XCTAssert(stream.isReadable == false)
            XCTAssert(stream.isWritable == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 3)
        }

        do {
            try? FileManager.default.removeItem(atPath: newFilePath)

            let stream = FileStream(filePath: newFilePath)

            XCTAssert(stream.filePath == newFilePath)

            XCTAssert(stream.isOpen == false)

            XCTAssert(stream.isReadable == false)
            XCTAssert(stream.isWritable == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        try? FileManager.default.removeItem(atPath: newFilePath)
    }

    // MARK:

    func testOpenForReading() {
        guard let emptyFilePath = Bundle(for: type(of: self)).path(forResource: "empty_file", ofType: "test") else {
            return XCTFail()
        }

        guard let sampleFilePath = Bundle(for: type(of: self)).path(forResource: "sample_file", ofType: "test") else {
            return XCTFail()
        }

        let newFilePath = FileManager.default.currentDirectoryPath + "/temp_file.test"

        do {
            let stream = FileStream(filePath: emptyFilePath)

            XCTAssert(stream.openForReading() == true)
            XCTAssert(stream.openForReading() == false)

            XCTAssert(stream.filePath == emptyFilePath)

            XCTAssert(stream.isOpen == true)

            XCTAssert(stream.isReadable == true)
            XCTAssert(stream.isWritable == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: sampleFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            XCTAssert(stream.openForReading() == true)
            XCTAssert(stream.openForReading() == false)

            XCTAssert(stream.filePath == newFilePath)

            XCTAssert(stream.isOpen == true)

            XCTAssert(stream.isReadable == true)
            XCTAssert(stream.isWritable == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 3)
        }

        do {
            try? FileManager.default.removeItem(atPath: newFilePath)

            let stream = FileStream(filePath: newFilePath)

            XCTAssert(stream.openForReading() == false)
            XCTAssert(stream.openForReading() == false)

            XCTAssert(stream.filePath == newFilePath)

            XCTAssert(stream.isOpen == false)

            XCTAssert(stream.isReadable == false)
            XCTAssert(stream.isWritable == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        try? FileManager.default.removeItem(atPath: newFilePath)
    }

    func testOpenForUpdating() {
        guard let emptyFilePath = Bundle(for: type(of: self)).path(forResource: "empty_file", ofType: "test") else {
            return XCTFail()
        }

        guard let sampleFilePath = Bundle(for: type(of: self)).path(forResource: "sample_file", ofType: "test") else {
            return XCTFail()
        }

        let newFilePath = FileManager.default.currentDirectoryPath + "/temp_file.test"

        do {
            let stream = FileStream(filePath: emptyFilePath)

            XCTAssert(stream.openForUpdating(truncate: false) == true)
            XCTAssert(stream.openForUpdating(truncate: false) == false)

            XCTAssert(stream.filePath == emptyFilePath)

            XCTAssert(stream.isOpen == true)

            XCTAssert(stream.isReadable == true)
            XCTAssert(stream.isWritable == true)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            let stream = FileStream(filePath: emptyFilePath)

            XCTAssert(stream.openForUpdating(truncate: true) == true)
            XCTAssert(stream.openForUpdating(truncate: true) == false)

            XCTAssert(stream.filePath == emptyFilePath)

            XCTAssert(stream.isOpen == true)

            XCTAssert(stream.isReadable == true)
            XCTAssert(stream.isWritable == true)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: sampleFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            XCTAssert(stream.openForUpdating(truncate: false) == true)
            XCTAssert(stream.openForUpdating(truncate: false) == false)

            XCTAssert(stream.filePath == newFilePath)

            XCTAssert(stream.isOpen == true)

            XCTAssert(stream.isReadable == true)
            XCTAssert(stream.isWritable == true)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 3)
        }

        do {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: sampleFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            XCTAssert(stream.openForUpdating(truncate: true) == true)
            XCTAssert(stream.openForUpdating(truncate: true) == false)

            XCTAssert(stream.filePath == newFilePath)

            XCTAssert(stream.isOpen == true)

            XCTAssert(stream.isReadable == true)
            XCTAssert(stream.isWritable == true)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            try? FileManager.default.removeItem(atPath: newFilePath)

            let stream = FileStream(filePath: newFilePath)

            XCTAssert(stream.openForUpdating(truncate: false) == true)
            XCTAssert(stream.openForUpdating(truncate: false) == false)

            XCTAssert(stream.filePath == newFilePath)

            XCTAssert(stream.isOpen == true)

            XCTAssert(stream.isReadable == true)
            XCTAssert(stream.isWritable == true)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            try? FileManager.default.removeItem(atPath: newFilePath)

            let stream = FileStream(filePath: newFilePath)

            XCTAssert(stream.openForUpdating(truncate: true) == true)
            XCTAssert(stream.openForUpdating(truncate: true) == false)

            XCTAssert(stream.filePath == newFilePath)

            XCTAssert(stream.isOpen == true)

            XCTAssert(stream.isReadable == true)
            XCTAssert(stream.isWritable == true)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        try? FileManager.default.removeItem(atPath: newFilePath)
    }

    func testOpenForWriting() {
        guard let emptyFilePath = Bundle(for: type(of: self)).path(forResource: "empty_file", ofType: "test") else {
            return XCTFail()
        }

        guard let sampleFilePath = Bundle(for: type(of: self)).path(forResource: "sample_file", ofType: "test") else {
            return XCTFail()
        }

        let newFilePath = FileManager.default.currentDirectoryPath + "/temp_file.test"

        do {
            let stream = FileStream(filePath: emptyFilePath)

            XCTAssert(stream.openForWriting(truncate: false) == true)
            XCTAssert(stream.openForWriting(truncate: false) == false)

            XCTAssert(stream.filePath == emptyFilePath)

            XCTAssert(stream.isOpen == true)

            XCTAssert(stream.isReadable == false)
            XCTAssert(stream.isWritable == true)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            let stream = FileStream(filePath: emptyFilePath)

            XCTAssert(stream.openForWriting(truncate: true) == true)
            XCTAssert(stream.openForWriting(truncate: true) == false)

            XCTAssert(stream.filePath == emptyFilePath)

            XCTAssert(stream.isOpen == true)

            XCTAssert(stream.isReadable == false)
            XCTAssert(stream.isWritable == true)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: sampleFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            XCTAssert(stream.openForWriting(truncate: false) == true)
            XCTAssert(stream.openForWriting(truncate: false) == false)

            XCTAssert(stream.filePath == newFilePath)

            XCTAssert(stream.isOpen == true)

            XCTAssert(stream.isReadable == false)
            XCTAssert(stream.isWritable == true)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 3)
        }

        do {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: sampleFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            XCTAssert(stream.openForWriting(truncate: true) == true)
            XCTAssert(stream.openForWriting(truncate: true) == false)

            XCTAssert(stream.filePath == newFilePath)

            XCTAssert(stream.isOpen == true)

            XCTAssert(stream.isReadable == false)
            XCTAssert(stream.isWritable == true)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            try? FileManager.default.removeItem(atPath: newFilePath)

            let stream = FileStream(filePath: newFilePath)

            XCTAssert(stream.openForWriting(truncate: false) == true)
            XCTAssert(stream.openForWriting(truncate: false) == false)

            XCTAssert(stream.filePath == newFilePath)

            XCTAssert(stream.isOpen == true)

            XCTAssert(stream.isReadable == false)
            XCTAssert(stream.isWritable == true)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            try? FileManager.default.removeItem(atPath: newFilePath)

            let stream = FileStream(filePath: newFilePath)

            XCTAssert(stream.openForWriting(truncate: true) == true)
            XCTAssert(stream.openForWriting(truncate: true) == false)

            XCTAssert(stream.filePath == newFilePath)

            XCTAssert(stream.isOpen == true)

            XCTAssert(stream.isReadable == false)
            XCTAssert(stream.isWritable == true)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        try? FileManager.default.removeItem(atPath: newFilePath)
    }

    func testClose() {
        guard let emptyFilePath = Bundle(for: type(of: self)).path(forResource: "empty_file", ofType: "test") else {
            return XCTFail()
        }

        guard let sampleFilePath = Bundle(for: type(of: self)).path(forResource: "sample_file", ofType: "test") else {
            return XCTFail()
        }

        let newFilePath = FileManager.default.currentDirectoryPath + "/temp_file.test"

        do {
            let stream = FileStream(filePath: emptyFilePath)

            stream.close()

            XCTAssert(stream.filePath == emptyFilePath)

            XCTAssert(stream.isOpen == false)

            XCTAssert(stream.isReadable == false)
            XCTAssert(stream.isWritable == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            let stream = FileStream(filePath: emptyFilePath)

            stream.openForReading()
            stream.close()

            XCTAssert(stream.filePath == emptyFilePath)

            XCTAssert(stream.isOpen == false)

            XCTAssert(stream.isReadable == false)
            XCTAssert(stream.isWritable == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            let stream = FileStream(filePath: emptyFilePath)

            stream.openForWriting(truncate: false)
            stream.close()

            XCTAssert(stream.filePath == emptyFilePath)

            XCTAssert(stream.isOpen == false)

            XCTAssert(stream.isReadable == false)
            XCTAssert(stream.isWritable == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            let stream = FileStream(filePath: emptyFilePath)

            stream.openForWriting(truncate: true)
            stream.close()

            XCTAssert(stream.filePath == emptyFilePath)

            XCTAssert(stream.isOpen == false)

            XCTAssert(stream.isReadable == false)
            XCTAssert(stream.isWritable == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            let stream = FileStream(filePath: emptyFilePath)

            stream.openForUpdating(truncate: true)
            stream.close()

            XCTAssert(stream.filePath == emptyFilePath)

            XCTAssert(stream.isOpen == false)

            XCTAssert(stream.isReadable == false)
            XCTAssert(stream.isWritable == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: sampleFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.close()

            XCTAssert(stream.filePath == newFilePath)

            XCTAssert(stream.isOpen == false)

            XCTAssert(stream.isReadable == false)
            XCTAssert(stream.isWritable == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 3)
        }

        do {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: sampleFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.openForReading()
            stream.close()

            XCTAssert(stream.filePath == newFilePath)

            XCTAssert(stream.isOpen == false)

            XCTAssert(stream.isReadable == false)
            XCTAssert(stream.isWritable == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 3)
        }

        do {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: sampleFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.openForWriting(truncate: false)
            stream.close()

            XCTAssert(stream.filePath == newFilePath)

            XCTAssert(stream.isOpen == false)

            XCTAssert(stream.isReadable == false)
            XCTAssert(stream.isWritable == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 3)
        }

        do {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: sampleFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.openForWriting(truncate: true)
            stream.close()

            XCTAssert(stream.filePath == newFilePath)

            XCTAssert(stream.isOpen == false)

            XCTAssert(stream.isReadable == false)
            XCTAssert(stream.isWritable == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: sampleFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.openForUpdating(truncate: true)
            stream.close()

            XCTAssert(stream.filePath == newFilePath)

            XCTAssert(stream.isOpen == false)

            XCTAssert(stream.isReadable == false)
            XCTAssert(stream.isWritable == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            try? FileManager.default.removeItem(atPath: newFilePath)

            let stream = FileStream(filePath: newFilePath)

            stream.close()

            XCTAssert(stream.filePath == newFilePath)

            XCTAssert(stream.isOpen == false)

            XCTAssert(stream.isReadable == false)
            XCTAssert(stream.isWritable == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            try? FileManager.default.removeItem(atPath: newFilePath)

            let stream = FileStream(filePath: newFilePath)

            stream.openForWriting(truncate: false)
            stream.close()

            XCTAssert(stream.filePath == newFilePath)

            XCTAssert(stream.isOpen == false)

            XCTAssert(stream.isReadable == false)
            XCTAssert(stream.isWritable == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            try? FileManager.default.removeItem(atPath: newFilePath)

            let stream = FileStream(filePath: newFilePath)

            stream.openForWriting(truncate: true)
            stream.close()

            XCTAssert(stream.filePath == newFilePath)

            XCTAssert(stream.isOpen == false)

            XCTAssert(stream.isReadable == false)
            XCTAssert(stream.isWritable == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            try? FileManager.default.removeItem(atPath: newFilePath)

            let stream = FileStream(filePath: newFilePath)

            stream.openForUpdating(truncate: true)
            stream.close()

            XCTAssert(stream.filePath == newFilePath)

            XCTAssert(stream.isOpen == false)

            XCTAssert(stream.isReadable == false)
            XCTAssert(stream.isWritable == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        try? FileManager.default.removeItem(atPath: newFilePath)
    }

    // MARK:

    func testSeek() {
        guard let emptyFilePath = Bundle(for: type(of: self)).path(forResource: "empty_file", ofType: "test") else {
            return XCTFail()
        }

        guard let sampleFilePath = Bundle(for: type(of: self)).path(forResource: "sample_file", ofType: "test") else {
            return XCTFail()
        }

        do {
            let stream = FileStream(filePath: emptyFilePath)

            XCTAssert(stream.seek(offset: 0) == false)
            XCTAssert(stream.seek(offset: 1) == false)

            XCTAssert(stream.offset == 0)
        }

        do {
            let stream = FileStream(filePath: emptyFilePath)

            stream.openForReading()

            XCTAssert(stream.seek(offset: 0) == true)
            XCTAssert(stream.seek(offset: 0) == true)

            XCTAssert(stream.offset == 0)
        }

        do {
            let stream = FileStream(filePath: emptyFilePath)

            stream.openForReading()

            XCTAssert(stream.seek(offset: 1) == false)
            XCTAssert(stream.seek(offset: 1) == false)

            XCTAssert(stream.offset == 0)
        }

        do {
            let stream = FileStream(filePath: sampleFilePath)

            XCTAssert(stream.seek(offset: 0) == false)
            XCTAssert(stream.seek(offset: 1) == false)
            XCTAssert(stream.seek(offset: 3) == false)
            XCTAssert(stream.seek(offset: 4) == false)

            XCTAssert(stream.offset == 0)
        }

        do {
            let stream = FileStream(filePath: sampleFilePath)

            stream.openForReading()

            XCTAssert(stream.seek(offset: 0) == true)
            XCTAssert(stream.seek(offset: 0) == true)

            XCTAssert(stream.offset == 0)
        }

        do {
            let stream = FileStream(filePath: sampleFilePath)

            stream.openForReading()

            XCTAssert(stream.seek(offset: 1) == true)
            XCTAssert(stream.seek(offset: 1) == true)

            XCTAssert(stream.offset == 1)
        }

        do {
            let stream = FileStream(filePath: sampleFilePath)

            stream.openForReading()

            XCTAssert(stream.seek(offset: 3) == true)
            XCTAssert(stream.seek(offset: 3) == true)

            XCTAssert(stream.offset == 3)
        }

        do {
            let stream = FileStream(filePath: sampleFilePath)

            stream.openForReading()

            XCTAssert(stream.seek(offset: 4) == false)
            XCTAssert(stream.seek(offset: 4) == false)

            XCTAssert(stream.offset == 0)
        }
    }

    func testRead() {
        guard let emptyFilePath = Bundle(for: type(of: self)).path(forResource: "empty_file", ofType: "test") else {
            return XCTFail()
        }

        guard let sampleFilePath = Bundle(for: type(of: self)).path(forResource: "sample_file", ofType: "test") else {
            return XCTFail()
        }

        do {
            let stream = FileStream(filePath: emptyFilePath)

            XCTAssert(stream.read(maxLength: -1) == [])
            XCTAssert(stream.read(maxLength: 0) == [])
            XCTAssert(stream.read(maxLength: 1) == [])

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            let stream = FileStream(filePath: emptyFilePath)

            stream.openForWriting(truncate: false)

            XCTAssert(stream.read(maxLength: -1) == [])
            XCTAssert(stream.read(maxLength: 0) == [])
            XCTAssert(stream.read(maxLength: 1) == [])

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            let stream = FileStream(filePath: emptyFilePath)

            stream.openForReading()

            XCTAssert(stream.read(maxLength: -1) == [])
            XCTAssert(stream.read(maxLength: 0) == [])
            XCTAssert(stream.read(maxLength: 1) == [])

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)
        }

        do {
            let stream = FileStream(filePath: sampleFilePath)

            XCTAssert(stream.read(maxLength: -1) == [])
            XCTAssert(stream.read(maxLength: 0) == [])
            XCTAssert(stream.read(maxLength: 1) == [])
            XCTAssert(stream.read(maxLength: 3) == [])
            XCTAssert(stream.read(maxLength: 4) == [])

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 3)
        }

        do {
            let stream = FileStream(filePath: sampleFilePath)

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
            let stream = FileStream(filePath: sampleFilePath)

            stream.openForReading()

            XCTAssert(stream.read(maxLength: -1) == [])

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 3)
        }

        do {
            let stream = FileStream(filePath: sampleFilePath)

            stream.openForReading()

            XCTAssert(stream.read(maxLength: 0) == [])

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 3)
        }

        do {
            let stream = FileStream(filePath: sampleFilePath)

            stream.openForReading()

            XCTAssert(stream.read(maxLength: 1) == [49])

            XCTAssert(stream.offset == 1)
            XCTAssert(stream.length == 3)
        }

        do {
            let stream = FileStream(filePath: sampleFilePath)

            stream.openForReading()

            XCTAssert(stream.read(maxLength: 3) == [49, 50, 51])

            XCTAssert(stream.offset == 3)
            XCTAssert(stream.length == 3)
        }

        do {
            let stream = FileStream(filePath: sampleFilePath)

            stream.openForReading()

            XCTAssert(stream.read(maxLength: 4) == [49, 50, 51])

            XCTAssert(stream.offset == 3)
            XCTAssert(stream.length == 3)
        }

        do {
            let stream = FileStream(filePath: sampleFilePath)

            stream.openForReading()
            stream.seek(offset: 1)

            XCTAssert(stream.read(maxLength: -1) == [])

            XCTAssert(stream.offset == 1)
            XCTAssert(stream.length == 3)
        }

        do {
            let stream = FileStream(filePath: sampleFilePath)

            stream.openForReading()
            stream.seek(offset: 1)

            XCTAssert(stream.read(maxLength: 0) == [])

            XCTAssert(stream.offset == 1)
            XCTAssert(stream.length == 3)
        }

        do {
            let stream = FileStream(filePath: sampleFilePath)

            stream.openForReading()
            stream.seek(offset: 1)

            XCTAssert(stream.read(maxLength: 1) == [50])

            XCTAssert(stream.offset == 2)
            XCTAssert(stream.length == 3)
        }

        do {
            let stream = FileStream(filePath: sampleFilePath)

            stream.openForReading()
            stream.seek(offset: 1)

            XCTAssert(stream.read(maxLength: 3) == [50, 51])

            XCTAssert(stream.offset == 3)
            XCTAssert(stream.length == 3)
        }
    }

    func testWrite() {
        guard let emptyFilePath = Bundle(for: type(of: self)).path(forResource: "empty_file", ofType: "test") else {
            return XCTFail()
        }

        guard let sampleFilePath = Bundle(for: type(of: self)).path(forResource: "sample_file", ofType: "test") else {
            return XCTFail()
        }

        let newFilePath = FileManager.default.currentDirectoryPath + "/temp_file.test"

        do {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: emptyFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            XCTAssert(stream.write(data: []) == 0)
            XCTAssert(stream.write(data: [1]) == 0)
            XCTAssert(stream.write(data: [1, 2, 3]) == 0)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [])
        }

        do {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: emptyFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.openForReading()

            XCTAssert(stream.write(data: []) == 0)
            XCTAssert(stream.write(data: [1]) == 0)
            XCTAssert(stream.write(data: [1, 2, 3]) == 0)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [])
        }

        do {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: emptyFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.openForWriting(truncate: false)

            XCTAssert(stream.write(data: []) == 0)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [])
        }

        do {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: emptyFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.openForWriting(truncate: false)

            XCTAssert(stream.write(data: [1]) == 1)

            XCTAssert(stream.offset == 1)
            XCTAssert(stream.length == 1)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [1])
        }

        do {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: emptyFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.openForWriting(truncate: false)

            XCTAssert(stream.write(data: [1, 2, 3]) == 3)

            XCTAssert(stream.offset == 3)
            XCTAssert(stream.length == 3)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [1, 2, 3])
        }

        do {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: sampleFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            XCTAssert(stream.write(data: []) == 0)
            XCTAssert(stream.write(data: [1]) == 0)
            XCTAssert(stream.write(data: [1, 2, 3]) == 0)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 3)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [49, 50, 51])
        }

        do {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: sampleFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.openForReading()

            XCTAssert(stream.write(data: []) == 0)
            XCTAssert(stream.write(data: [1]) == 0)
            XCTAssert(stream.write(data: [1, 2, 3]) == 0)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 3)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [49, 50, 51])
        }

        do {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: sampleFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.openForWriting(truncate: false)

            XCTAssert(stream.write(data: []) == 0)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 3)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [49, 50, 51])
        }

        do {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: sampleFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.openForWriting(truncate: false)

            XCTAssert(stream.write(data: [1]) == 1)

            XCTAssert(stream.offset == 1)
            XCTAssert(stream.length == 3)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [1, 50, 51])
        }

        do {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: sampleFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.openForWriting(truncate: false)

            XCTAssert(stream.write(data: [1, 2, 3]) == 3)

            XCTAssert(stream.offset == 3)
            XCTAssert(stream.length == 3)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [1, 2, 3])
        }

        do {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: sampleFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.openForWriting(truncate: false)
            stream.seek(offset: 2)

            XCTAssert(stream.write(data: []) == 0)

            XCTAssert(stream.offset == 2)
            XCTAssert(stream.length == 3)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [49, 50, 51])
        }

        do {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: sampleFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.openForWriting(truncate: false)
            stream.seek(offset: 2)

            XCTAssert(stream.write(data: [1]) == 1)

            XCTAssert(stream.offset == 3)
            XCTAssert(stream.length == 3)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [49, 50, 1])
        }

        do {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: sampleFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.openForWriting(truncate: false)
            stream.seek(offset: 2)

            XCTAssert(stream.write(data: [1, 2, 3]) == 3)

            XCTAssert(stream.offset == 5)
            XCTAssert(stream.length == 5)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [49, 50, 1, 2, 3])
        }

        try? FileManager.default.removeItem(atPath: newFilePath)
    }

    func testTruncate() {
        guard let emptyFilePath = Bundle(for: type(of: self)).path(forResource: "empty_file", ofType: "test") else {
            return XCTFail()
        }

        guard let sampleFilePath = Bundle(for: type(of: self)).path(forResource: "sample_file", ofType: "test") else {
            return XCTFail()
        }

        let newFilePath = FileManager.default.currentDirectoryPath + "/temp_file.test"

        do {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: emptyFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            XCTAssert(stream.truncate(length: 0) == false)
            XCTAssert(stream.truncate(length: 1) == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [])
        }

        do {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: emptyFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.openForReading()

            XCTAssert(stream.truncate(length: 0) == false)
            XCTAssert(stream.truncate(length: 1) == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [])
        }

        do {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: emptyFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.openForWriting(truncate: false)

            XCTAssert(stream.truncate(length: 0) == false)
            XCTAssert(stream.truncate(length: 1) == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [])
        }

        do {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: sampleFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            XCTAssert(stream.truncate(length: 0) == false)
            XCTAssert(stream.truncate(length: 1) == false)
            XCTAssert(stream.truncate(length: 3) == false)
            XCTAssert(stream.truncate(length: 4) == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 3)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [49, 50, 51])
        }

        do {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: sampleFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.openForReading()

            XCTAssert(stream.truncate(length: 0) == false)
            XCTAssert(stream.truncate(length: 1) == false)
            XCTAssert(stream.truncate(length: 3) == false)
            XCTAssert(stream.truncate(length: 4) == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 3)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [49, 50, 51])
        }

        do {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: sampleFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.openForWriting(truncate: false)

            XCTAssert(stream.truncate(length: 0) == true)
            XCTAssert(stream.truncate(length: 0) == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [])
        }

        do {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: sampleFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.openForWriting(truncate: false)

            XCTAssert(stream.truncate(length: 1) == true)
            XCTAssert(stream.truncate(length: 1) == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 1)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [49])
        }

        do {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: sampleFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.openForWriting(truncate: false)

            XCTAssert(stream.truncate(length: 3) == false)
            XCTAssert(stream.truncate(length: 3) == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 3)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [49, 50, 51])
        }

        do {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: sampleFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.openForWriting(truncate: false)

            XCTAssert(stream.truncate(length: 4) == false)
            XCTAssert(stream.truncate(length: 4) == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 3)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [49, 50, 51])
        }

        do {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: sampleFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.openForWriting(truncate: false)
            stream.seek(offset: 2)

            XCTAssert(stream.truncate(length: 0) == true)
            XCTAssert(stream.truncate(length: 0) == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [])
        }

        do {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: sampleFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.openForWriting(truncate: false)
            stream.seek(offset: 2)

            XCTAssert(stream.truncate(length: 1) == true)
            XCTAssert(stream.truncate(length: 1) == false)

            XCTAssert(stream.offset == 1)
            XCTAssert(stream.length == 1)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [49])
        }

        do {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: sampleFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.openForWriting(truncate: false)
            stream.seek(offset: 2)

            XCTAssert(stream.truncate(length: 3) == false)
            XCTAssert(stream.truncate(length: 3) == false)

            XCTAssert(stream.offset == 2)
            XCTAssert(stream.length == 3)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [49, 50, 51])
        }

        do {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: sampleFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.openForWriting(truncate: false)
            stream.seek(offset: 2)

            XCTAssert(stream.truncate(length: 4) == false)
            XCTAssert(stream.truncate(length: 4) == false)

            XCTAssert(stream.offset == 2)
            XCTAssert(stream.length == 3)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [49, 50, 51])
        }

        try? FileManager.default.removeItem(atPath: newFilePath)
    }

    func testInsert() {
        guard let emptyFilePath = Bundle(for: type(of: self)).path(forResource: "empty_file", ofType: "test") else {
            return XCTFail()
        }

        guard let sampleFilePath = Bundle(for: type(of: self)).path(forResource: "sample_file", ofType: "test") else {
            return XCTFail()
        }

        let newFilePath = FileManager.default.currentDirectoryPath + "/temp_file.test"

        for i in 1..<8 {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: emptyFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.bufferLength = i

            XCTAssert(stream.insert(data: []) == false)
            XCTAssert(stream.insert(data: [1]) == false)
            XCTAssert(stream.insert(data: [1, 2, 3]) == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [])
        }

        for i in 1..<8 {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: emptyFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.openForReading()
            stream.bufferLength = i

            XCTAssert(stream.insert(data: []) == false)
            XCTAssert(stream.insert(data: [1]) == false)
            XCTAssert(stream.insert(data: [1, 2, 3]) == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [])
        }

        for i in 1..<8 {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: emptyFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.openForWriting(truncate: false)
            stream.bufferLength = i

            XCTAssert(stream.insert(data: []) == false)
            XCTAssert(stream.insert(data: [1]) == false)
            XCTAssert(stream.insert(data: [1, 2, 3]) == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [])
        }

        for i in 1..<8 {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: emptyFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.openForUpdating(truncate: false)
            stream.bufferLength = i

            XCTAssert(stream.insert(data: []) == true)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [])
        }

        for i in 1..<8 {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: emptyFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.openForUpdating(truncate: false)
            stream.bufferLength = i

            XCTAssert(stream.insert(data: [1]) == true)

            XCTAssert(stream.offset == 1)
            XCTAssert(stream.length == 1)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [1])
        }

        for i in 1..<8 {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: emptyFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.openForUpdating(truncate: false)
            stream.bufferLength = i

            XCTAssert(stream.insert(data: [1, 2, 3]) == true)

            XCTAssert(stream.offset == 3)
            XCTAssert(stream.length == 3)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [1, 2, 3])
        }

        for i in 1..<8 {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: sampleFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.bufferLength = i

            XCTAssert(stream.insert(data: []) == false)
            XCTAssert(stream.insert(data: [1]) == false)
            XCTAssert(stream.insert(data: [1, 2, 3]) == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 3)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [49, 50, 51])
        }

        for i in 1..<8 {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: sampleFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.openForReading()
            stream.bufferLength = i

            XCTAssert(stream.insert(data: []) == false)
            XCTAssert(stream.insert(data: [1]) == false)
            XCTAssert(stream.insert(data: [1, 2, 3]) == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 3)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [49, 50, 51])
        }

        for i in 1..<8 {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: sampleFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.openForWriting(truncate: false)
            stream.bufferLength = i

            XCTAssert(stream.insert(data: []) == false)
            XCTAssert(stream.insert(data: [1]) == false)
            XCTAssert(stream.insert(data: [1, 2, 3]) == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 3)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [49, 50, 51])
        }

        for i in 1..<8 {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: sampleFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.openForUpdating(truncate: false)
            stream.bufferLength = i

            XCTAssert(stream.insert(data: []) == true)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 3)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [49, 50, 51])
        }

        for i in 1..<8 {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: sampleFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.openForUpdating(truncate: false)
            stream.bufferLength = i

            XCTAssert(stream.insert(data: [1]) == true)

            XCTAssert(stream.offset == 1)
            XCTAssert(stream.length == 4)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [1, 49, 50, 51])
        }

        for i in 1..<8 {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: sampleFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.openForUpdating(truncate: false)
            stream.bufferLength = i

            XCTAssert(stream.insert(data: [1, 2, 3]) == true)

            XCTAssert(stream.offset == 3)
            XCTAssert(stream.length == 6)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [1, 2, 3, 49, 50, 51])
        }

        for i in 1..<8 {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: sampleFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.openForUpdating(truncate: false)
            stream.bufferLength = i
            stream.seek(offset: 1)

            XCTAssert(stream.insert(data: []) == true)

            XCTAssert(stream.offset == 1)
            XCTAssert(stream.length == 3)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [49, 50, 51])
        }

        for i in 1..<8 {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: sampleFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.openForUpdating(truncate: false)
            stream.bufferLength = i
            stream.seek(offset: 1)

            XCTAssert(stream.insert(data: [1]) == true)

            XCTAssert(stream.offset == 2)
            XCTAssert(stream.length == 4)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [49, 1, 50, 51])
        }

        for i in 1..<8 {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: sampleFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.openForUpdating(truncate: false)
            stream.bufferLength = i
            stream.seek(offset: 1)

            XCTAssert(stream.insert(data: [1, 2, 3]) == true)

            XCTAssert(stream.offset == 4)
            XCTAssert(stream.length == 6)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [49, 1, 2, 3, 50, 51])
        }

        try? FileManager.default.removeItem(atPath: newFilePath)
    }

    func testRemove() {
        guard let emptyFilePath = Bundle(for: type(of: self)).path(forResource: "empty_file", ofType: "test") else {
            return XCTFail()
        }

        guard let sampleFilePath = Bundle(for: type(of: self)).path(forResource: "sample_file", ofType: "test") else {
            return XCTFail()
        }

        let newFilePath = FileManager.default.currentDirectoryPath + "/temp_file.test"

        for i in 1..<8 {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: emptyFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.bufferLength = i

            XCTAssert(stream.remove(length: 0) == false)
            XCTAssert(stream.remove(length: 1) == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [])
        }

        for i in 1..<8 {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: emptyFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.openForReading()
            stream.bufferLength = i

            XCTAssert(stream.remove(length: 0) == false)
            XCTAssert(stream.remove(length: 1) == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [])
        }

        for i in 1..<8 {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: emptyFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.openForWriting(truncate: false)
            stream.bufferLength = i

            XCTAssert(stream.remove(length: 0) == false)
            XCTAssert(stream.remove(length: 1) == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [])
        }

        for i in 1..<8 {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: emptyFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.openForUpdating(truncate: false)
            stream.bufferLength = i

            XCTAssert(stream.remove(length: 0) == true)
            XCTAssert(stream.remove(length: 0) == true)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [])
        }

        for i in 1..<8 {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: emptyFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.openForUpdating(truncate: false)
            stream.bufferLength = i

            XCTAssert(stream.remove(length: 1) == false)
            XCTAssert(stream.remove(length: 1) == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [])
        }

        for i in 1..<8 {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: sampleFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.bufferLength = i

            XCTAssert(stream.remove(length: 0) == false)
            XCTAssert(stream.remove(length: 1) == false)
            XCTAssert(stream.remove(length: 3) == false)
            XCTAssert(stream.remove(length: 4) == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 3)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [49, 50, 51])
        }

        for i in 1..<8 {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: sampleFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.openForReading()
            stream.bufferLength = i

            XCTAssert(stream.remove(length: 0) == false)
            XCTAssert(stream.remove(length: 2) == false)
            XCTAssert(stream.remove(length: 3) == false)
            XCTAssert(stream.remove(length: 4) == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 3)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [49, 50, 51])
        }

        for i in 1..<8 {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: sampleFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.openForWriting(truncate: false)
            stream.bufferLength = i

            XCTAssert(stream.remove(length: 0) == false)
            XCTAssert(stream.remove(length: 2) == false)
            XCTAssert(stream.remove(length: 3) == false)
            XCTAssert(stream.remove(length: 4) == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 3)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [49, 50, 51])
        }

        for i in 1..<8 {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: sampleFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.openForUpdating(truncate: false)
            stream.bufferLength = i

            XCTAssert(stream.remove(length: 0) == true)
            XCTAssert(stream.remove(length: 0) == true)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 3)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [49, 50, 51])
        }

        for i in 1..<8 {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: sampleFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.openForUpdating(truncate: false)
            stream.bufferLength = i

            XCTAssert(stream.remove(length: 2) == true)
            XCTAssert(stream.remove(length: 2) == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 1)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [51])
        }

        for i in 1..<8 {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: sampleFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.openForUpdating(truncate: false)
            stream.bufferLength = i

            XCTAssert(stream.remove(length: 3) == true)
            XCTAssert(stream.remove(length: 3) == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 0)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [])
        }

        for i in 1..<8 {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: sampleFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.openForUpdating(truncate: false)
            stream.bufferLength = i

            XCTAssert(stream.remove(length: 4) == false)
            XCTAssert(stream.remove(length: 4) == false)

            XCTAssert(stream.offset == 0)
            XCTAssert(stream.length == 3)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [49, 50, 51])
        }

        for i in 1..<8 {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: sampleFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.openForUpdating(truncate: false)
            stream.bufferLength = i
            stream.seek(offset: 1)

            XCTAssert(stream.remove(length: 0) == true)
            XCTAssert(stream.remove(length: 0) == true)

            XCTAssert(stream.offset == 1)
            XCTAssert(stream.length == 3)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [49, 50, 51])
        }

        for i in 1..<8 {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: sampleFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.openForUpdating(truncate: false)
            stream.bufferLength = i
            stream.seek(offset: 1)

            XCTAssert(stream.remove(length: 2) == true)
            XCTAssert(stream.remove(length: 2) == false)

            XCTAssert(stream.offset == 1)
            XCTAssert(stream.length == 1)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [49])
        }

        for i in 1..<8 {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: sampleFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.openForUpdating(truncate: false)
            stream.bufferLength = i
            stream.seek(offset: 1)

            XCTAssert(stream.remove(length: 3) == false)
            XCTAssert(stream.remove(length: 3) == false)

            XCTAssert(stream.offset == 1)
            XCTAssert(stream.length == 3)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [49, 50, 51])
        }

        for i in 1..<8 {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: sampleFilePath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            let stream = FileStream(filePath: newFilePath)

            stream.openForUpdating(truncate: false)
            stream.bufferLength = i
            stream.seek(offset: 1)

            XCTAssert(stream.remove(length: 4) == false)
            XCTAssert(stream.remove(length: 4) == false)

            XCTAssert(stream.offset == 1)
            XCTAssert(stream.length == 3)

            stream.synchronize()

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: newFilePath)) else {
                return XCTFail()
            }

            XCTAssert([UInt8](data) == [49, 50, 51])
        }

        try? FileManager.default.removeItem(atPath: newFilePath)
    }
}
