//
//  ID3v2FrameRegistryTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 27.08.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class TestFrameStuff: ID3v2FrameStuff {

    // MARK: Instance Properties

    var isEmpty: Bool {
        return false
    }

    // MARK: Initializers

    init() {
    }

    init(fromData data: [UInt8], version: ID3v2Version) {
    }

    // MARK: Instance Methods

    func toData(version: ID3v2Version) -> [UInt8]? {
        return nil
    }

    func toData() -> (data: [UInt8], version: ID3v2Version)? {
        guard let data = self.toData(version: ID3v2Version.v4) else {
            return nil
        }

        return (data: data, version: ID3v2Version.v4)
    }

    // MARK:

    func reset() {
    }
}

class TestFrameStuffFormat: ID3v2FrameStuffSubclassFormat {
    // MARK: Type Properties

    static let regular = TestFrameStuffFormat()

    // MARK: Instance Methods

    func createStuffSubclass(fromData data: [UInt8], version: ID3v2Version) -> TestFrameStuff {
        return TestFrameStuff(fromData: data, version: version)
    }

    func createStuffSubclass(fromOther other: TestFrameStuff) -> TestFrameStuff {
        return TestFrameStuff()
    }

    func createStuffSubclass() -> TestFrameStuff {
        return TestFrameStuff()
    }
}

class ID3v2FrameRegistryTest: XCTestCase {
    // MARK: Instance Methods

    func testIdentifySignature() {
        let registry = ID3v2FrameRegistry.regular

        registry.registerCustomID("Custom RVRB", signatures: [ID3v2Version.v2: [82, 69, 86],
                                                              ID3v2Version.v3: [82, 86, 82, 66],
                                                              ID3v2Version.v4: [82, 86, 82, 66]])

        XCTAssert(registry.identifySignature([83, 89, 76, 84], version: ID3v2Version.v2) == nil)
        XCTAssert(registry.identifySignature([1, 2, 3], version: ID3v2Version.v2) == nil)
        XCTAssert(registry.identifySignature([], version: ID3v2Version.v2) == nil)

        XCTAssert(registry.identifySignature([83, 76, 84], version: ID3v2Version.v3) == nil)
        XCTAssert(registry.identifySignature([1, 2, 3, 4], version: ID3v2Version.v3) == nil)
        XCTAssert(registry.identifySignature([], version: ID3v2Version.v3) == nil)

        XCTAssert(registry.identifySignature([83, 76, 84], version: ID3v2Version.v4) == nil)
        XCTAssert(registry.identifySignature([1, 2, 3, 4], version: ID3v2Version.v4) == nil)
        XCTAssert(registry.identifySignature([], version: ID3v2Version.v4) == nil)

        XCTAssert(registry.identifySignature([83, 76, 84], version: ID3v2Version.v2) == ID3v2FrameID.sylt)
        XCTAssert(registry.identifySignature([83, 76, 84, 0], version: ID3v2Version.v3) == ID3v2FrameID.sylt)
        XCTAssert(registry.identifySignature([83, 89, 76, 84], version: ID3v2Version.v3) == ID3v2FrameID.sylt)
        XCTAssert(registry.identifySignature([83, 89, 76, 84], version: ID3v2Version.v4) == ID3v2FrameID.sylt)

        XCTAssert(registry.identifySignature([82, 69, 86], version: ID3v2Version.v2) == registry.customIDs["Custom RVRB"])
        XCTAssert(registry.identifySignature([82, 69, 86, 0], version: ID3v2Version.v3) == registry.customIDs["Custom RVRB"])
        XCTAssert(registry.identifySignature([82, 86, 82, 66], version: ID3v2Version.v3) == registry.customIDs["Custom RVRB"])
        XCTAssert(registry.identifySignature([82, 86, 82, 66], version: ID3v2Version.v4) == registry.customIDs["Custom RVRB"])

        do {
            guard let customID = registry.identifySignature([65, 66, 67], version: ID3v2Version.v2) else {
                return XCTFail()
            }

            XCTAssert(customID.type == ID3v2FrameType.custom)

            XCTAssert(customID.signatures.count == 1)

            guard let signature = customID.signatures[ID3v2Version.v2] else {
                return XCTFail()
            }

            XCTAssert(signature == [65, 66, 67])

            XCTAssert(registry.customIDs[customID.name] != customID)
        }

        do {
            guard let customID = registry.identifySignature([65, 66, 67, 68], version: ID3v2Version.v3) else {
                return XCTFail()
            }

            XCTAssert(customID.type == ID3v2FrameType.custom)

            XCTAssert(customID.signatures.count == 1)

            guard let signature = customID.signatures[ID3v2Version.v3] else {
                return XCTFail()
            }

            XCTAssert(signature == [65, 66, 67, 68])

            XCTAssert(registry.customIDs[customID.name] != customID)
        }

        do {
            guard let customID = registry.identifySignature([65, 66, 67, 68], version: ID3v2Version.v4) else {
                return XCTFail()
            }

            XCTAssert(customID.type == ID3v2FrameType.custom)

            XCTAssert(customID.signatures.count == 1)

            guard let signature = customID.signatures[ID3v2Version.v4] else {
                return XCTFail()
            }

            XCTAssert(signature == [65, 66, 67, 68])

            XCTAssert(registry.customIDs[customID.name] != customID)
        }
    }

    func testRegisterCustomID() {
        let registry = ID3v2FrameRegistry.regular

        XCTAssert(registry.registerCustomID("Abc 123", signatures: [ID3v2Version.v2: [1, 2, 3]]) == nil)
        XCTAssert(registry.registerCustomID("Abc 123", signatures: [:]) == nil)

        XCTAssert(registry.registerCustomID("", signatures: [ID3v2Version.v2: [65, 66, 67]]) == nil)
        XCTAssert(registry.registerCustomID("", signatures: [:]) == nil)

        do {
            guard let customID = registry.registerCustomID("Abc 1", signatures: [ID3v2Version.v2: [80, 79, 80],
                                                                                 ID3v2Version.v3: [80, 79, 80, 77],
                                                                                 ID3v2Version.v4: [80, 79, 80, 77]]) else {
                return XCTFail()
            }

            XCTAssert(customID.type == ID3v2FrameType.custom)
            XCTAssert(customID.name == "Abc 1")

            XCTAssert(registry.customIDs["Abc 1"] == customID)

            XCTAssert(registry.registerCustomID("Abc 1", signatures: [ID3v2Version.v2: [80, 79, 80],
                                                                      ID3v2Version.v3: [80, 79, 80, 77],
                                                                      ID3v2Version.v4: [80, 79, 80, 77]]) == nil)

            XCTAssert(registry.registerCustomID("Abc 2", signatures: [ID3v2Version.v2: [80, 79, 80],
                                                                      ID3v2Version.v3: [80, 79, 80, 77],
                                                                      ID3v2Version.v4: [80, 79, 80, 77]]) == nil)

            XCTAssert(registry.registerCustomID("Abc 1", signatures: [ID3v2Version.v2: [80, 79, 80]]) == nil)
            XCTAssert(registry.registerCustomID("Abc 2", signatures: [ID3v2Version.v2: [80, 79, 80]]) == nil)

            XCTAssert(registry.registerCustomID("Abc 1", signatures: [:]) == nil)
        }

        do {
            guard let customID = registry.registerCustomID("Абв 1", signatures: [ID3v2Version.v2: [66, 85, 70],
                                                                                 ID3v2Version.v3: [82, 66, 85, 70],
                                                                                 ID3v2Version.v4: [82, 66, 85, 70]]) else {
                return XCTFail()
            }

            XCTAssert(customID.type == ID3v2FrameType.custom)
            XCTAssert(customID.name == "Абв 1")

            XCTAssert(registry.customIDs["Абв 1"] == customID)

            XCTAssert(registry.registerCustomID("Абв 1", signatures: [ID3v2Version.v2: [66, 85, 70],
                                                                      ID3v2Version.v3: [82, 66, 85, 70],
                                                                      ID3v2Version.v4: [82, 66, 85, 70]]) == nil)

            XCTAssert(registry.registerCustomID("Абв 2", signatures: [ID3v2Version.v2: [66, 85, 70],
                                                                      ID3v2Version.v3: [82, 66, 85, 70],
                                                                      ID3v2Version.v4: [82, 66, 85, 70]]) == nil)

            XCTAssert(registry.registerCustomID("Абв 1", signatures: [ID3v2Version.v2: [66, 85, 70]]) == nil)
            XCTAssert(registry.registerCustomID("Абв 2", signatures: [ID3v2Version.v2: [66, 85, 70]]) == nil)

            XCTAssert(registry.registerCustomID("Абв 1", signatures: [:]) == nil)
        }
    }

    func testRegisterStuff() {
        let registry = ID3v2FrameRegistry.regular
        let format = TestFrameStuffFormat.regular

        XCTAssert(registry.registerStuff(format: format, identifier: ID3v2FrameID.aenc) == false)
        XCTAssert(registry.registerStuff(format: format, identifier: ID3v2FrameID.apic) == false)

        guard let customID1 = registry.registerCustomID("Custom EFGH", signatures: [ID3v2Version.v2: [69, 70, 71],
                                                                                    ID3v2Version.v3: [69, 70, 71, 72],
                                                                                    ID3v2Version.v4: [69, 70, 71, 72]]) else {
            return XCTFail()
        }

        guard let customID2 = registry.registerCustomID("Custom IJKL", signatures: [ID3v2Version.v2: [73, 74, 75],
                                                                                    ID3v2Version.v3: [73, 74, 75, 76],
                                                                                    ID3v2Version.v4: [73, 74, 75, 76]]) else {
            return XCTFail()
        }

        XCTAssert(registry.registerStuff(format: format, identifier: customID1) == true)
        XCTAssert(registry.registerStuff(format: format, identifier: customID1) == false)

        XCTAssert(registry.registerStuff(format: format, identifier: customID2) == true)
        XCTAssert(registry.registerStuff(format: format, identifier: customID2) == false)

        XCTAssert(registry.stuffs[customID1] === format)
        XCTAssert(registry.stuffs[customID2] === format)
    }
}
