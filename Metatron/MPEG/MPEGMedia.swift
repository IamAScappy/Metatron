//
//  MPEGMedia.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 13.10.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import Foundation

public class MPEGMedia {

    // MARK: Instance Properties

    private let stream: Stream

    private var introID3v2TagSlot: MPEGMediaIntroSlot<ID3v2TagCreator>
    private var outroID3v2TagSlot: MPEGMediaOutroSlot<ID3v2TagCreator>
    private var outroAPETagSlot: MPEGMediaOutroSlot<APETagCreator>
    private var outroLyrics3TagSlot: MPEGMediaOutroSlot<Lyrics3TagCreator>
    private var outroID3v1TagSlot: MPEGMediaOutroSlot<ID3v1TagCreator>

    private let properties: MPEGProperties

    // MARK:

    public var introID3v2Tag: ID3v2Tag? {
        get {
            return self.introID3v2TagSlot.tag
        }

        set {
            self.introID3v2TagSlot.tag = newValue
        }
    }

    public var outroID3v2Tag: ID3v2Tag? {
        get {
            return self.outroID3v2TagSlot.tag
        }

        set {
            self.outroID3v2TagSlot.tag = newValue
        }
    }

    public var outroAPETag: APETag? {
        get {
            return self.outroAPETagSlot.tag
        }

        set {
            self.outroAPETagSlot.tag = newValue
        }
    }

    public var outroLyrics3Tag: Lyrics3Tag? {
        get {
            return self.outroLyrics3TagSlot.tag
        }

        set {
            self.outroLyrics3TagSlot.tag = newValue
        }
    }

    public var outroID3v1Tag: ID3v1Tag? {
        get {
            return self.outroID3v1TagSlot.tag
        }

        set {
            self.outroID3v1TagSlot.tag = newValue
        }
    }

    // MARK:

    public var version: MPEGVersion {
        return self.properties.version
    }

    public var layer: MPEGLayer {
        return self.properties.layer
    }

    public var duration: Double {
        return self.properties.duration
    }

    public var bitRate: Int {
        return self.properties.bitRate
    }

    public var sampleRate: Int {
        return self.properties.sampleRate
    }

    public var channelMode: MPEGChannelMode {
        return self.properties.channelMode
    }

    public var copyrighted: Bool {
        return self.properties.copyrighted
    }

    public var original: Bool {
        return self.properties.original
    }

    public var emphasis: MPEGEmphasis {
        return self.properties.emphasis
    }

    public var bitRateMode: MPEGBitRateMode {
        return self.properties.bitRateMode
    }

    public var xingHeader: MPEGXingHeader? {
        return self.properties.xingHeader
    }

    public var vbriHeader: MPEGVBRIHeader? {
        return self.properties.vbriHeader
    }

    public var channels: Int {
        switch self.channelMode {
        case MPEGChannelMode.stereo, MPEGChannelMode.jointStereo, MPEGChannelMode.dualChannel:
            return 2

        case MPEGChannelMode.singleChannel:
            return 1
        }
    }

    // MARK:

    public var filePath: String {
        if let stream = self.stream as? FileStream {
            return stream.filePath
        }

        return ""
    }

    public var isReadOnly: Bool {
        return (!self.stream.isWritable)
    }

    // MARK: Initializers

    public init(fromStream stream: Stream) throws {
        guard stream.isOpen && stream.isReadable && (stream.length > 0) else {
            throw MediaError.invalidStream
        }

        var range = Range<UInt64>(0..<stream.length)

        var introID3v2TagSlot: MPEGMediaIntroSlot<ID3v2TagCreator>?
        var outroID3v2TagSlot: MPEGMediaOutroSlot<ID3v2TagCreator>?
        var outroAPETagSlot: MPEGMediaOutroSlot<APETagCreator>?
        var outroLyrics3TagSlot: MPEGMediaOutroSlot<Lyrics3TagCreator>?
        var outroID3v1TagSlot: MPEGMediaOutroSlot<ID3v1TagCreator>?

        if let slot = MPEGMediaIntroSlot(creator: ID3v2TagCreator.regular, stream: stream, range: range) {
            range = slot.range.upperBound..<range.upperBound

            while let excess = MPEGMediaIntroSlot(creator: ID3v2TagCreator.regular, stream: stream, range: range) {
                range = excess.range.upperBound..<range.upperBound
            }

            slot.range = slot.range.lowerBound..<range.lowerBound

            if slot.tag!.fillingLength > 0 {
                slot.tag!.fillingLength = Int(min(UInt64(slot.range.count), UInt64(Int.max)))
            }

            introID3v2TagSlot = slot
        }

        if let slot = MPEGMediaOutroSlot(creator: APETagCreator.regular, stream: stream, range: range) {
            range = range.lowerBound..<slot.range.lowerBound

            outroAPETagSlot = slot
        }

        if let slot = MPEGMediaOutroSlot(creator: Lyrics3TagCreator.regular, stream: stream, range: range) {
            range = range.lowerBound..<slot.range.lowerBound

            outroLyrics3TagSlot = slot

            if outroAPETagSlot == nil {
                if let slot = MPEGMediaOutroSlot(creator: APETagCreator.regular, stream: stream, range: range) {
                    range = range.lowerBound..<slot.range.lowerBound

                    outroAPETagSlot = slot
                }
            }
        }

        if let slot = MPEGMediaOutroSlot(creator: ID3v1TagCreator.regular, stream: stream, range: range) {
            range = range.lowerBound..<slot.range.lowerBound

            outroID3v1TagSlot = slot

            if let slot = MPEGMediaOutroSlot(creator: APETagCreator.regular, stream: stream, range: range) {
                range = range.lowerBound..<slot.range.lowerBound

                outroAPETagSlot = slot
            }

            if let slot = MPEGMediaOutroSlot(creator: Lyrics3TagCreator.regular, stream: stream, range: range) {
                range = range.lowerBound..<slot.range.lowerBound

                outroLyrics3TagSlot = slot

                if outroAPETagSlot == nil {
                    if let slot = MPEGMediaOutroSlot(creator: APETagCreator.regular, stream: stream, range: range) {
                        range = range.lowerBound..<slot.range.lowerBound

                        outroAPETagSlot = slot
                    }
                }
            }
        }

        if let slot = MPEGMediaOutroSlot(creator: ID3v2TagCreator.regular, stream: stream, range: range) {
            range = range.lowerBound..<slot.range.lowerBound

            outroID3v2TagSlot = slot
        }

        guard let properties = MPEGProperties(fromStream: stream, range: range) else {
            throw MediaError.invalidFormat
        }

        self.stream = stream

        self.introID3v2TagSlot = introID3v2TagSlot ?? MPEGMediaIntroSlot()
        self.outroID3v2TagSlot = outroID3v2TagSlot ?? MPEGMediaOutroSlot()
        self.outroAPETagSlot = outroAPETagSlot ?? MPEGMediaOutroSlot()
        self.outroLyrics3TagSlot = outroLyrics3TagSlot ?? MPEGMediaOutroSlot()
        self.outroID3v1TagSlot = outroID3v1TagSlot ?? MPEGMediaOutroSlot()

        self.properties = properties
    }

    public convenience init(fromFilePath filePath: String, readOnly: Bool) throws {
        guard !filePath.isEmpty else {
            throw MediaError.invalidFile
        }

        let stream = FileStream(filePath: filePath)

        if readOnly {
            guard stream.openForReading() else {
                throw MediaError.invalidFile
            }
        } else {
            guard stream.openForUpdating(truncate: false) else {
                throw MediaError.invalidFile
            }
        }

        guard stream.length > 0 else {
            throw MediaError.invalidData
        }

        try self.init(fromStream: stream)
    }

    public convenience init(fromData data: [UInt8], readOnly: Bool) throws {
        guard !data.isEmpty else {
            throw MediaError.invalidData
        }

        let stream = MemoryStream(data: data)

        if readOnly {
            guard stream.openForReading() else {
                throw MediaError.invalidStream
            }
        } else {
            guard stream.openForUpdating(truncate: false) else {
                throw MediaError.invalidStream
            }
        }

        try self.init(fromStream: stream)
    }

    // MARK: Instance Methods

    @discardableResult
    public func save() -> Bool {
        guard self.stream.isOpen && self.stream.isWritable && (self.stream.length > 0) else {
            return false
        }

        guard self.stream.seek(offset: self.introID3v2TagSlot.range.lowerBound) else {
            return false
        }

        if let data = self.introID3v2TagSlot.tag?.toData() {
            let range = self.introID3v2TagSlot.range

            if range.upperBound == 0 {
                guard self.stream.insert(data: data) else {
                    return false
                }

                self.introID3v2TagSlot.range = range.lowerBound..<self.stream.offset

                let framesLowerBound = self.properties.framesRange.lowerBound + UInt64(data.count)
                let framesUpperBound = self.properties.framesRange.upperBound + UInt64(data.count)

                self.properties.framesRange = framesLowerBound..<framesUpperBound
            } else if UInt64(data.count) > UInt64(range.count) {
                let delta = UInt64(data.count) - UInt64(range.count)

                guard self.stream.write(data: [UInt8](data.prefix(Int(range.count)))) == Int(range.count) else {
                    return false
                }

                guard self.stream.insert(data: [UInt8](data.suffix(Int(delta)))) else {
                    return false
                }

                self.introID3v2TagSlot.range = range.lowerBound..<self.stream.offset

                let framesLowerBound = self.properties.framesRange.lowerBound + delta
                let framesUpperBound = self.properties.framesRange.upperBound + delta

                self.properties.framesRange = framesLowerBound..<framesUpperBound
            } else {
                guard self.stream.write(data: data) == data.count else {
                    return false
                }

                if range.upperBound > self.stream.offset {
                    let delta = range.upperBound - self.stream.offset

                    guard self.stream.remove(length: delta) else {
                        return false
                    }

                    self.introID3v2TagSlot.range = range.lowerBound..<self.stream.offset

                    let framesLowerBound = self.properties.framesRange.lowerBound - delta
                    let framesUpperBound = self.properties.framesRange.upperBound - delta

                    self.properties.framesRange = framesLowerBound..<framesUpperBound
                }
            }

            self.introID3v2TagSlot.range = range
        } else {
            let rangeLength = UInt64(self.introID3v2TagSlot.range.count)

            guard self.stream.remove(length: rangeLength) else {
                return false
            }

            self.introID3v2TagSlot.range = 0..<0
            
            let framesLowerBound = self.properties.framesRange.lowerBound - rangeLength
            let framesUpperBound = self.properties.framesRange.upperBound - rangeLength
            
            self.properties.framesRange = framesLowerBound..<framesUpperBound
        }

        guard self.stream.seek(offset: self.properties.framesRange.upperBound) else {
            return false
        }

        var nextLowerBound = self.stream.offset

        if let tag = self.outroID3v2TagSlot.tag {
            tag.version = ID3v2Version.v4

            tag.footerPresent = true
            tag.fillingLength = 0

            if let data = tag.toData() {
                guard self.stream.write(data: data) == data.count else {
                    return false
                }

                self.outroID3v2TagSlot.range = nextLowerBound..<self.stream.offset
            } else {
                self.outroID3v2TagSlot.range = 0..<0
            }
        } else {
            self.outroID3v2TagSlot.range = 0..<0
        }

        nextLowerBound = self.stream.offset

        if let tag = self.outroAPETagSlot.tag {
            tag.version = APEVersion.v2

            tag.footerPresent = true
            tag.fillingLength = 0

            if let data = tag.toData() {
                guard self.stream.write(data: data) == data.count else {
                    return false
                }

                self.outroAPETagSlot.range = nextLowerBound..<self.stream.offset
            } else {
                self.outroAPETagSlot.range = 0..<0
            }
        } else {
            self.outroAPETagSlot.range = 0..<0
        }

        nextLowerBound = self.stream.offset

        if let data = self.outroLyrics3TagSlot.tag?.toData() {
            guard self.stream.write(data: data) == data.count else {
                return false
            }

            self.outroLyrics3TagSlot.range = nextLowerBound..<self.stream.offset
        } else {
            self.outroLyrics3TagSlot.range = 0..<0
        }

        nextLowerBound = self.stream.offset

        if let tag = self.outroID3v1TagSlot.tag {
            let extVersionAvailable: Bool

            if self.outroID3v2TagSlot.range.lowerBound > 0 {
                extVersionAvailable = false
            } else if self.outroAPETagSlot.range.lowerBound > 0 {
                extVersionAvailable = false
            } else if self.outroLyrics3TagSlot.range.lowerBound > 0 {
                extVersionAvailable = false
            } else {
                extVersionAvailable = true
            }

            if !extVersionAvailable {
                switch tag.version {
                case ID3v1Version.vExt0:
                    tag.version = ID3v1Version.v0

                case ID3v1Version.vExt1:
                    tag.version = ID3v1Version.v1

                case ID3v1Version.v0, ID3v1Version.v1:
                    break
                }
            }

            if let data = tag.toData() {
                guard self.stream.write(data: data) == data.count else {
                    return false
                }

                self.outroID3v1TagSlot.range = nextLowerBound..<self.stream.offset
            } else {
                self.outroID3v1TagSlot.range = 0..<0
            }
        } else {
            self.outroID3v1TagSlot.range = 0..<0
        }

        self.stream.truncate(length: self.stream.offset)
        self.stream.synchronize()

        return true
    }
}
