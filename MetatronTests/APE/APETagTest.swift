//
//  APETagTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 26.08.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

extension APETag {

    // MARK: Initializers

    fileprivate convenience init?(fromData data: [UInt8], range: inout Range<UInt64>) {
        let stream = MemoryStream(data: data)

        guard stream.openForReading() else {
            return nil
        }

        self.init(fromStream: stream, range: &range)
    }
}

class APETagTest: XCTestCase {

    // MARK: Instance Methods

    func testSubscript() {
        let tag = APETag()

        XCTAssert(tag.isEmpty && (tag.itemList.count == 0))

        XCTAssert(tag.appendItem("Abc 1") != nil)
        XCTAssert(tag.appendItem("Abc 2") != nil)

        XCTAssert((!tag.isEmpty) && (tag.itemList.count == 2))

        guard let item1 = tag["Abc 1"] else {
            return XCTFail()
        }

        guard let item2 = tag["Abc 1"] else {
            return XCTFail()
        }

        guard let item3 = tag["Abc 2"] else {
            return XCTFail()
        }

        XCTAssert(item1 === item2)
        XCTAssert(item1 !== item3)

        XCTAssert(item1.identifier == "Abc 1")
        XCTAssert(item2.identifier == "Abc 1")
        XCTAssert(item3.identifier == "Abc 2")

        XCTAssert(tag["Abc 3"] == nil)
        XCTAssert(tag["Абв 4"] == nil)
    }

    // MARK:

    func testAppendItem() {
        let tag = APETag()

        XCTAssert(tag.isEmpty && (tag.itemList.count == 0))

        guard let item1 = tag.appendItem("Abc 1") else {
            return XCTFail()
        }

        XCTAssert((!tag.isEmpty) && (tag.itemList.count == 1))

        guard let item2 = tag.appendItem("Abc 1") else {
            return XCTFail()
        }

        XCTAssert((!tag.isEmpty) && (tag.itemList.count == 1))

        guard let item3 = tag.appendItem("Abc 2") else {
            return XCTFail()
        }

        XCTAssert((!tag.isEmpty) && (tag.itemList.count == 2))

        XCTAssert(item1 === item2)
        XCTAssert(item1 !== item3)

        XCTAssert(item1.identifier == "Abc 1")
        XCTAssert(item2.identifier == "Abc 1")
        XCTAssert(item3.identifier == "Abc 2")

        XCTAssert(tag.appendItem("Abc 1") === item1)
        XCTAssert(tag.appendItem("Abc 2") === item3)

        item1.value = [1, 2, 3]

        item1.access = APEItem.Access.readOnly
        item1.format = APEItem.Format.binary

        XCTAssert(tag.appendItem("Abc 1") === item1)
        XCTAssert(tag.appendItem("Abc 2") === item3)

        XCTAssert(item1.isValid && (!item1.isEmpty))

        XCTAssert(item1.access == APEItem.Access.readOnly)
        XCTAssert(item1.format == APEItem.Format.binary)

        XCTAssert(item3.isValid && item3.isEmpty)

        XCTAssert(item3.access == APEItem.Access.readWrite)
        XCTAssert(item3.format == APEItem.Format.textual)

        XCTAssert(tag.appendItem("Dummy") == nil)
        XCTAssert(tag.appendItem("Абв 4") == nil)
    }

    func testResetItem() {
        let tag = APETag()

        XCTAssert(tag.isEmpty && (tag.itemList.count == 0))

        guard let item1 = tag.resetItem("Abc 1") else {
            return XCTFail()
        }

        XCTAssert((!tag.isEmpty) && (tag.itemList.count == 1))

        guard let item2 = tag.resetItem("Abc 1") else {
            return XCTFail()
        }

        XCTAssert((!tag.isEmpty) && (tag.itemList.count == 1))

        guard let item3 = tag.resetItem("Abc 2") else {
            return XCTFail()
        }

        XCTAssert((!tag.isEmpty) && (tag.itemList.count == 2))

        XCTAssert(item1 === item2)
        XCTAssert(item1 !== item3)

        XCTAssert(item1.identifier == "Abc 1")
        XCTAssert(item2.identifier == "Abc 1")
        XCTAssert(item3.identifier == "Abc 2")

        XCTAssert(tag.resetItem("Abc 1") === item1)
        XCTAssert(tag.resetItem("Abc 2") === item3)

        item1.value = [1, 2, 3]

        item1.access = APEItem.Access.readOnly
        item1.format = APEItem.Format.binary

        XCTAssert(tag.resetItem("Abc 1") === item1)
        XCTAssert(tag.resetItem("Abc 2") === item3)

        XCTAssert(item1.isValid && item1.isEmpty)

        XCTAssert(item1.access == APEItem.Access.readWrite)
        XCTAssert(item1.format == APEItem.Format.textual)

        XCTAssert(item3.isValid && item3.isEmpty)

        XCTAssert(item3.access == APEItem.Access.readWrite)
        XCTAssert(item3.format == APEItem.Format.textual)

        XCTAssert(tag.resetItem("Dummy") == nil)
        XCTAssert(tag.resetItem("Абв 4") == nil)
    }

    func testRemoveItem() {
        let tag = APETag()

        XCTAssert(tag.isEmpty && (tag.itemList.count == 0))

        guard let item1 = tag.appendItem("Abc 1") else {
            return XCTFail()
        }

        guard let item2 = tag.appendItem("Abc 2") else {
            return XCTFail()
        }

        XCTAssert((!tag.isEmpty) && (tag.itemList.count == 2))

        XCTAssert(tag.removeItem(item1.identifier) == true)
        XCTAssert(tag.removeItem(item1.identifier) == false)

        XCTAssert((!tag.isEmpty) && (tag.itemList.count == 1))

        XCTAssert(tag.removeItem(item2.identifier) == true)
        XCTAssert(tag.removeItem(item2.identifier) == false)

        XCTAssert(tag.isEmpty && (tag.itemList.count == 0))
    }

    func testRevise() {
        let tag = APETag()

        XCTAssert(tag.isEmpty && (tag.itemList.count == 0))

        guard let item1 = tag.appendItem("Abc 1") else {
            return XCTFail()
        }

        guard let item2 = tag.appendItem("Abc 2") else {
            return XCTFail()
        }

        guard tag.appendItem("Abc 3") != nil else {
            return XCTFail()
        }

        XCTAssert((!tag.isEmpty) && (tag.itemList.count == 3))

        item1.timeValue = TagTime(hour: 12, minute: 34, second: 56)
        item2.dateValue = TagDate(year: 1999, month: 8, day: 11)

        tag.revise()

        XCTAssert((!tag.isEmpty) && (tag.itemList.count == 2))

        XCTAssert(tag.itemList[0] === item1)
        XCTAssert(tag.itemList[1] === item2)
    }

    func testClear() {
        let tag = APETag()

        XCTAssert(tag.isEmpty && (tag.itemList.count == 0))

        guard let item1 = tag.appendItem("Abc 1") else {
            return XCTFail()
        }

        guard let item2 = tag.appendItem("Abc 2") else {
            return XCTFail()
        }

        guard tag.appendItem("Abc 3") != nil else {
            return XCTFail()
        }

        XCTAssert((!tag.isEmpty) && (tag.itemList.count == 3))

        item1.timeValue = TagTime(hour: 12, minute: 34, second: 56)
        item2.dateValue = TagDate(year: 1999, month: 8, day: 11)

        tag.clear()

        XCTAssert(tag.isEmpty && (tag.itemList.count == 0))
    }

    // MARK:

    func testVersion1CaseA() {
        let tag = APETag(version: APEVersion.v1)

        tag.headerPresent = true
        tag.footerPresent = true

        tag.fillingLength = 123456

        XCTAssert(tag.isEmpty && (tag.toData() == nil))

        tag.title = "Title"
        tag.artists = ["Artist 1", "Artist 2"]

        tag.album = "Album"
        tag.genres = ["Genre 1", "Genre 2", "Genre 3"]

        tag.releaseDate = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: 34, second: 56))

        tag.trackNumber = TagNumber(3, total: 4)
        tag.discNumber = TagNumber(1, total: 2)

        tag.coverArt = TagImage(data: [1, 2, 3], description: "Cover art")

        tag.copyrights = ["Copyright"]
        tag.comments = ["Comment 1", "Comment 2", "Comment 3", "Comment 4"]

        tag.lyrics = TagLyrics(pieces: [TagLyrics.Piece("Lyrics piece 1", timeStamp: 1230),
                                        TagLyrics.Piece("Lyrics piece 2", timeStamp: 4560)])

        guard let extraItem1 = tag.appendItem("Extra item 1") else {
            return XCTFail()
        }

        guard let extraItem2 = tag.appendItem("Extra item 2") else {
            return XCTFail()
        }

        extraItem1.timeValue = TagTime(hour: 12, minute: 34, second: 56)
        extraItem2.dateValue = TagDate(year: 1998, month: 12, day: 31)

        XCTAssert(!tag.isEmpty)

        guard let data = tag.toData() else {
            return XCTFail()
        }

        XCTAssert(data.count == tag.fillingLength)

        let prefixData = Array<UInt8>(repeating: 123, count: 123)
        let suffixData = Array<UInt8>(repeating: 231, count: 231)

        var range = Range<UInt64>(123..<(123 + UInt64(data.count)))

        guard let other = APETag(fromData: prefixData + data + suffixData, range: &range) else {
            return XCTFail()
        }

        XCTAssert(range.lowerBound == 123)
        XCTAssert(range.upperBound == 123 + UInt64(data.count))

        XCTAssert(!other.isEmpty)

        XCTAssert(other.version == tag.version)

        XCTAssert(other.headerPresent == false)
        XCTAssert(other.footerPresent == true)

        XCTAssert(other.fillingLength == tag.fillingLength)

        XCTAssert(other.title == tag.title)
        XCTAssert(other.artists == tag.artists)

        XCTAssert(other.album == tag.album)
        XCTAssert(other.genres == tag.genres)

        XCTAssert(other.releaseDate == tag.releaseDate)

        XCTAssert(other.trackNumber == tag.trackNumber)
        XCTAssert(other.discNumber == tag.discNumber)

        XCTAssert(other.coverArt == TagImage())

        XCTAssert(other.copyrights == tag.copyrights)
        XCTAssert(other.comments == tag.comments)

        XCTAssert(other.lyrics == tag.lyrics)

        guard let otherExtraItem1 = other["Extra item 1"] else {
            return XCTFail()
        }

        guard let otherExtraItem2 = other["Extra item 2"] else {
            return XCTFail()
        }

        XCTAssert(otherExtraItem1.value == extraItem1.value)
        XCTAssert(otherExtraItem2.value == extraItem2.value)

        XCTAssert(other.itemList.count == tag.itemList.count - 1)
    }

    func testVersion1CaseB() {
        let tag = APETag(version: APEVersion.v1)

        tag.headerPresent = false
        tag.footerPresent = true

        tag.fillingLength = 123456

        XCTAssert(tag.isEmpty && (tag.toData() == nil))

        tag.title = "Title"
        tag.artists = ["Artist 1", "Artist 2"]

        tag.album = "Album"
        tag.genres = ["Genre 1", "Genre 2", "Genre 3"]

        tag.releaseDate = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: 34, second: 56))

        tag.trackNumber = TagNumber(3, total: 4)
        tag.discNumber = TagNumber(1, total: 2)

        tag.coverArt = TagImage(data: [1, 2, 3], description: "Cover art")

        tag.copyrights = ["Copyright"]
        tag.comments = ["Comment 1", "Comment 2", "Comment 3", "Comment 4"]

        tag.lyrics = TagLyrics(pieces: [TagLyrics.Piece("Lyrics piece 1", timeStamp: 1230),
                                        TagLyrics.Piece("Lyrics piece 2", timeStamp: 4560)])

        guard let extraItem1 = tag.appendItem("Extra item 1") else {
            return XCTFail()
        }

        guard let extraItem2 = tag.appendItem("Extra item 2") else {
            return XCTFail()
        }

        extraItem1.timeValue = TagTime(hour: 12, minute: 34, second: 56)
        extraItem2.dateValue = TagDate(year: 1998, month: 12, day: 31)

        XCTAssert(!tag.isEmpty)

        guard let data = tag.toData() else {
            return XCTFail()
        }

        XCTAssert(data.count == tag.fillingLength)

        let prefixData = Array<UInt8>(repeating: 123, count: 123)
        let suffixData = Array<UInt8>(repeating: 231, count: 231)

        var range = Range<UInt64>(0..<(123 + UInt64(data.count)))

        guard let other = APETag(fromData: prefixData + data + suffixData, range: &range) else {
            return XCTFail()
        }

        XCTAssert(range.lowerBound == 123)
        XCTAssert(range.upperBound == 123 + UInt64(data.count))

        XCTAssert(!other.isEmpty)

        XCTAssert(other.version == tag.version)

        XCTAssert(other.headerPresent == false)
        XCTAssert(other.footerPresent == true)

        XCTAssert(other.fillingLength == tag.fillingLength)

        XCTAssert(other.title == tag.title)
        XCTAssert(other.artists == tag.artists)

        XCTAssert(other.album == tag.album)
        XCTAssert(other.genres == tag.genres)

        XCTAssert(other.releaseDate == tag.releaseDate)

        XCTAssert(other.trackNumber == tag.trackNumber)
        XCTAssert(other.discNumber == tag.discNumber)

        XCTAssert(other.coverArt == TagImage())

        XCTAssert(other.copyrights == tag.copyrights)
        XCTAssert(other.comments == tag.comments)

        XCTAssert(other.lyrics == tag.lyrics)

        guard let otherExtraItem1 = other["Extra item 1"] else {
            return XCTFail()
        }

        guard let otherExtraItem2 = other["Extra item 2"] else {
            return XCTFail()
        }

        XCTAssert(otherExtraItem1.value == extraItem1.value)
        XCTAssert(otherExtraItem2.value == extraItem2.value)

        XCTAssert(other.itemList.count == tag.itemList.count - 1)
    }

    func testVersion1CaseC() {
        let tag = APETag(version: APEVersion.v1)

        tag.headerPresent = true
        tag.footerPresent = false

        tag.fillingLength = 0

        XCTAssert(tag.isEmpty && (tag.toData() == nil))

        tag.title = "Title"
        tag.artists = ["Artist 1", "Artist 2"]

        tag.album = "Album"
        tag.genres = ["Genre 1", "Genre 2", "Genre 3"]

        tag.releaseDate = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: 34, second: 56))

        tag.trackNumber = TagNumber(3, total: 4)
        tag.discNumber = TagNumber(1, total: 2)

        tag.coverArt = TagImage(data: [1, 2, 3], description: "Cover art")

        tag.copyrights = ["Copyright"]
        tag.comments = ["Comment 1", "Comment 2", "Comment 3", "Comment 4"]

        tag.lyrics = TagLyrics(pieces: [TagLyrics.Piece("Lyrics piece 1", timeStamp: 1230),
                                        TagLyrics.Piece("Lyrics piece 2", timeStamp: 4560)])

        guard let extraItem1 = tag.appendItem("Extra item 1") else {
            return XCTFail()
        }

        guard let extraItem2 = tag.appendItem("Extra item 2") else {
            return XCTFail()
        }

        extraItem1.timeValue = TagTime(hour: 12, minute: 34, second: 56)
        extraItem2.dateValue = TagDate(year: 1998, month: 12, day: 31)

        XCTAssert((!tag.isEmpty) && (tag.toData() == nil))
    }

    func testVersion1CaseD() {
        let tag = APETag(version: APEVersion.v1)

        tag.headerPresent = false
        tag.footerPresent = false

        tag.fillingLength = 0

        XCTAssert(tag.isEmpty && (tag.toData() == nil))

        tag.title = "Title"
        tag.artists = ["Artist 1", "Artist 2"]

        tag.album = "Album"
        tag.genres = ["Genre 1", "Genre 2", "Genre 3"]

        tag.releaseDate = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: 34, second: 56))

        tag.trackNumber = TagNumber(3, total: 4)
        tag.discNumber = TagNumber(1, total: 2)

        tag.coverArt = TagImage(data: [1, 2, 3], description: "Cover art")

        tag.copyrights = ["Copyright"]
        tag.comments = ["Comment 1", "Comment 2", "Comment 3", "Comment 4"]

        tag.lyrics = TagLyrics(pieces: [TagLyrics.Piece("Lyrics piece 1", timeStamp: 1230),
                                        TagLyrics.Piece("Lyrics piece 2", timeStamp: 4560)])

        guard let extraItem1 = tag.appendItem("Extra item 1") else {
            return XCTFail()
        }

        guard let extraItem2 = tag.appendItem("Extra item 2") else {
            return XCTFail()
        }

        extraItem1.timeValue = TagTime(hour: 12, minute: 34, second: 56)
        extraItem2.dateValue = TagDate(year: 1998, month: 12, day: 31)

        XCTAssert((!tag.isEmpty) && (tag.toData() == nil))
    }

    // MARK:

    func testVersion2CaseA() {
        let tag = APETag(version: APEVersion.v2)

        tag.headerPresent = true
        tag.footerPresent = true

        tag.fillingLength = 123456

        XCTAssert(tag.isEmpty && (tag.toData() == nil))

        tag.title = "Title"
        tag.artists = ["Artist 1", "Artist 2"]

        tag.album = "Album"
        tag.genres = ["Genre 1", "Genre 2", "Genre 3"]

        tag.releaseDate = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: 34, second: 56))

        tag.trackNumber = TagNumber(3, total: 4)
        tag.discNumber = TagNumber(1, total: 2)

        tag.coverArt = TagImage(data: [1, 2, 3], description: "Cover art")

        tag.copyrights = ["Copyright"]
        tag.comments = ["Comment 1", "Comment 2", "Comment 3", "Comment 4"]

        tag.lyrics = TagLyrics(pieces: [TagLyrics.Piece("Lyrics piece 1", timeStamp: 1230),
                                        TagLyrics.Piece("Lyrics piece 2", timeStamp: 4560)])

        guard let extraItem1 = tag.appendItem("Extra item 1") else {
            return XCTFail()
        }

        guard let extraItem2 = tag.appendItem("Extra item 2") else {
            return XCTFail()
        }

        extraItem1.timeValue = TagTime(hour: 12, minute: 34, second: 56)
        extraItem2.dateValue = TagDate(year: 1998, month: 12, day: 31)

        XCTAssert(!tag.isEmpty)

        guard let data = tag.toData() else {
            return XCTFail()
        }

        XCTAssert(data.count == tag.fillingLength)

        let prefixData = Array<UInt8>(repeating: 123, count: 123)
        let suffixData = Array<UInt8>(repeating: 231, count: 231)

        var range = Range<UInt64>(123..<(354 + UInt64(data.count)))

        guard let other = APETag(fromData: prefixData + data + suffixData, range: &range) else {
            return XCTFail()
        }

        XCTAssert(range.lowerBound == 123)
        XCTAssert(range.upperBound == 123 + UInt64(data.count))

        XCTAssert(!other.isEmpty)

        XCTAssert(other.version == tag.version)

        XCTAssert(other.headerPresent == tag.headerPresent)
        XCTAssert(other.footerPresent == tag.footerPresent)

        XCTAssert(other.fillingLength == tag.fillingLength)

        XCTAssert(other.title == tag.title)
        XCTAssert(other.artists == tag.artists)

        XCTAssert(other.album == tag.album)
        XCTAssert(other.genres == tag.genres)

        XCTAssert(other.releaseDate == tag.releaseDate)

        XCTAssert(other.trackNumber == tag.trackNumber)
        XCTAssert(other.discNumber == tag.discNumber)

        XCTAssert(other.coverArt == tag.coverArt)

        XCTAssert(other.copyrights == tag.copyrights)
        XCTAssert(other.comments == tag.comments)

        XCTAssert(other.lyrics == tag.lyrics)

        guard let otherExtraItem1 = other["Extra item 1"] else {
            return XCTFail()
        }

        guard let otherExtraItem2 = other["Extra item 2"] else {
            return XCTFail()
        }

        XCTAssert(otherExtraItem1.value == extraItem1.value)
        XCTAssert(otherExtraItem2.value == extraItem2.value)

        XCTAssert(other.itemList.count == tag.itemList.count)
    }

    func testVersion2CaseB() {
        let tag = APETag(version: APEVersion.v2)

        tag.headerPresent = false
        tag.footerPresent = true

        tag.fillingLength = 123456

        XCTAssert(tag.isEmpty && (tag.toData() == nil))

        tag.title = "Title"
        tag.artists = ["Artist 1", "Artist 2"]

        tag.album = "Album"
        tag.genres = ["Genre 1", "Genre 2", "Genre 3"]

        tag.releaseDate = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: 34, second: 56))

        tag.trackNumber = TagNumber(3, total: 4)
        tag.discNumber = TagNumber(1, total: 2)

        tag.coverArt = TagImage(data: [1, 2, 3], description: "Cover art")

        tag.copyrights = ["Copyright"]
        tag.comments = ["Comment 1", "Comment 2", "Comment 3", "Comment 4"]

        tag.lyrics = TagLyrics(pieces: [TagLyrics.Piece("Lyrics piece 1", timeStamp: 1230),
                                        TagLyrics.Piece("Lyrics piece 2", timeStamp: 4560)])

        guard let extraItem1 = tag.appendItem("Extra item 1") else {
            return XCTFail()
        }

        guard let extraItem2 = tag.appendItem("Extra item 2") else {
            return XCTFail()
        }

        extraItem1.timeValue = TagTime(hour: 12, minute: 34, second: 56)
        extraItem2.dateValue = TagDate(year: 1998, month: 12, day: 31)

        XCTAssert(!tag.isEmpty)

        guard let data = tag.toData() else {
            return XCTFail()
        }

        XCTAssert(data.count == tag.fillingLength)

        let prefixData = Array<UInt8>(repeating: 123, count: 123)
        let suffixData = Array<UInt8>(repeating: 231, count: 231)

        var range = Range<UInt64>(0..<(123 + UInt64(data.count)))

        guard let other = APETag(fromData: prefixData + data + suffixData, range: &range) else {
            return XCTFail()
        }

        XCTAssert(range.lowerBound == 123)
        XCTAssert(range.upperBound == 123 + UInt64(data.count))

        XCTAssert(!other.isEmpty)

        XCTAssert(other.version == tag.version)

        XCTAssert(other.headerPresent == tag.headerPresent)
        XCTAssert(other.footerPresent == tag.footerPresent)

        XCTAssert(other.fillingLength == tag.fillingLength)

        XCTAssert(other.title == tag.title)
        XCTAssert(other.artists == tag.artists)

        XCTAssert(other.album == tag.album)
        XCTAssert(other.genres == tag.genres)

        XCTAssert(other.releaseDate == tag.releaseDate)

        XCTAssert(other.trackNumber == tag.trackNumber)
        XCTAssert(other.discNumber == tag.discNumber)

        XCTAssert(other.coverArt == tag.coverArt)

        XCTAssert(other.copyrights == tag.copyrights)
        XCTAssert(other.comments == tag.comments)

        XCTAssert(other.lyrics == tag.lyrics)

        guard let otherExtraItem1 = other["Extra item 1"] else {
            return XCTFail()
        }

        guard let otherExtraItem2 = other["Extra item 2"] else {
            return XCTFail()
        }

        XCTAssert(otherExtraItem1.value == extraItem1.value)
        XCTAssert(otherExtraItem2.value == extraItem2.value)

        XCTAssert(other.itemList.count == tag.itemList.count)
    }

    func testVersion2CaseC() {
        let tag = APETag(version: APEVersion.v2)

        tag.headerPresent = true
        tag.footerPresent = false

        tag.fillingLength = 0

        XCTAssert(tag.isEmpty && (tag.toData() == nil))

        tag.title = "Title"
        tag.artists = ["Artist 1", "Artist 2"]

        tag.album = "Album"
        tag.genres = ["Genre 1", "Genre 2", "Genre 3"]

        tag.releaseDate = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: 34, second: 56))

        tag.trackNumber = TagNumber(3, total: 4)
        tag.discNumber = TagNumber(1, total: 2)

        tag.coverArt = TagImage(data: [1, 2, 3], description: "Cover art")

        tag.copyrights = ["Copyright"]
        tag.comments = ["Comment 1", "Comment 2", "Comment 3", "Comment 4"]

        tag.lyrics = TagLyrics(pieces: [TagLyrics.Piece("Lyrics piece 1", timeStamp: 1230),
                                        TagLyrics.Piece("Lyrics piece 2", timeStamp: 4560)])

        guard let extraItem1 = tag.appendItem("Extra item 1") else {
            return XCTFail()
        }

        guard let extraItem2 = tag.appendItem("Extra item 2") else {
            return XCTFail()
        }

        extraItem1.timeValue = TagTime(hour: 12, minute: 34, second: 56)
        extraItem2.dateValue = TagDate(year: 1998, month: 12, day: 31)

        XCTAssert(!tag.isEmpty)

        guard let data = tag.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        var range = Range<UInt64>(0..<UInt64(data.count))

        guard let other = APETag(fromData: data, range: &range) else {
            return XCTFail()
        }

        XCTAssert(range.lowerBound == 0)
        XCTAssert(range.upperBound == UInt64(data.count))

        XCTAssert(!other.isEmpty)

        XCTAssert(other.version == tag.version)

        XCTAssert(other.headerPresent == tag.headerPresent)
        XCTAssert(other.footerPresent == tag.footerPresent)

        XCTAssert(other.fillingLength == tag.fillingLength)

        XCTAssert(other.title == tag.title)
        XCTAssert(other.artists == tag.artists)

        XCTAssert(other.album == tag.album)
        XCTAssert(other.genres == tag.genres)

        XCTAssert(other.releaseDate == tag.releaseDate)

        XCTAssert(other.trackNumber == tag.trackNumber)
        XCTAssert(other.discNumber == tag.discNumber)

        XCTAssert(other.coverArt == tag.coverArt)

        XCTAssert(other.copyrights == tag.copyrights)
        XCTAssert(other.comments == tag.comments)

        XCTAssert(other.lyrics == tag.lyrics)

        guard let otherExtraItem1 = other["Extra item 1"] else {
            return XCTFail()
        }

        guard let otherExtraItem2 = other["Extra item 2"] else {
            return XCTFail()
        }

        XCTAssert(otherExtraItem1.value == extraItem1.value)
        XCTAssert(otherExtraItem2.value == extraItem2.value)

        XCTAssert(other.itemList.count == tag.itemList.count)
    }

    func testVersion2CaseD() {
        let tag = APETag(version: APEVersion.v2)

        tag.headerPresent = false
        tag.footerPresent = false

        tag.fillingLength = 0

        XCTAssert(tag.isEmpty && (tag.toData() == nil))

        tag.title = "Title"
        tag.artists = ["Artist 1", "Artist 2"]

        tag.album = "Album"
        tag.genres = ["Genre 1", "Genre 2", "Genre 3"]

        tag.releaseDate = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: 34, second: 56))

        tag.trackNumber = TagNumber(3, total: 4)
        tag.discNumber = TagNumber(1, total: 2)

        tag.coverArt = TagImage(data: [1, 2, 3], description: "Cover art")

        tag.copyrights = ["Copyright"]
        tag.comments = ["Comment 1", "Comment 2", "Comment 3", "Comment 4"]

        tag.lyrics = TagLyrics(pieces: [TagLyrics.Piece("Lyrics piece 1", timeStamp: 1230),
                                        TagLyrics.Piece("Lyrics piece 2", timeStamp: 4560)])

        guard let extraItem1 = tag.appendItem("Extra item 1") else {
            return XCTFail()
        }

        guard let extraItem2 = tag.appendItem("Extra item 2") else {
            return XCTFail()
        }

        extraItem1.timeValue = TagTime(hour: 12, minute: 34, second: 56)
        extraItem2.dateValue = TagDate(year: 1998, month: 12, day: 31)

        XCTAssert((!tag.isEmpty) && (tag.toData() == nil))
    }
}
