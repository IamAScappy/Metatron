//
//  Lyrics3TagTest.swift
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

extension Lyrics3Tag {

    // MARK: Initializers

    fileprivate convenience init?(fromData data: [UInt8], range: inout Range<UInt64>) {
        let stream = MemoryStream(data: data)

        guard stream.openForReading() else {
            return nil
        }

        self.init(fromStream: stream, range: &range)
    }
}

class Lyrics3TagTest: XCTestCase {

    // MARK: Instance Methods

    func testSubscript() {
        let tag = Lyrics3Tag()

        XCTAssert(tag.isEmpty && (tag.fieldList.count == 0))

        tag.appendField(Lyrics3FieldID.lyr)
        tag.appendField(Lyrics3FieldID.inf)

        XCTAssert((!tag.isEmpty) && (tag.fieldList.count == 2))

        guard let field1 = tag[Lyrics3FieldID.lyr] else {
            return XCTFail()
        }

        guard let field2 = tag[Lyrics3FieldID.lyr] else {
            return XCTFail()
        }

        guard let field3 = tag[Lyrics3FieldID.inf] else {
            return XCTFail()
        }

        XCTAssert(field1 === field2)
        XCTAssert(field1 !== field3)

        XCTAssert(field1.identifier == Lyrics3FieldID.lyr)
        XCTAssert(field2.identifier == Lyrics3FieldID.lyr)
        XCTAssert(field3.identifier == Lyrics3FieldID.inf)

        XCTAssert(tag[Lyrics3FieldID.ind] == nil)
    }

    // MARK:

    func testAppendField() {
        let tag = Lyrics3Tag()

        XCTAssert(tag.isEmpty && (tag.fieldList.count == 0))

        let field1 = tag.appendField(Lyrics3FieldID.lyr)

        XCTAssert((!tag.isEmpty) && (tag.fieldList.count == 1))

        let field2 = tag.appendField(Lyrics3FieldID.lyr)

        XCTAssert((!tag.isEmpty) && (tag.fieldList.count == 1))

        let field3 = tag.appendField(Lyrics3FieldID.inf)

        XCTAssert((!tag.isEmpty) && (tag.fieldList.count == 2))

        XCTAssert(field1 === field2)
        XCTAssert(field1 !== field3)

        XCTAssert(field1.identifier == Lyrics3FieldID.lyr)
        XCTAssert(field2.identifier == Lyrics3FieldID.lyr)
        XCTAssert(field3.identifier == Lyrics3FieldID.inf)

        XCTAssert(tag.appendField(Lyrics3FieldID.lyr) === field1)
        XCTAssert(tag.appendField(Lyrics3FieldID.inf) === field3)

        let stuff = field1.imposeStuff(format: Lyrics3UnknownValueFormat.regular)

        XCTAssert(tag.appendField(Lyrics3FieldID.lyr) === field1)
        XCTAssert(tag.appendField(Lyrics3FieldID.inf) === field3)

        XCTAssert(field1.stuff === stuff)
        XCTAssert(field3.stuff == nil)
    }

    func testResetField() {
        let tag = Lyrics3Tag()

        XCTAssert(tag.isEmpty && (tag.fieldList.count == 0))

        let field1 = tag.resetField(Lyrics3FieldID.lyr)

        XCTAssert((!tag.isEmpty) && (tag.fieldList.count == 1))

        let field2 = tag.resetField(Lyrics3FieldID.lyr)

        XCTAssert((!tag.isEmpty) && (tag.fieldList.count == 1))

        let field3 = tag.resetField(Lyrics3FieldID.inf)

        XCTAssert((!tag.isEmpty) && (tag.fieldList.count == 2))

        XCTAssert(field1 === field2)
        XCTAssert(field1 !== field3)

        XCTAssert(field1.identifier == Lyrics3FieldID.lyr)
        XCTAssert(field2.identifier == Lyrics3FieldID.lyr)
        XCTAssert(field3.identifier == Lyrics3FieldID.inf)

        XCTAssert(tag.resetField(Lyrics3FieldID.lyr) === field1)
        XCTAssert(tag.resetField(Lyrics3FieldID.inf) === field3)

        field1.imposeStuff(format: Lyrics3UnknownValueFormat.regular)

        XCTAssert(tag.resetField(Lyrics3FieldID.lyr) === field1)
        XCTAssert(tag.resetField(Lyrics3FieldID.inf) === field3)

        XCTAssert(field1.stuff == nil)
        XCTAssert(field3.stuff == nil)
    }

    func testRemoveField() {
        let tag = Lyrics3Tag()

        XCTAssert(tag.isEmpty && (tag.fieldList.count == 0))

        let field1 = tag.appendField(Lyrics3FieldID.lyr)

        XCTAssert((!tag.isEmpty) && (tag.fieldList.count == 1))

        let field2 = tag.appendField(Lyrics3FieldID.inf)

        XCTAssert((!tag.isEmpty) && (tag.fieldList.count == 2))

        XCTAssert(tag.removeField(field1.identifier) == true)
        XCTAssert(tag.removeField(field1.identifier) == false)

        XCTAssert((!tag.isEmpty) && (tag.fieldList.count == 1))

        XCTAssert(tag.removeField(field2.identifier) == true)
        XCTAssert(tag.removeField(field2.identifier) == false)

        XCTAssert(tag.isEmpty && (tag.fieldList.count == 0))
    }

    func testRevise() {
        let tag = Lyrics3Tag()

        let field1 = tag.appendField(Lyrics3FieldID.lyr)
        let field2 = tag.appendField(Lyrics3FieldID.inf)

        tag.appendField(Lyrics3FieldID.aut)

        XCTAssert((!tag.isEmpty) && (tag.fieldList.count == 3))

        let stuff1 = field1.imposeStuff(format: Lyrics3UnknownValueFormat.regular)
        let stuff2 = field2.imposeStuff(format: Lyrics3UnknownValueFormat.regular)

        stuff1.content = [1, 2, 3]
        stuff2.content = [4, 5, 6]

        tag.revise()

        XCTAssert((!tag.isEmpty) && (tag.fieldList.count == 2))

        XCTAssert(tag.fieldList[0] === field1)
        XCTAssert(tag.fieldList[1] === field2)
    }

    func testClear() {
        let tag = Lyrics3Tag()

        XCTAssert(tag.isEmpty && (tag.fieldList.count == 0))

        let field1 = tag.appendField(Lyrics3FieldID.lyr)
        let field2 = tag.appendField(Lyrics3FieldID.inf)

        tag.appendField(Lyrics3FieldID.aut)

        XCTAssert((!tag.isEmpty) && (tag.fieldList.count == 3))

        let stuff1 = field1.imposeStuff(format: Lyrics3UnknownValueFormat.regular)
        let stuff2 = field2.imposeStuff(format: Lyrics3UnknownValueFormat.regular)

        stuff1.content = [1, 2, 3]
        stuff2.content = [4, 5, 6]

        tag.clear()

        XCTAssert(tag.isEmpty && (tag.fieldList.count == 0))
    }

    // MARK:

 	func testVersion1CaseA() {
        let tag = Lyrics3Tag(version: Lyrics3Version.v1)

        XCTAssert(tag.isEmpty && (tag.toData() == nil))

        tag.title = "Title"
        tag.artists = ["Artist 1", "Artist 2"]

        tag.album = "Album"

        tag.comments = ["Comment 1", "Comment 2", "Comment 3", "Comment 4"]

        tag.lyrics = TagLyrics(pieces: [TagLyrics.Piece("Lyrics piece 1", timeStamp: 123000),
                                        TagLyrics.Piece("Lyrics piece 2", timeStamp: 456000)])

        let extraField1 = tag.appendField(Lyrics3FieldID.aut)
        let extraField2 = tag.appendField(Lyrics3FieldID.img)

        let extraStuff1 = extraField1.imposeStuff(format: Lyrics3TextInformationFormat.regular)
        let extraStuff2 = extraField2.imposeStuff(format: Lyrics3TextInformationFormat.regular)

        extraStuff1.content = "Author"
        extraStuff2.content = "album_cover.jpg||Album cover||[00:10]\njumping.jpg||He jumps at the audience!||[01:00]"

        XCTAssert(!tag.isEmpty)

        guard let data = tag.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        let prefixData = Array<UInt8>(repeating: 123, count: 123)
        let suffixData = Array<UInt8>(repeating: 231, count: 231)

        var range = Range<UInt64>(123..<(123 + UInt64(data.count)))

        guard let other = Lyrics3Tag(fromData: prefixData + data + suffixData, range: &range) else {
            return XCTFail()
        }

        XCTAssert(range.lowerBound == 123)
        XCTAssert(range.upperBound == 123 + UInt64(data.count))

        XCTAssert(!other.isEmpty)

        XCTAssert(other.version == tag.version)

        XCTAssert(other.title == "")
        XCTAssert(other.artists == [])

        XCTAssert(other.album == "")

        XCTAssert(other.comments == [])

        XCTAssert(other.lyrics == tag.lyrics)

        XCTAssert(other[Lyrics3FieldID.aut] == nil)
        XCTAssert(other[Lyrics3FieldID.img] == nil)

        XCTAssert(other.fieldList.count == 1)
    }

    func testVersion1CaseB() {
        let tag = Lyrics3Tag(version: Lyrics3Version.v1)

        XCTAssert(tag.isEmpty && (tag.toData() == nil))

        tag.title = Array<String>(repeating: "Title", count: 123).joined(separator: " ")
        tag.artists = Array<String>(repeating: "Artist", count: 123)

        tag.album = Array<String>(repeating: "Album", count: 123).joined(separator: " ")

        tag.comments = Array<String>(repeating: "Comment", count: 123)

        tag.lyrics = TagLyrics(pieces: [TagLyrics.Piece("Lyrics piece 1", timeStamp: 123000),
                                        TagLyrics.Piece("Lyrics piece 2", timeStamp: 456000)])

        let extraField1 = tag.appendField(Lyrics3FieldID.aut)
        let extraField2 = tag.appendField(Lyrics3FieldID.img)

        let extraStuff1 = extraField1.imposeStuff(format: Lyrics3TextInformationFormat.regular)
        let extraStuff2 = extraField2.imposeStuff(format: Lyrics3TextInformationFormat.regular)

        extraStuff1.content = Array<String>(repeating: "Author", count: 123).joined(separator: ", ")
        extraStuff2.content = "album_cover.jpg||Album cover||[00:10]\njumping.jpg||He jumps at the audience!||[01:00]"

        XCTAssert(!tag.isEmpty)

        guard let data = tag.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        var range = Range<UInt64>(0..<UInt64(data.count))

        guard let other = Lyrics3Tag(fromData: data, range: &range) else {
            return XCTFail()
        }

        XCTAssert(range.lowerBound == 0)
        XCTAssert(range.upperBound == UInt64(data.count))

        XCTAssert(!other.isEmpty)

        XCTAssert(other.version == tag.version)

        XCTAssert(other.title == "")
        XCTAssert(other.artists == [])

        XCTAssert(other.album == "")

        XCTAssert(other.comments == [])

        XCTAssert(other.lyrics == tag.lyrics)

        XCTAssert(other[Lyrics3FieldID.aut] == nil)
        XCTAssert(other[Lyrics3FieldID.img] == nil)

        XCTAssert(other.fieldList.count == 1)
    }

    // MARK:

    func testVersion2CaseA() {
        let tag = Lyrics3Tag(version: Lyrics3Version.v2)

        XCTAssert(tag.isEmpty && (tag.toData() == nil))

        tag.title = "Title"
        tag.artists = ["Artist 1", "Artist 2"]

        tag.album = "Album"

        tag.comments = ["Comment 1", "Comment 2", "Comment 3", "Comment 4"]

        tag.lyrics = TagLyrics(pieces: [TagLyrics.Piece("Lyrics piece 1", timeStamp: 123000),
                                        TagLyrics.Piece("Lyrics piece 2", timeStamp: 456000)])

        let extraField1 = tag.appendField(Lyrics3FieldID.aut)
        let extraField2 = tag.appendField(Lyrics3FieldID.img)

        let extraStuff1 = extraField1.imposeStuff(format: Lyrics3TextInformationFormat.regular)
        let extraStuff2 = extraField2.imposeStuff(format: Lyrics3TextInformationFormat.regular)

        extraStuff1.content = "Author"
        extraStuff2.content = "album_cover.jpg||Album cover||[00:10]\njumping.jpg||He jumps at the audience!||[01:00]"

        XCTAssert(!tag.isEmpty)

        guard let data = tag.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        let prefixData = Array<UInt8>(repeating: 123, count: 123)
        let suffixData = Array<UInt8>(repeating: 231, count: 231)

        var range = Range<UInt64>(123..<(123 + UInt64(data.count)))

        guard let other = Lyrics3Tag(fromData: prefixData + data + suffixData, range: &range) else {
            return XCTFail()
        }

        XCTAssert(range.lowerBound == 123)
        XCTAssert(range.upperBound == 123 + UInt64(data.count))

        XCTAssert(!other.isEmpty)

        XCTAssert(other.version == tag.version)

        XCTAssert(other.title == tag.title.prefix(250))
        XCTAssert(other.artists == [tag.artists.joined(separator: ", ").prefix(250)])

        XCTAssert(other.album == tag.album.prefix(250))

        XCTAssert(other.comments == [tag.comments.joined(separator: "\n")])

        XCTAssert(other.lyrics == tag.lyrics)

        guard let otherField1 = other[Lyrics3FieldID.aut] else {
            return XCTFail()
        }

        guard let otherField2 = other[Lyrics3FieldID.img] else {
            return XCTFail()
        }

        let otherExtraStuff1 = otherField1.stuff(format: Lyrics3TextInformationFormat.regular)
        let otherExtraStuff2 = otherField2.stuff(format: Lyrics3TextInformationFormat.regular)

        XCTAssert(otherExtraStuff1.content == extraStuff1.content)
        XCTAssert(otherExtraStuff2.content == extraStuff2.content)

        XCTAssert(other.fieldList.count == tag.fieldList.count)
    }

    func testVersion2CaseB() {
        let tag = Lyrics3Tag(version: Lyrics3Version.v2)

        XCTAssert(tag.isEmpty && (tag.toData() == nil))

        tag.title = Array<String>(repeating: "Title", count: 123).joined(separator: " ")
        tag.artists = Array<String>(repeating: "Artist", count: 123)

        tag.album = Array<String>(repeating: "Album", count: 123).joined(separator: " ")

        tag.comments = Array<String>(repeating: "Comment", count: 123)

        tag.lyrics = TagLyrics(pieces: [TagLyrics.Piece("Lyrics piece 1", timeStamp: 123000),
                                        TagLyrics.Piece("Lyrics piece 2", timeStamp: 456000)])

        let extraField1 = tag.appendField(Lyrics3FieldID.aut)
        let extraField2 = tag.appendField(Lyrics3FieldID.img)

        let extraStuff1 = extraField1.imposeStuff(format: Lyrics3TextInformationFormat.regular)
        let extraStuff2 = extraField2.imposeStuff(format: Lyrics3TextInformationFormat.regular)

        extraStuff1.content = Array<String>(repeating: "Author", count: 123).joined(separator: ", ")
        extraStuff2.content = "album_cover.jpg||Album cover||[00:10]\njumping.jpg||He jumps at the audience!||[01:00]"

        XCTAssert(!tag.isEmpty)

        guard let data = tag.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        var range = Range<UInt64>(0..<UInt64(data.count))

        guard let other = Lyrics3Tag(fromData: data, range: &range) else {
            return XCTFail()
        }

        XCTAssert(range.lowerBound == 0)
        XCTAssert(range.upperBound == UInt64(data.count))

        XCTAssert(!other.isEmpty)

        XCTAssert(other.version == tag.version)

        XCTAssert(other.title == tag.title.prefix(250))
        XCTAssert(other.artists == [tag.artists.joined(separator: ", ").prefix(250)])

        XCTAssert(other.album == tag.album.prefix(250))

        XCTAssert(other.comments == [tag.comments.joined(separator: "\n")])

        XCTAssert(other.lyrics == tag.lyrics)

        guard let otherField1 = other[Lyrics3FieldID.aut] else {
            return XCTFail()
        }

        guard let otherField2 = other[Lyrics3FieldID.img] else {
            return XCTFail()
        }

        let otherExtraStuff1 = otherField1.stuff(format: Lyrics3TextInformationFormat.regular)
        let otherExtraStuff2 = otherField2.stuff(format: Lyrics3TextInformationFormat.regular)

        XCTAssert(otherExtraStuff1.content == extraStuff1.content)
        XCTAssert(otherExtraStuff2.content == extraStuff2.content)

        XCTAssert(other.fieldList.count == tag.fieldList.count)
    }
}
