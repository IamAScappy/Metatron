//
//  MPEGProperties.swift
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

public class MPEGProperties {

    // MARK: Instance Properties

    public internal(set) var framesRange: Range<UInt64>

    private let header: MPEGHeader

    public let xingHeader: MPEGXingHeader?
    public let vbriHeader: MPEGVBRIHeader?

    public let duration: Double
    public let bitRate: Int

    // MARK:

    public var version: MPEGVersion {
        return self.header.version
    }

    public var layer: MPEGLayer {
        return self.header.layer
    }

    public var sampleRate: Int {
        return self.header.sampleRate
    }

    public var channelMode: MPEGChannelMode {
        return self.header.channelMode
    }

    public var copyrighted: Bool {
        return self.header.copyrighted
    }

    public var original: Bool {
        return self.header.original
    }

    public var emphasis: MPEGEmphasis {
        return self.header.emphasis
    }

    public var bitRateMode: MPEGBitRateMode {
        if let xingHeader = self.xingHeader {
            return xingHeader.bitRateMode
        } else if self.vbriHeader != nil {
            return MPEGBitRateMode.variable
        } else {
            return MPEGBitRateMode.constant
        }
    }

    // MARK: Initializers

    public init?(fromStream stream: Stream, range: Range<UInt64>) {
    	assert(stream.isOpen && stream.isReadable && (stream.length >= range.upperBound), "Invalid stream")

        guard UInt64(range.count) >= UInt64(MPEGHeader.anyDataLength) else {
            return nil
        }

        self.framesRange = range

        var header: MPEGHeader?

        repeat {
        	guard stream.seek(offset: self.framesRange.lowerBound) else {
                return nil
            }

            let data = stream.read(maxLength: MPEGHeader.anyDataLength)

            guard data.count == MPEGHeader.anyDataLength else {
                return nil
            }

            header = MPEGHeader(fromData: data)

            if let header = header {
            	if header.isValid {
                    if UInt64(self.framesRange.count) <= UInt64(header.frameLength) {
                        break
                    }

                    guard stream.seek(offset: self.framesRange.lowerBound + UInt64(header.frameLength)) else {
                        return nil
                    }

                    let nextData = stream.read(maxLength: MPEGHeader.anyDataLength)

                    guard nextData.count == MPEGHeader.anyDataLength else {
                        return nil
                    }

                    if nextData[0] == 255 {
                        if nextData[1] & 254 == data[1] & 254 {
                            if nextData[2] & 12 == data[2] & 12 {
                                break
                            }
                        }
                    }
                }
            }

            self.framesRange = (self.framesRange.lowerBound + 1)..<self.framesRange.upperBound
        }
        while UInt64(self.framesRange.count) >= UInt64(MPEGHeader.anyDataLength)

        guard header != nil else {
            return nil
        }

        self.header = header!

        let headerRange = Range(range.lowerBound..<(range.lowerBound + UInt64(MPEGHeader.anyDataLength)))

        var xingHeaderRange = Range((headerRange.upperBound + UInt64(self.header.sideInfoLength))..<range.upperBound)
        var vbriHeaderRange = Range((headerRange.upperBound + 32)..<range.upperBound)

        let bitRateMode: MPEGBitRateMode

        let bytesCount: UInt32
        let framesCount: UInt32

        if let xingHeader = MPEGXingHeader(fromStream: stream, range: &xingHeaderRange) {
            bitRateMode = xingHeader.bitRateMode

            bytesCount = xingHeader.bytesCount ?? 0
            framesCount = xingHeader.framesCount ?? 0

            self.xingHeader = xingHeader
            self.vbriHeader = nil
        } else if let vbriHeader = MPEGVBRIHeader(fromStream: stream, range: &vbriHeaderRange) {
            bitRateMode = MPEGBitRateMode.variable

            bytesCount = vbriHeader.bytesCount
            framesCount = vbriHeader.framesCount

            self.xingHeader = nil
            self.vbriHeader = vbriHeader
        } else {
            bitRateMode = MPEGBitRateMode.constant

            bytesCount = 0
            framesCount = 0

            self.xingHeader = nil
            self.vbriHeader = nil
        }

        switch bitRateMode {
        case MPEGBitRateMode.variable:
            if (self.header.sampleRate > 0) && (framesCount > 0) {
                let samplesPerFrame = Double(self.header.samplesPerFrame)
                let sampleRate = Double(self.header.sampleRate)

                self.duration = Double(framesCount) * (samplesPerFrame * 1000.0 / sampleRate)

                if bytesCount > 0 {
                    self.bitRate = Int(Double(bytesCount) * 8.0 / self.duration + 0.5)
                } else {
                    self.bitRate = Int(Double(self.framesRange.count) * 8.0 / self.duration + 0.5)
                }
            } else {
                self.duration = 0.0

                self.bitRate = max(self.header.bitRate, 0)
            }

        case MPEGBitRateMode.constant:
            self.bitRate = max(self.header.bitRate, 0)

            if self.bitRate > 0 {
                if bytesCount > 0 {
                    self.duration = Double(bytesCount) * 8.0 / Double(self.bitRate)
                } else {
                    self.duration = Double(self.framesRange.count) * 8.0 / Double(self.bitRate)
                }
            } else {
                self.duration = 0.0
            }
        }
    }
}
