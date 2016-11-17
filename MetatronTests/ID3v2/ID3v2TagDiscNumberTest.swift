//
//  ID3v2TagDiscNumberTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 08.10.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class ID3v2TagDiscNumberTest: XCTestCase {

    // MARK: Instance Methods

    func test() {
        let tag = ID3v2Tag()

        do {
            let value = TagNumber()

            tag.discNumber = value

            XCTAssert(tag.discNumber == value.revised)

            let frame = tag.appendFrameSet(ID3v2FrameID.tpos).mainFrame

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

            XCTAssert(tag.discNumber == TagNumber())
        }

        do {
            let value = TagNumber(0, total: 12)

            tag.discNumber = value

            XCTAssert(tag.discNumber == value.revised)

            let frame = tag.appendFrameSet(ID3v2FrameID.tpos).mainFrame

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

            XCTAssert(tag.discNumber == TagNumber())
        }

        do {
            let value = TagNumber(34, total: 12)

            tag.discNumber = value

            XCTAssert(tag.discNumber == value.revised)

            let frame = tag.appendFrameSet(ID3v2FrameID.tpos).mainFrame

            XCTAssert(frame.stuff(format: ID3v2TextInformationFormat.regular).numberValue == value.revised)

            do {
                tag.version = ID3v2Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.discNumber == value.revised)
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.discNumber == value.revised)
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.discNumber == value.revised)
            }

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).numberValue = value

            XCTAssert(tag.discNumber == TagNumber())
        }

        do {
            let value = TagNumber(-12, total: 34)

            tag.discNumber = value

            XCTAssert(tag.discNumber == value.revised)

            let frame = tag.appendFrameSet(ID3v2FrameID.tpos).mainFrame

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

            XCTAssert(tag.discNumber == TagNumber())
        }

        do {
            let value = TagNumber(12, total: -34)

            tag.discNumber = value

            XCTAssert(tag.discNumber == value.revised)

            let frame = tag.appendFrameSet(ID3v2FrameID.tpos).mainFrame

            XCTAssert(frame.stuff(format: ID3v2TextInformationFormat.regular).numberValue == value.revised)

            do {
                tag.version = ID3v2Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.discNumber == value.revised)
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.discNumber == value.revised)
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.discNumber == value.revised)
            }

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).numberValue = value

            XCTAssert(tag.discNumber == TagNumber())
        }

        do {
            let value = TagNumber(-12, total: -34)

            tag.discNumber = value

            XCTAssert(tag.discNumber == value.revised)

            let frame = tag.appendFrameSet(ID3v2FrameID.tpos).mainFrame

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

            XCTAssert(tag.discNumber == TagNumber())
        }

        do {
            let value = TagNumber(12)

            tag.discNumber = value

            XCTAssert(tag.discNumber == value.revised)

            let frame = tag.appendFrameSet(ID3v2FrameID.tpos).mainFrame

            XCTAssert(frame.stuff(format: ID3v2TextInformationFormat.regular).numberValue == value.revised)

            do {
                tag.version = ID3v2Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.discNumber == value.revised)
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.discNumber == value.revised)
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.discNumber == value.revised)
            }

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).numberValue = value

            XCTAssert(tag.discNumber == value)
        }

        do {
            let value = TagNumber(12, total: 34)

            tag.discNumber = value

            XCTAssert(tag.discNumber == value.revised)

            let frame = tag.appendFrameSet(ID3v2FrameID.tpos).mainFrame

            XCTAssert(frame.stuff(format: ID3v2TextInformationFormat.regular).numberValue == value.revised)

            do {
                tag.version = ID3v2Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.discNumber == value.revised)
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.discNumber == value.revised)
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.discNumber == value.revised)
            }

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).numberValue = value

            XCTAssert(tag.discNumber == value)
        }

        do {
            let frame = tag.appendFrameSet(ID3v2FrameID.tpos).mainFrame

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = ["0"]

            XCTAssert(tag.discNumber == TagNumber())
        }

        do {
            let frame = tag.appendFrameSet(ID3v2FrameID.tpos).mainFrame

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = ["12"]

            XCTAssert(tag.discNumber == TagNumber(12))
        }

        do {
            let frame = tag.appendFrameSet(ID3v2FrameID.tpos).mainFrame

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = ["12/34"]

            XCTAssert(tag.discNumber == TagNumber(12, total: 34))
        }

        do {
            let frame = tag.appendFrameSet(ID3v2FrameID.tpos).mainFrame

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = ["12/0"]

            XCTAssert(tag.discNumber == TagNumber(12))
        }

        do {
            let frame = tag.appendFrameSet(ID3v2FrameID.tpos).mainFrame

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = ["0/12"]

            XCTAssert(tag.discNumber == TagNumber())
        }

        do {
            let frame = tag.appendFrameSet(ID3v2FrameID.tpos).mainFrame

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = ["34/12"]

            XCTAssert(tag.discNumber == TagNumber(34))
        }

        do {
            let frame = tag.appendFrameSet(ID3v2FrameID.tpos).mainFrame

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = ["-12/34"]

            XCTAssert(tag.discNumber == TagNumber())
        }

        do {
            let frame = tag.appendFrameSet(ID3v2FrameID.tpos).mainFrame

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = ["12/-34"]

            XCTAssert(tag.discNumber == TagNumber(12))
        }

        do {
            let frame = tag.appendFrameSet(ID3v2FrameID.tpos).mainFrame

            frame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = ["-12/-34"]

            XCTAssert(tag.discNumber == TagNumber())
        }
    }
}
