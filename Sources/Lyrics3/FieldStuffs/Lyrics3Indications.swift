//
//  Lyrics3Indications.swift
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

public class Lyrics3Indications: Lyrics3FieldStuff {

    // MARK: Instance Properties

    public var lyricsFieldPresent: Bool = false
    public var lyricsSynchronized: Bool = false

    public var randomSelectable: Bool = true

    // MARK:

    public var isEmpty: Bool {
        if self.lyricsFieldPresent {
            return false
        }

        if self.lyricsSynchronized {
            return false
        }

        if !self.randomSelectable {
            return false
        }

        return true
    }

    // MARK: Initializers

    public init() {
    }

    public required init(fromData data: [UInt8]) {
        guard data.count >= 3 else {
            return
        }

        self.lyricsFieldPresent = (data[0] != 0)
        self.lyricsSynchronized = (data[1] != 0)

        self.randomSelectable = (data[2] == 0)
    }

    // MARK: Instance Methods

    public func toData() -> [UInt8]? {
        guard !self.isEmpty else {
            return nil
        }

        return [self.lyricsFieldPresent ? 1 : 0,
                self.lyricsSynchronized ? 1 : 0,
                self.randomSelectable ? 0 : 1]
    }
}

public class Lyrics3IndicationsFormat: Lyrics3FieldStuffSubclassFormat {

    // MARK: Type Properties

    public static let regular = Lyrics3IndicationsFormat()

    // MARK: Instance Methods

    public func createStuffSubclass(fromData data: [UInt8]) -> Lyrics3Indications {
        return Lyrics3Indications(fromData: data)
    }

    public func createStuffSubclass(fromOther other: Lyrics3Indications) -> Lyrics3Indications {
        let stuff = Lyrics3Indications()

        stuff.lyricsFieldPresent = other.lyricsFieldPresent
        stuff.lyricsSynchronized = other.lyricsSynchronized

        stuff.randomSelectable = other.randomSelectable

        return stuff
    }

    public func createStuffSubclass() -> Lyrics3Indications {
        return Lyrics3Indications()
    }
}
