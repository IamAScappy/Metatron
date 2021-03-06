//
//  ID3v2ExtHeader.swift
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

class ID3v2ExtHeader {

    // MARK: Instance Properties

    private(set) var ownDataLength: UInt32

    var padding: UInt32

    // MARK: Initializers

    init() {
        self.ownDataLength = 0

        self.padding = 0
    }

    init?(fromData data: [UInt8], version: ID3v2Version) {
        switch version {
        case ID3v2Version.v2:
            return nil

        case ID3v2Version.v3:
            guard data.count >= 10 else {
                return nil
            }

            self.ownDataLength = UInt32(data[3])

            self.ownDataLength |= UInt32(data[2]) << 8
            self.ownDataLength |= UInt32(data[1]) << 16
            self.ownDataLength |= UInt32(data[0]) << 24

            guard UInt64(self.ownDataLength) <= UInt64(data.count - 4) else {
                return nil
            }

            self.padding = UInt32(data[9])

            self.padding |= UInt32(data[8]) << 8
            self.padding |= UInt32(data[7]) << 16
            self.padding |= UInt32(data[6]) << 24

            self.ownDataLength += 4

        case ID3v2Version.v4:
            guard data.count >= 6 else {
                return nil
            }

            self.ownDataLength = ID3v2Unsynchronisation.uint28FromData(data)

            guard UInt64(self.ownDataLength) <= UInt64(data.count) else {
                return nil
            }

            self.padding = 0
        }
    }

    // MARK: Instance Methods

    func toData(version: ID3v2Version) -> [UInt8]? {
        switch version {
        case ID3v2Version.v2:
            return nil

        case ID3v2Version.v3:
            self.ownDataLength = 6

            let data = [UInt8((self.ownDataLength >> 24) & 255),
                        UInt8((self.ownDataLength >> 16) & 255),
                        UInt8((self.ownDataLength >> 8) & 255),
                        UInt8((self.ownDataLength) & 255),

                        UInt8(0), UInt8(0),

                        UInt8((self.padding >> 24) & 255),
                        UInt8((self.padding >> 16) & 255),
                        UInt8((self.padding >> 8) & 255),
                        UInt8((self.padding) & 255)]

            self.ownDataLength = 10

            return data

        case ID3v2Version.v4:
            self.ownDataLength = 6

            var data = ID3v2Unsynchronisation.dataFromUInt28(self.ownDataLength)

            data.append(1)
            data.append(0)

            return data
        }
    }
}
