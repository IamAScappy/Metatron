//
//  Lyrics3Indications.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 24.10.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
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
