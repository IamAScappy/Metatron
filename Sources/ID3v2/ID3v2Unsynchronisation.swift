//
//  ID3v2Unsynchronisation.swift
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

class ID3v2Unsynchronisation {

	// MARK: Type Methods

    static func uint14FromData(_ data: [UInt8]) -> UInt16 {
        guard !data.isEmpty else {
            return 0
        }

        if data.count == 1 {
            return UInt16(data[0])
        }

        let byte0 = UInt16(data[0])
        let byte1 = UInt16(data[1])

        if ((byte0 & 128) != 0) || ((byte1 & 128) != 0) {
            return (byte0 << 8) | byte1
        }

        return (byte0 << 7) | byte1
    }

	static func uint28FromData(_ data: [UInt8]) -> UInt32 {
    	guard !data.isEmpty else {
    		return 0
    	}

    	let last = (data.count > 3) ? 3 : (data.count - 1)

    	var value = UInt32(data[last])

    	for i in 0..<last {
    		let byte = UInt32(data[i])

			if (byte & 128) != 0 {
				value = 0

				for j in 0..<last {
    				value |= UInt32(data[j]) << UInt32((last - j) * 8)
    			}

    			return value
			}

            value |= byte << UInt32((last - i) * 7)
    	}

    	return value
	}

    static func uint56FromData(_ data: [UInt8]) -> UInt64 {
        guard !data.isEmpty else {
            return 0
        }

        let last = (data.count > 7) ? 7 : (data.count - 1)

        var value = UInt64(data[last])

        for i in 0..<last {
            let byte = UInt64(data[i])

            if (byte & 128) != 0 {
                value = 0

                for j in 0..<last {
                    value |= UInt64(data[j]) << UInt64((last - j) * 8)
                }

                return value
            }

            value |= byte << UInt64((last - i) * 7)
        }

        return value
    }

    // MARK:

    static func dataFromUInt14(_ value: UInt16) -> [UInt8] {
        assert(value < 16384, "Invalid value: can store only 14 bits")

        return [UInt8((value & 16256) >> 7), UInt8(value & 127)]
    }

	static func dataFromUInt28(_ value: UInt32) -> [UInt8] {
    	assert(value < 268435456, "Invalid value: can store only 28 bits")

    	return [UInt8((value & 266338304) >> 21),
    			UInt8((value & 2080768) >> 14),
    			UInt8((value & 16256) >> 7),
    			UInt8((value & 127))]
	}

    static func dataFromUInt56(_ value: UInt64) -> [UInt8] {
        assert(value < 72057594037927936, "Invalid value: can store only 56 bits")

        return [UInt8((value & 71494644084506624) >> 49),
                UInt8((value & 558551906910208) >> 42),
                UInt8((value & 4363686772736) >> 35),
                UInt8((value & 34091302912) >> 28),

                UInt8((value & 266338304) >> 21),
                UInt8((value & 2080768) >> 14),
                UInt8((value & 16256) >> 7),
                UInt8((value & 127))]
    }

    // MARK:

    static func encode(_ data: [UInt8]) -> [UInt8] {
        var outData: [UInt8] = []

        guard !data.isEmpty else {
            return outData
        }

        outData.reserveCapacity(data.count)

        var offset = 0

        while offset < data.count - 1 {
            outData.append(data[offset])

            if data[offset] == 255 {
                let next = data[offset + 1]

                if (next > 223) || (next == 0) {
                    outData.append(0)
                }
            }

            offset += 1
        }

        outData.append(data[offset])

        if data[offset] == 255 {
            outData.append(0)
        }

        return outData
    }

    static func decode(_ data: [UInt8]) -> [UInt8] {
        var outData: [UInt8] = []

        guard !data.isEmpty else {
            return outData
        }

        outData.reserveCapacity(data.count)

        var offset = 0

        while offset < data.count - 1 {
            outData.append(data[offset])

            if (data[offset] == 255) && (data[offset + 1] == 0) {
                offset += 2
            } else {
                offset += 1
            }
        }

        if offset < data.count {
            outData.append(data[offset])
        }

        return outData
    }
}
