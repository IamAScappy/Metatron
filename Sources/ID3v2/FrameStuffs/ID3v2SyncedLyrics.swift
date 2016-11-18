//
//  ID3v2SyncedLyrics.swift
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

public class ID3v2SyncedLyrics: ID3v2FrameStuff {

	// MARK: Nested Types

    public enum ContentType: UInt8 {
	    case other
        case lyrics
        case transcription
        case movement
        case events
        case chord
        case trivia
        case webpageURLs
        case imageURLs
	}

    public struct Syllable: Equatable {

        // MARK: Instance Properties

        public var text: String = ""

        public var timeStamp: UInt32 = 0

        // MARK:

        public var isEmpty: Bool {
            return self.text.isEmpty
        }

        // MARK: Initializers

        init(_ text: String, timeStamp: UInt32) {
            self.text = text

            self.timeStamp = timeStamp
        }

        init() {
        }
    }

    // MARK: Instance Properties

    public var textEncoding: ID3v2TextEncoding = ID3v2TextEncoding.utf8
    public var language: ID3v2Language = ID3v2Language.und

    public var timeStampFormat: ID3v2TimeStampFormat = ID3v2TimeStampFormat.absoluteMilliseconds
    public var contentType: ContentType = ContentType.other

    public var description: String = ""

    public var syllables: [Syllable] = []

    // MARK:

    public var isEmpty: Bool {
        return self.syllables.isEmpty
    }

    // MARK: Initializers

    public init() {
    }

    public required init(fromData data: [UInt8], version: ID3v2Version) {
        guard data.count > 11 else {
            return
        }

        guard let textEncoding = ID3v2TextEncoding(rawValue: data[0]) else {
            return
        }

        guard let language = ID3v2Language(code: [UInt8](data[1..<4])) else {
            return
        }

        guard let timeStampFormat = ID3v2TimeStampFormat(rawValue: data[4]) else {
            return
        }

        guard let contentType = ContentType(rawValue: data[5]) else {
            return
        }

        guard let description = textEncoding.decode([UInt8](data.suffix(from: 6))) else {
            return
        }

        var offset = 6 + description.endIndex

        var syllables: [Syllable] = []

        if textEncoding == ID3v2TextEncoding.utf16 {
            guard offset <= data.count - 8 else {
                return
            }

            let utf16TextEncoding: ID3v2TextEncoding

            if (data[offset] == 255) && (data[offset + 1] == 254) {
                utf16TextEncoding = ID3v2TextEncoding.utf16LE
            } else if (data[offset] == 254) && (data[offset + 1] == 255) {
                utf16TextEncoding = ID3v2TextEncoding.utf16BE
            } else {
                utf16TextEncoding = textEncoding
            }

            repeat {
                guard let text = utf16TextEncoding.decode([UInt8](data.suffix(from: offset))) else {
                    return
                }

                offset += text.endIndex

                guard offset < data.count - 3 else {
                    return
                }

                var timeStamp = UInt32(data[offset + 3])

                timeStamp |= UInt32(data[offset + 2]) << 8
                timeStamp |= UInt32(data[offset + 1]) << 16
                timeStamp |= UInt32(data[offset + 0]) << 24

                syllables.append(Syllable(text.text, timeStamp: timeStamp))

                offset += 4
            }
            while offset < data.count
        } else {
            guard offset <= data.count - 5 else {
                return
            }

            repeat {
                guard let text = textEncoding.decode([UInt8](data.suffix(from: offset))) else {
                    return
                }

                offset += text.endIndex

                guard offset < data.count - 3 else {
                    return
                }

                var timeStamp = UInt32(data[offset + 3])

                timeStamp |= UInt32(data[offset + 2]) << 8
                timeStamp |= UInt32(data[offset + 1]) << 16
                timeStamp |= UInt32(data[offset + 0]) << 24

                syllables.append(Syllable(text.text, timeStamp: timeStamp))

                offset += 4
            }
            while offset < data.count
        }

        self.textEncoding = textEncoding
        self.language = language

        self.timeStampFormat = timeStampFormat
        self.contentType = contentType

        self.description = description.text

        self.syllables = syllables
    }

    // MARK: Instance Methods

    public func toData(version: ID3v2Version) -> [UInt8]? {
        guard !self.isEmpty else {
            return nil
        }

        let textEncoding: ID3v2TextEncoding

        switch version {
        case ID3v2Version.v2, ID3v2Version.v3:
            if self.textEncoding == ID3v2TextEncoding.latin1 {
                textEncoding = ID3v2TextEncoding.latin1
            } else {
                textEncoding = ID3v2TextEncoding.utf16
            }

        case ID3v2Version.v4:
            textEncoding = self.textEncoding
        }

        var data = [textEncoding.rawValue]

        data.append(contentsOf: self.language.code)

        data.append(self.timeStampFormat.rawValue)
        data.append(self.contentType.rawValue)

        data.append(contentsOf: textEncoding.encode(self.description, termination: true))

        var timeStamp: UInt32 = 0

        for syllable in self.syllables {
            if timeStamp < syllable.timeStamp {
                timeStamp = syllable.timeStamp
            }

            data.append(contentsOf: textEncoding.encode(syllable.text, termination: true))

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

public class ID3v2SyncedLyricsFormat: ID3v2FrameStuffSubclassFormat {

    // MARK: Type Properties

    public static let regular = ID3v2SyncedLyricsFormat()

    // MARK: Instance Methods

    public func createStuffSubclass(fromData data: [UInt8], version: ID3v2Version) -> ID3v2SyncedLyrics {
        return ID3v2SyncedLyrics(fromData: data, version: version)
    }

    public func createStuffSubclass(fromOther other: ID3v2SyncedLyrics) -> ID3v2SyncedLyrics {
        let stuff = ID3v2SyncedLyrics()

        stuff.textEncoding = other.textEncoding
        stuff.language = other.language

        stuff.timeStampFormat = other.timeStampFormat
        stuff.contentType = other.contentType

        stuff.description = other.description

        stuff.syllables = other.syllables

        return stuff
    }

    public func createStuffSubclass() -> ID3v2SyncedLyrics {
        return ID3v2SyncedLyrics()
    }
}

public func == (left: ID3v2SyncedLyrics.Syllable, right: ID3v2SyncedLyrics.Syllable) -> Bool {
    if left.text != right.text {
        return false
    }

    if left.timeStamp != right.timeStamp {
        return false
    }

    return true
}

public func != (left: ID3v2SyncedLyrics.Syllable, right: ID3v2SyncedLyrics.Syllable) -> Bool {
    return !(left == right)
}
