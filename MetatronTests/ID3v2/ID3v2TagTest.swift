//
//  ID3v2TagTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 13.10.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

extension ID3v2Tag {

    // MARK: Initializers

    fileprivate convenience init?(fromData data: [UInt8], range: inout Range<UInt64>) {
        let stream = MemoryStream(data: data)

        guard stream.openForReading() else {
            return nil
        }

        self.init(fromStream: stream, range: &range)
    }
}

class ID3v2TagTest: XCTestCase {

    // MARK: Instance Methods

    func testSubscript() {
        let tag = ID3v2Tag()

        XCTAssert(tag.isEmpty && (tag.frameSetList.count == 0))

        tag.appendFrameSet(ID3v2FrameID.aenc)
        tag.appendFrameSet(ID3v2FrameID.apic)

        XCTAssert((!tag.isEmpty) && (tag.frameSetList.count == 2))

        guard let frameSet1 = tag[ID3v2FrameID.aenc] else {
            return XCTFail()
        }

        guard let frameSet2 = tag[ID3v2FrameID.aenc] else {
            return XCTFail()
        }

        guard let frameSet3 = tag[ID3v2FrameID.apic] else {
            return XCTFail()
        }

        XCTAssert(frameSet1 === frameSet2)
        XCTAssert(frameSet1 !== frameSet3)

        XCTAssert(frameSet1.identifier == ID3v2FrameID.aenc)
        XCTAssert(frameSet2.identifier == ID3v2FrameID.aenc)
        XCTAssert(frameSet3.identifier == ID3v2FrameID.apic)

        XCTAssert(tag[ID3v2FrameID.aspi] == nil)
        XCTAssert(tag[ID3v2FrameID.comm] == nil)
    }

    // MARK:

    func testAppendFrameSet() {
        let tag = ID3v2Tag()

        XCTAssert(tag.isEmpty && (tag.frameSetList.count == 0))

        let frameSet1 = tag.appendFrameSet(ID3v2FrameID.aenc)

        XCTAssert((!tag.isEmpty) && (tag.frameSetList.count == 1))

        let frameSet2 = tag.appendFrameSet(ID3v2FrameID.aenc)

        XCTAssert((!tag.isEmpty) && (tag.frameSetList.count == 1))

        let frameSet3 = tag.appendFrameSet(ID3v2FrameID.apic)

        XCTAssert((!tag.isEmpty) && (tag.frameSetList.count == 2))

        XCTAssert(frameSet1 === frameSet2)
        XCTAssert(frameSet1 !== frameSet3)

        XCTAssert(frameSet1.identifier == ID3v2FrameID.aenc)
        XCTAssert(frameSet2.identifier == ID3v2FrameID.aenc)
        XCTAssert(frameSet3.identifier == ID3v2FrameID.apic)

        XCTAssert(tag.appendFrameSet(ID3v2FrameID.aenc) === frameSet1)
        XCTAssert(tag.appendFrameSet(ID3v2FrameID.apic) === frameSet3)

        frameSet1.appendFrame()
        frameSet1.appendFrame()

        XCTAssert(tag.appendFrameSet(ID3v2FrameID.aenc) === frameSet1)
        XCTAssert(tag.appendFrameSet(ID3v2FrameID.apic) === frameSet3)

        XCTAssert(frameSet1.frames.count == 3)
        XCTAssert(frameSet3.frames.count == 1)
    }

    func testResetFrameSet() {
        let tag = ID3v2Tag()

        XCTAssert(tag.isEmpty && (tag.frameSetList.count == 0))

        let frameSet1 = tag.resetFrameSet(ID3v2FrameID.aenc)

        XCTAssert((!tag.isEmpty) && (tag.frameSetList.count == 1))

        let frameSet2 = tag.resetFrameSet(ID3v2FrameID.aenc)

        XCTAssert((!tag.isEmpty) && (tag.frameSetList.count == 1))

        let frameSet3 = tag.resetFrameSet(ID3v2FrameID.apic)

        XCTAssert((!tag.isEmpty) && (tag.frameSetList.count == 2))

        XCTAssert(frameSet1 === frameSet2)
        XCTAssert(frameSet1 !== frameSet3)

        XCTAssert(frameSet1.identifier == ID3v2FrameID.aenc)
        XCTAssert(frameSet2.identifier == ID3v2FrameID.aenc)
        XCTAssert(frameSet3.identifier == ID3v2FrameID.apic)

        XCTAssert(tag.resetFrameSet(ID3v2FrameID.aenc) === frameSet1)
        XCTAssert(tag.resetFrameSet(ID3v2FrameID.apic) === frameSet3)

        frameSet1.appendFrame()
        frameSet1.appendFrame()

        XCTAssert(tag.resetFrameSet(ID3v2FrameID.aenc) === frameSet1)
        XCTAssert(tag.resetFrameSet(ID3v2FrameID.apic) === frameSet3)

        XCTAssert(frameSet1.frames.count == 1)
        XCTAssert(frameSet3.frames.count == 1)
    }

    func testRemoveFrameSet() {
        let tag = ID3v2Tag()

        XCTAssert(tag.isEmpty && (tag.frameSetList.count == 0))

        let frameSet1 = tag.appendFrameSet(ID3v2FrameID.aenc)

        XCTAssert((!tag.isEmpty) && (tag.frameSetList.count == 1))

        let frameSet2 = tag.appendFrameSet(ID3v2FrameID.apic)

        XCTAssert((!tag.isEmpty) && (tag.frameSetList.count == 2))

        XCTAssert(tag.removeFrameSet(frameSet1.identifier) == true)
        XCTAssert(tag.removeFrameSet(frameSet1.identifier) == false)

        XCTAssert((!tag.isEmpty) && (tag.frameSetList.count == 1))

        XCTAssert(tag.removeFrameSet(frameSet2.identifier) == true)
        XCTAssert(tag.removeFrameSet(frameSet2.identifier) == false)

        XCTAssert(tag.isEmpty && (tag.frameSetList.count == 0))
    }

    func testRevise() {
        let tag = ID3v2Tag()

        let frameSet1 = tag.appendFrameSet(ID3v2FrameID.aenc)
        let frameSet2 = tag.appendFrameSet(ID3v2FrameID.apic)

        tag.appendFrameSet(ID3v2FrameID.comm)

        XCTAssert((!tag.isEmpty) && (tag.frameSetList.count == 3))

        let stuff1 = frameSet1.mainFrame.imposeStuff(format: ID3v2UnknownValueFormat.regular)
        let stuff2 = frameSet2.mainFrame.imposeStuff(format: ID3v2UnknownValueFormat.regular)

        stuff1.content = [1, 2, 3]
        stuff2.content = [4, 5, 6]

        tag.revise()

        XCTAssert((!tag.isEmpty) && (tag.frameSetList.count == 2))

        XCTAssert(tag.frameSetList[0] === frameSet1)
        XCTAssert(tag.frameSetList[1] === frameSet2)
    }

    func testClear() {
        let tag = ID3v2Tag()

        XCTAssert(tag.isEmpty && (tag.frameSetList.count == 0))

        let frameSet1 = tag.appendFrameSet(ID3v2FrameID.aenc)
        let frameSet2 = tag.appendFrameSet(ID3v2FrameID.apic)

        tag.appendFrameSet(ID3v2FrameID.comm)

        XCTAssert((!tag.isEmpty) && (tag.frameSetList.count == 3))

        let stuff1 = frameSet1.mainFrame.imposeStuff(format: ID3v2UnknownValueFormat.regular)
        let stuff2 = frameSet2.mainFrame.imposeStuff(format: ID3v2UnknownValueFormat.regular)

        stuff1.content = [1, 2, 3]
        stuff2.content = [4, 5, 6]

        tag.clear()

        XCTAssert(tag.isEmpty && (tag.frameSetList.count == 0))
    }

    // MARK:

    func testVersion2CaseA() {
        let tag = ID3v2Tag(version: ID3v2Version.v2)

        tag.revision = 123

        tag.experimentalIndicator = true
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

        tag.coverArt = TagImage(data: [1, 2, 3], mainMimeType: "image/png", description: "Cover art")

        tag.copyrights = ["Copyright"]
        tag.comments = ["Comment 1", "Comment 2", "Comment 3", "Comment 4"]

        tag.lyrics = TagLyrics(pieces: [TagLyrics.Piece("Lyrics piece 1", timeStamp: 1230),
                                        TagLyrics.Piece("Lyrics piece 2", timeStamp: 4560)])

        let extraFrameSet1 = tag.appendFrameSet(ID3v2FrameID.tcom)
        let extraFrameSet2 = tag.appendFrameSet(ID3v2FrameID.tpub)

        let extraStuff1 = extraFrameSet1.mainFrame.imposeStuff(format: ID3v2TextInformationFormat.regular)
        let extraStuff2 = extraFrameSet2.mainFrame.imposeStuff(format: ID3v2TextInformationFormat.regular)

        extraStuff1.timeValue = TagTime(hour: 12, minute: 34, second: 56)
        extraStuff2.dateValue = TagDate(year: 1998, month: 12, day: 31)

        XCTAssert(!tag.isEmpty)

        guard let data = tag.toData() else {
            return XCTFail()
        }

        XCTAssert(data.count == tag.fillingLength)

        let prefixData = Array<UInt8>(repeating: 123, count: 123)
        let suffixData = Array<UInt8>(repeating: 231, count: 231)

        var range = Range<UInt64>(123..<(123 + UInt64(data.count)))

        guard let other = ID3v2Tag(fromData: prefixData + data + suffixData, range: &range) else {
            return XCTFail()
        }

        XCTAssert(range.lowerBound == 123)
        XCTAssert(range.upperBound == 123 + UInt64(data.count))

        XCTAssert(!other.isEmpty)

        XCTAssert(other.version == tag.version)
        XCTAssert(other.revision == tag.revision)

        XCTAssert(other.experimentalIndicator == false)
        XCTAssert(other.footerPresent == false)

        XCTAssert(other.fillingLength == tag.fillingLength)

        XCTAssert(other.title == tag.title)
        XCTAssert(other.artists == tag.artists)

        XCTAssert(other.album == tag.album)
        XCTAssert(other.genres == tag.genres)

        XCTAssert(other.releaseDate == TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: 34)))

        XCTAssert(other.trackNumber == tag.trackNumber)
        XCTAssert(other.discNumber == tag.discNumber)

        XCTAssert(other.coverArt == tag.coverArt)

        XCTAssert(other.copyrights == tag.copyrights)
        XCTAssert(other.comments == tag.comments)

        XCTAssert(other.lyrics == tag.lyrics)

        guard let otherFrameSet1 = other[ID3v2FrameID.tcom] else {
            return XCTFail()
        }

        guard let otherFrameSet2 = other[ID3v2FrameID.tpub] else {
            return XCTFail()
        }

        let otherExtraStuff1 = otherFrameSet1.mainFrame.stuff(format: ID3v2TextInformationFormat.regular)
        let otherExtraStuff2 = otherFrameSet2.mainFrame.stuff(format: ID3v2TextInformationFormat.regular)

        XCTAssert(otherExtraStuff1.timeValue == TagTime(hour: 12, minute: 34))
        XCTAssert(otherExtraStuff2.dateValue == TagDate(year: 1998, month: 12, day: 31))

        XCTAssert(other.frameSetList.count == tag.frameSetList.count - 1)
    }

    func testVersion2CaseB() {
        let tag = ID3v2Tag(version: ID3v2Version.v2)

        tag.revision = 123

        tag.experimentalIndicator = true
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

        tag.coverArt = TagImage(data: [1, 2, 3], mainMimeType: "image/jpeg", description: "Cover art")

        tag.copyrights = ["Copyright"]
        tag.comments = ["Comment 1", "Comment 2", "Comment 3", "Comment 4"]

        tag.lyrics = TagLyrics(pieces: [TagLyrics.Piece("Lyrics piece 1", timeStamp: 1230),
                                        TagLyrics.Piece("Lyrics piece 2", timeStamp: 4560)])

        let extraFrameSet1 = tag.appendFrameSet(ID3v2FrameID.tcom)
        let extraFrameSet2 = tag.appendFrameSet(ID3v2FrameID.tpub)

        let extraStuff1 = extraFrameSet1.mainFrame.imposeStuff(format: ID3v2TextInformationFormat.regular)
        let extraStuff2 = extraFrameSet2.mainFrame.imposeStuff(format: ID3v2TextInformationFormat.regular)

        extraStuff1.timeValue = TagTime(hour: 12, minute: 34, second: 56)
        extraStuff2.dateValue = TagDate(year: 1998, month: 12, day: 31)

        XCTAssert(!tag.isEmpty)

        guard let data = tag.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        let prefixData = Array<UInt8>(repeating: 123, count: 123)
        let suffixData = Array<UInt8>(repeating: 231, count: 231)

        var range = Range<UInt64>(123..<(354 + UInt64(data.count)))

        guard let other = ID3v2Tag(fromData: prefixData + data + suffixData, range: &range) else {
            return XCTFail()
        }

        XCTAssert(range.lowerBound == 123)
        XCTAssert(range.upperBound == 123 + UInt64(data.count))

        XCTAssert(!other.isEmpty)

        XCTAssert(other.version == tag.version)
        XCTAssert(other.revision == tag.revision)

        XCTAssert(other.experimentalIndicator == false)
        XCTAssert(other.footerPresent == false)

        XCTAssert(other.fillingLength == tag.fillingLength)

        XCTAssert(other.title == tag.title)
        XCTAssert(other.artists == tag.artists)

        XCTAssert(other.album == tag.album)
        XCTAssert(other.genres == tag.genres)

        XCTAssert(other.releaseDate == TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: 34)))

        XCTAssert(other.trackNumber == tag.trackNumber)
        XCTAssert(other.discNumber == tag.discNumber)

        XCTAssert(other.coverArt == tag.coverArt)

        XCTAssert(other.copyrights == tag.copyrights)
        XCTAssert(other.comments == tag.comments)

        XCTAssert(other.lyrics == tag.lyrics)

        guard let otherFrameSet1 = other[ID3v2FrameID.tcom] else {
            return XCTFail()
        }

        guard let otherFrameSet2 = other[ID3v2FrameID.tpub] else {
            return XCTFail()
        }

        let otherExtraStuff1 = otherFrameSet1.mainFrame.stuff(format: ID3v2TextInformationFormat.regular)
        let otherExtraStuff2 = otherFrameSet2.mainFrame.stuff(format: ID3v2TextInformationFormat.regular)

        XCTAssert(otherExtraStuff1.timeValue == TagTime(hour: 12, minute: 34))
        XCTAssert(otherExtraStuff2.dateValue == TagDate(year: 1998, month: 12, day: 31))

        XCTAssert(other.frameSetList.count == tag.frameSetList.count - 1)
    }

    func testVersion2CaseC() {
        let tag = ID3v2Tag(version: ID3v2Version.v2)

        tag.revision = 0

        tag.experimentalIndicator = false
        tag.footerPresent = false

        tag.fillingLength = 123456

        XCTAssert(tag.isEmpty && (tag.toData() == nil))

        tag.title = "Title"
        tag.artists = ["Artist 1", "Artist 2"]

        tag.album = "Album"
        tag.genres = ["Genre 1", "Genre 2", "Genre 3"]

        tag.releaseDate = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: 34, second: 56))

        tag.trackNumber = TagNumber(3, total: 4)
        tag.discNumber = TagNumber(1, total: 2)

        tag.coverArt = TagImage(data: [1, 2, 3], mainMimeType: "image/gif", description: "Cover art")

        tag.copyrights = ["Copyright"]
        tag.comments = ["Comment 1", "Comment 2", "Comment 3", "Comment 4"]

        tag.lyrics = TagLyrics(pieces: [TagLyrics.Piece("Lyrics piece 1", timeStamp: 1230),
                                        TagLyrics.Piece("Lyrics piece 2", timeStamp: 4560)])

        let extraFrameSet1 = tag.appendFrameSet(ID3v2FrameID.tcom)
        let extraFrameSet2 = tag.appendFrameSet(ID3v2FrameID.tpub)

        let extraStuff1 = extraFrameSet1.mainFrame.imposeStuff(format: ID3v2TextInformationFormat.regular)
        let extraStuff2 = extraFrameSet2.mainFrame.imposeStuff(format: ID3v2TextInformationFormat.regular)

        extraStuff1.timeValue = TagTime(hour: 12, minute: 34, second: 56)
        extraStuff2.dateValue = TagDate(year: 1998, month: 12, day: 31)

        XCTAssert(!tag.isEmpty)

        guard let data = tag.toData() else {
            return XCTFail()
        }

        XCTAssert(data.count == tag.fillingLength)

        var range = Range<UInt64>(0..<UInt64(data.count))

        guard let other = ID3v2Tag(fromData: data, range: &range) else {
            return XCTFail()
        }

        XCTAssert(range.lowerBound == 0)
        XCTAssert(range.upperBound == UInt64(data.count))

        XCTAssert(!other.isEmpty)

        XCTAssert(other.version == tag.version)
        XCTAssert(other.revision == tag.revision)

        XCTAssert(other.experimentalIndicator == false)
        XCTAssert(other.footerPresent == false)

        XCTAssert(other.fillingLength == tag.fillingLength)

        XCTAssert(other.title == tag.title)
        XCTAssert(other.artists == tag.artists)

        XCTAssert(other.album == tag.album)
        XCTAssert(other.genres == tag.genres)

        XCTAssert(other.releaseDate == TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: 34)))

        XCTAssert(other.trackNumber == tag.trackNumber)
        XCTAssert(other.discNumber == tag.discNumber)

        XCTAssert(other.coverArt == TagImage())

        XCTAssert(other.copyrights == tag.copyrights)
        XCTAssert(other.comments == tag.comments)

        XCTAssert(other.lyrics == tag.lyrics)

        guard let otherFrameSet1 = other[ID3v2FrameID.tcom] else {
            return XCTFail()
        }

        guard let otherFrameSet2 = other[ID3v2FrameID.tpub] else {
            return XCTFail()
        }

        let otherExtraStuff1 = otherFrameSet1.mainFrame.stuff(format: ID3v2TextInformationFormat.regular)
        let otherExtraStuff2 = otherFrameSet2.mainFrame.stuff(format: ID3v2TextInformationFormat.regular)

        XCTAssert(otherExtraStuff1.timeValue == TagTime(hour: 12, minute: 34))
        XCTAssert(otherExtraStuff2.dateValue == TagDate(year: 1998, month: 12, day: 31))

        XCTAssert(other.frameSetList.count == tag.frameSetList.count - 2)
    }

    // MARK:

    func testVersion3CaseA() {
        let tag = ID3v2Tag(version: ID3v2Version.v3)

        tag.revision = 123

        tag.experimentalIndicator = true
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

        tag.coverArt = TagImage(data: [1, 2, 3], mainMimeType: "image/png", description: "Cover art")

        tag.copyrights = ["Copyright"]
        tag.comments = ["Comment 1", "Comment 2", "Comment 3", "Comment 4"]

        tag.lyrics = TagLyrics(pieces: [TagLyrics.Piece("Lyrics piece 1", timeStamp: 1230),
                                        TagLyrics.Piece("Lyrics piece 2", timeStamp: 4560)])

        let extraFrameSet1 = tag.appendFrameSet(ID3v2FrameID.tcom)
        let extraFrameSet2 = tag.appendFrameSet(ID3v2FrameID.tpub)

        let extraStuff1 = extraFrameSet1.mainFrame.imposeStuff(format: ID3v2TextInformationFormat.regular)
        let extraStuff2 = extraFrameSet2.mainFrame.imposeStuff(format: ID3v2TextInformationFormat.regular)

        extraStuff1.timeValue = TagTime(hour: 12, minute: 34, second: 56)
        extraStuff2.dateValue = TagDate(year: 1998, month: 12, day: 31)

        XCTAssert(!tag.isEmpty)

        guard let data = tag.toData() else {
            return XCTFail()
        }

        XCTAssert(data.count == tag.fillingLength)

        let prefixData = Array<UInt8>(repeating: 123, count: 123)
        let suffixData = Array<UInt8>(repeating: 231, count: 231)

        var range = Range<UInt64>(123..<(123 + UInt64(data.count)))

        guard let other = ID3v2Tag(fromData: prefixData + data + suffixData, range: &range) else {
            return XCTFail()
        }

        XCTAssert(range.lowerBound == 123)
        XCTAssert(range.upperBound == 123 + UInt64(data.count))

        XCTAssert(!other.isEmpty)

        XCTAssert(other.version == tag.version)
        XCTAssert(other.revision == tag.revision)

        XCTAssert(other.experimentalIndicator == tag.experimentalIndicator)
        XCTAssert(other.footerPresent == false)

        XCTAssert(other.fillingLength == tag.fillingLength)

        XCTAssert(other.title == tag.title)
        XCTAssert(other.artists == tag.artists)

        XCTAssert(other.album == tag.album)
        XCTAssert(other.genres == tag.genres)

        XCTAssert(other.releaseDate == TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: 34)))

        XCTAssert(other.trackNumber == tag.trackNumber)
        XCTAssert(other.discNumber == tag.discNumber)

        XCTAssert(other.coverArt == tag.coverArt)

        XCTAssert(other.copyrights == tag.copyrights)
        XCTAssert(other.comments == tag.comments)

        XCTAssert(other.lyrics == tag.lyrics)

        guard let otherFrameSet1 = other[ID3v2FrameID.tcom] else {
            return XCTFail()
        }

        guard let otherFrameSet2 = other[ID3v2FrameID.tpub] else {
            return XCTFail()
        }

        let otherExtraStuff1 = otherFrameSet1.mainFrame.stuff(format: ID3v2TextInformationFormat.regular)
        let otherExtraStuff2 = otherFrameSet2.mainFrame.stuff(format: ID3v2TextInformationFormat.regular)

        XCTAssert(otherExtraStuff1.timeValue == TagTime(hour: 12, minute: 34))
        XCTAssert(otherExtraStuff2.dateValue == TagDate(year: 1998, month: 12, day: 31))

        XCTAssert(other.frameSetList.count == tag.frameSetList.count - 1)
    }

    func testVersion3CaseB() {
        let tag = ID3v2Tag(version: ID3v2Version.v3)

        tag.revision = 123

        tag.experimentalIndicator = true
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

        tag.coverArt = TagImage(data: [1, 2, 3], mainMimeType: "image/jpeg", description: "Cover art")

        tag.copyrights = ["Copyright"]
        tag.comments = ["Comment 1", "Comment 2", "Comment 3", "Comment 4"]

        tag.lyrics = TagLyrics(pieces: [TagLyrics.Piece("Lyrics piece 1", timeStamp: 1230),
                                        TagLyrics.Piece("Lyrics piece 2", timeStamp: 4560)])

        let extraFrameSet1 = tag.appendFrameSet(ID3v2FrameID.tcom)
        let extraFrameSet2 = tag.appendFrameSet(ID3v2FrameID.tpub)

        let extraStuff1 = extraFrameSet1.mainFrame.imposeStuff(format: ID3v2TextInformationFormat.regular)
        let extraStuff2 = extraFrameSet2.mainFrame.imposeStuff(format: ID3v2TextInformationFormat.regular)

        extraStuff1.timeValue = TagTime(hour: 12, minute: 34, second: 56)
        extraStuff2.dateValue = TagDate(year: 1998, month: 12, day: 31)

        XCTAssert(!tag.isEmpty)

        guard let data = tag.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        let prefixData = Array<UInt8>(repeating: 123, count: 123)
        let suffixData = Array<UInt8>(repeating: 231, count: 231)

        var range = Range<UInt64>(123..<(354 + UInt64(data.count)))

        guard let other = ID3v2Tag(fromData: prefixData + data + suffixData, range: &range) else {
            return XCTFail()
        }

        XCTAssert(range.lowerBound == 123)
        XCTAssert(range.upperBound == 123 + UInt64(data.count))

        XCTAssert(!other.isEmpty)

        XCTAssert(other.version == tag.version)
        XCTAssert(other.revision == tag.revision)

        XCTAssert(other.experimentalIndicator == tag.experimentalIndicator)
        XCTAssert(other.footerPresent == false)

        XCTAssert(other.fillingLength == tag.fillingLength)

        XCTAssert(other.title == tag.title)
        XCTAssert(other.artists == tag.artists)

        XCTAssert(other.album == tag.album)
        XCTAssert(other.genres == tag.genres)

        XCTAssert(other.releaseDate == TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: 34)))

        XCTAssert(other.trackNumber == tag.trackNumber)
        XCTAssert(other.discNumber == tag.discNumber)

        XCTAssert(other.coverArt == tag.coverArt)

        XCTAssert(other.copyrights == tag.copyrights)
        XCTAssert(other.comments == tag.comments)

        XCTAssert(other.lyrics == tag.lyrics)

        guard let otherFrameSet1 = other[ID3v2FrameID.tcom] else {
            return XCTFail()
        }

        guard let otherFrameSet2 = other[ID3v2FrameID.tpub] else {
            return XCTFail()
        }

        let otherExtraStuff1 = otherFrameSet1.mainFrame.stuff(format: ID3v2TextInformationFormat.regular)
        let otherExtraStuff2 = otherFrameSet2.mainFrame.stuff(format: ID3v2TextInformationFormat.regular)

        XCTAssert(otherExtraStuff1.timeValue == TagTime(hour: 12, minute: 34))
        XCTAssert(otherExtraStuff2.dateValue == TagDate(year: 1998, month: 12, day: 31))

        XCTAssert(other.frameSetList.count == tag.frameSetList.count - 1)
    }

    func testVersion3CaseC() {
        let tag = ID3v2Tag(version: ID3v2Version.v3)

        tag.revision = 0

        tag.experimentalIndicator = false
        tag.footerPresent = false

        tag.fillingLength = 123456

        XCTAssert(tag.isEmpty && (tag.toData() == nil))

        tag.title = "Title"
        tag.artists = ["Artist 1", "Artist 2"]

        tag.album = "Album"
        tag.genres = ["Genre 1", "Genre 2", "Genre 3"]

        tag.releaseDate = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: 34, second: 56))

        tag.trackNumber = TagNumber(3, total: 4)
        tag.discNumber = TagNumber(1, total: 2)

        tag.coverArt = TagImage(data: [1, 2, 3], mainMimeType: "image/gif", description: "Cover art")

        tag.copyrights = ["Copyright"]
        tag.comments = ["Comment 1", "Comment 2", "Comment 3", "Comment 4"]

        tag.lyrics = TagLyrics(pieces: [TagLyrics.Piece("Lyrics piece 1", timeStamp: 1230),
                                        TagLyrics.Piece("Lyrics piece 2", timeStamp: 4560)])

        let extraFrameSet1 = tag.appendFrameSet(ID3v2FrameID.tcom)
        let extraFrameSet2 = tag.appendFrameSet(ID3v2FrameID.tpub)

        let extraStuff1 = extraFrameSet1.mainFrame.imposeStuff(format: ID3v2TextInformationFormat.regular)
        let extraStuff2 = extraFrameSet2.mainFrame.imposeStuff(format: ID3v2TextInformationFormat.regular)

        extraStuff1.timeValue = TagTime(hour: 12, minute: 34, second: 56)
        extraStuff2.dateValue = TagDate(year: 1998, month: 12, day: 31)

        XCTAssert(!tag.isEmpty)

        guard let data = tag.toData() else {
            return XCTFail()
        }

        XCTAssert(data.count == tag.fillingLength)

        var range = Range<UInt64>(0..<UInt64(data.count))

        guard let other = ID3v2Tag(fromData: data, range: &range) else {
            return XCTFail()
        }

        XCTAssert(range.lowerBound == 0)
        XCTAssert(range.upperBound == UInt64(data.count))

        XCTAssert(!other.isEmpty)

        XCTAssert(other.version == tag.version)
        XCTAssert(other.revision == tag.revision)

        XCTAssert(other.experimentalIndicator == tag.experimentalIndicator)
        XCTAssert(other.footerPresent == false)

        XCTAssert(other.fillingLength == tag.fillingLength)

        XCTAssert(other.title == tag.title)
        XCTAssert(other.artists == tag.artists)

        XCTAssert(other.album == tag.album)
        XCTAssert(other.genres == tag.genres)

        XCTAssert(other.releaseDate == TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: 34)))

        XCTAssert(other.trackNumber == tag.trackNumber)
        XCTAssert(other.discNumber == tag.discNumber)

        XCTAssert(other.coverArt == tag.coverArt)

        XCTAssert(other.copyrights == tag.copyrights)
        XCTAssert(other.comments == tag.comments)

        XCTAssert(other.lyrics == tag.lyrics)

        guard let otherFrameSet1 = other[ID3v2FrameID.tcom] else {
            return XCTFail()
        }

        guard let otherFrameSet2 = other[ID3v2FrameID.tpub] else {
            return XCTFail()
        }

        let otherExtraStuff1 = otherFrameSet1.mainFrame.stuff(format: ID3v2TextInformationFormat.regular)
        let otherExtraStuff2 = otherFrameSet2.mainFrame.stuff(format: ID3v2TextInformationFormat.regular)

        XCTAssert(otherExtraStuff1.timeValue == TagTime(hour: 12, minute: 34))
        XCTAssert(otherExtraStuff2.dateValue == TagDate(year: 1998, month: 12, day: 31))

        XCTAssert(other.frameSetList.count == tag.frameSetList.count - 1)
    }

    // MARK:

    func testVersion4CaseA() {
        let tag = ID3v2Tag(version: ID3v2Version.v4)

        tag.revision = 123

        tag.experimentalIndicator = true
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

        tag.coverArt = TagImage(data: [1, 2, 3], mainMimeType: "image/png", description: "Cover art")

        tag.copyrights = ["Copyright"]
        tag.comments = ["Comment 1", "Comment 2", "Comment 3", "Comment 4"]

        tag.lyrics = TagLyrics(pieces: [TagLyrics.Piece("Lyrics piece 1", timeStamp: 1230),
                                        TagLyrics.Piece("Lyrics piece 2", timeStamp: 4560)])

        let extraFrameSet1 = tag.appendFrameSet(ID3v2FrameID.tcom)
        let extraFrameSet2 = tag.appendFrameSet(ID3v2FrameID.tpub)

        let extraStuff1 = extraFrameSet1.mainFrame.imposeStuff(format: ID3v2TextInformationFormat.regular)
        let extraStuff2 = extraFrameSet2.mainFrame.imposeStuff(format: ID3v2TextInformationFormat.regular)

        extraStuff1.timeValue = TagTime(hour: 12, minute: 34, second: 56)
        extraStuff2.dateValue = TagDate(year: 1998, month: 12, day: 31)

        XCTAssert(!tag.isEmpty)

        guard let data = tag.toData() else {
            return XCTFail()
        }

        XCTAssert(data.count == tag.fillingLength)

        let prefixData = Array<UInt8>(repeating: 123, count: 123)
        let suffixData = Array<UInt8>(repeating: 231, count: 231)

        var range = Range<UInt64>(0..<(123 + UInt64(data.count)))

        guard let other = ID3v2Tag(fromData: prefixData + data + suffixData, range: &range) else {
            return XCTFail()
        }

        XCTAssert(range.lowerBound == 123)
        XCTAssert(range.upperBound == 123 + UInt64(data.count))

        XCTAssert(!other.isEmpty)

        XCTAssert(other.version == tag.version)
        XCTAssert(other.revision == tag.revision)

        XCTAssert(other.experimentalIndicator == tag.experimentalIndicator)
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

        guard let otherFrameSet1 = other[ID3v2FrameID.tcom] else {
            return XCTFail()
        }

        guard let otherFrameSet2 = other[ID3v2FrameID.tpub] else {
            return XCTFail()
        }

        let otherExtraStuff1 = otherFrameSet1.mainFrame.stuff(format: ID3v2TextInformationFormat.regular)
        let otherExtraStuff2 = otherFrameSet2.mainFrame.stuff(format: ID3v2TextInformationFormat.regular)

        XCTAssert(otherExtraStuff1.timeValue == TagTime(hour: 12, minute: 34))
        XCTAssert(otherExtraStuff2.dateValue == TagDate(year: 1998, month: 12, day: 31))

        XCTAssert(other.frameSetList.count == tag.frameSetList.count - 3)
    }

    func testVersion4CaseB() {
        let tag = ID3v2Tag(version: ID3v2Version.v4)

        tag.revision = 123

        tag.experimentalIndicator = true
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

        tag.coverArt = TagImage(data: [1, 2, 3], mainMimeType: "image/jpeg", description: "Cover art")

        tag.copyrights = ["Copyright"]
        tag.comments = ["Comment 1", "Comment 2", "Comment 3", "Comment 4"]

        tag.lyrics = TagLyrics(pieces: [TagLyrics.Piece("Lyrics piece 1", timeStamp: 1230),
                                        TagLyrics.Piece("Lyrics piece 2", timeStamp: 4560)])

        let extraFrameSet1 = tag.appendFrameSet(ID3v2FrameID.tcom)
        let extraFrameSet2 = tag.appendFrameSet(ID3v2FrameID.tpub)

        let extraStuff1 = extraFrameSet1.mainFrame.imposeStuff(format: ID3v2TextInformationFormat.regular)
        let extraStuff2 = extraFrameSet2.mainFrame.imposeStuff(format: ID3v2TextInformationFormat.regular)

        extraStuff1.timeValue = TagTime(hour: 12, minute: 34, second: 56)
        extraStuff2.dateValue = TagDate(year: 1998, month: 12, day: 31)

        XCTAssert(!tag.isEmpty)

        guard let data = tag.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        let prefixData = Array<UInt8>(repeating: 123, count: 123)
        let suffixData = Array<UInt8>(repeating: 231, count: 231)

        var range = Range<UInt64>(123..<(354 + UInt64(data.count)))

        guard let other = ID3v2Tag(fromData: prefixData + data + suffixData, range: &range) else {
            return XCTFail()
        }

        XCTAssert(range.lowerBound == 123)
        XCTAssert(range.upperBound == 123 + UInt64(data.count))

        XCTAssert(!other.isEmpty)

        XCTAssert(other.version == tag.version)
        XCTAssert(other.revision == tag.revision)

        XCTAssert(other.experimentalIndicator == tag.experimentalIndicator)
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

        guard let otherFrameSet1 = other[ID3v2FrameID.tcom] else {
            return XCTFail()
        }

        guard let otherFrameSet2 = other[ID3v2FrameID.tpub] else {
            return XCTFail()
        }

        let otherExtraStuff1 = otherFrameSet1.mainFrame.stuff(format: ID3v2TextInformationFormat.regular)
        let otherExtraStuff2 = otherFrameSet2.mainFrame.stuff(format: ID3v2TextInformationFormat.regular)

        XCTAssert(otherExtraStuff1.timeValue == TagTime(hour: 12, minute: 34))
        XCTAssert(otherExtraStuff2.dateValue == TagDate(year: 1998, month: 12, day: 31))

        XCTAssert(other.frameSetList.count == tag.frameSetList.count - 3)
    }

    func testVersion4CaseC() {
        let tag = ID3v2Tag(version: ID3v2Version.v4)

        tag.revision = 0

        tag.experimentalIndicator = false
        tag.footerPresent = false

        tag.fillingLength = 123456

        XCTAssert(tag.isEmpty && (tag.toData() == nil))

        tag.title = "Title"
        tag.artists = ["Artist 1", "Artist 2"]

        tag.album = "Album"
        tag.genres = ["Genre 1", "Genre 2", "Genre 3"]

        tag.releaseDate = TagDate(year: 1998, month: 12, day: 31, time: TagTime(hour: 12, minute: 34, second: 56))

        tag.trackNumber = TagNumber(3, total: 4)
        tag.discNumber = TagNumber(1, total: 2)

        tag.coverArt = TagImage(data: [1, 2, 3], mainMimeType: "image/gif", description: "Cover art")

        tag.copyrights = ["Copyright"]
        tag.comments = ["Comment 1", "Comment 2", "Comment 3", "Comment 4"]

        tag.lyrics = TagLyrics(pieces: [TagLyrics.Piece("Lyrics piece 1", timeStamp: 1230),
                                        TagLyrics.Piece("Lyrics piece 2", timeStamp: 4560)])

        let extraFrameSet1 = tag.appendFrameSet(ID3v2FrameID.tcom)
        let extraFrameSet2 = tag.appendFrameSet(ID3v2FrameID.tpub)

        let extraStuff1 = extraFrameSet1.mainFrame.imposeStuff(format: ID3v2TextInformationFormat.regular)
        let extraStuff2 = extraFrameSet2.mainFrame.imposeStuff(format: ID3v2TextInformationFormat.regular)

        extraStuff1.timeValue = TagTime(hour: 12, minute: 34, second: 56)
        extraStuff2.dateValue = TagDate(year: 1998, month: 12, day: 31)

        XCTAssert(!tag.isEmpty)

        guard let data = tag.toData() else {
            return XCTFail()
        }

        XCTAssert(data.count == tag.fillingLength)

        var range = Range<UInt64>(0..<UInt64(data.count))

        guard let other = ID3v2Tag(fromData: data, range: &range) else {
            return XCTFail()
        }

        XCTAssert(range.lowerBound == 0)
        XCTAssert(range.upperBound == UInt64(data.count))

        XCTAssert(!other.isEmpty)

        XCTAssert(other.version == tag.version)
        XCTAssert(other.revision == tag.revision)

        XCTAssert(other.experimentalIndicator == tag.experimentalIndicator)
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

        guard let otherFrameSet1 = other[ID3v2FrameID.tcom] else {
            return XCTFail()
        }

        guard let otherFrameSet2 = other[ID3v2FrameID.tpub] else {
            return XCTFail()
        }

        let otherExtraStuff1 = otherFrameSet1.mainFrame.stuff(format: ID3v2TextInformationFormat.regular)
        let otherExtraStuff2 = otherFrameSet2.mainFrame.stuff(format: ID3v2TextInformationFormat.regular)

        XCTAssert(otherExtraStuff1.timeValue == TagTime(hour: 12, minute: 34))
        XCTAssert(otherExtraStuff2.dateValue == TagDate(year: 1998, month: 12, day: 31))

        XCTAssert(other.frameSetList.count == tag.frameSetList.count - 3)
    }

    // MARK:

    func testFrameLengthV4File() {
        guard let filePath = Bundle(for: type(of: self)).url(forResource: "frame_length_v4", withExtension: "id3") else {
            return XCTFail()
        }

        guard let data = try? Data(contentsOf: filePath) else {
            return XCTFail()
        }

        guard let tag = ID3v2Tag(fromData: [UInt8](data)) else {
            return XCTFail()
        }

        XCTAssert(!tag.isEmpty)

        XCTAssert(tag.version == ID3v2Version.v4)
        XCTAssert(tag.revision == 0)

        XCTAssert(tag.experimentalIndicator == false)
        XCTAssert(tag.footerPresent == false)

        XCTAssert(tag.fillingLength == 38402)

        XCTAssert(tag.frameSetList.count == 9)

        XCTAssert(tag.title == "Sunshine Superman")
        XCTAssert(tag.artists == ["Donovan"])

        XCTAssert(tag.album == "Sunshine Superman")
        XCTAssert(tag.genres == ["Folk"])

        XCTAssert(tag.releaseDate == TagDate(year: 1966))

        XCTAssert(tag.trackNumber == TagNumber(1))
        XCTAssert(tag.discNumber == TagNumber())

        XCTAssert(!tag.coverArt.isEmpty)

        XCTAssert(tag.copyrights == [])
        XCTAssert(tag.comments == [])

        XCTAssert(tag.lyrics == TagLyrics())

        guard let otherFrameSet = tag[ID3v2FrameID.wcom] else {
            return XCTFail()
        }

        XCTAssert(!otherFrameSet.mainFrame.stuff(format: ID3v2URLLinkFormat.regular).isEmpty)
    }

    func testUnsynchronisedFile() {
        guard let filePath = Bundle(for: type(of: self)).url(forResource: "unsynchronised", withExtension: "id3") else {
            return XCTFail()
        }

        guard let data = try? Data(contentsOf: filePath) else {
            return XCTFail()
        }

        guard let tag = ID3v2Tag(fromData: [UInt8](data)) else {
            return XCTFail()
        }

        XCTAssert(!tag.isEmpty)

        XCTAssert(tag.version == ID3v2Version.v3)
        XCTAssert(tag.revision == 0)

        XCTAssert(tag.experimentalIndicator == false)
        XCTAssert(tag.footerPresent == false)

        XCTAssert(tag.fillingLength == 0)

        XCTAssert(tag.frameSetList.count == 5)

        XCTAssert(tag.title == "My babe just cares for me")
        XCTAssert(tag.artists == ["Nina Simone"])

        XCTAssert(tag.album == "100% Jazz")
        XCTAssert(tag.genres == [])

        XCTAssert(tag.releaseDate == TagDate())

        XCTAssert(tag.trackNumber == TagNumber(3))
        XCTAssert(tag.discNumber == TagNumber())

        XCTAssert(tag.coverArt.isEmpty)

        XCTAssert(tag.copyrights == [])
        XCTAssert(tag.comments == [])

        XCTAssert(tag.lyrics == TagLyrics())

        guard let otherFrameSet = tag[ID3v2FrameID.tlen] else {
            return XCTFail()
        }

        XCTAssert(!otherFrameSet.mainFrame.stuff(format: ID3v2TextInformationFormat.regular).isEmpty)
    }

    func testBrokenFrameFile() {
        guard let filePath = Bundle(for: type(of: self)).url(forResource: "broken_frame", withExtension: "id3") else {
            return XCTFail()
        }

        guard let data = try? Data(contentsOf: filePath) else {
            return XCTFail()
        }

        guard let tag = ID3v2Tag(fromData: [UInt8](data)) else {
            return XCTFail()
        }

        XCTAssert(tag.isEmpty)

        XCTAssert(tag.version == ID3v2Version.v4)
        XCTAssert(tag.revision == 0)

        XCTAssert(tag.experimentalIndicator == false)
        XCTAssert(tag.footerPresent == false)

        XCTAssert(tag.fillingLength == 280)

        XCTAssert(tag.frameSetList.isEmpty)

        XCTAssert(tag.title == "")
        XCTAssert(tag.artists == [])

        XCTAssert(tag.album == "")
        XCTAssert(tag.genres == [])

        XCTAssert(tag.releaseDate == TagDate())

        XCTAssert(tag.trackNumber == TagNumber())
        XCTAssert(tag.discNumber == TagNumber())

        XCTAssert(tag.coverArt.isEmpty)

        XCTAssert(tag.copyrights == [])
        XCTAssert(tag.comments == [])

        XCTAssert(tag.lyrics == TagLyrics())
    }
}
