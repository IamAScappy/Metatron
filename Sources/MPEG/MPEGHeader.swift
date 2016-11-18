//
//  MPEGHeader.swift
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

import Foundation

public class MPEGHeader {

    // MARK: Type Properties

    static let bitRates: [[[Int]]] = [[[32, 64, 96, 128, 160, 192, 224, 256, 288, 320, 352, 384, 416, 448],
                                       [32, 48, 56, 64,  80,  96,  112, 128, 160, 192, 224, 256, 320, 384],
                                       [32, 40, 48, 56,  64,  80,  96,  112, 128, 160, 192, 224, 256, 320]],

                                      [[32, 48, 56, 64, 80, 96, 112, 128, 144, 160, 176, 192, 224, 256],
                                       [8,  16, 24, 32, 40, 48, 56,  64,  80,  96,  112, 128, 144, 160],
                                       [8,  16, 24, 32, 40, 48, 56,  64,  80,  96,  112, 128, 144, 160]]]

    static let sampleRates: [[Int]] = [[44100, 48000, 32000],
                                       [22050, 24000, 16000],
                                       [11025, 12000, 8000]]

    static let samplesPerFrames: [[Int]] = [[384, 1152, 1152],
                                            [384, 1152, 576]]

    static let allowedChannelModes: [[[Bool]]] = [[[true, true, true, true],
                                                   [true, true, true, true],
                                                   [true, true, true, true],
                                                   [true, true, true, true],
                                                   [true, true, true, true],
                                                   [true, true, true, true],
                                                   [true, true, true, true],
                                                   [true, true, true, true],
                                                   [true, true, true, true],
                                                   [true, true, true, true],
                                                   [true, true, true, true],
                                                   [true, true, true, true],
                                                   [true, true, true, true],
                                                   [true, true, true, true],
                                                   [true, true, true, true]],

                                                  [[true, true, true, true],
                                                   [false, false, false, true],
                                                   [false, false, false, true],
                                                   [false, false, false, true],
                                                   [true, true, true, true],
                                                   [false, false, false, true],
                                                   [true, true, true, true],
                                                   [true, true, true, true],
                                                   [true, true, true, true],
                                                   [true, true, true, true],
                                                   [true, true, true, true],
                                                   [true, true, true, false],
                                                   [true, true, true, false],
                                                   [true, true, true, false],
                                                   [true, true, true, false]],

                                                  [[true, true, true, true],
                                                   [true, true, true, true],
                                                   [true, true, true, true],
                                                   [true, true, true, true],
                                                   [true, true, true, true],
                                                   [true, true, true, true],
                                                   [true, true, true, true],
                                                   [true, true, true, true],
                                                   [true, true, true, true],
                                                   [true, true, true, true],
                                                   [true, true, true, true],
                                                   [true, true, true, true],
                                                   [true, true, true, true],
                                                   [true, true, true, true],
                                                   [true, true, true, true]]]

    static let sideInfoLengths: [[Int]] = [[32, 32, 32, 17],
                                          [17, 17, 17, 9]]

    static let slotLengths: [Int] = [4, 1, 1]

    // MARK:

    static let anyDataLength: Int = 4

	// MARK: Instance Properties

    public var version: MPEGVersion
    public var layer: MPEGLayer

    public var crc16: UInt16?

    public var bitRate: Int
    public var sampleRate: Int

    public var padding: Bool
    public var privatized: Bool

    public var channelMode: MPEGChannelMode

    public var copyrighted: Bool
    public var original: Bool

    public var emphasis: MPEGEmphasis

    // MARK:

    public var samplesPerFrame: Int {
        return MPEGHeader.samplesPerFrames[self.version.majorIndex][self.layer.index]
    }

    public var frameLength: Int {
        if (self.bitRate > 0) && (self.sampleRate > 0) {
            if self.padding {
                let slotLength = MPEGHeader.slotLengths[self.layer.index]

                return (self.samplesPerFrame * self.bitRate * 125) / self.sampleRate + slotLength
            } else {
                return (self.samplesPerFrame * self.bitRate * 125) / self.sampleRate
            }
        }

        return 0
    }

    // MARK:

    var sideInfoLength: Int {
        return MPEGHeader.sideInfoLengths[self.version.majorIndex][self.channelMode.index]
    }

    var bitRateIndex: Int {
        let bitRates = MPEGHeader.bitRates[self.version.majorIndex][self.layer.index]

        for i in 0..<bitRates.count {
            if self.bitRate == bitRates[i] {
                return i + 1
            }
        }

        return 15
    }

    var sampleRateIndex: Int {
        let sampleRates = MPEGHeader.sampleRates[self.version.index]

        for i in 0..<sampleRates.count {
            if self.sampleRate == sampleRates[i] {
                return i
            }
        }

        return 3
    }

    // MARK:

    public var isValid: Bool {
        let bitRateIndex = self.bitRateIndex

        if bitRateIndex >= 15 {
            return false
        }

        if self.sampleRateIndex >= 3 {
            return false
        }

        return MPEGHeader.allowedChannelModes[self.layer.index][bitRateIndex][self.channelMode.index]
    }

	// MARK: Initializers

    public init() {
        self.version = MPEGVersion.v1
        self.layer = MPEGLayer.layer3

        self.bitRate = 160
        self.sampleRate = 44100

        self.padding = false
        self.privatized = false

        self.channelMode = MPEGChannelMode.stereo

        self.copyrighted = false
        self.original = false

        self.emphasis = MPEGEmphasis.none
    }

	public init?(fromData data: [UInt8]) {
		guard data.count >= MPEGHeader.anyDataLength else {
    		return nil
    	}

    	guard (data[0] == 255) && ((data[1] & 224) == 224) else {
            return nil
    	}

        switch (data[1] >> 3) & 3 {
        case 0:
            self.version = MPEGVersion.v2x5

        case 2:
            self.version = MPEGVersion.v2

        case 3:
            self.version = MPEGVersion.v1

        default:
            return nil
        }

        switch (data[1] >> 1) & 3 {
        case 1:
            self.layer = MPEGLayer.layer3

        case 2:
            self.layer = MPEGLayer.layer2

        case 3:
            self.layer = MPEGLayer.layer1

        default:
            return nil
        }

        if ((data[1] & 1) == 0) && (data.count >= 6) {
            self.crc16 = (UInt16(data[4]) << 8) | UInt16(data[5])
        }

        let bitRateIndex = Int((data[2] >> 4) & 15)

        if (bitRateIndex > 0) && (bitRateIndex < 15) {
            self.bitRate = MPEGHeader.bitRates[self.version.majorIndex][self.layer.index][bitRateIndex - 1]
        } else {
            self.bitRate = 0
        }

        let sampleRateIndex = Int((data[2] >> 2) & 3)

        if sampleRateIndex < 3 {
            self.sampleRate = MPEGHeader.sampleRates[self.version.index][sampleRateIndex]
        } else {
            self.sampleRate = 0
        }

        self.padding = ((data[2] & 2) != 0)
        self.privatized = ((data[2] & 1) != 0)

        self.channelMode = MPEGChannelMode(rawValue: (data[3] >> 4) & 15)!

        self.copyrighted = ((data[3] & 8) != 0)
        self.original = ((data[3] & 4) != 0)

        self.emphasis = MPEGEmphasis(rawValue: data[3] & 3)!
	}

    // MARK: Instance Methods

    public func toData() -> [UInt8]? {
        guard self.isValid else {
            return nil
        }

        var data: [UInt8]

        switch self.version {
        case MPEGVersion.v1:
            data = [255, 248, 0, 0]

        case MPEGVersion.v2:
            data = [255, 240, 0, 0]

        case MPEGVersion.v2x5:
            data = [255, 224, 0, 0]
        }

        switch self.layer {
        case MPEGLayer.layer1:
            data[1] |= 7

        case MPEGLayer.layer2:
            data[1] |= 5

        case MPEGLayer.layer3:
            data[1] |= 3
        }

        if let crc16 = self.crc16 {
            data[1] &= 254

            data.append(UInt8((crc16 >> 8) & 255))
            data.append(UInt8(crc16 & 255))
        }

        data[2] |= UInt8(self.bitRateIndex & 15) << 4
        data[2] |= UInt8(self.sampleRateIndex & 3) << 2

        if self.padding {
            data[2] |= 2
        }

        if self.privatized {
            data[2] |= 1
        }

        data[3] |= self.channelMode.rawValue << 4

        if self.copyrighted {
            data[3] |= 8
        }

        if self.original {
            data[3] |= 4
        }

        data[3] |= self.emphasis.rawValue

        return data
    }
}
