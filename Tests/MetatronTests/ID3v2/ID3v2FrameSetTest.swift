//
//  ID3v2FrameSetTest.swift
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

class ID3v2FrameSetTest: XCTestCase {

    // MARK: Instance Methods

    func testInit() {
        do {
            let frameSet = ID3v2FrameSet(identifier: ID3v2FrameID.tofn)

            XCTAssert(frameSet.identifier == ID3v2FrameID.tofn)
            XCTAssert(frameSet.frames.count == 1)
            XCTAssert(frameSet.mainFrame == frameSet.frames[0])
        }

        do {
            let frames: [ID3v2Frame] = [ID3v2Frame(identifier: ID3v2FrameID.uslt),
                                        ID3v2Frame(identifier: ID3v2FrameID.uslt),
                                        ID3v2Frame(identifier: ID3v2FrameID.uslt)]

            let frameSet = ID3v2FrameSet(frames: frames)

            XCTAssert(frameSet.identifier == ID3v2FrameID.uslt)
            XCTAssert(frameSet.frames.count == 3)
            XCTAssert(frameSet.mainFrame == frames[0])

            XCTAssert(frameSet.frames[0] == frames[0])
            XCTAssert(frameSet.frames[1] == frames[1])
            XCTAssert(frameSet.frames[2] == frames[2])
        }

        do {
            let frames: [ID3v2Frame] = [ID3v2Frame(identifier: ID3v2FrameID.uslt),
                                        ID3v2Frame(identifier: ID3v2FrameID.toly),
                                        ID3v2Frame(identifier: ID3v2FrameID.uslt)]


            let frameSet = ID3v2FrameSet(frames: frames)

            XCTAssert(frameSet.identifier == ID3v2FrameID.uslt)
            XCTAssert(frameSet.frames.count == 2)
            XCTAssert(frameSet.mainFrame == frames[0])

            XCTAssert(frameSet.frames[0] == frames[0])
            XCTAssert(frameSet.frames[1] == frames[2])
        }
    }

    func testRemoveFrame() {
        let frames: [ID3v2Frame] = [ID3v2Frame(identifier: ID3v2FrameID.txxx),
                                    ID3v2Frame(identifier: ID3v2FrameID.txxx),
                                    ID3v2Frame(identifier: ID3v2FrameID.txxx)]

        let frameSet = ID3v2FrameSet(frames: frames)

        do {
            XCTAssert(frameSet.removeFrame(frames[0]) == true)
            XCTAssert(frameSet.removeFrame(frames[0]) == false)

            XCTAssert(frameSet.identifier == ID3v2FrameID.txxx)
            XCTAssert(frameSet.frames.count == 2)
            XCTAssert(frameSet.mainFrame == frames[1])
        }

        do {
            frameSet.removeFrame(at: 0)

            XCTAssert(frameSet.removeFrame(frames[1]) == false)

            XCTAssert(frameSet.identifier == ID3v2FrameID.txxx)
            XCTAssert(frameSet.frames.count == 1)
            XCTAssert(frameSet.mainFrame == frames[2])
        }

        do {
            XCTAssert(frameSet.removeFrame(frames[2]) == true)
            XCTAssert(frameSet.removeFrame(frames[2]) == false)

            XCTAssert(frameSet.identifier == ID3v2FrameID.txxx)
            XCTAssert(frameSet.frames.count == 1)
            XCTAssert(frameSet.mainFrame != frames[2])
        }
    }

    func testAppendFrame() {
        let frameSet = ID3v2FrameSet(identifier: ID3v2FrameID.wxxx)

        do {
            let frame = frameSet.appendFrame()

            XCTAssert(frameSet.identifier == ID3v2FrameID.wxxx)
            XCTAssert(frameSet.frames.count == 2)
            XCTAssert(frameSet.mainFrame != frame)

            XCTAssert(frameSet.frames[1] == frame)
        }

        do {
            let frame = frameSet.appendFrame()

            XCTAssert(frameSet.identifier == ID3v2FrameID.wxxx)
            XCTAssert(frameSet.frames.count == 3)
            XCTAssert(frameSet.mainFrame != frame)

            XCTAssert(frameSet.frames[2] == frame)
        }
    }

    func testReset() {
        let frames: [ID3v2Frame] = [ID3v2Frame(identifier: ID3v2FrameID.txxx),
                                    ID3v2Frame(identifier: ID3v2FrameID.txxx),
                                    ID3v2Frame(identifier: ID3v2FrameID.txxx)]

        do {
            frames[0].tagAlterPreservation = true
            frames[0].fileAlterPreservation = true

            frames[0].readOnly = true

            frames[0].unsynchronisation = true
            frames[0].dataLengthIndicator = true

            frames[0].compression = 6

            frames[0].group = 128

            let stuff = frames[0].imposeStuff(format: ID3v2UnknownValueFormat.regular)

            for _ in 0..<123 {
                stuff.content.append(UInt8(arc4random_uniform(256)))
            }
        }

        do {
            frames[1].tagAlterPreservation = true
            frames[1].fileAlterPreservation = true

            frames[1].readOnly = true

            frames[1].unsynchronisation = true
            frames[1].dataLengthIndicator = true

            frames[1].compression = 6

            frames[1].group = nil

            let stuff = frames[1].imposeStuff(format: ID3v2UnknownValueFormat.regular)

            for _ in 0..<123 {
                stuff.content.append(UInt8(arc4random_uniform(256)))
            }
        }

        do {
            frames[2].tagAlterPreservation = true
            frames[2].fileAlterPreservation = true

            frames[2].readOnly = true

            frames[2].unsynchronisation = true
            frames[2].dataLengthIndicator = true

            frames[2].compression = 0

            frames[2].group = 128

            let stuff = frames[2].imposeStuff(format: ID3v2UnknownValueFormat.regular)

            for _ in 0..<123 {
                stuff.content.append(UInt8(arc4random_uniform(256)))
            }
        }

        let frameSet = ID3v2FrameSet(frames: frames)

        frameSet.reset()

        XCTAssert(frameSet.identifier == ID3v2FrameID.txxx)
        XCTAssert(frameSet.mainFrame == frames[0])
        XCTAssert(frameSet.frames.count == 1)

        XCTAssert(frameSet.mainFrame.isEmpty)

        XCTAssert(frameSet.mainFrame.stuff == nil)

        XCTAssert(frameSet.mainFrame.tagAlterPreservation == false)
        XCTAssert(frameSet.mainFrame.fileAlterPreservation == false)

        XCTAssert(frameSet.mainFrame.readOnly == false)

        XCTAssert(frameSet.mainFrame.unsynchronisation == false)
        XCTAssert(frameSet.mainFrame.dataLengthIndicator == false)

        XCTAssert(frameSet.mainFrame.compression == 0)

        XCTAssert(frameSet.mainFrame.group == nil)
    }
}
