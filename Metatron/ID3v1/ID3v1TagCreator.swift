//
//  ID3v1TagCreator.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 02.11.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import Foundation

public class ID3v1TagCreator: TagCreator {

    // MARK: Type Properties

    public static let regular = ID3v1TagCreator()

    // MARK: Instance Methods

    public func createTag(fromData data: [UInt8]) -> ID3v1Tag? {
        return ID3v1Tag(fromData: data)
    }

    public func createTag(fromStream stream: Stream, range: inout Range<UInt64>) -> ID3v1Tag? {
        return ID3v1Tag(fromStream: stream, range: &range)
    }
}
