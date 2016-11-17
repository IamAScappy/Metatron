//
//  MPEGVBRIHeader.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 30.10.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import Foundation

public struct MPEGVBRIHeader {

    // MARK: Type Properties

    static let dataMarker: [UInt8] = [86, 66, 82, 73]

    static let minDataLength: Int = 26

    // MARK: Instance Properties

    public var version: UInt16

    public var delay: UInt16
    public var quality: UInt16

    public var bytesCount: UInt32
    public var framesCount: UInt32

    public var scaleFactor: UInt16

    public var bytesPerEntry: UInt16
    public var framesPerEntry: UInt16

    public var tableOfContent: [UInt64]

    // MARK:

    public var isValid: Bool {
        if (self.bytesCount == 0) || (self.framesCount == 0) || (self.bytesCount < self.framesCount) {
            return false
        }

        if (self.bytesPerEntry == 0) || (self.bytesPerEntry > 8) || (self.framesPerEntry == 0) {
            return false
        }

        if self.tableOfContent.isEmpty || (self.tableOfContent.count > Int(UInt16.max)) {
            return false
        }

        return true
    }

    // MARK: Initializers

    public init() {
        self.version = 1

        self.delay = 0
        self.quality = 0

        self.bytesCount = 0
        self.framesCount = 0

        self.scaleFactor = 1

        self.bytesPerEntry = 0
        self.framesPerEntry = 0

        self.tableOfContent = []
    }

    public init?(fromData data: [UInt8]) {
        guard data.count >= MPEGVBRIHeader.minDataLength else {
            return nil
        }

        guard data.starts(with: MPEGVBRIHeader.dataMarker) else {
            return nil
        }

        self.version = UInt16(data[5]) | (UInt16(data[4]) << 8)

        self.delay = UInt16(data[7]) | (UInt16(data[6]) << 8)
        self.quality = UInt16(data[9]) | (UInt16(data[8]) << 8)

        self.bytesCount = UInt32(data[13])

        self.bytesCount |= UInt32(data[12]) << 8
        self.bytesCount |= UInt32(data[11]) << 16
        self.bytesCount |= UInt32(data[10]) << 24

        self.framesCount = UInt32(data[17])

        self.framesCount |= UInt32(data[16]) << 8
        self.framesCount |= UInt32(data[15]) << 16
        self.framesCount |= UInt32(data[14]) << 24

        let entriesCount = Int(UInt16(data[19]) | (UInt16(data[18]) << 8)) + 1

        self.scaleFactor = UInt16(data[21]) | (UInt16(data[20]) << 8)

        self.bytesPerEntry = UInt16(data[23]) | (UInt16(data[22]) << 8)
        self.framesPerEntry = UInt16(data[25]) | (UInt16(data[24]) << 8)

        guard self.bytesPerEntry > 0 else {
            return nil
        }

        guard self.bytesPerEntry <= 8 else {
            return nil
        }

        var offset = MPEGVBRIHeader.minDataLength

        guard offset <= data.count - (Int(self.bytesPerEntry) * entriesCount) else {
            return nil
        }

        self.tableOfContent = []

        let lastIndex = UInt64(self.bytesPerEntry) - 1

        for _ in 0..<entriesCount {
            var entry: UInt64 = 0

            for j: UInt64 in 0...lastIndex {
                entry |= UInt64(data[offset]) << (8 * (lastIndex - j))

                offset += 1
            }

            self.tableOfContent.append(entry)
        }
    }

    public init?(fromStream stream: Stream, range: inout Range<UInt64>) {
        assert(stream.isOpen && stream.isReadable && (stream.length >= range.upperBound), "Invalid stream")

        guard range.lowerBound < range.upperBound else {
            return nil
        }

        let maxDataLength = UInt64(range.count)

        guard UInt64(MPEGVBRIHeader.minDataLength) <= maxDataLength else {
            return nil
        }

        guard stream.seek(offset: range.lowerBound) else {
            return nil
        }

        let data = stream.read(maxLength: MPEGVBRIHeader.minDataLength)

        guard data.count == MPEGVBRIHeader.minDataLength else {
            return nil
        }

        guard data.starts(with: MPEGVBRIHeader.dataMarker) else {
            return nil
        }

        self.version = UInt16(data[5]) | (UInt16(data[4]) << 8)

        self.delay = UInt16(data[7]) | (UInt16(data[6]) << 8)
        self.quality = UInt16(data[9]) | (UInt16(data[8]) << 8)

        self.bytesCount = UInt32(data[13])

        self.bytesCount |= UInt32(data[12]) << 8
        self.bytesCount |= UInt32(data[11]) << 16
        self.bytesCount |= UInt32(data[10]) << 24

        self.framesCount = UInt32(data[17])

        self.framesCount |= UInt32(data[16]) << 8
        self.framesCount |= UInt32(data[15]) << 16
        self.framesCount |= UInt32(data[14]) << 24

        let entriesCount = Int(UInt16(data[19]) | (UInt16(data[18]) << 8)) + 1

        self.scaleFactor = UInt16(data[21]) | (UInt16(data[20]) << 8)

        self.bytesPerEntry = UInt16(data[23]) | (UInt16(data[22]) << 8)
        self.framesPerEntry = UInt16(data[25]) | (UInt16(data[24]) << 8)

        self.tableOfContent = []

        guard (self.bytesPerEntry > 0) && (self.bytesPerEntry <= 8) else {
            return nil
        }

        if entriesCount > 0 {
            let nextDataLength = Int(self.bytesPerEntry) * entriesCount

            guard range.upperBound - stream.offset >= UInt64(nextDataLength) else {
                return nil
            }

            let nextData = stream.read(maxLength: nextDataLength)

            guard nextData.count == nextDataLength else {
                return nil
            }

            let shifts = UInt64(self.bytesPerEntry - 1) * 8

            var offset = 0

            for _ in 0..<entriesCount {
                var entry: UInt64 = 0

                for i: UInt64 in stride(from: shifts, through: 0, by: -8) {
                    entry |= UInt64(nextData[offset]) << i

                    offset += 1
                }

                self.tableOfContent.append(entry)
            }
        }

        range = range.lowerBound..<stream.offset
    }

    // MARK: Instance Methods

    public func toData() -> [UInt8]? {
        guard self.isValid else {
            return nil
        }

        var data: [UInt8] = MPEGVBRIHeader.dataMarker

        data.append(contentsOf: [UInt8((self.version >> 8) & 255),
                                 UInt8((self.version) & 255)])

        data.append(contentsOf: [UInt8((self.delay >> 8) & 255),
                                 UInt8((self.delay) & 255)])

        data.append(contentsOf: [UInt8((self.quality >> 8) & 255),
                                 UInt8((self.quality) & 255)])

        data.append(contentsOf: [UInt8((self.bytesCount >> 24) & 255),
                                 UInt8((self.bytesCount >> 16) & 255),
                                 UInt8((self.bytesCount >> 8) & 255),
                                 UInt8((self.bytesCount) & 255)])

        data.append(contentsOf: [UInt8((self.framesCount >> 24) & 255),
                                 UInt8((self.framesCount >> 16) & 255),
                                 UInt8((self.framesCount >> 8) & 255),
                                 UInt8((self.framesCount) & 255)])

        let entriesCount = UInt16(self.tableOfContent.count - 1)

        data.append(contentsOf: [UInt8((entriesCount >> 8) & 255),
                                 UInt8((entriesCount) & 255)])

        data.append(contentsOf: [UInt8((self.scaleFactor >> 8) & 255),
                                 UInt8((self.scaleFactor) & 255)])

        data.append(contentsOf: [UInt8((self.bytesPerEntry >> 8) & 255),
                                 UInt8((self.bytesPerEntry) & 255)])

        data.append(contentsOf: [UInt8((self.framesPerEntry >> 8) & 255),
                                 UInt8((self.framesPerEntry) & 255)])

        let lastIndex = UInt64(self.bytesPerEntry) - 1

        for i in 0..<self.tableOfContent.count {
            for j: UInt64 in 0...lastIndex {
                data.append(UInt8((self.tableOfContent[i] >> (8 * (lastIndex - j))) & 255))
            }
        }

        return data
    }
}
