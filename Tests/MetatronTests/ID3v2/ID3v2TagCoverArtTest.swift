//
//  ID3v2TagCoverArtTest.swift
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

class ID3v2TagCoverArtTest: XCTestCase {

    // MARK: Instance Methods

    func test() {
        let tag = ID3v2Tag()

        do {
            let value = TagImage()

            tag.coverArt = value

            XCTAssert(tag.coverArt == TagImage())

            let frame = tag.appendFrameSet(ID3v2FrameID.apic).mainFrame

            XCTAssert(frame.stuff == nil)

            do {
                tag.version = ID3v2Version.v2

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = ID3v2Version.v3

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = ID3v2Version.v4

                XCTAssert(tag.toData() == nil)
            }

            let stuff = frame.imposeStuff(format: ID3v2AttachedPictureFormat.regular)

            stuff.pictureType = ID3v2AttachedPicture.PictureType.frontCover

            stuff.imageValue = value

            XCTAssert(tag.coverArt == TagImage())
        }

        do {
            let value = TagImage(data: [], mainMimeType: "image/jpeg", description: "Abc 123")

            tag.coverArt = value

            XCTAssert(tag.coverArt == TagImage())

            let frame = tag.appendFrameSet(ID3v2FrameID.apic).mainFrame

            XCTAssert(frame.stuff == nil)

            do {
                tag.version = ID3v2Version.v2

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = ID3v2Version.v3

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = ID3v2Version.v4

                XCTAssert(tag.toData() == nil)
            }

            let stuff = frame.imposeStuff(format: ID3v2AttachedPictureFormat.regular)

            stuff.pictureType = ID3v2AttachedPicture.PictureType.frontCover

            stuff.imageValue = value

            XCTAssert(tag.coverArt == TagImage())
        }

        do {
            let value = TagImage(data: [], mainMimeType: "image/png", description: "Абв 123")

            tag.coverArt = value

            XCTAssert(tag.coverArt == TagImage())

            let frame = tag.appendFrameSet(ID3v2FrameID.apic).mainFrame

            XCTAssert(frame.stuff == nil)

            do {
                tag.version = ID3v2Version.v2

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = ID3v2Version.v3

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = ID3v2Version.v4

                XCTAssert(tag.toData() == nil)
            }

            let stuff = frame.imposeStuff(format: ID3v2AttachedPictureFormat.regular)

            stuff.pictureType = ID3v2AttachedPicture.PictureType.frontCover

            stuff.imageValue = value

            XCTAssert(tag.coverArt == TagImage())
        }

        do {
            let value = TagImage(data: [1, 2, 3])

            tag.coverArt = value

            XCTAssert(tag.coverArt == value)

            let frame = tag.appendFrameSet(ID3v2FrameID.apic).mainFrame

            XCTAssert(frame.stuff(format: ID3v2AttachedPictureFormat.regular).imageValue == value)

            do {
                tag.version = ID3v2Version.v2

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.coverArt == value)
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.coverArt == value)
            }

            let stuff = frame.imposeStuff(format: ID3v2AttachedPictureFormat.regular)

            stuff.pictureType = ID3v2AttachedPicture.PictureType.frontCover

            stuff.imageValue = value

            XCTAssert(tag.coverArt == value)
        }

        do {
            let value = TagImage(data: [1, 2, 3], mainMimeType: "image/jpeg")

            tag.coverArt = value

            XCTAssert(tag.coverArt == value)

            let frame = tag.appendFrameSet(ID3v2FrameID.apic).mainFrame

            XCTAssert(frame.stuff(format: ID3v2AttachedPictureFormat.regular).imageValue == value)

            do {
                tag.version = ID3v2Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.coverArt == value)
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.coverArt == value)
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.coverArt == value)
            }

            let stuff = frame.imposeStuff(format: ID3v2AttachedPictureFormat.regular)

            stuff.pictureType = ID3v2AttachedPicture.PictureType.frontCover

            stuff.imageValue = value

            XCTAssert(tag.coverArt == value)
        }

        do {
            let value = TagImage(data: [1, 2, 3], description: "Abc 123")

            tag.coverArt = value

            XCTAssert(tag.coverArt == value)

            let frame = tag.appendFrameSet(ID3v2FrameID.apic).mainFrame

            XCTAssert(frame.stuff(format: ID3v2AttachedPictureFormat.regular).imageValue == value)

            do {
                tag.version = ID3v2Version.v2

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.coverArt == value)
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.coverArt == value)
            }

            let stuff = frame.imposeStuff(format: ID3v2AttachedPictureFormat.regular)

            stuff.pictureType = ID3v2AttachedPicture.PictureType.frontCover

            stuff.imageValue = value

            XCTAssert(tag.coverArt == value)
        }

        do {
            let value = TagImage(data: [1, 2, 3], description: "Абв 123")

            tag.coverArt = value

            XCTAssert(tag.coverArt == value)

            let frame = tag.appendFrameSet(ID3v2FrameID.apic).mainFrame

            XCTAssert(frame.stuff(format: ID3v2AttachedPictureFormat.regular).imageValue == value)

            do {
                tag.version = ID3v2Version.v2

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.coverArt == value)
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.coverArt == value)
            }

            let stuff = frame.imposeStuff(format: ID3v2AttachedPictureFormat.regular)

            stuff.pictureType = ID3v2AttachedPicture.PictureType.frontCover

            stuff.imageValue = value

            XCTAssert(tag.coverArt == value)
        }

        do {
            let value = TagImage(data: [1, 2, 3], mainMimeType: "image/jpeg", description: "Abc 123")

            tag.coverArt = value

            XCTAssert(tag.coverArt == value)

            let frame = tag.appendFrameSet(ID3v2FrameID.apic).mainFrame

            XCTAssert(frame.stuff(format: ID3v2AttachedPictureFormat.regular).imageValue == value)

            do {
                tag.version = ID3v2Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.coverArt == value)
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.coverArt == value)
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.coverArt == value)
            }

            let stuff = frame.imposeStuff(format: ID3v2AttachedPictureFormat.regular)

            stuff.pictureType = ID3v2AttachedPicture.PictureType.frontCover

            stuff.imageValue = value

            XCTAssert(tag.coverArt == value)
        }

        do {
            let value = TagImage(data: [0, 0, 0], mainMimeType: "image/jpeg", description: "Abc 123")

            tag.coverArt = value

            XCTAssert(tag.coverArt == value)

            let frame = tag.appendFrameSet(ID3v2FrameID.apic).mainFrame

            XCTAssert(frame.stuff(format: ID3v2AttachedPictureFormat.regular).imageValue == value)

            do {
                tag.version = ID3v2Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.coverArt == value)
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.coverArt == value)
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.coverArt == value)
            }

            let stuff = frame.imposeStuff(format: ID3v2AttachedPictureFormat.regular)

            stuff.pictureType = ID3v2AttachedPicture.PictureType.frontCover

            stuff.imageValue = value

            XCTAssert(tag.coverArt == value)
        }

        do {
            let frameSet = tag.resetFrameSet(ID3v2FrameID.apic)

            do {
                XCTAssert(frameSet.frames.count == 1)

                let stuff = frameSet.mainFrame.imposeStuff(format: ID3v2AttachedPictureFormat.regular)

                XCTAssert(frameSet.frames.count == 1)

                stuff.pictureType = ID3v2AttachedPicture.PictureType.other

                stuff.imageValue = TagImage(data: [1, 2, 3])

                XCTAssert(tag.coverArt == TagImage(data: [1, 2, 3]))
            }

            do {
                XCTAssert(frameSet.frames.count == 1)

                let stuff = frameSet.appendFrame().imposeStuff(format: ID3v2AttachedPictureFormat.regular)

                XCTAssert(frameSet.frames.count == 2)

                stuff.pictureType = ID3v2AttachedPicture.PictureType.fileIcon

                stuff.imageValue = TagImage()

                XCTAssert(tag.coverArt == TagImage(data: [1, 2, 3]))
            }

            do {
                XCTAssert(frameSet.frames.count == 2)

                let stuff = frameSet.appendFrame().imposeStuff(format: ID3v2AttachedPictureFormat.regular)

                XCTAssert(frameSet.frames.count == 3)

                stuff.pictureType = ID3v2AttachedPicture.PictureType.backCover

                stuff.imageValue = TagImage(data: [4, 5, 6], description: "Abc 123")

                XCTAssert(tag.coverArt == TagImage(data: [4, 5, 6], description: "Abc 123"))
            }

            do {
                XCTAssert(frameSet.frames.count == 3)

                let stuff = frameSet.appendFrame().imposeStuff(format: ID3v2AttachedPictureFormat.regular)

                XCTAssert(frameSet.frames.count == 4)

                stuff.pictureType = ID3v2AttachedPicture.PictureType.frontCover

                stuff.imageValue = TagImage(data: [7, 8, 9], description: "Abc 123")

                XCTAssert(tag.coverArt == TagImage(data: [7, 8, 9], description: "Abc 123"))
            }
        }
    }
}
