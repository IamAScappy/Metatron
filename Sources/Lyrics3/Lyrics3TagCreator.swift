//
//  Lyrics3TagFormat.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 02.11.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import Foundation

public class Lyrics3TagCreator: TagCreator {

    // MARK: Type Properties

    public static let regular = Lyrics3TagCreator()

    // MARK: Instance Methods

    public func createTag(fromData data: [UInt8]) -> Lyrics3Tag? {
        return Lyrics3Tag(fromData: data)
    }

    public func createTag(fromStream stream: Stream, range: inout Range<UInt64>) -> Lyrics3Tag? {
        return Lyrics3Tag(fromStream: stream, range: &range)
    }
}
