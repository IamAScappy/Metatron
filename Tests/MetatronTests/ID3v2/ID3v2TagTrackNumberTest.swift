//
//  ID3v2TagTrackNumberTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 08.10.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class ID3v2TagTrackNumberTest: XCTestCase {

    // MARK: Instance Methods

    func test() {
    	let tag = ID3v2Tag()

        do {
            let value = TagNumber()

            tag.trackNumber = value

            XCTAssert(tag.trackNumber == value.revised)

            let frame = tag.appendFrameSet(ID3v2FrameID.trck).mainFrame

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

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).numberValue = value

            XCTAssert(tag.trackNumber == TagNumber())
        }

        do {
            let value = TagNumber(0, total: 12)

            tag.trackNumber = value

            XCTAssert(tag.trackNumber == value.revised)

            let frame = tag.appendFrameSet(ID3v2FrameID.trck).mainFrame

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

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).numberValue = value

            XCTAssert(tag.trackNumber == TagNumber())
        }

        do {
            let value = TagNumber(34, total: 12)

            tag.trackNumber = value

            XCTAssert(tag.trackNumber == value.revised)

            let frame = tag.appendFrameSet(ID3v2FrameID.trck).mainFrame

            XCTAssert(frame.stuff(format: ID3v2TextInformationFormat.regular).numberValue == value.revised)

            do {
                tag.version = ID3v2Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.trackNumber == value.revised)
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.trackNumber == value.revised)
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.trackNumber == value.revised)
            }

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).numberValue = value

            XCTAssert(tag.trackNumber == TagNumber())
        }

        do {
            let value = TagNumber(-12, total: 34)

            tag.trackNumber = value

            XCTAssert(tag.trackNumber == value.revised)

            let frame = tag.appendFrameSet(ID3v2FrameID.trck).mainFrame

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

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).numberValue = value

            XCTAssert(tag.trackNumber == TagNumber())
        }

        do {
            let value = TagNumber(12, total: -34)

            tag.trackNumber = value

            XCTAssert(tag.trackNumber == value.revised)

            let frame = tag.appendFrameSet(ID3v2FrameID.trck).mainFrame

            XCTAssert(frame.stuff(format: ID3v2TextInformationFormat.regular).numberValue == value.revised)

            do {
                tag.version = ID3v2Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.trackNumber == value.revised)
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.trackNumber == value.revised)
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.trackNumber == value.revised)
            }

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).numberValue = value

            XCTAssert(tag.trackNumber == TagNumber())
        }

        do {
            let value = TagNumber(-12, total: -34)

            tag.trackNumber = value

            XCTAssert(tag.trackNumber == value.revised)

            let frame = tag.appendFrameSet(ID3v2FrameID.trck).mainFrame

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

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).numberValue = value

            XCTAssert(tag.trackNumber == TagNumber())
        }

        do {
            let value = TagNumber(12)

            tag.trackNumber = value

            XCTAssert(tag.trackNumber == value.revised)

            let frame = tag.appendFrameSet(ID3v2FrameID.trck).mainFrame

            XCTAssert(frame.stuff(format: ID3v2TextInformationFormat.regular).numberValue == value.revised)

            do {
                tag.version = ID3v2Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.trackNumber == value.revised)
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.trackNumber == value.revised)
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.trackNumber == value.revised)
            }

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).numberValue = value

            XCTAssert(tag.trackNumber == value)
        }

        do {
            let value = TagNumber(12, total: 34)

            tag.trackNumber = value

            XCTAssert(tag.trackNumber == value.revised)

            let frame = tag.appendFrameSet(ID3v2FrameID.trck).mainFrame

            XCTAssert(frame.stuff(format: ID3v2TextInformationFormat.regular).numberValue == value.revised)

            do {
                tag.version = ID3v2Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.trackNumber == value.revised)
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.trackNumber == value.revised)
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.trackNumber == value.revised)
            }

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).numberValue = value

            XCTAssert(tag.trackNumber == value)
        }

        do {
            let frame = tag.appendFrameSet(ID3v2FrameID.trck).mainFrame

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = ["0"]

            XCTAssert(tag.trackNumber == TagNumber())
        }

        do {
            let frame = tag.appendFrameSet(ID3v2FrameID.trck).mainFrame

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = ["12"]

            XCTAssert(tag.trackNumber == TagNumber(12))
        }

        do {
            let frame = tag.appendFrameSet(ID3v2FrameID.trck).mainFrame

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = ["12/34"]

            XCTAssert(tag.trackNumber == TagNumber(12, total: 34))
        }

        do {
            let frame = tag.appendFrameSet(ID3v2FrameID.trck).mainFrame

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = ["12/0"]

            XCTAssert(tag.trackNumber == TagNumber(12))
        }

        do {
            let frame = tag.appendFrameSet(ID3v2FrameID.trck).mainFrame

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = ["0/12"]

            XCTAssert(tag.trackNumber == TagNumber())
        }

        do {
            let frame = tag.appendFrameSet(ID3v2FrameID.trck).mainFrame

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = ["34/12"]

            XCTAssert(tag.trackNumber == TagNumber(34))
        }

        do {
            let frame = tag.appendFrameSet(ID3v2FrameID.trck).mainFrame

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = ["-12/34"]

            XCTAssert(tag.trackNumber == TagNumber())
        }

        do {
            let frame = tag.appendFrameSet(ID3v2FrameID.trck).mainFrame

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = ["12/-34"]

            XCTAssert(tag.trackNumber == TagNumber(12))
        }

        do {
            let frame = tag.appendFrameSet(ID3v2FrameID.trck).mainFrame

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = ["-12/-34"]

            XCTAssert(tag.trackNumber == TagNumber())
        }
    }
}
