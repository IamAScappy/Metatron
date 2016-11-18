//
//  ID3v1TagTest.swift
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

extension ID3v1Tag {

    // MARK: Initializers

    fileprivate convenience init?(fromData data: [UInt8], range: inout Range<UInt64>) {
        let stream = MemoryStream(data: data)

        guard stream.openForReading() else {
            return nil
        }

        self.init(fromStream: stream, range: &range)
    }
}

extension String {

    // MARK: Instance Methods

    func deencoded(with textEncoding: ID3v1TextEncoding) -> String {
        return textEncoding.decode(textEncoding.encode(self)) ?? ""
    }
}

class ID3v1TagTest: XCTestCase {

    // MARK: Instance Methods

    func testClear() {
        let tag = ID3v1Tag()

        XCTAssert(tag.isEmpty)

        tag.title = "Title"
        tag.artists = ["Artist 1", "Artist 2"]

        tag.album = "Album"
        tag.genres = ["Genre 1", "Genre 2", "Genre 3"]

        tag.releaseDate = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: 34, second: 56))

        tag.trackNumber = TagNumber(3, total: 4)

        tag.comments = ["Comment 1", "Comment 2", "Comment 3", "Comment 4"]

        tag.velocity = 3
        tag.startTime = 123
        tag.endTime = 456

        XCTAssert(!tag.isEmpty)

        tag.clear()

        XCTAssert(tag.isEmpty)

        XCTAssert(tag.title == "")
        XCTAssert(tag.artists == [])

        XCTAssert(tag.album == "")
        XCTAssert(tag.genres == [])

        XCTAssert(tag.releaseDate == TagDate())

        XCTAssert(tag.trackNumber == TagNumber())

        XCTAssert(tag.comments == [])

        XCTAssert(tag.velocity == 0)
        XCTAssert(tag.startTime == 0)
        XCTAssert(tag.endTime == 0)
    }

    // MARK:

    func testVersion0CaseA() {
        let tag = ID3v1Tag(version: ID3v1Version.v0)

        XCTAssert(tag.isEmpty && (tag.toData() == nil))

        tag.title = "Title"
        tag.artist = "Artist"

        tag.album = "Album"
        tag.genre = "Classic Rock"

        tag.releaseDate = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: 34, second: 56))

        tag.trackNumber = TagNumber(12, total: 34)

        tag.comment = "Comment"

        tag.velocity = 3
        tag.startTime = 123
        tag.endTime = 456

        XCTAssert(!tag.isEmpty)

        guard let data = tag.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        let prefixData = Array<UInt8>(repeating: 123, count: 123)
        let suffixData = Array<UInt8>(repeating: 231, count: 231)

        var range = Range<UInt64>(123..<(123 + UInt64(data.count)))

        guard let other = ID3v1Tag(fromData: prefixData + data + suffixData, range: &range) else {
            return XCTFail()
        }

        XCTAssert(range.lowerBound == 123)
        XCTAssert(range.upperBound == 123 + UInt64(data.count))

        XCTAssert(!other.isEmpty)

        XCTAssert(other.version == ID3v1Version.v1)

        XCTAssert(other.title == tag.title.prefix(30))
        XCTAssert(other.artist == tag.artist.prefix(30))

        XCTAssert(other.album == tag.album.prefix(30))
        XCTAssert(other.genre == tag.genre)

        XCTAssert(other.releaseDate == TagDate(year: tag.releaseDate.year))

        XCTAssert(other.trackNumber == TagNumber())

        XCTAssert(other.comment == tag.comment.prefix(30))

        XCTAssert(other.velocity == 0)
        XCTAssert(other.startTime == 0)
        XCTAssert(other.endTime == 0)
    }

    func testVersion0CaseB() {
        let tag = ID3v1Tag(version: ID3v1Version.v0)

        XCTAssert(tag.isEmpty && (tag.toData() == nil))

        tag.title = Array<String>(repeating: "Title", count: 123).joined(separator: " ")
        tag.artist = Array<String>(repeating: "Artist", count: 123).joined(separator: ", ")

        tag.album = Array<String>(repeating: "Album", count: 123).joined(separator: " ")
        tag.genre = Array<String>(repeating: "Genre", count: 123).joined(separator: "/")

        tag.releaseDate = TagDate(year: 1998)

        tag.trackNumber = TagNumber(12)

        tag.comment = Array<String>(repeating: "Comment", count: 123).joined(separator: "\n")

        tag.velocity = 3
        tag.startTime = 123
        tag.endTime = 456

        XCTAssert(!tag.isEmpty)

        guard let data = tag.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        var range = Range<UInt64>(0..<UInt64(data.count))

        guard let other = ID3v1Tag(fromData: data, range: &range) else {
            return XCTFail()
        }

        XCTAssert(range.lowerBound == 0)
        XCTAssert(range.upperBound == UInt64(data.count))

        XCTAssert(!other.isEmpty)

        XCTAssert(other.version == ID3v1Version.v0)

        XCTAssert(other.title == tag.title.prefix(30))
        XCTAssert(other.artist == tag.artist.prefix(30))

        XCTAssert(other.album == tag.album.prefix(30))
        XCTAssert(other.genre == "")

        XCTAssert(other.releaseDate == TagDate(year: tag.releaseDate.year))

        XCTAssert(other.trackNumber == TagNumber())

        XCTAssert(other.comment == tag.comment.prefix(30))

        XCTAssert(other.velocity == 0)
        XCTAssert(other.startTime == 0)
        XCTAssert(other.endTime == 0)
    }

    func testVersion0CaseC() {
        let tag = ID3v1Tag(version: ID3v1Version.v0)

        XCTAssert(tag.isEmpty && (tag.toData() == nil))

        tag.title = "Title"
        tag.artist = "Artist"

        tag.album = "Album"
        tag.genre = "Genre"

        tag.releaseDate = TagDate(year: 10000)

        tag.trackNumber = TagNumber(999, total: 999)

        tag.comment = "Comment"

        tag.velocity = 999
        tag.startTime = 99999
        tag.endTime = 99999

        XCTAssert(!tag.isEmpty)

        guard let data = tag.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        var range = Range<UInt64>(0..<UInt64(data.count))

        guard let other = ID3v1Tag(fromData: data, range: &range) else {
            return XCTFail()
        }

        XCTAssert(range.lowerBound == 0)
        XCTAssert(range.upperBound == UInt64(data.count))

        XCTAssert(!other.isEmpty)

        XCTAssert(other.version == ID3v1Version.v1)

        XCTAssert(other.title == tag.title.prefix(30))
        XCTAssert(other.artist == tag.artist.prefix(30))

        XCTAssert(other.album == tag.album.prefix(30))
        XCTAssert(other.genre == "")

        XCTAssert(other.releaseDate == TagDate())

        XCTAssert(other.trackNumber == TagNumber())

        XCTAssert(other.comment == tag.comment.prefix(30))

        XCTAssert(other.velocity == 0)
        XCTAssert(other.startTime == 0)
        XCTAssert(other.endTime == 0)
    }

    func testVersion0CaseD() {
        let tag = ID3v1Tag(version: ID3v1Version.v0)

        XCTAssert(tag.isEmpty && (tag.toData() == nil))

        tag.title = Array<String>(repeating: "Title", count: 123).joined(separator: " ")
        tag.artist = Array<String>(repeating: "Artist", count: 123).joined(separator: ", ")

        tag.album = Array<String>(repeating: "Album", count: 123).joined(separator: " ")
        tag.genre = Array<String>(repeating: "Genre", count: 123).joined(separator: "/")

        tag.releaseDate = TagDate(year: 1998, month: 0, day: 0, time: TagTime(hour: 24, minute: 60, second: 60))

        tag.trackNumber = TagNumber(34, total: 12)

        tag.comment = Array<String>(repeating: "Comment", count: 123).joined(separator: "\n")

        tag.velocity = 0
        tag.startTime = 0
        tag.endTime = 0

        XCTAssert(!tag.isEmpty)

        guard let data = tag.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        var range = Range<UInt64>(0..<UInt64(data.count))

        guard let other = ID3v1Tag(fromData: data, range: &range) else {
            return XCTFail()
        }

        XCTAssert(range.lowerBound == 0)
        XCTAssert(range.upperBound == UInt64(data.count))

        XCTAssert(!other.isEmpty)

        XCTAssert(other.version == ID3v1Version.v0)

        XCTAssert(other.title == tag.title.prefix(30))
        XCTAssert(other.artist == tag.artist.prefix(30))

        XCTAssert(other.album == tag.album.prefix(30))
        XCTAssert(other.genre == "")

        XCTAssert(other.releaseDate == TagDate(year: tag.releaseDate.year))

        XCTAssert(other.trackNumber == TagNumber())

        XCTAssert(other.comment == tag.comment.prefix(30))

        XCTAssert(other.velocity == 0)
        XCTAssert(other.startTime == 0)
        XCTAssert(other.endTime == 0)
    }

    // MARK:

    func testVersion1CaseA() {
        let tag = ID3v1Tag(version: ID3v1Version.v1)

        XCTAssert(tag.isEmpty && (tag.toData() == nil))

        tag.title = "Title"
        tag.artist = "Artist"

        tag.album = "Album"
        tag.genre = "Classic Rock"

        tag.releaseDate = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: 34, second: 56))

        tag.trackNumber = TagNumber(12, total: 34)

        tag.comment = "Comment"

        tag.velocity = 3
        tag.startTime = 123
        tag.endTime = 456

        XCTAssert(!tag.isEmpty)

        guard let data = tag.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        let prefixData = Array<UInt8>(repeating: 123, count: 123)
        let suffixData = Array<UInt8>(repeating: 231, count: 231)

        var range = Range<UInt64>(123..<(123 + UInt64(data.count)))

        guard let other = ID3v1Tag(fromData: prefixData + data + suffixData, range: &range) else {
            return XCTFail()
        }

        XCTAssert(range.lowerBound == 123)
        XCTAssert(range.upperBound == 123 + UInt64(data.count))

        XCTAssert(!other.isEmpty)

        XCTAssert(other.version == ID3v1Version.v1)

        XCTAssert(other.title == tag.title.prefix(30))
        XCTAssert(other.artist == tag.artist.prefix(30))

        XCTAssert(other.album == tag.album.prefix(30))
        XCTAssert(other.genre == tag.genre)

        XCTAssert(other.releaseDate == TagDate(year: tag.releaseDate.year))

        XCTAssert(other.trackNumber == TagNumber(tag.trackNumber.value))

        XCTAssert(other.comment == tag.comment.prefix(28))

        XCTAssert(other.velocity == 0)
        XCTAssert(other.startTime == 0)
        XCTAssert(other.endTime == 0)
    }

    func testVersion1CaseB() {
        let tag = ID3v1Tag(version: ID3v1Version.v1)

        XCTAssert(tag.isEmpty && (tag.toData() == nil))

        tag.title = Array<String>(repeating: "Title", count: 123).joined(separator: " ")
        tag.artist = Array<String>(repeating: "Artist", count: 123).joined(separator: ", ")

        tag.album = Array<String>(repeating: "Album", count: 123).joined(separator: " ")
        tag.genre = Array<String>(repeating: "Genre", count: 123).joined(separator: "/")

        tag.releaseDate = TagDate(year: 1998)

        tag.trackNumber = TagNumber(12)

        tag.comment = Array<String>(repeating: "Comment", count: 123).joined(separator: "\n")

        tag.velocity = 3
        tag.startTime = 123
        tag.endTime = 456

        XCTAssert(!tag.isEmpty)

        guard let data = tag.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        var range = Range<UInt64>(0..<UInt64(data.count))

        guard let other = ID3v1Tag(fromData: data, range: &range) else {
            return XCTFail()
        }

        XCTAssert(range.lowerBound == 0)
        XCTAssert(range.upperBound == UInt64(data.count))

        XCTAssert(!other.isEmpty)

        XCTAssert(other.version == ID3v1Version.v1)

        XCTAssert(other.title == tag.title.prefix(30))
        XCTAssert(other.artist == tag.artist.prefix(30))

        XCTAssert(other.album == tag.album.prefix(30))
        XCTAssert(other.genre == "")

        XCTAssert(other.releaseDate == TagDate(year: tag.releaseDate.year))

        XCTAssert(other.trackNumber == TagNumber(tag.trackNumber.value))

        XCTAssert(other.comment == tag.comment.prefix(28))

        XCTAssert(other.velocity == 0)
        XCTAssert(other.startTime == 0)
        XCTAssert(other.endTime == 0)
    }

    func testVersion1CaseC() {
        let tag = ID3v1Tag(version: ID3v1Version.v1)

        XCTAssert(tag.isEmpty && (tag.toData() == nil))

        tag.title = "Title"
        tag.artist = "Artist"

        tag.album = "Album"
        tag.genre = "Genre"

        tag.releaseDate = TagDate(year: 10000)

        tag.trackNumber = TagNumber(999, total: 999)

        tag.comment = "Comment"

        tag.velocity = 999
        tag.startTime = 99999
        tag.endTime = 99999

        XCTAssert(!tag.isEmpty)

        guard let data = tag.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        var range = Range<UInt64>(0..<UInt64(data.count))

        guard let other = ID3v1Tag(fromData: data, range: &range) else {
            return XCTFail()
        }

        XCTAssert(range.lowerBound == 0)
        XCTAssert(range.upperBound == UInt64(data.count))

        XCTAssert(!other.isEmpty)

        XCTAssert(other.version == ID3v1Version.v1)

        XCTAssert(other.title == tag.title.prefix(30))
        XCTAssert(other.artist == tag.artist.prefix(30))

        XCTAssert(other.album == tag.album.prefix(30))
        XCTAssert(other.genre == "")

        XCTAssert(other.releaseDate == TagDate())

        XCTAssert(other.trackNumber == TagNumber())

        XCTAssert(other.comment == tag.comment.prefix(28))

        XCTAssert(other.velocity == 0)
        XCTAssert(other.startTime == 0)
        XCTAssert(other.endTime == 0)
    }

    func testVersion1CaseD() {
        let tag = ID3v1Tag(version: ID3v1Version.v1)

        XCTAssert(tag.isEmpty && (tag.toData() == nil))

        tag.title = Array<String>(repeating: "Title", count: 123).joined(separator: " ")
        tag.artist = Array<String>(repeating: "Artist", count: 123).joined(separator: ", ")

        tag.album = Array<String>(repeating: "Album", count: 123).joined(separator: " ")
        tag.genre = Array<String>(repeating: "Genre", count: 123).joined(separator: "/")

        tag.releaseDate = TagDate(year: 1998, month: 0, day: 0, time: TagTime(hour: 24, minute: 60, second: 60))

        tag.trackNumber = TagNumber(34, total: 12)

        tag.comment = Array<String>(repeating: "Comment", count: 123).joined(separator: "\n")

        tag.velocity = 0
        tag.startTime = 0
        tag.endTime = 0

        XCTAssert(!tag.isEmpty)

        guard let data = tag.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        var range = Range<UInt64>(0..<UInt64(data.count))

        guard let other = ID3v1Tag(fromData: data, range: &range) else {
            return XCTFail()
        }

        XCTAssert(range.lowerBound == 0)
        XCTAssert(range.upperBound == UInt64(data.count))

        XCTAssert(!other.isEmpty)

        XCTAssert(other.version == ID3v1Version.v1)

        XCTAssert(other.title == tag.title.prefix(30))
        XCTAssert(other.artist == tag.artist.prefix(30))

        XCTAssert(other.album == tag.album.prefix(30))
        XCTAssert(other.genre == "")

        XCTAssert(other.releaseDate == TagDate(year: tag.releaseDate.year))

        XCTAssert(other.trackNumber == TagNumber(tag.trackNumber.value))

        XCTAssert(other.comment == tag.comment.prefix(28))

        XCTAssert(other.velocity == 0)
        XCTAssert(other.startTime == 0)
        XCTAssert(other.endTime == 0)
    }

    // MARK:

    func testVersionExt0CaseA() {
        let tag = ID3v1Tag(version: ID3v1Version.vExt0)

        XCTAssert(tag.isEmpty && (tag.toData() == nil))

        tag.title = "Title"
        tag.artist = "Artist"

        tag.album = "Album"
        tag.genre = "Classic Rock"

        tag.releaseDate = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: 34, second: 56))

        tag.trackNumber = TagNumber(12, total: 34)

        tag.comment = "Comment"

        tag.velocity = 3
        tag.startTime = 123
        tag.endTime = 456

        XCTAssert(!tag.isEmpty)

        guard let data = tag.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        let prefixData = Array<UInt8>(repeating: 123, count: 123)
        let suffixData = Array<UInt8>(repeating: 231, count: 231)

        var range = Range<UInt64>(123..<(123 + UInt64(data.count)))

        guard let other = ID3v1Tag(fromData: prefixData + data + suffixData, range: &range) else {
            return XCTFail()
        }

        XCTAssert(range.lowerBound == 123)
        XCTAssert(range.upperBound == 123 + UInt64(data.count))

        XCTAssert(!other.isEmpty)

        XCTAssert(other.version == ID3v1Version.vExt1)

        XCTAssert(other.title == tag.title.prefix(90))
        XCTAssert(other.artist == tag.artist.prefix(90))

        XCTAssert(other.album == tag.album.prefix(90))
        XCTAssert(other.genre == tag.genre.prefix(30))

        XCTAssert(other.releaseDate == TagDate(year: tag.releaseDate.year))

        XCTAssert(other.trackNumber == TagNumber())

        XCTAssert(other.comment == tag.comment.prefix(30))

        XCTAssert(other.velocity == tag.velocity)
        XCTAssert(other.startTime == tag.startTime)
        XCTAssert(other.endTime == tag.endTime)
    }

    func testVersionExt0CaseB() {
        let tag = ID3v1Tag(version: ID3v1Version.vExt0)

        XCTAssert(tag.isEmpty && (tag.toData() == nil))

        tag.title = Array<String>(repeating: "Title", count: 123).joined(separator: " ")
        tag.artist = Array<String>(repeating: "Artist", count: 123).joined(separator: ", ")

        tag.album = Array<String>(repeating: "Album", count: 123).joined(separator: " ")
        tag.genre = Array<String>(repeating: "Genre", count: 123).joined(separator: "/")

        tag.releaseDate = TagDate(year: 1998)

        tag.trackNumber = TagNumber(12)

        tag.comment = Array<String>(repeating: "Comment", count: 123).joined(separator: "\n")

        tag.velocity = 3
        tag.startTime = 123
        tag.endTime = 456

        XCTAssert(!tag.isEmpty)

        guard let data = tag.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        var range = Range<UInt64>(0..<UInt64(data.count))

        guard let other = ID3v1Tag(fromData: data, range: &range) else {
            return XCTFail()
        }

        XCTAssert(range.lowerBound == 0)
        XCTAssert(range.upperBound == UInt64(data.count))

        XCTAssert(!other.isEmpty)

        XCTAssert(other.version == ID3v1Version.vExt0)

        XCTAssert(other.title == tag.title.prefix(90))
        XCTAssert(other.artist == tag.artist.prefix(90))

        XCTAssert(other.album == tag.album.prefix(90))
        XCTAssert(other.genre == tag.genre.prefix(30))

        XCTAssert(other.releaseDate == TagDate(year: tag.releaseDate.year))

        XCTAssert(other.trackNumber == TagNumber())

        XCTAssert(other.comment == tag.comment.prefix(30))

        XCTAssert(other.velocity == tag.velocity)
        XCTAssert(other.startTime == tag.startTime)
        XCTAssert(other.endTime == tag.endTime)
    }

    func testVersionExt0CaseC() {
        let tag = ID3v1Tag(version: ID3v1Version.vExt0)

        XCTAssert(tag.isEmpty && (tag.toData() == nil))

        tag.title = "Title"
        tag.artist = "Artist"

        tag.album = "Album"
        tag.genre = "Genre"

        tag.releaseDate = TagDate(year: 10000)

        tag.trackNumber = TagNumber(999, total: 999)

        tag.comment = "Comment"

        tag.velocity = 999
        tag.startTime = 99999
        tag.endTime = 99999

        XCTAssert(!tag.isEmpty)

        guard let data = tag.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        var range = Range<UInt64>(0..<UInt64(data.count))

        guard let other = ID3v1Tag(fromData: data, range: &range) else {
            return XCTFail()
        }

        XCTAssert(range.lowerBound == 0)
        XCTAssert(range.upperBound == UInt64(data.count))

        XCTAssert(!other.isEmpty)

        XCTAssert(other.version == ID3v1Version.vExt1)

        XCTAssert(other.title == tag.title.prefix(90))
        XCTAssert(other.artist == tag.artist.prefix(90))

        XCTAssert(other.album == tag.album.prefix(90))
        XCTAssert(other.genre == tag.genre.prefix(30))

        XCTAssert(other.releaseDate == TagDate())

        XCTAssert(other.trackNumber == TagNumber())

        XCTAssert(other.comment == tag.comment.prefix(30))

        XCTAssert(other.velocity == 0)
        XCTAssert(other.startTime == 0)
        XCTAssert(other.endTime == 0)
    }

    func testVersionExt0CaseD() {
        let tag = ID3v1Tag(version: ID3v1Version.vExt0)

        XCTAssert(tag.isEmpty && (tag.toData() == nil))

        tag.title = Array<String>(repeating: "Title", count: 123).joined(separator: " ")
        tag.artist = Array<String>(repeating: "Artist", count: 123).joined(separator: ", ")

        tag.album = Array<String>(repeating: "Album", count: 123).joined(separator: " ")
        tag.genre = Array<String>(repeating: "Genre", count: 123).joined(separator: "/")

        tag.releaseDate = TagDate(year: 1998, month: 0, day: 0, time: TagTime(hour: 24, minute: 60, second: 60))

        tag.trackNumber = TagNumber(34, total: 12)

        tag.comment = Array<String>(repeating: "Comment", count: 123).joined(separator: "\n")

        tag.velocity = 0
        tag.startTime = 0
        tag.endTime = 0

        XCTAssert(!tag.isEmpty)

        guard let data = tag.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        var range = Range<UInt64>(0..<UInt64(data.count))

        guard let other = ID3v1Tag(fromData: data, range: &range) else {
            return XCTFail()
        }

        XCTAssert(range.lowerBound == 0)
        XCTAssert(range.upperBound == UInt64(data.count))

        XCTAssert(!other.isEmpty)

        XCTAssert(other.version == ID3v1Version.vExt0)

        XCTAssert(other.title == tag.title.prefix(90))
        XCTAssert(other.artist == tag.artist.prefix(90))

        XCTAssert(other.album == tag.album.prefix(90))
        XCTAssert(other.genre == tag.genre.prefix(30))

        XCTAssert(other.releaseDate == TagDate(year: tag.releaseDate.year))

        XCTAssert(other.trackNumber == TagNumber())

        XCTAssert(other.comment == tag.comment.prefix(30))

        XCTAssert(other.velocity == tag.velocity)
        XCTAssert(other.startTime == tag.startTime)
        XCTAssert(other.endTime == tag.endTime)
    }

    // MARK:

    func testVersionExt1CaseA() {
        let tag = ID3v1Tag(version: ID3v1Version.vExt1)

        XCTAssert(tag.isEmpty && (tag.toData() == nil))

        tag.title = "Title"
        tag.artist = "Artist"

        tag.album = "Album"
        tag.genre = "Classic Rock"

        tag.releaseDate = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: 34, second: 56))

        tag.trackNumber = TagNumber(12, total: 34)

        tag.comment = "Comment"

        tag.velocity = 3
        tag.startTime = 123
        tag.endTime = 456

        XCTAssert(!tag.isEmpty)

        guard let data = tag.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        let prefixData = Array<UInt8>(repeating: 123, count: 123)
        let suffixData = Array<UInt8>(repeating: 231, count: 231)

        var range = Range<UInt64>(123..<(123 + UInt64(data.count)))

        guard let other = ID3v1Tag(fromData: prefixData + data + suffixData, range: &range) else {
            return XCTFail()
        }

        XCTAssert(range.lowerBound == 123)
        XCTAssert(range.upperBound == 123 + UInt64(data.count))

        XCTAssert(!other.isEmpty)

        XCTAssert(other.version == ID3v1Version.vExt1)

        XCTAssert(other.title == tag.title.prefix(90))
        XCTAssert(other.artist == tag.artist.prefix(90))

        XCTAssert(other.album == tag.album.prefix(90))
        XCTAssert(other.genre == tag.genre.prefix(30))

        XCTAssert(other.releaseDate == TagDate(year: tag.releaseDate.year))

        XCTAssert(other.trackNumber == TagNumber(tag.trackNumber.value))

        XCTAssert(other.comment == tag.comment.prefix(28))

        XCTAssert(other.velocity == tag.velocity)
        XCTAssert(other.startTime == tag.startTime)
        XCTAssert(other.endTime == tag.endTime)
    }

    func testVersionExt1CaseB() {
        let tag = ID3v1Tag(version: ID3v1Version.vExt1)

        XCTAssert(tag.isEmpty && (tag.toData() == nil))

        tag.title = Array<String>(repeating: "Title", count: 123).joined(separator: " ")
        tag.artist = Array<String>(repeating: "Artist", count: 123).joined(separator: ", ")

        tag.album = Array<String>(repeating: "Album", count: 123).joined(separator: " ")
        tag.genre = Array<String>(repeating: "Genre", count: 123).joined(separator: "/")

        tag.releaseDate = TagDate(year: 1998)

        tag.trackNumber = TagNumber(12)

        tag.comment = Array<String>(repeating: "Comment", count: 123).joined(separator: "\n")

        tag.velocity = 3
        tag.startTime = 123
        tag.endTime = 456

        XCTAssert(!tag.isEmpty)

        guard let data = tag.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        var range = Range<UInt64>(0..<UInt64(data.count))

        guard let other = ID3v1Tag(fromData: data, range: &range) else {
            return XCTFail()
        }

        XCTAssert(range.lowerBound == 0)
        XCTAssert(range.upperBound == UInt64(data.count))

        XCTAssert(!other.isEmpty)

        XCTAssert(other.version == ID3v1Version.vExt1)

        XCTAssert(other.title == tag.title.prefix(90))
        XCTAssert(other.artist == tag.artist.prefix(90))

        XCTAssert(other.album == tag.album.prefix(90))
        XCTAssert(other.genre == tag.genre.prefix(30))

        XCTAssert(other.releaseDate == TagDate(year: tag.releaseDate.year))

        XCTAssert(other.trackNumber == TagNumber(tag.trackNumber.value))

        XCTAssert(other.comment == tag.comment.prefix(28))

        XCTAssert(other.velocity == tag.velocity)
        XCTAssert(other.startTime == tag.startTime)
        XCTAssert(other.endTime == tag.endTime)
    }

    func testVersionExt1CaseC() {
        let tag = ID3v1Tag(version: ID3v1Version.vExt1)

        XCTAssert(tag.isEmpty && (tag.toData() == nil))

        tag.title = "Title"
        tag.artist = "Artist"

        tag.album = "Album"
        tag.genre = "Genre"

        tag.releaseDate = TagDate(year: 10000)

        tag.trackNumber = TagNumber(999, total: 999)

        tag.comment = "Comment"

        tag.velocity = 999
        tag.startTime = 99999
        tag.endTime = 99999

        XCTAssert(!tag.isEmpty)

        guard let data = tag.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        var range = Range<UInt64>(0..<UInt64(data.count))

        guard let other = ID3v1Tag(fromData: data, range: &range) else {
            return XCTFail()
        }

        XCTAssert(range.lowerBound == 0)
        XCTAssert(range.upperBound == UInt64(data.count))

        XCTAssert(!other.isEmpty)

        XCTAssert(other.version == ID3v1Version.vExt1)

        XCTAssert(other.title == tag.title.prefix(90))
        XCTAssert(other.artist == tag.artist.prefix(90))

        XCTAssert(other.album == tag.album.prefix(90))
        XCTAssert(other.genre == tag.genre.prefix(30))

        XCTAssert(other.releaseDate == TagDate())

        XCTAssert(other.trackNumber == TagNumber())

        XCTAssert(other.comment == tag.comment.prefix(28))

        XCTAssert(other.velocity == 0)
        XCTAssert(other.startTime == 0)
        XCTAssert(other.endTime == 0)
    }

    func testVersionExt1CaseD() {
        let tag = ID3v1Tag(version: ID3v1Version.vExt1)

        XCTAssert(tag.isEmpty && (tag.toData() == nil))

        tag.title = Array<String>(repeating: "Title", count: 123).joined(separator: " ")
        tag.artist = Array<String>(repeating: "Artist", count: 123).joined(separator: ", ")

        tag.album = Array<String>(repeating: "Album", count: 123).joined(separator: " ")
        tag.genre = Array<String>(repeating: "Genre", count: 123).joined(separator: "/")

        tag.releaseDate = TagDate(year: 1998, month: 0, day: 0, time: TagTime(hour: 24, minute: 60, second: 60))

        tag.trackNumber = TagNumber(34, total: 12)

        tag.comment = Array<String>(repeating: "Comment", count: 123).joined(separator: "\n")

        tag.velocity = 0
        tag.startTime = 0
        tag.endTime = 0

        XCTAssert(!tag.isEmpty)

        guard let data = tag.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        var range = Range<UInt64>(0..<UInt64(data.count))

        guard let other = ID3v1Tag(fromData: data, range: &range) else {
            return XCTFail()
        }

        XCTAssert(range.lowerBound == 0)
        XCTAssert(range.upperBound == UInt64(data.count))

        XCTAssert(!other.isEmpty)

        XCTAssert(other.version == ID3v1Version.vExt1)

        XCTAssert(other.title == tag.title.prefix(90))
        XCTAssert(other.artist == tag.artist.prefix(90))

        XCTAssert(other.album == tag.album.prefix(90))
        XCTAssert(other.genre == tag.genre.prefix(30))

        XCTAssert(other.releaseDate == TagDate(year: tag.releaseDate.year))

        XCTAssert(other.trackNumber == TagNumber(tag.trackNumber.value))

        XCTAssert(other.comment == tag.comment.prefix(28))

        XCTAssert(other.velocity == tag.velocity)
        XCTAssert(other.startTime == tag.startTime)
        XCTAssert(other.endTime == tag.endTime)
    }
}
