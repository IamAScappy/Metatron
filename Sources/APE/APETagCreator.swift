//
//  APETagCreator.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 02.11.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import Foundation

public class APETagCreator: TagCreator {

    // MARK: Type Properties

    public static let regular = APETagCreator()

    // MARK: Instance Methods

    public func createTag(fromData data: [UInt8]) -> APETag? {
        return APETag(fromData: data)
    }

    public func createTag(fromStream stream: Stream, range: inout Range<UInt64>) -> APETag? {
        return APETag(fromStream: stream, range: &range)
    }
}
