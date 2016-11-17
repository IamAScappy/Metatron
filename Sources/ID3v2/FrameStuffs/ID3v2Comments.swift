//
//  ID3v2Comments.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 08.09.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import Foundation

public class ID3v2Comments: ID3v2LocalizedText {
}

public class ID3v2CommentsFormat: ID3v2FrameStuffSubclassFormat {

    // MARK: Type Properties

    public static let regular = ID3v2CommentsFormat()

    // MARK: Instance Methods

    public func createStuffSubclass(fromData data: [UInt8], version: ID3v2Version) -> ID3v2Comments {
        return ID3v2Comments(fromData: data, version: version)
    }

    public func createStuffSubclass(fromOther other: ID3v2Comments) -> ID3v2Comments {
        let stuff = ID3v2Comments()

        stuff.textEncoding = other.textEncoding
        stuff.language = other.language

        stuff.description = other.description
        stuff.content = other.content

        return stuff
    }

    public func createStuffSubclass() -> ID3v2Comments {
        return ID3v2Comments()
    }
}
