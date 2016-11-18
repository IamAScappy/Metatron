//
//  ID3v2SyncedTempoCodes.swift
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

public class ID3v2SyncedTempoCodes: ID3v2FrameStuff {

	// MARK: Nested Types

    public struct Tempo: Equatable {

        // MARK: Instance Properties

        public var bmp: UInt16 = 0

        public var timeStamp: UInt32 = 0

        // MARK: Initializers

        init(_ bmp: UInt16, timeStamp: UInt32) {
            self.bmp = bmp

            self.timeStamp = timeStamp
        }

        init() {
        }
    }

    // MARK: Instance Properties

    public var timeStampFormat: ID3v2TimeStampFormat = ID3v2TimeStampFormat.absoluteMilliseconds

    public var tempos: [Tempo] = []

    // MARK:

    public var isEmpty: Bool {
        return self.tempos.isEmpty
    }

    // MARK: Initializers

    public init() {
    }

    public required init(fromData data: [UInt8], version: ID3v2Version) {
    	guard data.count > 5 else {
            return
        }

    	guard let timeStampFormat = ID3v2TimeStampFormat(rawValue: data[0]) else {
            return
        }

        var offset = 1

        var tempos: [Tempo] = []

        repeat {
            var bmp = UInt16(data[offset])

            if data[offset] == 255 {
                offset += 1

                guard offset <= data.count - 5 else {
                    return
                }

                bmp += UInt16(data[offset])
            }

            var timeStamp = UInt32(data[offset + 4])

            timeStamp |= UInt32(data[offset + 3]) << 8
            timeStamp |= UInt32(data[offset + 2]) << 16
            timeStamp |= UInt32(data[offset + 1]) << 24

            tempos.append(Tempo(bmp, timeStamp: timeStamp))

            offset += 5
        }
        while offset <= data.count - 5

        guard offset == data.count else {
            return
        }

        self.timeStampFormat = timeStampFormat

        self.tempos = tempos
    }

    // MARK: Instance Methods

    public func toData(version: ID3v2Version) -> [UInt8]? {
        guard !self.isEmpty else {
            return nil
        }

        var data = [self.timeStampFormat.rawValue]

        var timeStamp: UInt32 = 0

        for tempo in self.tempos {
            if tempo.bmp >= 255 {
                let extraByte = min(tempo.bmp - 255, 255)

                data.append(contentsOf: [255, UInt8(extraByte)])
            } else {
                data.append(UInt8(tempo.bmp))
            }

            if timeStamp < tempo.timeStamp {
                timeStamp = tempo.timeStamp
            }

            data.append(contentsOf: [UInt8((timeStamp >> 24) & 255),
                                     UInt8((timeStamp >> 16) & 255),
                                     UInt8((timeStamp >> 8) & 255),
                                     UInt8((timeStamp) & 255)])
        }

        return data
    }

    public func toData() -> (data: [UInt8], version: ID3v2Version)? {
        guard let data = self.toData(version: ID3v2Version.v4) else {
            return nil
        }

        return (data: data, version: ID3v2Version.v4)
    }
}

public class ID3v2SyncedTempoCodesFormat: ID3v2FrameStuffSubclassFormat {

    // MARK: Type Properties

    public static let regular = ID3v2SyncedTempoCodesFormat()

    // MARK: Instance Methods

    public func createStuffSubclass(fromData data: [UInt8], version: ID3v2Version) -> ID3v2SyncedTempoCodes {
        return ID3v2SyncedTempoCodes(fromData: data, version: version)
    }

    public func createStuffSubclass(fromOther other: ID3v2SyncedTempoCodes) -> ID3v2SyncedTempoCodes {
        let stuff = ID3v2SyncedTempoCodes()

        stuff.timeStampFormat = other.timeStampFormat

        stuff.tempos = other.tempos

        return stuff
    }

    public func createStuffSubclass() -> ID3v2SyncedTempoCodes {
        return ID3v2SyncedTempoCodes()
    }
}

public func == (left: ID3v2SyncedTempoCodes.Tempo, right: ID3v2SyncedTempoCodes.Tempo) -> Bool {
    if left.bmp != right.bmp {
        return false
    }

    if left.timeStamp != right.timeStamp {
        return false
    }

    return true
}

public func != (left: ID3v2SyncedTempoCodes.Tempo, right: ID3v2SyncedTempoCodes.Tempo) -> Bool {
    return !(left == right)
}
