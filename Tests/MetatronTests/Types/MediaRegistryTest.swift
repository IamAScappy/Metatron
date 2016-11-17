//
//  MediaRegistryTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 10.11.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class TestMedia: Media {

    // MARK: Instance Properties

    var title: String {
        get {
            return ""
        }

        set {
        }
    }

    var artists: [String] {
        get {
            return []
        }

        set {
        }
    }

    var album: String {
        get {
            return ""
        }

        set {
        }
    }

    var genres: [String] {
        get {
            return []
        }

        set {
        }
    }

    var releaseDate: TagDate {
        get {
            return TagDate()
        }

        set {
        }
    }

    var trackNumber: TagNumber {
        get {
            return TagNumber()
        }

        set {
        }
    }

    var discNumber: TagNumber {
        get {
            return TagNumber()
        }

        set {
        }
    }

    var coverArt: TagImage {
        get {
            return TagImage()
        }

        set {
        }
    }

    var copyrights: [String] {
        get {
            return []
        }

        set {
        }
    }

    var comments: [String] {
        get {
            return []
        }

        set {
        }
    }

    var lyrics: TagLyrics {
        get {
            return TagLyrics()
        }

        set {
        }
    }

    // MARK:

    var duration: Double {
        return 123.0
    }

    var bitRate: Int {
        return 128
    }

    var sampleRate: Int {
        return 44100
    }

    var channels: Int {
        return 2
    }

    // MARK:

    var filePath: String {
        return ""
    }

    var isReadOnly: Bool {
        return true
    }

    // MARK: Initializers

    init(fromStream stream: Metatron.Stream) throws {
        guard stream.length != 0 else {
            throw MediaError.invalidStream
        }
    }

    convenience init(fromFilePath filePath: String, readOnly: Bool) throws {
        guard !filePath.isEmpty else {
            throw MediaError.invalidFile
        }

        let stream = FileStream(filePath: filePath)

        if readOnly {
            guard stream.openForReading() else {
                throw MediaError.invalidStream
            }
        } else {
            guard stream.openForUpdating(truncate: false) else {
                throw MediaError.invalidStream
            }
        }

        try self.init(fromStream: stream)
    }

    convenience init(fromData data: [UInt8], readOnly: Bool) throws {
        guard !data.isEmpty else {
            throw MediaError.invalidFile
        }

        let stream = MemoryStream(data: data)

        if readOnly {
            guard stream.openForReading() else {
                throw MediaError.invalidStream
            }
        } else {
            guard stream.openForUpdating(truncate: false) else {
                throw MediaError.invalidStream
            }
        }

        try self.init(fromStream: stream)
    }

    // MARK: Instance Methods

    @discardableResult
    func save() -> Bool {
        return false
    }
}

class TestMediaFormat: MediaFormat {
    // MARK: Type Properties

    static let regular = TestMediaFormat()

    // MARK: Instance Methods

    func createMedia(fromStream stream: Metatron.Stream) throws -> Media {
        return try TestMedia(fromStream: stream)
    }

    func createMedia(fromFilePath filePath: String, readOnly: Bool) throws -> Media {
        return try TestMedia(fromFilePath: filePath, readOnly: readOnly)
    }

    func createMedia(fromData data: [UInt8], readOnly: Bool) throws -> Media {
        return try TestMedia(fromData: data, readOnly: readOnly)
    }
}

class MediaRegistryTest: XCTestCase {
    // MARK: Instance Methods

    func testRegisterMedia() {
        let registry = MediaRegistry.regular
        let format = TestMediaFormat.regular

        XCTAssert(registry.registerMedia(format: format, fileExtension: "mp3") == false)

        XCTAssert(registry.registerMedia(format: format, fileExtension: "test1") == true)
        XCTAssert(registry.registerMedia(format: format, fileExtension: "test1") == false)

        XCTAssert(registry.registerMedia(format: format, fileExtension: "test2") == true)
        XCTAssert(registry.registerMedia(format: format, fileExtension: "test2") == false)

        XCTAssert(registry.medias["test1"] === format)
        XCTAssert(registry.medias["test2"] === format)
    }

    func testIdentifyFilePath() {
        let registry = MediaRegistry.regular
        let format = TestMediaFormat.regular

        registry.registerMedia(format: format, fileExtension: "test123")

        XCTAssert(registry.identifyFilePath("") == nil)

        XCTAssert(registry.identifyFilePath("file") == nil)
        XCTAssert(registry.identifyFilePath("file.") == nil)

        XCTAssert(registry.identifyFilePath(".test123") == nil)
        XCTAssert(registry.identifyFilePath(".test456") == nil)

        XCTAssert(registry.identifyFilePath("file.test123") === format)
        XCTAssert(registry.identifyFilePath("file.test456") == nil)
    }

    func testCreateMedia() {
        let registry = MediaRegistry.regular
        let format = TestMediaFormat.regular

        registry.registerMedia(format: format, fileExtension: "test123")

        guard let emptyFilePath = Bundle(for: type(of: self)).path(forResource: "empty_file", ofType: "test") else {
            return XCTFail()
        }

        guard let sampleFilePath = Bundle(for: type(of: self)).path(forResource: "sample_file", ofType: "test") else {
            return XCTFail()
        }

        do {
            do {
                let stream = MemoryStream(data: [])

                XCTAssert((try? createMedia(fromStream: stream)) == nil)
            }

            do {
                let stream = MemoryStream(data: [1, 2, 3])

                XCTAssert((try? createMedia(fromStream: stream)) == nil)
            }

            do {
                let stream = MemoryStream(data: [])

                if stream.openForReading() {
                    XCTAssert((try? createMedia(fromStream: stream)) == nil)
                } else {
                    XCTFail()
                }
            }

            do {
                let stream = MemoryStream(data: [1, 2, 3])

                if stream.openForReading() {
                    XCTAssert((try? createMedia(fromStream: stream)) != nil)
                } else {
                    XCTFail()
                }
            }
        }

        do {
            do {
                let stream = FileStream(filePath: emptyFilePath)

                XCTAssert((try? createMedia(fromStream: stream)) == nil)
            }

            do {
                let stream = FileStream(filePath: sampleFilePath)

                XCTAssert((try? createMedia(fromStream: stream)) == nil)
            }

            do {
                let stream = FileStream(filePath: emptyFilePath)

                if stream.openForReading() {
                    XCTAssert((try? createMedia(fromStream: stream)) == nil)
                } else {
                    XCTFail()
                }
            }

            do {
                let stream = FileStream(filePath: sampleFilePath)

                if stream.openForReading() {
                    XCTAssert((try? createMedia(fromStream: stream)) != nil)
                } else {
                    XCTFail()
                }
            }
        }

        do {
            XCTAssert((try? createMedia(fromFilePath: emptyFilePath, readOnly: true)) == nil)
            XCTAssert((try? createMedia(fromFilePath: emptyFilePath, readOnly: false)) == nil)

            XCTAssert((try? createMedia(fromFilePath: sampleFilePath, readOnly: true)) != nil)
            XCTAssert((try? createMedia(fromFilePath: sampleFilePath, readOnly: false)) != nil)
        }

        do {
            XCTAssert((try? createMedia(fromData: [], readOnly: true)) == nil)
            XCTAssert((try? createMedia(fromData: [], readOnly: false)) == nil)

            XCTAssert((try? createMedia(fromData: [1, 2, 3], readOnly: true)) != nil)
            XCTAssert((try? createMedia(fromData: [1, 2, 3], readOnly: false)) != nil)
        }
    }
}
