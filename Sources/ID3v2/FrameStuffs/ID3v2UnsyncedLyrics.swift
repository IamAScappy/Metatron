//
//  ID3v2UnsyncedLyrics.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 07.09.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import Foundation

public class ID3v2UnsyncedLyrics: ID3v2Comments {
}

public class ID3v2UnsyncedLyricsFormat: ID3v2FrameStuffSubclassFormat {

    // MARK: Type Properties

    public static let regular = ID3v2UnsyncedLyricsFormat()

    // MARK: Instance Methods

    public func createStuffSubclass(fromData data: [UInt8], version: ID3v2Version) -> ID3v2UnsyncedLyrics {
        return ID3v2UnsyncedLyrics(fromData: data, version: version)
    }

    public func createStuffSubclass(fromOther other: ID3v2UnsyncedLyrics) -> ID3v2UnsyncedLyrics {
        let stuff = ID3v2UnsyncedLyrics()

        stuff.textEncoding = other.textEncoding
        stuff.language = other.language

        stuff.description = other.description
        stuff.content = other.content

        return stuff
    }

    public func createStuffSubclass() -> ID3v2UnsyncedLyrics {
        return ID3v2UnsyncedLyrics()
    }
}
