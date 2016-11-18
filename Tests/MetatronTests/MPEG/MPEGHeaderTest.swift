//
//  MPEGHeaderTest.swift
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

class MPEGHeaderTest: XCTestCase {

    // MARK: Instance Methods

    func testVersion1Layer1CaseA() {
        let header = MPEGHeader()

        XCTAssert(header.isValid)

        header.version = MPEGVersion.v1
        header.layer = MPEGLayer.layer1

        header.crc16 = 123

        header.bitRate = 128
        header.sampleRate = 44100

        header.padding = true
        header.privatized = true

        header.channelMode = MPEGChannelMode.stereo

        header.copyrighted = true
        header.original = true

        header.emphasis = MPEGEmphasis.ccitJx17

        XCTAssert(header.isValid)

        guard let data = header.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        guard let otherHeader = MPEGHeader(fromData: data) else {
            return XCTFail()
        }

        XCTAssert(otherHeader.isValid)

        XCTAssert(otherHeader.version == header.version)
        XCTAssert(otherHeader.layer == header.layer)

        XCTAssert(otherHeader.crc16 == header.crc16!)

        XCTAssert(otherHeader.bitRate == header.bitRate)
        XCTAssert(otherHeader.sampleRate == header.sampleRate)

        XCTAssert(otherHeader.padding == header.padding)
        XCTAssert(otherHeader.privatized == header.privatized)

        XCTAssert(otherHeader.channelMode == header.channelMode)

        XCTAssert(otherHeader.copyrighted == header.copyrighted)
        XCTAssert(otherHeader.original == header.original)

        XCTAssert(otherHeader.emphasis == header.emphasis)
    }

    func testVersion1Layer1CaseB() {
        let header = MPEGHeader()

        XCTAssert(header.isValid)

        header.version = MPEGVersion.v1
        header.layer = MPEGLayer.layer1

        header.crc16 = nil

        header.bitRate = 32
        header.sampleRate = 48000

        header.padding = false
        header.privatized = false

        header.channelMode = MPEGChannelMode.jointStereo(stereoCoding: MPEGStereoCoding.midSideAndIntensity)

        header.copyrighted = false
        header.original = false

        header.emphasis = MPEGEmphasis.e50x15ms

        XCTAssert(header.isValid)

        guard let data = header.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        guard let otherHeader = MPEGHeader(fromData: data) else {
            return XCTFail()
        }

        XCTAssert(otherHeader.isValid)

        XCTAssert(otherHeader.version == header.version)
        XCTAssert(otherHeader.layer == header.layer)

        XCTAssert(otherHeader.crc16 == nil)

        XCTAssert(otherHeader.bitRate == header.bitRate)
        XCTAssert(otherHeader.sampleRate == header.sampleRate)

        XCTAssert(otherHeader.padding == header.padding)
        XCTAssert(otherHeader.privatized == header.privatized)

        XCTAssert(otherHeader.channelMode == header.channelMode)

        XCTAssert(otherHeader.copyrighted == header.copyrighted)
        XCTAssert(otherHeader.original == header.original)

        XCTAssert(otherHeader.emphasis == header.emphasis)
    }

    func testVersion1Layer1CaseC() {
        let header = MPEGHeader()

        XCTAssert(header.isValid)

        header.version = MPEGVersion.v1
        header.layer = MPEGLayer.layer1

        header.crc16 = 123

        header.bitRate = 0
        header.sampleRate = 32000

        header.padding = true
        header.privatized = true

        header.channelMode = MPEGChannelMode.dualChannel

        header.copyrighted = false
        header.original = false

        header.emphasis = MPEGEmphasis.none

        XCTAssert(!header.isValid)

        XCTAssert(header.toData() == nil)
    }

    func testVersion1Layer1CaseD() {
        let header = MPEGHeader()

        XCTAssert(header.isValid)

        header.version = MPEGVersion.v1
        header.layer = MPEGLayer.layer1

        header.crc16 = 123

        header.bitRate = 123
        header.sampleRate = 123

        header.padding = true
        header.privatized = true

        header.channelMode = MPEGChannelMode.stereo

        header.copyrighted = true
        header.original = true

        header.emphasis = MPEGEmphasis.none

        XCTAssert(!header.isValid)

        XCTAssert(header.toData() == nil)
    }

    func testVersion1Layer1CaseE() {
        let header = MPEGHeader()

        XCTAssert(header.isValid)

        header.version = MPEGVersion.v1
        header.layer = MPEGLayer.layer1

        header.crc16 = 123

        header.bitRate = 448
        header.sampleRate = 48000

        header.padding = true
        header.privatized = true

        header.channelMode = MPEGChannelMode.singleChannel

        header.copyrighted = true
        header.original = true

        header.emphasis = MPEGEmphasis.none

        XCTAssert(header.isValid)

        guard let data = header.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        guard let otherHeader = MPEGHeader(fromData: data) else {
            return XCTFail()
        }

        XCTAssert(otherHeader.isValid)

        XCTAssert(otherHeader.version == header.version)
        XCTAssert(otherHeader.layer == header.layer)

        XCTAssert(otherHeader.crc16 == header.crc16!)

        XCTAssert(otherHeader.bitRate == header.bitRate)
        XCTAssert(otherHeader.sampleRate == header.sampleRate)

        XCTAssert(otherHeader.padding == header.padding)
        XCTAssert(otherHeader.privatized == header.privatized)

        XCTAssert(otherHeader.channelMode == header.channelMode)

        XCTAssert(otherHeader.copyrighted == header.copyrighted)
        XCTAssert(otherHeader.original == header.original)

        XCTAssert(otherHeader.emphasis == header.emphasis)
    }

    // MARK:

    func testVersion1Layer2CaseA() {
        let header = MPEGHeader()

        XCTAssert(header.isValid)

        header.version = MPEGVersion.v1
        header.layer = MPEGLayer.layer2

        header.crc16 = 123

        header.bitRate = 128
        header.sampleRate = 44100

        header.padding = true
        header.privatized = true

        header.channelMode = MPEGChannelMode.stereo

        header.copyrighted = true
        header.original = true

        header.emphasis = MPEGEmphasis.ccitJx17

        XCTAssert(header.isValid)

        guard let data = header.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        guard let otherHeader = MPEGHeader(fromData: data) else {
            return XCTFail()
        }

        XCTAssert(otherHeader.isValid)

        XCTAssert(otherHeader.version == header.version)
        XCTAssert(otherHeader.layer == header.layer)

        XCTAssert(otherHeader.crc16 == header.crc16!)

        XCTAssert(otherHeader.bitRate == header.bitRate)
        XCTAssert(otherHeader.sampleRate == header.sampleRate)

        XCTAssert(otherHeader.padding == header.padding)
        XCTAssert(otherHeader.privatized == header.privatized)

        XCTAssert(otherHeader.channelMode == header.channelMode)

        XCTAssert(otherHeader.copyrighted == header.copyrighted)
        XCTAssert(otherHeader.original == header.original)

        XCTAssert(otherHeader.emphasis == header.emphasis)
    }

    func testVersion1Layer2CaseB() {
        let header = MPEGHeader()

        XCTAssert(header.isValid)

        header.version = MPEGVersion.v1
        header.layer = MPEGLayer.layer2

        header.crc16 = nil

        header.bitRate = 32
        header.sampleRate = 48000

        header.padding = false
        header.privatized = false

        header.channelMode = MPEGChannelMode.jointStereo(stereoCoding: MPEGStereoCoding.midSideAndIntensity)

        header.copyrighted = false
        header.original = false

        header.emphasis = MPEGEmphasis.e50x15ms

        XCTAssert(!header.isValid)

        XCTAssert(header.toData() == nil)
    }

    func testVersion1Layer2CaseC() {
        let header = MPEGHeader()

        XCTAssert(header.isValid)

        header.version = MPEGVersion.v1
        header.layer = MPEGLayer.layer2

        header.crc16 = 123

        header.bitRate = 0
        header.sampleRate = 32000

        header.padding = true
        header.privatized = true

        header.channelMode = MPEGChannelMode.dualChannel

        header.copyrighted = false
        header.original = false

        header.emphasis = MPEGEmphasis.none

        XCTAssert(!header.isValid)

        XCTAssert(header.toData() == nil)
    }

    func testVersion1Layer2CaseD() {
        let header = MPEGHeader()

        XCTAssert(header.isValid)

        header.version = MPEGVersion.v1
        header.layer = MPEGLayer.layer2

        header.crc16 = 123

        header.bitRate = 123
        header.sampleRate = 123

        header.padding = true
        header.privatized = true

        header.channelMode = MPEGChannelMode.stereo

        header.copyrighted = true
        header.original = true

        header.emphasis = MPEGEmphasis.none

        XCTAssert(!header.isValid)

        XCTAssert(header.toData() == nil)
    }

    func testVersion1Layer2CaseE() {
        let header = MPEGHeader()

        XCTAssert(header.isValid)

        header.version = MPEGVersion.v1
        header.layer = MPEGLayer.layer2

        header.crc16 = 123

        header.bitRate = 384
        header.sampleRate = 48000

        header.padding = true
        header.privatized = true

        header.channelMode = MPEGChannelMode.singleChannel

        header.copyrighted = true
        header.original = true

        header.emphasis = MPEGEmphasis.none

        XCTAssert(!header.isValid)

        XCTAssert(header.toData() == nil)
    }

    // MARK:

    func testVersion1Layer3CaseA() {
        let header = MPEGHeader()

        XCTAssert(header.isValid)

        header.version = MPEGVersion.v1
        header.layer = MPEGLayer.layer3

        header.crc16 = 123

        header.bitRate = 128
        header.sampleRate = 44100

        header.padding = true
        header.privatized = true

        header.channelMode = MPEGChannelMode.stereo

        header.copyrighted = true
        header.original = true

        header.emphasis = MPEGEmphasis.ccitJx17

        XCTAssert(header.isValid)

        guard let data = header.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        guard let otherHeader = MPEGHeader(fromData: data) else {
            return XCTFail()
        }

        XCTAssert(otherHeader.isValid)

        XCTAssert(otherHeader.version == header.version)
        XCTAssert(otherHeader.layer == header.layer)

        XCTAssert(otherHeader.crc16 == header.crc16!)

        XCTAssert(otherHeader.bitRate == header.bitRate)
        XCTAssert(otherHeader.sampleRate == header.sampleRate)

        XCTAssert(otherHeader.padding == header.padding)
        XCTAssert(otherHeader.privatized == header.privatized)

        XCTAssert(otherHeader.channelMode == header.channelMode)

        XCTAssert(otherHeader.copyrighted == header.copyrighted)
        XCTAssert(otherHeader.original == header.original)

        XCTAssert(otherHeader.emphasis == header.emphasis)
    }

    func testVersion1Layer3CaseB() {
        let header = MPEGHeader()

        XCTAssert(header.isValid)

        header.version = MPEGVersion.v1
        header.layer = MPEGLayer.layer3

        header.crc16 = nil

        header.bitRate = 32
        header.sampleRate = 48000

        header.padding = false
        header.privatized = false

        header.channelMode = MPEGChannelMode.jointStereo(stereoCoding: MPEGStereoCoding.midSideAndIntensity)

        header.copyrighted = false
        header.original = false

        header.emphasis = MPEGEmphasis.e50x15ms

        XCTAssert(header.isValid)

        guard let data = header.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        guard let otherHeader = MPEGHeader(fromData: data) else {
            return XCTFail()
        }

        XCTAssert(otherHeader.isValid)

        XCTAssert(otherHeader.version == header.version)
        XCTAssert(otherHeader.layer == header.layer)

        XCTAssert(otherHeader.crc16 == nil)

        XCTAssert(otherHeader.bitRate == header.bitRate)
        XCTAssert(otherHeader.sampleRate == header.sampleRate)

        XCTAssert(otherHeader.padding == header.padding)
        XCTAssert(otherHeader.privatized == header.privatized)

        XCTAssert(otherHeader.channelMode == header.channelMode)

        XCTAssert(otherHeader.copyrighted == header.copyrighted)
        XCTAssert(otherHeader.original == header.original)

        XCTAssert(otherHeader.emphasis == header.emphasis)
    }

    func testVersion1Layer3CaseC() {
        let header = MPEGHeader()

        XCTAssert(header.isValid)

        header.version = MPEGVersion.v1
        header.layer = MPEGLayer.layer3

        header.crc16 = 123

        header.bitRate = 0
        header.sampleRate = 32000

        header.padding = true
        header.privatized = true

        header.channelMode = MPEGChannelMode.dualChannel

        header.copyrighted = false
        header.original = false

        header.emphasis = MPEGEmphasis.none

        XCTAssert(!header.isValid)

        XCTAssert(header.toData() == nil)
    }

    func testVersion1Layer3CaseD() {
        let header = MPEGHeader()

        XCTAssert(header.isValid)

        header.version = MPEGVersion.v1
        header.layer = MPEGLayer.layer3

        header.crc16 = 123

        header.bitRate = 123
        header.sampleRate = 123

        header.padding = true
        header.privatized = true

        header.channelMode = MPEGChannelMode.stereo

        header.copyrighted = true
        header.original = true

        header.emphasis = MPEGEmphasis.none

        XCTAssert(!header.isValid)

        XCTAssert(header.toData() == nil)
    }

    func testVersion1Layer3CaseE() {
        let header = MPEGHeader()

        XCTAssert(header.isValid)

        header.version = MPEGVersion.v1
        header.layer = MPEGLayer.layer3

        header.crc16 = 123

        header.bitRate = 320
        header.sampleRate = 48000

        header.padding = true
        header.privatized = true

        header.channelMode = MPEGChannelMode.singleChannel

        header.copyrighted = true
        header.original = true

        header.emphasis = MPEGEmphasis.none

        XCTAssert(header.isValid)

        guard let data = header.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        guard let otherHeader = MPEGHeader(fromData: data) else {
            return XCTFail()
        }

        XCTAssert(otherHeader.isValid)

        XCTAssert(otherHeader.version == header.version)
        XCTAssert(otherHeader.layer == header.layer)

        XCTAssert(otherHeader.crc16 == header.crc16!)

        XCTAssert(otherHeader.bitRate == header.bitRate)
        XCTAssert(otherHeader.sampleRate == header.sampleRate)

        XCTAssert(otherHeader.padding == header.padding)
        XCTAssert(otherHeader.privatized == header.privatized)

        XCTAssert(otherHeader.channelMode == header.channelMode)

        XCTAssert(otherHeader.copyrighted == header.copyrighted)
        XCTAssert(otherHeader.original == header.original)

        XCTAssert(otherHeader.emphasis == header.emphasis)
    }

    // MARK:

    func testVersion2Layer1CaseA() {
        let header = MPEGHeader()

        XCTAssert(header.isValid)

        header.version = MPEGVersion.v2
        header.layer = MPEGLayer.layer1

        header.crc16 = 123

        header.bitRate = 128
        header.sampleRate = 22050

        header.padding = true
        header.privatized = true

        header.channelMode = MPEGChannelMode.stereo

        header.copyrighted = true
        header.original = true

        header.emphasis = MPEGEmphasis.ccitJx17

        XCTAssert(header.isValid)

        guard let data = header.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        guard let otherHeader = MPEGHeader(fromData: data) else {
            return XCTFail()
        }

        XCTAssert(otherHeader.isValid)

        XCTAssert(otherHeader.version == header.version)
        XCTAssert(otherHeader.layer == header.layer)

        XCTAssert(otherHeader.crc16 == header.crc16!)

        XCTAssert(otherHeader.bitRate == header.bitRate)
        XCTAssert(otherHeader.sampleRate == header.sampleRate)

        XCTAssert(otherHeader.padding == header.padding)
        XCTAssert(otherHeader.privatized == header.privatized)

        XCTAssert(otherHeader.channelMode == header.channelMode)

        XCTAssert(otherHeader.copyrighted == header.copyrighted)
        XCTAssert(otherHeader.original == header.original)

        XCTAssert(otherHeader.emphasis == header.emphasis)
    }

    func testVersion2Layer1CaseB() {
        let header = MPEGHeader()

        XCTAssert(header.isValid)

        header.version = MPEGVersion.v2
        header.layer = MPEGLayer.layer1

        header.crc16 = nil

        header.bitRate = 32
        header.sampleRate = 24000

        header.padding = false
        header.privatized = false

        header.channelMode = MPEGChannelMode.jointStereo(stereoCoding: MPEGStereoCoding.midSideAndIntensity)

        header.copyrighted = false
        header.original = false

        header.emphasis = MPEGEmphasis.e50x15ms

        XCTAssert(header.isValid)

        guard let data = header.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        guard let otherHeader = MPEGHeader(fromData: data) else {
            return XCTFail()
        }

        XCTAssert(otherHeader.isValid)

        XCTAssert(otherHeader.version == header.version)
        XCTAssert(otherHeader.layer == header.layer)

        XCTAssert(otherHeader.crc16 == nil)

        XCTAssert(otherHeader.bitRate == header.bitRate)
        XCTAssert(otherHeader.sampleRate == header.sampleRate)

        XCTAssert(otherHeader.padding == header.padding)
        XCTAssert(otherHeader.privatized == header.privatized)

        XCTAssert(otherHeader.channelMode == header.channelMode)

        XCTAssert(otherHeader.copyrighted == header.copyrighted)
        XCTAssert(otherHeader.original == header.original)

        XCTAssert(otherHeader.emphasis == header.emphasis)
    }

    func testVersion2Layer1CaseC() {
        let header = MPEGHeader()

        XCTAssert(header.isValid)

        header.version = MPEGVersion.v2
        header.layer = MPEGLayer.layer1

        header.crc16 = 123

        header.bitRate = 0
        header.sampleRate = 16000

        header.padding = true
        header.privatized = true

        header.channelMode = MPEGChannelMode.dualChannel

        header.copyrighted = false
        header.original = false

        header.emphasis = MPEGEmphasis.none

        XCTAssert(!header.isValid)

        XCTAssert(header.toData() == nil)
    }

    func testVersion2Layer1CaseD() {
        let header = MPEGHeader()

        XCTAssert(header.isValid)

        header.version = MPEGVersion.v2
        header.layer = MPEGLayer.layer1

        header.crc16 = 123

        header.bitRate = 123
        header.sampleRate = 123

        header.padding = true
        header.privatized = true

        header.channelMode = MPEGChannelMode.stereo

        header.copyrighted = true
        header.original = true

        header.emphasis = MPEGEmphasis.none

        XCTAssert(!header.isValid)

        XCTAssert(header.toData() == nil)
    }

    func testVersion2Layer1CaseE() {
        let header = MPEGHeader()

        XCTAssert(header.isValid)

        header.version = MPEGVersion.v2
        header.layer = MPEGLayer.layer1

        header.crc16 = 123

        header.bitRate = 256
        header.sampleRate = 24000

        header.padding = true
        header.privatized = true

        header.channelMode = MPEGChannelMode.singleChannel

        header.copyrighted = true
        header.original = true

        header.emphasis = MPEGEmphasis.none

        XCTAssert(header.isValid)

        guard let data = header.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        guard let otherHeader = MPEGHeader(fromData: data) else {
            return XCTFail()
        }

        XCTAssert(otherHeader.isValid)

        XCTAssert(otherHeader.version == header.version)
        XCTAssert(otherHeader.layer == header.layer)

        XCTAssert(otherHeader.crc16 == header.crc16!)

        XCTAssert(otherHeader.bitRate == header.bitRate)
        XCTAssert(otherHeader.sampleRate == header.sampleRate)

        XCTAssert(otherHeader.padding == header.padding)
        XCTAssert(otherHeader.privatized == header.privatized)

        XCTAssert(otherHeader.channelMode == header.channelMode)

        XCTAssert(otherHeader.copyrighted == header.copyrighted)
        XCTAssert(otherHeader.original == header.original)

        XCTAssert(otherHeader.emphasis == header.emphasis)
    }

    // MARK:

    func testVersion2Layer2CaseA() {
        let header = MPEGHeader()

        XCTAssert(header.isValid)

        header.version = MPEGVersion.v2
        header.layer = MPEGLayer.layer2

        header.crc16 = 123

        header.bitRate = 128
        header.sampleRate = 22050

        header.padding = true
        header.privatized = true

        header.channelMode = MPEGChannelMode.stereo

        header.copyrighted = true
        header.original = true

        header.emphasis = MPEGEmphasis.ccitJx17

        XCTAssert(header.isValid)

        guard let data = header.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        guard let otherHeader = MPEGHeader(fromData: data) else {
            return XCTFail()
        }

        XCTAssert(otherHeader.isValid)

        XCTAssert(otherHeader.version == header.version)
        XCTAssert(otherHeader.layer == header.layer)

        XCTAssert(otherHeader.crc16 == header.crc16!)

        XCTAssert(otherHeader.bitRate == header.bitRate)
        XCTAssert(otherHeader.sampleRate == header.sampleRate)

        XCTAssert(otherHeader.padding == header.padding)
        XCTAssert(otherHeader.privatized == header.privatized)

        XCTAssert(otherHeader.channelMode == header.channelMode)

        XCTAssert(otherHeader.copyrighted == header.copyrighted)
        XCTAssert(otherHeader.original == header.original)

        XCTAssert(otherHeader.emphasis == header.emphasis)
    }

    func testVersion2Layer2CaseB() {
        let header = MPEGHeader()

        XCTAssert(header.isValid)

        header.version = MPEGVersion.v2
        header.layer = MPEGLayer.layer2

        header.crc16 = nil

        header.bitRate = 32
        header.sampleRate = 24000

        header.padding = false
        header.privatized = false

        header.channelMode = MPEGChannelMode.jointStereo(stereoCoding: MPEGStereoCoding.midSideAndIntensity)

        header.copyrighted = false
        header.original = false

        header.emphasis = MPEGEmphasis.e50x15ms

        XCTAssert(header.isValid)

        guard let data = header.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        guard let otherHeader = MPEGHeader(fromData: data) else {
            return XCTFail()
        }

        XCTAssert(otherHeader.isValid)

        XCTAssert(otherHeader.version == header.version)
        XCTAssert(otherHeader.layer == header.layer)

        XCTAssert(otherHeader.crc16 == nil)

        XCTAssert(otherHeader.bitRate == header.bitRate)
        XCTAssert(otherHeader.sampleRate == header.sampleRate)

        XCTAssert(otherHeader.padding == header.padding)
        XCTAssert(otherHeader.privatized == header.privatized)

        XCTAssert(otherHeader.channelMode == header.channelMode)

        XCTAssert(otherHeader.copyrighted == header.copyrighted)
        XCTAssert(otherHeader.original == header.original)

        XCTAssert(otherHeader.emphasis == header.emphasis)
    }

    func testVersion2Layer2CaseC() {
        let header = MPEGHeader()

        XCTAssert(header.isValid)

        header.version = MPEGVersion.v2
        header.layer = MPEGLayer.layer2

        header.crc16 = 123

        header.bitRate = 0
        header.sampleRate = 16000

        header.padding = true
        header.privatized = true

        header.channelMode = MPEGChannelMode.dualChannel

        header.copyrighted = false
        header.original = false

        header.emphasis = MPEGEmphasis.none

        XCTAssert(!header.isValid)

        XCTAssert(header.toData() == nil)
    }

    func testVersion2Layer2CaseD() {
        let header = MPEGHeader()

        XCTAssert(header.isValid)

        header.version = MPEGVersion.v2
        header.layer = MPEGLayer.layer2

        header.crc16 = 123

        header.bitRate = 123
        header.sampleRate = 123

        header.padding = true
        header.privatized = true

        header.channelMode = MPEGChannelMode.stereo

        header.copyrighted = true
        header.original = true

        header.emphasis = MPEGEmphasis.none

        XCTAssert(!header.isValid)

        XCTAssert(header.toData() == nil)
    }

    func testVersion2Layer2CaseE() {
        let header = MPEGHeader()

        XCTAssert(header.isValid)

        header.version = MPEGVersion.v2
        header.layer = MPEGLayer.layer2

        header.crc16 = 123

        header.bitRate = 160
        header.sampleRate = 24000

        header.padding = true
        header.privatized = true

        header.channelMode = MPEGChannelMode.singleChannel

        header.copyrighted = true
        header.original = true

        header.emphasis = MPEGEmphasis.none

        XCTAssert(!header.isValid)

        XCTAssert(header.toData() == nil)
    }

    // MARK:

    func testVersion2Layer3CaseA() {
        let header = MPEGHeader()

        XCTAssert(header.isValid)

        header.version = MPEGVersion.v2
        header.layer = MPEGLayer.layer3

        header.crc16 = 123

        header.bitRate = 128
        header.sampleRate = 22050

        header.padding = true
        header.privatized = true

        header.channelMode = MPEGChannelMode.stereo

        header.copyrighted = true
        header.original = true

        header.emphasis = MPEGEmphasis.ccitJx17

        XCTAssert(header.isValid)

        guard let data = header.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        guard let otherHeader = MPEGHeader(fromData: data) else {
            return XCTFail()
        }

        XCTAssert(otherHeader.isValid)

        XCTAssert(otherHeader.version == header.version)
        XCTAssert(otherHeader.layer == header.layer)

        XCTAssert(otherHeader.crc16 == header.crc16!)

        XCTAssert(otherHeader.bitRate == header.bitRate)
        XCTAssert(otherHeader.sampleRate == header.sampleRate)

        XCTAssert(otherHeader.padding == header.padding)
        XCTAssert(otherHeader.privatized == header.privatized)

        XCTAssert(otherHeader.channelMode == header.channelMode)

        XCTAssert(otherHeader.copyrighted == header.copyrighted)
        XCTAssert(otherHeader.original == header.original)

        XCTAssert(otherHeader.emphasis == header.emphasis)
    }

    func testVersion2Layer3CaseB() {
        let header = MPEGHeader()

        XCTAssert(header.isValid)

        header.version = MPEGVersion.v2
        header.layer = MPEGLayer.layer3

        header.crc16 = nil

        header.bitRate = 32
        header.sampleRate = 24000

        header.padding = false
        header.privatized = false

        header.channelMode = MPEGChannelMode.jointStereo(stereoCoding: MPEGStereoCoding.midSideAndIntensity)

        header.copyrighted = false
        header.original = false

        header.emphasis = MPEGEmphasis.e50x15ms

        XCTAssert(header.isValid)

        guard let data = header.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        guard let otherHeader = MPEGHeader(fromData: data) else {
            return XCTFail()
        }

        XCTAssert(otherHeader.isValid)

        XCTAssert(otherHeader.version == header.version)
        XCTAssert(otherHeader.layer == header.layer)

        XCTAssert(otherHeader.crc16 == nil)

        XCTAssert(otherHeader.bitRate == header.bitRate)
        XCTAssert(otherHeader.sampleRate == header.sampleRate)

        XCTAssert(otherHeader.padding == header.padding)
        XCTAssert(otherHeader.privatized == header.privatized)

        XCTAssert(otherHeader.channelMode == header.channelMode)

        XCTAssert(otherHeader.copyrighted == header.copyrighted)
        XCTAssert(otherHeader.original == header.original)

        XCTAssert(otherHeader.emphasis == header.emphasis)
    }

    func testVersion2Layer3CaseC() {
        let header = MPEGHeader()

        XCTAssert(header.isValid)

        header.version = MPEGVersion.v2
        header.layer = MPEGLayer.layer3

        header.crc16 = 123

        header.bitRate = 0
        header.sampleRate = 16000

        header.padding = true
        header.privatized = true

        header.channelMode = MPEGChannelMode.dualChannel

        header.copyrighted = false
        header.original = false

        header.emphasis = MPEGEmphasis.none

        XCTAssert(!header.isValid)

        XCTAssert(header.toData() == nil)
    }

    func testVersion2Layer3CaseD() {
        let header = MPEGHeader()

        XCTAssert(header.isValid)

        header.version = MPEGVersion.v2
        header.layer = MPEGLayer.layer3

        header.crc16 = 123

        header.bitRate = 123
        header.sampleRate = 123

        header.padding = true
        header.privatized = true

        header.channelMode = MPEGChannelMode.stereo

        header.copyrighted = true
        header.original = true

        header.emphasis = MPEGEmphasis.none

        XCTAssert(!header.isValid)

        XCTAssert(header.toData() == nil)
    }

    func testVersion2Layer3CaseE() {
        let header = MPEGHeader()

        XCTAssert(header.isValid)

        header.version = MPEGVersion.v2
        header.layer = MPEGLayer.layer3

        header.crc16 = 123

        header.bitRate = 160
        header.sampleRate = 24000

        header.padding = true
        header.privatized = true

        header.channelMode = MPEGChannelMode.singleChannel

        header.copyrighted = true
        header.original = true

        header.emphasis = MPEGEmphasis.none

        XCTAssert(header.isValid)

        guard let data = header.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        guard let otherHeader = MPEGHeader(fromData: data) else {
            return XCTFail()
        }

        XCTAssert(otherHeader.isValid)

        XCTAssert(otherHeader.version == header.version)
        XCTAssert(otherHeader.layer == header.layer)

        XCTAssert(otherHeader.crc16 == header.crc16!)

        XCTAssert(otherHeader.bitRate == header.bitRate)
        XCTAssert(otherHeader.sampleRate == header.sampleRate)

        XCTAssert(otherHeader.padding == header.padding)
        XCTAssert(otherHeader.privatized == header.privatized)

        XCTAssert(otherHeader.channelMode == header.channelMode)

        XCTAssert(otherHeader.copyrighted == header.copyrighted)
        XCTAssert(otherHeader.original == header.original)

        XCTAssert(otherHeader.emphasis == header.emphasis)
    }

    // MARK:

    func testVersion3Layer1CaseA() {
        let header = MPEGHeader()

        XCTAssert(header.isValid)

        header.version = MPEGVersion.v2x5
        header.layer = MPEGLayer.layer1

        header.crc16 = 123

        header.bitRate = 128
        header.sampleRate = 11025

        header.padding = true
        header.privatized = true

        header.channelMode = MPEGChannelMode.stereo

        header.copyrighted = true
        header.original = true

        header.emphasis = MPEGEmphasis.ccitJx17

        XCTAssert(header.isValid)

        guard let data = header.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        guard let otherHeader = MPEGHeader(fromData: data) else {
            return XCTFail()
        }

        XCTAssert(otherHeader.isValid)

        XCTAssert(otherHeader.version == header.version)
        XCTAssert(otherHeader.layer == header.layer)

        XCTAssert(otherHeader.crc16 == header.crc16!)

        XCTAssert(otherHeader.bitRate == header.bitRate)
        XCTAssert(otherHeader.sampleRate == header.sampleRate)

        XCTAssert(otherHeader.padding == header.padding)
        XCTAssert(otherHeader.privatized == header.privatized)

        XCTAssert(otherHeader.channelMode == header.channelMode)

        XCTAssert(otherHeader.copyrighted == header.copyrighted)
        XCTAssert(otherHeader.original == header.original)

        XCTAssert(otherHeader.emphasis == header.emphasis)
    }

    func testVersion3Layer1CaseB() {
        let header = MPEGHeader()

        XCTAssert(header.isValid)

        header.version = MPEGVersion.v2x5
        header.layer = MPEGLayer.layer1

        header.crc16 = nil

        header.bitRate = 32
        header.sampleRate = 12000

        header.padding = false
        header.privatized = false

        header.channelMode = MPEGChannelMode.jointStereo(stereoCoding: MPEGStereoCoding.midSideAndIntensity)

        header.copyrighted = false
        header.original = false

        header.emphasis = MPEGEmphasis.e50x15ms

        XCTAssert(header.isValid)

        guard let data = header.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        guard let otherHeader = MPEGHeader(fromData: data) else {
            return XCTFail()
        }

        XCTAssert(otherHeader.isValid)

        XCTAssert(otherHeader.version == header.version)
        XCTAssert(otherHeader.layer == header.layer)

        XCTAssert(otherHeader.crc16 == nil)

        XCTAssert(otherHeader.bitRate == header.bitRate)
        XCTAssert(otherHeader.sampleRate == header.sampleRate)

        XCTAssert(otherHeader.padding == header.padding)
        XCTAssert(otherHeader.privatized == header.privatized)

        XCTAssert(otherHeader.channelMode == header.channelMode)

        XCTAssert(otherHeader.copyrighted == header.copyrighted)
        XCTAssert(otherHeader.original == header.original)

        XCTAssert(otherHeader.emphasis == header.emphasis)
    }

    func testVersion3Layer1CaseC() {
        let header = MPEGHeader()

        XCTAssert(header.isValid)

        header.version = MPEGVersion.v2x5
        header.layer = MPEGLayer.layer1

        header.crc16 = 123

        header.bitRate = 0
        header.sampleRate = 8000

        header.padding = true
        header.privatized = true

        header.channelMode = MPEGChannelMode.dualChannel

        header.copyrighted = false
        header.original = false

        header.emphasis = MPEGEmphasis.none

        XCTAssert(!header.isValid)

        XCTAssert(header.toData() == nil)
    }

    func testVersion3Layer1CaseD() {
        let header = MPEGHeader()

        XCTAssert(header.isValid)

        header.version = MPEGVersion.v2x5
        header.layer = MPEGLayer.layer1

        header.crc16 = 123

        header.bitRate = 123
        header.sampleRate = 123

        header.padding = true
        header.privatized = true

        header.channelMode = MPEGChannelMode.stereo

        header.copyrighted = true
        header.original = true

        header.emphasis = MPEGEmphasis.none

        XCTAssert(!header.isValid)

        XCTAssert(header.toData() == nil)
    }

    func testVersion3Layer1CaseE() {
        let header = MPEGHeader()

        XCTAssert(header.isValid)

        header.version = MPEGVersion.v2x5
        header.layer = MPEGLayer.layer1

        header.crc16 = 123

        header.bitRate = 256
        header.sampleRate = 12000

        header.padding = true
        header.privatized = true

        header.channelMode = MPEGChannelMode.singleChannel

        header.copyrighted = true
        header.original = true

        header.emphasis = MPEGEmphasis.none

        XCTAssert(header.isValid)

        guard let data = header.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        guard let otherHeader = MPEGHeader(fromData: data) else {
            return XCTFail()
        }

        XCTAssert(otherHeader.isValid)

        XCTAssert(otherHeader.version == header.version)
        XCTAssert(otherHeader.layer == header.layer)

        XCTAssert(otherHeader.crc16 == header.crc16!)

        XCTAssert(otherHeader.bitRate == header.bitRate)
        XCTAssert(otherHeader.sampleRate == header.sampleRate)

        XCTAssert(otherHeader.padding == header.padding)
        XCTAssert(otherHeader.privatized == header.privatized)

        XCTAssert(otherHeader.channelMode == header.channelMode)

        XCTAssert(otherHeader.copyrighted == header.copyrighted)
        XCTAssert(otherHeader.original == header.original)

        XCTAssert(otherHeader.emphasis == header.emphasis)
    }

    // MARK:

    func testVersion3Layer2CaseA() {
        let header = MPEGHeader()

        XCTAssert(header.isValid)

        header.version = MPEGVersion.v2x5
        header.layer = MPEGLayer.layer2

        header.crc16 = 123

        header.bitRate = 128
        header.sampleRate = 11025

        header.padding = true
        header.privatized = true

        header.channelMode = MPEGChannelMode.stereo

        header.copyrighted = true
        header.original = true

        header.emphasis = MPEGEmphasis.ccitJx17

        XCTAssert(header.isValid)

        guard let data = header.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        guard let otherHeader = MPEGHeader(fromData: data) else {
            return XCTFail()
        }

        XCTAssert(otherHeader.isValid)

        XCTAssert(otherHeader.version == header.version)
        XCTAssert(otherHeader.layer == header.layer)

        XCTAssert(otherHeader.crc16 == header.crc16!)

        XCTAssert(otherHeader.bitRate == header.bitRate)
        XCTAssert(otherHeader.sampleRate == header.sampleRate)

        XCTAssert(otherHeader.padding == header.padding)
        XCTAssert(otherHeader.privatized == header.privatized)

        XCTAssert(otherHeader.channelMode == header.channelMode)

        XCTAssert(otherHeader.copyrighted == header.copyrighted)
        XCTAssert(otherHeader.original == header.original)

        XCTAssert(otherHeader.emphasis == header.emphasis)
    }

    func testVersion3Layer2CaseB() {
        let header = MPEGHeader()

        XCTAssert(header.isValid)

        header.version = MPEGVersion.v2x5
        header.layer = MPEGLayer.layer2

        header.crc16 = nil

        header.bitRate = 32
        header.sampleRate = 12000

        header.padding = false
        header.privatized = false

        header.channelMode = MPEGChannelMode.jointStereo(stereoCoding: MPEGStereoCoding.midSideAndIntensity)

        header.copyrighted = false
        header.original = false

        header.emphasis = MPEGEmphasis.e50x15ms

        XCTAssert(header.isValid)

        guard let data = header.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        guard let otherHeader = MPEGHeader(fromData: data) else {
            return XCTFail()
        }

        XCTAssert(otherHeader.isValid)

        XCTAssert(otherHeader.version == header.version)
        XCTAssert(otherHeader.layer == header.layer)

        XCTAssert(otherHeader.crc16 == nil)

        XCTAssert(otherHeader.bitRate == header.bitRate)
        XCTAssert(otherHeader.sampleRate == header.sampleRate)

        XCTAssert(otherHeader.padding == header.padding)
        XCTAssert(otherHeader.privatized == header.privatized)

        XCTAssert(otherHeader.channelMode == header.channelMode)

        XCTAssert(otherHeader.copyrighted == header.copyrighted)
        XCTAssert(otherHeader.original == header.original)

        XCTAssert(otherHeader.emphasis == header.emphasis)
    }

    func testVersion3Layer2CaseC() {
        let header = MPEGHeader()

        XCTAssert(header.isValid)

        header.version = MPEGVersion.v2x5
        header.layer = MPEGLayer.layer2

        header.crc16 = 123

        header.bitRate = 0
        header.sampleRate = 8000

        header.padding = true
        header.privatized = true

        header.channelMode = MPEGChannelMode.dualChannel

        header.copyrighted = false
        header.original = false

        header.emphasis = MPEGEmphasis.none

        XCTAssert(!header.isValid)

        XCTAssert(header.toData() == nil)
    }

    func testVersion3Layer2CaseD() {
        let header = MPEGHeader()

        XCTAssert(header.isValid)

        header.version = MPEGVersion.v2x5
        header.layer = MPEGLayer.layer2

        header.crc16 = 123

        header.bitRate = 123
        header.sampleRate = 123

        header.padding = true
        header.privatized = true

        header.channelMode = MPEGChannelMode.stereo

        header.copyrighted = true
        header.original = true

        header.emphasis = MPEGEmphasis.none

        XCTAssert(!header.isValid)

        XCTAssert(header.toData() == nil)
    }

    func testVersion3Layer2CaseE() {
        let header = MPEGHeader()

        XCTAssert(header.isValid)

        header.version = MPEGVersion.v2x5
        header.layer = MPEGLayer.layer2

        header.crc16 = 123

        header.bitRate = 160
        header.sampleRate = 12000

        header.padding = true
        header.privatized = true

        header.channelMode = MPEGChannelMode.singleChannel

        header.copyrighted = true
        header.original = true

        header.emphasis = MPEGEmphasis.none

        XCTAssert(!header.isValid)

        XCTAssert(header.toData() == nil)
    }

    // MARK:

    func testVersion3Layer3CaseA() {
        let header = MPEGHeader()

        XCTAssert(header.isValid)

        header.version = MPEGVersion.v2x5
        header.layer = MPEGLayer.layer3

        header.crc16 = 123

        header.bitRate = 128
        header.sampleRate = 11025

        header.padding = true
        header.privatized = true

        header.channelMode = MPEGChannelMode.stereo

        header.copyrighted = true
        header.original = true

        header.emphasis = MPEGEmphasis.ccitJx17

        XCTAssert(header.isValid)

        guard let data = header.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        guard let otherHeader = MPEGHeader(fromData: data) else {
            return XCTFail()
        }

        XCTAssert(otherHeader.isValid)

        XCTAssert(otherHeader.version == header.version)
        XCTAssert(otherHeader.layer == header.layer)

        XCTAssert(otherHeader.crc16 == header.crc16!)

        XCTAssert(otherHeader.bitRate == header.bitRate)
        XCTAssert(otherHeader.sampleRate == header.sampleRate)

        XCTAssert(otherHeader.padding == header.padding)
        XCTAssert(otherHeader.privatized == header.privatized)

        XCTAssert(otherHeader.channelMode == header.channelMode)

        XCTAssert(otherHeader.copyrighted == header.copyrighted)
        XCTAssert(otherHeader.original == header.original)

        XCTAssert(otherHeader.emphasis == header.emphasis)
    }

    func testVersion3Layer3CaseB() {
        let header = MPEGHeader()

        XCTAssert(header.isValid)

        header.version = MPEGVersion.v2x5
        header.layer = MPEGLayer.layer3

        header.crc16 = nil

        header.bitRate = 32
        header.sampleRate = 12000

        header.padding = false
        header.privatized = false

        header.channelMode = MPEGChannelMode.jointStereo(stereoCoding: MPEGStereoCoding.midSideAndIntensity)

        header.copyrighted = false
        header.original = false

        header.emphasis = MPEGEmphasis.e50x15ms

        XCTAssert(header.isValid)

        guard let data = header.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        guard let otherHeader = MPEGHeader(fromData: data) else {
            return XCTFail()
        }

        XCTAssert(otherHeader.isValid)

        XCTAssert(otherHeader.version == header.version)
        XCTAssert(otherHeader.layer == header.layer)

        XCTAssert(otherHeader.crc16 == nil)

        XCTAssert(otherHeader.bitRate == header.bitRate)
        XCTAssert(otherHeader.sampleRate == header.sampleRate)

        XCTAssert(otherHeader.padding == header.padding)
        XCTAssert(otherHeader.privatized == header.privatized)

        XCTAssert(otherHeader.channelMode == header.channelMode)

        XCTAssert(otherHeader.copyrighted == header.copyrighted)
        XCTAssert(otherHeader.original == header.original)

        XCTAssert(otherHeader.emphasis == header.emphasis)
    }

    func testVersion3Layer3CaseC() {
        let header = MPEGHeader()

        XCTAssert(header.isValid)

        header.version = MPEGVersion.v2x5
        header.layer = MPEGLayer.layer3

        header.crc16 = 123

        header.bitRate = 0
        header.sampleRate = 8000

        header.padding = true
        header.privatized = true

        header.channelMode = MPEGChannelMode.dualChannel

        header.copyrighted = false
        header.original = false

        header.emphasis = MPEGEmphasis.none

        XCTAssert(!header.isValid)

        XCTAssert(header.toData() == nil)
    }

    func testVersion3Layer3CaseD() {
        let header = MPEGHeader()

        XCTAssert(header.isValid)

        header.version = MPEGVersion.v2x5
        header.layer = MPEGLayer.layer3

        header.crc16 = 123

        header.bitRate = 123
        header.sampleRate = 123

        header.padding = true
        header.privatized = true

        header.channelMode = MPEGChannelMode.stereo

        header.copyrighted = true
        header.original = true

        header.emphasis = MPEGEmphasis.none

        XCTAssert(!header.isValid)

        XCTAssert(header.toData() == nil)
    }

    func testVersion3Layer3CaseE() {
        let header = MPEGHeader()

        XCTAssert(header.isValid)

        header.version = MPEGVersion.v2x5
        header.layer = MPEGLayer.layer3

        header.crc16 = 123

        header.bitRate = 160
        header.sampleRate = 12000

        header.padding = true
        header.privatized = true

        header.channelMode = MPEGChannelMode.singleChannel

        header.copyrighted = true
        header.original = true

        header.emphasis = MPEGEmphasis.none

        XCTAssert(header.isValid)

        guard let data = header.toData() else {
            return XCTFail()
        }

        XCTAssert(!data.isEmpty)

        guard let otherHeader = MPEGHeader(fromData: data) else {
            return XCTFail()
        }

        XCTAssert(otherHeader.isValid)

        XCTAssert(otherHeader.version == header.version)
        XCTAssert(otherHeader.layer == header.layer)

        XCTAssert(otherHeader.crc16 == header.crc16!)

        XCTAssert(otherHeader.bitRate == header.bitRate)
        XCTAssert(otherHeader.sampleRate == header.sampleRate)

        XCTAssert(otherHeader.padding == header.padding)
        XCTAssert(otherHeader.privatized == header.privatized)

        XCTAssert(otherHeader.channelMode == header.channelMode)

        XCTAssert(otherHeader.copyrighted == header.copyrighted)
        XCTAssert(otherHeader.original == header.original)

        XCTAssert(otherHeader.emphasis == header.emphasis)
    }
}
