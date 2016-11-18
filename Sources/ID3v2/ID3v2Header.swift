//
//  ID3v2Header.swift
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

class ID3v2Header {

	// MARK: Nested Types

    enum Position {
        case header
        case footer
    }

    // MARK: Type Properties

    static let headerDataMarker: [UInt8] = [73, 68, 51]
    static let footerDataMarker: [UInt8] = [51, 68, 73]

    static let maxBodyLength: Int = 268435455
    static let anyDataLength: Int = 10

	// MARK: Instance Properties

    let position: Position

    // MARK:

    var version: ID3v2Version
    var revision: UInt8

    var unsynchronisation: Bool
    var compression: Bool

    var experimentalIndicator: Bool

    var extHeaderPresent: Bool
    var footerPresent: Bool

    var bodyLength: UInt32

    // MARK:

    var isValid: Bool {
        if self.bodyLength > UInt32(ID3v2Header.maxBodyLength) {
            return false
        }

        if self.revision > 254 {
            return false
        }

        return true
    }

    // MARK: Initializers

    init(version: ID3v2Version = ID3v2Version.v4) {
        self.position = Position.header

        self.version = version
        self.revision = 0

        self.unsynchronisation = false
        self.compression = false

        self.experimentalIndicator = false

        self.extHeaderPresent = false
        self.footerPresent = false

        self.bodyLength = 0
    }

    init?(fromData data: [UInt8]) {
    	guard data.count >= ID3v2Header.anyDataLength else {
            return nil
        }

        if data.starts(with: ID3v2Header.headerDataMarker) {
            self.position = Position.header
        } else if data.starts(with: ID3v2Header.footerDataMarker) {
            self.position = Position.footer
        } else {
        	return nil
        }

        switch data[3] {
        case 2:
        	self.version = ID3v2Version.v2

        	self.unsynchronisation = ((data[5] & 128) != 0)
        	self.compression = ((data[5] & 64) != 0)

        	self.experimentalIndicator = false

	        self.extHeaderPresent = false
	        self.footerPresent = false

        case 3:
        	self.version = ID3v2Version.v3

        	self.unsynchronisation = ((data[5] & 128) != 0)
        	self.compression = false

        	self.experimentalIndicator = ((data[5] & 32) != 0)

	        self.extHeaderPresent = ((data[5] & 64) != 0)
	        self.footerPresent = false

        case 4:
        	self.version = ID3v2Version.v4

        	self.unsynchronisation = ((data[5] & 128) != 0)
        	self.compression = false

        	self.experimentalIndicator = ((data[5] & 32) != 0)

	        self.extHeaderPresent = ((data[5] & 64) != 0)
	        self.footerPresent = ((data[5] & 16) != 0)

        default:
        	return nil
        }

        guard data[4] < 255 else {
        	return nil
        }

        self.revision = data[4]

        for i in 6..<10 {
        	guard data[i] < 128 else {
	        	return nil
	        }
        }

        self.bodyLength = ID3v2Unsynchronisation.uint28FromData([UInt8](data[6..<10]))
    }

    // MARK: Instance Methods

    func toData() -> (header: [UInt8], footer: [UInt8])? {
        guard self.isValid else {
            return nil
        }

        guard self.bodyLength > 0 else {
            return nil
        }

        var data = ID3v2Header.headerDataMarker

        switch self.version {
        case ID3v2Version.v2:
            data.append(contentsOf: [2, self.revision, 0])

            if self.unsynchronisation {
                data[5] |= 128
            }

            if self.compression {
                data[5] |= 64
            }

            data.append(contentsOf: ID3v2Unsynchronisation.dataFromUInt28(self.bodyLength))

            return (header: data, footer: [])

        case ID3v2Version.v3:
            data.append(contentsOf: [3, self.revision, 0])

            if self.unsynchronisation {
                data[5] |= 128
            }

            if self.experimentalIndicator {
                data[5] |= 32
            }

            if self.extHeaderPresent {
                data[5] |= 64
            }

            data.append(contentsOf: ID3v2Unsynchronisation.dataFromUInt28(self.bodyLength))

            return (header: data, footer: [])

        case ID3v2Version.v4:
            data.append(contentsOf: [4, self.revision, 0])

            if self.unsynchronisation {
                data[5] |= 128
            }

            if self.experimentalIndicator {
                data[5] |= 32
            }

            if self.extHeaderPresent {
                data[5] |= 64
            }

            data.append(contentsOf: ID3v2Unsynchronisation.dataFromUInt28(self.bodyLength))

            var footerData: [UInt8] = []

            if self.footerPresent {
                data[5] |= 16

                footerData.append(contentsOf: ID3v2Header.footerDataMarker)
                footerData.append(contentsOf: data.suffix(from: 3))
            }

            return (header: data, footer: footerData)
        }
    }
}
