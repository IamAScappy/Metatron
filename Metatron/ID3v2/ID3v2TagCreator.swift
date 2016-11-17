//
//  ID3v2TagCreator.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 02.11.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import Foundation

public class ID3v2TagCreator: TagCreator {

    // MARK: Type Properties

    public static let regular = ID3v2TagCreator()

    // MARK: Instance Methods

    public func createTag(fromData data: [UInt8]) -> ID3v2Tag? {
        return ID3v2Tag(fromData: data)
    }

    public func createTag(fromStream stream: Stream, range: inout Range<UInt64>) -> ID3v2Tag? {
        return ID3v2Tag(fromStream: stream, range: &range)
    }
}
