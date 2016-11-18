//
//  APEHeader.swift
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

class APEHeader {

    // MARK: Nested Types

    enum Position: UInt8 {
        case header = 1
        case footer = 0
    }

    // MARK: Type Properties

    static let dataMarker: [UInt8] = [65, 80, 69, 84, 65, 71, 69, 88]

    static let maxBodyLength: Int = 2147483615
    static let anyDataLength: Int = 32

    // MARK: Instance Properties

    let position: Position

    // MARK:

    var version: APEVersion

    var headerPresent: Bool
    var footerPresent: Bool

    var bodyLength: UInt32
    var itemCount: UInt32

    // MARK:

    var isValid: Bool {
        if self.bodyLength > UInt32(APEHeader.maxBodyLength) {
            return false
        }

        if self.itemCount > self.bodyLength / UInt32(APEItem.minDataLength) {
            return false
        }

        switch self.version {
        case APEVersion.v1:
            if !self.footerPresent {
                return false
            }

        case APEVersion.v2:
            if (!self.headerPresent) && (!self.footerPresent) {
                return false
            }
        }

        return true
    }

    // MARK: Initializers

    init(version: APEVersion = APEVersion.v2) {
        self.version = version

        self.position = Position.footer

        self.headerPresent = false
        self.footerPresent = true

        self.bodyLength = 0
        self.itemCount = 0
    }

    init?(fromData data: [UInt8]) {
        guard data.count >= APEHeader.anyDataLength else {
            return nil
        }

        guard data.starts(with: APEHeader.dataMarker) else {
            return nil
        }

        var version = UInt32(data[8])

        version |= UInt32(data[9]) << 8
        version |= UInt32(data[10]) << 16
        version |= UInt32(data[11]) << 24

        guard version <= 2000 else {
            return nil
        }

        if version == 2000 {
            self.version = APEVersion.v2
        } else {
            self.version = APEVersion.v1
        }

        var dataLength = UInt32(data[12])

        dataLength |= UInt32(data[13]) << 8
        dataLength |= UInt32(data[14]) << 16
        dataLength |= UInt32(data[15]) << 24

        guard dataLength >= UInt32(APEHeader.anyDataLength) else {
            return nil
        }

        self.bodyLength = dataLength - UInt32(APEHeader.anyDataLength)

        self.itemCount = UInt32(data[16])

        self.itemCount |= UInt32(data[17]) << 8
        self.itemCount |= UInt32(data[18]) << 16
        self.itemCount |= UInt32(data[19]) << 24

        switch self.version {
        case APEVersion.v1:
            self.position = Position.footer

            self.headerPresent = false
            self.footerPresent = true

        case APEVersion.v2:
            let flags = data[23]

            self.position = Position(rawValue: (flags >> 5) & 1)!

            self.headerPresent = ((flags & 128) != 0)
            self.footerPresent = ((flags & 64) == 0)
        }
    }

    // MARK: Instance Methods

    func toData() -> (header: [UInt8], footer: [UInt8])? {
        guard self.isValid else {
            return nil
        }

        guard self.bodyLength > 0 else {
            return nil
        }

        var data = APEHeader.dataMarker

        switch self.version {
        case APEVersion.v1:
            data.append(contentsOf: [232, 3, 0, 0])

        case APEVersion.v2:
            data.append(contentsOf: [208, 7, 0, 0])
        }

        let dataLength = self.bodyLength + UInt32(APEHeader.anyDataLength)

        data.append(contentsOf: [UInt8((dataLength) & 255),
                                 UInt8((dataLength >> 8) & 255),
                                 UInt8((dataLength >> 16) & 255),
                                 UInt8((dataLength >> 24) & 255)])

        data.append(contentsOf: [UInt8((self.itemCount) & 255),
                                 UInt8((self.itemCount >> 8) & 255),
                                 UInt8((self.itemCount >> 16) & 255),
                                 UInt8((self.itemCount >> 24) & 255)])

        data.append(contentsOf: Array<UInt8>(repeating: 0, count: 12))

        if (self.version == APEVersion.v1) || (!self.headerPresent) {
            return (header: [], footer: data)
        }

        data[23] |= 128

        let footerData: [UInt8]

        if self.footerPresent {
            footerData = data

            data[23] |= 32
        } else {
            footerData = []

            data[23] |= 64
            data[23] |= 32
        }

        return (header: data, footer: footerData)
    }
}
