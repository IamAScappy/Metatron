//
//  ID3v2TagGenresTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 03.10.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class ID3v2TagGenresTest: XCTestCase {

    // MARK: Instance Methods

    func test() {
    	let tag = ID3v2Tag()

        do {
            let value: [String] = []

            tag.genres = value

            XCTAssert(tag.genres == value)

            let frame = tag.appendFrameSet(ID3v2FrameID.tcon).mainFrame

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

            frame.imposeStuff(format: ID3v2ContentTypeFormat.regular).fields = value

            XCTAssert(tag.genres == value)
        }

        do {
            let value = [""]

            tag.genres = value

            XCTAssert(tag.genres == [])

            let frame = tag.appendFrameSet(ID3v2FrameID.tcon).mainFrame

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

            frame.imposeStuff(format: ID3v2ContentTypeFormat.regular).fields = value

            XCTAssert(tag.genres == [])
        }

        do {
            let value = ["Abc 123"]

            tag.genres = value

            XCTAssert(tag.genres == value)

            let frame = tag.appendFrameSet(ID3v2FrameID.tcon).mainFrame

            XCTAssert(frame.stuff(format: ID3v2ContentTypeFormat.regular).fields == value)

            do {
                tag.version = ID3v2Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genres == value)
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genres == value)
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genres == value)
            }

            frame.imposeStuff(format: ID3v2ContentTypeFormat.regular).fields = value

            XCTAssert(tag.genres == value)
        }

        do {
            let value = ["Абв 123"]

            tag.genres = value

            XCTAssert(tag.genres == value)

            let frame = tag.appendFrameSet(ID3v2FrameID.tcon).mainFrame

            XCTAssert(frame.stuff(format: ID3v2ContentTypeFormat.regular).fields == value)

            do {
                tag.version = ID3v2Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genres == value)
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genres == value)
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genres == value)
            }

            frame.imposeStuff(format: ID3v2ContentTypeFormat.regular).fields = value

            XCTAssert(tag.genres == value)
        }

        do {
            let value = ["Abc 1", "Abc 2"]

            tag.genres = value

            XCTAssert(tag.genres == value)

            let frame = tag.appendFrameSet(ID3v2FrameID.tcon).mainFrame

            XCTAssert(frame.stuff(format: ID3v2ContentTypeFormat.regular).fields == value)

            do {
                tag.version = ID3v2Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genres == value)
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genres == value)
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genres == value)
            }

            frame.imposeStuff(format: ID3v2ContentTypeFormat.regular).fields = value

            XCTAssert(tag.genres == value)
        }

        do {
            let value = ["", "Abc 2"]

            tag.genres = value

            XCTAssert(tag.genres == ["Abc 2"])

            let frame = tag.appendFrameSet(ID3v2FrameID.tcon).mainFrame

            XCTAssert(frame.stuff(format: ID3v2ContentTypeFormat.regular).fields == ["Abc 2"])

            do {
                tag.version = ID3v2Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genres == ["Abc 2"])
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genres == ["Abc 2"])
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genres == ["Abc 2"])
            }

            frame.imposeStuff(format: ID3v2ContentTypeFormat.regular).fields = value

            XCTAssert(tag.genres == ["Abc 2"])
        }

        do {
            let value = ["Abc 1", ""]

            tag.genres = value

            XCTAssert(tag.genres == ["Abc 1"])

            let frame = tag.appendFrameSet(ID3v2FrameID.tcon).mainFrame

            XCTAssert(frame.stuff(format: ID3v2ContentTypeFormat.regular).fields == ["Abc 1"])

            do {
                tag.version = ID3v2Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genres == ["Abc 1"])
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genres == ["Abc 1"])
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genres == ["Abc 1"])
            }

            frame.imposeStuff(format: ID3v2ContentTypeFormat.regular).fields = value

            XCTAssert(tag.genres == ["Abc 1"])
        }

        do {
            let value = ["", ""]

            tag.genres = value

            XCTAssert(tag.genres == [])

            let frame = tag.appendFrameSet(ID3v2FrameID.tcon).mainFrame

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

            frame.imposeStuff(format: ID3v2ContentTypeFormat.regular).fields = value

            XCTAssert(tag.genres == [])
        }

        do {
            let value = [Array<String>(repeating: "Abc", count: 123).joined(separator: "\n")]

            tag.genres = value

            XCTAssert(tag.genres == value)

            let frame = tag.appendFrameSet(ID3v2FrameID.tcon).mainFrame

            XCTAssert(frame.stuff(format: ID3v2ContentTypeFormat.regular).fields == value)

            do {
                tag.version = ID3v2Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genres == value)
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genres == value)
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genres == value)
            }

            frame.imposeStuff(format: ID3v2ContentTypeFormat.regular).fields = value

            XCTAssert(tag.genres == value)
        }

        do {
            let value = Array<String>(repeating: "Abc", count: 123)

            tag.genres = value

            XCTAssert(tag.genres == value)

            let frame = tag.appendFrameSet(ID3v2FrameID.tcon).mainFrame

            XCTAssert(frame.stuff(format: ID3v2ContentTypeFormat.regular).fields == value)

            do {
                tag.version = ID3v2Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genres == value)
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genres == value)
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genres == value)
            }

            frame.imposeStuff(format: ID3v2ContentTypeFormat.regular).fields = value

            XCTAssert(tag.genres == value)
        }

        do {
            let value = ["(Abc 1)Abc 2 Abc 3"]

            tag.genres = value

            XCTAssert(tag.genres == value)

            let frame = tag.appendFrameSet(ID3v2FrameID.tcon).mainFrame

            XCTAssert(frame.stuff(format: ID3v2ContentTypeFormat.regular).fields == value)

            do {
                tag.version = ID3v2Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genres == ["(Abc 1)", "Abc 2 Abc 3"])
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genres == ["(Abc 1)", "Abc 2 Abc 3"])
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genres == ["(Abc 1)", "Abc 2 Abc 3"])
            }

            frame.imposeStuff(format: ID3v2ContentTypeFormat.regular).fields = value

            XCTAssert(tag.genres == value)
        }

        do {
            let value = ["Abc 1(Abc 2)Abc 3"]

            tag.genres = value

            XCTAssert(tag.genres == value)

            let frame = tag.appendFrameSet(ID3v2FrameID.tcon).mainFrame

            XCTAssert(frame.stuff(format: ID3v2ContentTypeFormat.regular).fields == value)

            do {
                tag.version = ID3v2Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genres == ["Abc 1", "(Abc 2)", "Abc 3"])
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genres == ["Abc 1", "(Abc 2)", "Abc 3"])
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genres == value)
            }

            frame.imposeStuff(format: ID3v2ContentTypeFormat.regular).fields = value

            XCTAssert(tag.genres == value)
        }

        do {
            let value = ["Abc 1 Abc 2(Abc 3)"]

            tag.genres = value

            XCTAssert(tag.genres == value)

            let frame = tag.appendFrameSet(ID3v2FrameID.tcon).mainFrame

            XCTAssert(frame.stuff(format: ID3v2ContentTypeFormat.regular).fields == value)

            do {
                tag.version = ID3v2Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genres == ["Abc 1 Abc 2", "(Abc 3)"])
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genres == ["Abc 1 Abc 2", "(Abc 3)"])
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genres == value)
            }

            frame.imposeStuff(format: ID3v2ContentTypeFormat.regular).fields = value

            XCTAssert(tag.genres == value)
        }

        do {
            let value = ["(Abc 1)", "Abc 2 Abc 3"]

            tag.genres = value

            XCTAssert(tag.genres == value)

            let frame = tag.appendFrameSet(ID3v2FrameID.tcon).mainFrame

            XCTAssert(frame.stuff(format: ID3v2ContentTypeFormat.regular).fields == value)

            do {
                tag.version = ID3v2Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genres == value)
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genres == value)
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genres == value)
            }

            frame.imposeStuff(format: ID3v2ContentTypeFormat.regular).fields = value

            XCTAssert(tag.genres == value)
        }

        do {
            let value = ["Abc 1", "(Abc 2)", "Abc 3"]

            tag.genres = value

            XCTAssert(tag.genres == value)

            let frame = tag.appendFrameSet(ID3v2FrameID.tcon).mainFrame

            XCTAssert(frame.stuff(format: ID3v2ContentTypeFormat.regular).fields == value)

            do {
                tag.version = ID3v2Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genres == value)
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genres == value)
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genres == value)
            }

            frame.imposeStuff(format: ID3v2ContentTypeFormat.regular).fields = value

            XCTAssert(tag.genres == value)
        }

        do {
            let value = ["Abc 1 Abc 2", "(Abc 3)"]

            tag.genres = value

            XCTAssert(tag.genres == value)

            let frame = tag.appendFrameSet(ID3v2FrameID.tcon).mainFrame

            XCTAssert(frame.stuff(format: ID3v2ContentTypeFormat.regular).fields == value)

            do {
                tag.version = ID3v2Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genres == value)
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genres == value)
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genres == value)
            }

            frame.imposeStuff(format: ID3v2ContentTypeFormat.regular).fields = value

            XCTAssert(tag.genres == value)
        }

        do {
            let value = ["()", "Abc 2 Abc 3"]

            tag.genres = value

            XCTAssert(tag.genres == value)

            let frame = tag.appendFrameSet(ID3v2FrameID.tcon).mainFrame

            XCTAssert(frame.stuff(format: ID3v2ContentTypeFormat.regular).fields == value)

            do {
                tag.version = ID3v2Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genres == value)
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genres == value)
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genres == value)
            }

            frame.imposeStuff(format: ID3v2ContentTypeFormat.regular).fields = value

            XCTAssert(tag.genres == value)
        }

        do {
            let value = ["Abc 1", "()", "Abc 3"]

            tag.genres = value

            XCTAssert(tag.genres == value)

            let frame = tag.appendFrameSet(ID3v2FrameID.tcon).mainFrame

            XCTAssert(frame.stuff(format: ID3v2ContentTypeFormat.regular).fields == value)

            do {
                tag.version = ID3v2Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genres == value)
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genres == value)
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genres == value)
            }

            frame.imposeStuff(format: ID3v2ContentTypeFormat.regular).fields = value

            XCTAssert(tag.genres == value)
        }

        do {
            let value = ["Abc 1 Abc 2", "()"]

            tag.genres = value

            XCTAssert(tag.genres == value)

            let frame = tag.appendFrameSet(ID3v2FrameID.tcon).mainFrame

            XCTAssert(frame.stuff(format: ID3v2ContentTypeFormat.regular).fields == value)

            do {
                tag.version = ID3v2Version.v2

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genres == value)
            }

            do {
                tag.version = ID3v2Version.v3

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genres == value)
            }

            do {
                tag.version = ID3v2Version.v4

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v2Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.genres == value)
            }

            frame.imposeStuff(format: ID3v2ContentTypeFormat.regular).fields = value

            XCTAssert(tag.genres == value)
        }
    }
}
