//
//  ID3v2ContentTypeTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 03.10.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class ID3v2ContentTypeTest: XCTestCase {

    // MARK: Instance Methods

    func testCreateClone() {
        let stuff = ID3v2ContentType()

        stuff.textEncoding = ID3v2TextEncoding.latin1

        stuff.fields = ["Abc 123"]

        let other = ID3v2ContentTypeFormat.regular.createStuffSubclass(fromOther: stuff)

        XCTAssert(other.textEncoding == stuff.textEncoding)

        XCTAssert(other.fields == stuff.fields)
    }

    func testImposeStuff() {
        let frame = ID3v2Frame(identifier: ID3v2FrameID.tcon)

        let stuff1 = frame.imposeStuff(format: ID3v2ContentTypeFormat.regular)
        let stuff2 = frame.imposeStuff(format: ID3v2ContentTypeFormat.regular)

        XCTAssert(frame.stuff is ID3v2ContentType)

        XCTAssert(frame.stuff === stuff1)
        XCTAssert(frame.stuff === stuff2)
    }

    // MARK:

    func testSerialization() {
        let stuff = ID3v2ContentType()

        do {
            let value: [String] = []

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v2)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == value)

                XCTAssert(serialized == value)
            }

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v3)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == value)

                XCTAssert(serialized == value)
            }

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v4)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == value)

                XCTAssert(serialized == value)
            }
        }

        do {
            let value: [String] = [""]

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v2)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == value)

                XCTAssert(serialized == ["()"])
            }

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v3)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == value)

                XCTAssert(serialized == ["()"])
            }

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v4)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == value)

                XCTAssert(serialized == value)
            }
        }

        do {
            let value = ["Abc 123"]

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v2)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == value)

                XCTAssert(serialized == ["(Abc 123)"])
            }

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v3)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == value)

                XCTAssert(serialized == ["(Abc 123)"])
            }

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v4)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == value)

                XCTAssert(serialized == value)
            }
        }

        do {
            let value = ["Абв 123"]

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v2)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == value)

                XCTAssert(serialized == ["(Абв 123)"])
            }

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v3)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == value)

                XCTAssert(serialized == ["(Абв 123)"])
            }

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v4)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == value)

                XCTAssert(serialized == value)
            }
        }

        do {
            let value = ["Abc 1", "Abc 2"]

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v2)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == value)

                XCTAssert(serialized == ["(Abc 1)(Abc 2)"])
            }

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v3)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == value)

                XCTAssert(serialized == ["(Abc 1)(Abc 2)"])
            }

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v4)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == value)

                XCTAssert(serialized == value)
            }
        }

        do {
            let value = ["", "Abc 2"]

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v2)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == value)

                XCTAssert(serialized == ["()(Abc 2)"])
            }

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v3)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == value)

                XCTAssert(serialized == ["()(Abc 2)"])
            }

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v4)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == value)

                XCTAssert(serialized == value)
            }
        }

        do {
            let value = ["Abc 1", ""]

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v2)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == value)

                XCTAssert(serialized == ["(Abc 1)()"])
            }

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v3)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == value)

                XCTAssert(serialized == ["(Abc 1)()"])
            }

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v4)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == value)

                XCTAssert(serialized == value)
            }
        }

        do {
            let value = ["", ""]

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v2)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == value)

                XCTAssert(serialized == ["()()"])
            }

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v3)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == value)

                XCTAssert(serialized == ["()()"])
            }

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v4)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == value)

                XCTAssert(serialized == value)
            }
        }

        do {
            let value = [Array<String>(repeating: "Abc", count: 123).joined(separator: "\n")]

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v2)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == value)

                XCTAssert(serialized == ["(" + value.joined(separator: ")(") + ")"])
            }

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v3)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == value)

                XCTAssert(serialized == ["(" + value.joined(separator: ")(") + ")"])
            }

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v4)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == value)

                XCTAssert(serialized == value)
            }
        }

        do {
            let value = Array<String>(repeating: "Abc", count: 123)

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v2)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == value)

                XCTAssert(serialized == ["(" + value.joined(separator: ")(") + ")"])
            }

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v3)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == value)

                XCTAssert(serialized == ["(" + value.joined(separator: ")(") + ")"])
            }

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v4)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == value)

                XCTAssert(serialized == value)
            }
        }

        do {
            let value = ["(Abc 1)Abc 2 Abc 3"]

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v2)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == ["(Abc 1)", "Abc 2 Abc 3"])
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == ["(Abc 1)", "Abc 2 Abc 3"])
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == ["(Abc 1)", "Abc 2 Abc 3"])

                XCTAssert(serialized == ["((Abc 1)Abc 2 Abc 3"])
            }

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v3)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == ["(Abc 1)", "Abc 2 Abc 3"])
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == ["(Abc 1)", "Abc 2 Abc 3"])
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == ["(Abc 1)", "Abc 2 Abc 3"])

                XCTAssert(serialized == ["((Abc 1)Abc 2 Abc 3"])
            }

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v4)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == ["(Abc 1)", "Abc 2 Abc 3"])
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == ["(Abc 1)", "Abc 2 Abc 3"])
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == ["(Abc 1)", "Abc 2 Abc 3"])

                XCTAssert(serialized == ["((Abc 1)Abc 2 Abc 3"])
            }
        }

        do {
            let value = ["Abc 1(Abc 2)Abc 3"]

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v2)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == ["Abc 1", "(Abc 2)", "Abc 3"])
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == ["Abc 1", "(Abc 2)", "Abc 3"])
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == ["Abc 1", "(Abc 2)", "Abc 3"])

                XCTAssert(serialized == ["(Abc 1)((Abc 2)Abc 3"])
            }

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v3)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == ["Abc 1", "(Abc 2)", "Abc 3"])
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == ["Abc 1", "(Abc 2)", "Abc 3"])
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == ["Abc 1", "(Abc 2)", "Abc 3"])

                XCTAssert(serialized == ["(Abc 1)((Abc 2)Abc 3"])
            }

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v4)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == value)

                XCTAssert(serialized == value)
            }
        }

        do {
            let value = ["Abc 1 Abc 2(Abc 3)"]

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v2)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == ["Abc 1 Abc 2", "(Abc 3)"])
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == ["Abc 1 Abc 2", "(Abc 3)"])
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == ["Abc 1 Abc 2", "(Abc 3)"])

                XCTAssert(serialized == ["(Abc 1 Abc 2)((Abc 3)"])
            }

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v3)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == ["Abc 1 Abc 2", "(Abc 3)"])
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == ["Abc 1 Abc 2", "(Abc 3)"])
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == ["Abc 1 Abc 2", "(Abc 3)"])

                XCTAssert(serialized == ["(Abc 1 Abc 2)((Abc 3)"])
            }

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v4)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == value)

                XCTAssert(serialized == value)
            }
        }

        do {
            let value = ["(Abc 1)", "Abc 2 Abc 3"]

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v2)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == value)

                XCTAssert(serialized == ["((Abc 1)(Abc 2 Abc 3)"])
            }

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v3)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == value)

                XCTAssert(serialized == ["((Abc 1)(Abc 2 Abc 3)"])
            }

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v4)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == value)

                XCTAssert(serialized == ["((Abc 1)", "Abc 2 Abc 3"])
            }
        }

        do {
            let value = ["Abc 1", "(Abc 2)", "Abc 3"]

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v2)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == value)

                XCTAssert(serialized == ["(Abc 1)((Abc 2)(Abc 3)"])
            }

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v3)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == value)

                XCTAssert(serialized == ["(Abc 1)((Abc 2)(Abc 3)"])
            }

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v4)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == value)

                XCTAssert(serialized == ["Abc 1", "((Abc 2)" ,"Abc 3"])
            }
        }

        do {
            let value = ["Abc 1 Abc 2", "(Abc 3)"]

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v2)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == value)

                XCTAssert(serialized == ["(Abc 1 Abc 2)((Abc 3)"])
            }

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v3)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == value)

                XCTAssert(serialized == ["(Abc 1 Abc 2)((Abc 3)"])
            }

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v4)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == value)

                XCTAssert(serialized == ["Abc 1 Abc 2", "((Abc 3)"])
            }
        }

        do {
            let value = ["()", "Abc 2 Abc 3"]

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v2)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == value)

                XCTAssert(serialized == ["(()(Abc 2 Abc 3)"])
            }

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v3)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == value)

                XCTAssert(serialized == ["(()(Abc 2 Abc 3)"])
            }

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v4)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == value)

                XCTAssert(serialized == ["(()", "Abc 2 Abc 3"])
            }
        }

        do {
            let value = ["Abc 1", "()", "Abc 3"]

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v2)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == value)

                XCTAssert(serialized == ["(Abc 1)(()(Abc 3)"])
            }

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v3)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == value)

                XCTAssert(serialized == ["(Abc 1)(()(Abc 3)"])
            }

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v4)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == value)

                XCTAssert(serialized == ["Abc 1", "(()", "Abc 3"])
            }
        }

        do {
            let value = ["Abc 1 Abc 2", "()"]

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v2)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == value)

                XCTAssert(serialized == ["(Abc 1 Abc 2)(()"])
            }

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v3)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == value)

                XCTAssert(serialized == ["(Abc 1 Abc 2)(()"])
            }

            do {
                let serialized = stuff.serialize(fields: value, version: ID3v2Version.v4)

                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v4) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v2) == value)
                XCTAssert(stuff.deserialize(fields: serialized, version: ID3v2Version.v3) == value)

                XCTAssert(serialized == ["Abc 1 Abc 2", "(()"])
            }
        }

        do {
            let value = ["(Abc 1)Abc 2", "(Abc 3)Abc 4"]

            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v2) == ["Abc 1", "Abc 2", "Abc 3", "Abc 4"])
            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v3) == ["Abc 1", "Abc 2", "Abc 3", "Abc 4"])
            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v4) == ["Abc 1", "Abc 2", "Abc 3", "Abc 4"])
        }

        do {
            let value = ["(Abc 1)Abc 2(Abc 3)Abc 4"]

            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v2) == ["Abc 1", "Abc 2", "Abc 3", "Abc 4"])
            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v3) == ["Abc 1", "Abc 2", "Abc 3", "Abc 4"])
            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v4) == ["Abc 1", "Abc 2", "Abc 3", "Abc 4"])
        }

        do {
            let value = ["(Abc 1)(Abc 3)Abc 4"]

            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v2) == ["Abc 1", "Abc 3", "Abc 4"])
            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v3) == ["Abc 1", "Abc 3", "Abc 4"])
            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v4) == ["Abc 1", "Abc 3", "Abc 4"])
        }

        do {
            let value = ["(Abc 1)Abc 2(Abc 3)"]

            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v2) == ["Abc 1", "Abc 2", "Abc 3"])
            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v3) == ["Abc 1", "Abc 2", "Abc 3"])
            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v4) == ["Abc 1", "Abc 2", "Abc 3"])
        }

        do {
            let value = ["(Abc 1)(Abc 3)"]

            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v2) == ["Abc 1", "Abc 3"])
            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v3) == ["Abc 1", "Abc 3"])
            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v4) == ["Abc 1", "Abc 3"])
        }

        do {
            let value = ["()Abc 2(Abc 3)Abc 4"]

            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v2) == ["", "Abc 2", "Abc 3", "Abc 4"])
            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v3) == ["", "Abc 2", "Abc 3", "Abc 4"])
            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v4) == ["", "Abc 2", "Abc 3", "Abc 4"])
        }

        do {
            let value = ["(Abc 1)Abc 2()Abc 4"]

            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v2) == ["Abc 1", "Abc 2", "", "Abc 4"])
            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v3) == ["Abc 1", "Abc 2", "", "Abc 4"])
            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v4) == ["Abc 1", "Abc 2", "", "Abc 4"])
        }

        do {
            let value = ["()Abc 2()Abc 4"]

            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v2) == ["", "Abc 2", "", "Abc 4"])
            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v3) == ["", "Abc 2", "", "Abc 4"])
            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v4) == ["", "Abc 2", "", "Abc 4"])
        }

        do {
            let value = ["()()"]

            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v2) == ["", ""])
            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v3) == ["", ""])
            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v4) == ["", ""])
        }

        do {
            let value = ["()"]

            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v2) == [""])
            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v3) == [""])
            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v4) == [""])
        }

        do {
            let value = ["((Abc 1))Abc 2(Abc 3)Abc 4"]


            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v2) == ["(Abc 1)", ")Abc 2", "Abc 3", "Abc 4"])
            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v3) == ["(Abc 1)", ")Abc 2", "Abc 3", "Abc 4"])
            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v4) == ["(Abc 1)", ")Abc 2", "Abc 3", "Abc 4"])
        }

        do {
            let value = ["(Abc 1)Abc 2((Abc 3))Abc 4"]

            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v2) == ["Abc 1", "Abc 2", "(Abc 3)", ")Abc 4"])
            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v3) == ["Abc 1", "Abc 2", "(Abc 3)", ")Abc 4"])
            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v4) == ["Abc 1", "Abc 2", "(Abc 3)", ")Abc 4"])
        }

        do {
            let value = ["((Abc 1))Abc 2((Abc 3))Abc 4"]

            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v2) == ["(Abc 1)", ")Abc 2", "(Abc 3)", ")Abc 4"])
            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v3) == ["(Abc 1)", ")Abc 2", "(Abc 3)", ")Abc 4"])
            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v4) == ["(Abc 1)", ")Abc 2", "(Abc 3)", ")Abc 4"])
        }

        do {
            let value = ["(Abc 1)((Abc 2)(Abc 3)((Abc 4)"]

            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v2) == ["Abc 1", "(Abc 2)", "Abc 3", "(Abc 4)"])
            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v3) == ["Abc 1", "(Abc 2)", "Abc 3", "(Abc 4)"])
            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v4) == ["Abc 1", "(Abc 2)", "Abc 3", "(Abc 4)"])
        }

        do {
            let value = ["(Abc 1((Abc 2))(Abc 3)((Abc 4)"]

            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v2) == ["Abc 1((Abc 2", ")", "Abc 3", "(Abc 4)"])
            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v3) == ["Abc 1((Abc 2", ")", "Abc 3", "(Abc 4)"])
            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v4) == ["Abc 1((Abc 2", ")", "Abc 3", "(Abc 4)"])
        }

        do {
            let value = ["(Abc 1)((Abc 2)(Abc 3((Abc 4))"]

            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v2) == ["Abc 1", "(Abc 2)", "Abc 3((Abc 4", ")"])
            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v3) == ["Abc 1", "(Abc 2)", "Abc 3((Abc 4", ")"])
            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v4) == ["Abc 1", "(Abc 2)", "Abc 3((Abc 4", ")"])
        }

        do {
            let value = ["(Abc 1((Abc 2))(Abc 3((Abc 4))"]

            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v2) == ["Abc 1((Abc 2", ")", "Abc 3((Abc 4", ")"])
            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v3) == ["Abc 1((Abc 2", ")", "Abc 3((Abc 4", ")"])
            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v4) == ["Abc 1((Abc 2", ")", "Abc 3((Abc 4", ")"])
        }

        do {
            let value = ["(123)Abc 123"]

            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v2) == [ID3v1GenreList[123], "Abc 123"])
            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v3) == [ID3v1GenreList[123], "Abc 123"])
            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v4) == [ID3v1GenreList[123], "Abc 123"])
        }

        do {
            let value = ["(123)"]

            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v2) == [ID3v1GenreList[123]])
            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v3) == [ID3v1GenreList[123]])
            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v4) == [ID3v1GenreList[123]])
        }

        do {
            let value = ["123"]

            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v2) == [ID3v1GenreList[123]])
            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v3) == [ID3v1GenreList[123]])
            XCTAssert(stuff.deserialize(fields: value, version: ID3v2Version.v4) == [ID3v1GenreList[123]])
        }
    }
}
