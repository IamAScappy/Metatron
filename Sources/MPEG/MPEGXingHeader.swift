//
//  MPEGXingHeader.swift
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

public struct MPEGXingHeader {

	// MARK: Type Properties

    static let dataMarkerCBR: [UInt8] = [73, 110, 102, 111]
	static let dataMarkerVBR: [UInt8] = [88, 105, 110, 103]

	static let minDataLength: Int = 8

	// MARK: Instance Properties

	public var bitRateMode: MPEGBitRateMode

	public var framesCount: UInt32?
	public var bytesCount: UInt32?

    public var tableOfContent: [UInt8]?

    public var quality: UInt32?

    // MARK:

    public var isValid: Bool {
        if let framesCount = self.framesCount {
            if let bytesCount = self.bytesCount {
                if framesCount > bytesCount {
                    return false
                }
            }

            if framesCount == 0 {
                return false
            }
        }

        if let bytesCount = self.bytesCount {
            if bytesCount == 0 {
                return false
            }
        }

        if let tableOfContent = self.tableOfContent {
            if tableOfContent.count != 100 {
                return false
            }
        }

        switch self.bitRateMode {
        case MPEGBitRateMode.variable:
        	return true

        case MPEGBitRateMode.constant:
        	if self.framesCount != nil {
        		return true
        	}

        	if self.bytesCount != nil {
        		return true
        	}

        	if self.tableOfContent != nil {
    			return true
    		}

			if self.tableOfContent != nil {
    			return true
    		}

            return false
        }
    }

	// MARK: Initializers

    public init() {
        self.bitRateMode = MPEGBitRateMode.constant
    }

	public init?(fromData data: [UInt8]) {
		let stream = MemoryStream(data: data)

        guard stream.openForReading() else {
            return nil
        }

        var range = Range<UInt64>(0..<UInt64(data.count))

        self.init(fromStream: stream, range: &range)
    }

    public init?(fromStream stream: Stream, range: inout Range<UInt64>) {
        assert(stream.isOpen && stream.isReadable && (stream.length >= range.upperBound), "Invalid stream")

        guard range.lowerBound < range.upperBound else {
            return nil
        }

        let maxDataLength = UInt64(range.count)

        guard UInt64(MPEGXingHeader.minDataLength) <= maxDataLength else {
            return nil
        }

        guard stream.seek(offset: range.lowerBound) else {
            return nil
        }

        let data = stream.read(maxLength: MPEGXingHeader.minDataLength)

        guard data.count == MPEGXingHeader.minDataLength else {
            return nil
        }

        if data.starts(with: MPEGXingHeader.dataMarkerVBR) {
            self.bitRateMode = MPEGBitRateMode.variable
        } else {
            guard data.starts(with: MPEGXingHeader.dataMarkerCBR) else {
                return nil
            }

            self.bitRateMode = MPEGBitRateMode.constant
        }

        if (data[7] & 1) != 0 {
            guard range.upperBound - stream.offset >= UInt64(4) else {
                return nil
            }

            let nextData = stream.read(maxLength: 4)

            guard nextData.count == 4 else {
                return nil
            }

            var framesCount = UInt32(nextData[3])

            framesCount |= UInt32(nextData[2]) << 8
            framesCount |= UInt32(nextData[1]) << 16
            framesCount |= UInt32(nextData[0]) << 24

            self.framesCount = framesCount
        }

        if (data[7] & 2) != 0 {
            guard range.upperBound - stream.offset >= UInt64(4) else {
                return nil
            }

            let nextData = stream.read(maxLength: 4)

            guard nextData.count == 4 else {
                return nil
            }

            var bytesCount = UInt32(nextData[3])

            bytesCount |= UInt32(nextData[2]) << 8
            bytesCount |= UInt32(nextData[1]) << 16
            bytesCount |= UInt32(nextData[0]) << 24

            self.bytesCount = bytesCount
        }

        if (data[7] & 4) != 0 {
            guard range.upperBound - stream.offset >= UInt64(100) else {
                return nil
            }

            let nextData = stream.read(maxLength: 100)

            guard nextData.count == 100 else {
                return nil
            }

            self.tableOfContent = nextData
        }

        if (data[7] & 8) != 0 {
            guard range.upperBound - stream.offset >= UInt64(4) else {
                return nil
            }

            let nextData = stream.read(maxLength: 4)

            guard nextData.count == 4 else {
                return nil
            }

            var quality = UInt32(nextData[3])

            quality |= UInt32(nextData[2]) << 8
            quality |= UInt32(nextData[1]) << 16
            quality |= UInt32(nextData[0]) << 24

            self.quality = quality
        }

        range = range.lowerBound..<stream.offset
    }

    // MARK: Instance Methods

    public func toData() -> [UInt8]? {
    	guard self.isValid else {
    		return nil
    	}

        var data: [UInt8]

        switch self.bitRateMode {
        case MPEGBitRateMode.variable:
            data = MPEGXingHeader.dataMarkerVBR

        case MPEGBitRateMode.constant:
            data = MPEGXingHeader.dataMarkerCBR
        }

        data.append(contentsOf: [0, 0, 0, 0])

        if let framesCount = self.framesCount {
            data.append(contentsOf: [UInt8((framesCount >> 24) & 255),
                                     UInt8((framesCount >> 16) & 255),
                                     UInt8((framesCount >> 8) & 255),
                                     UInt8((framesCount) & 255)])

            data[7] |= 1
        }

        if let bytesCount = self.bytesCount {
            data.append(contentsOf: [UInt8((bytesCount >> 24) & 255),
                                     UInt8((bytesCount >> 16) & 255),
                                     UInt8((bytesCount >> 8) & 255),
                                     UInt8((bytesCount) & 255)])

            data[7] |= 2
        }

        if let tableOfContent = self.tableOfContent {
            data.append(contentsOf: tableOfContent)

            data[7] |= 4
        }

        if let quality = self.quality {
            data.append(contentsOf: [UInt8((quality >> 24) & 255),
                                     UInt8((quality >> 16) & 255),
                                     UInt8((quality >> 8) & 255),
                                     UInt8((quality) & 255)])

            data[7] |= 8
        }

        return data
	}
}
