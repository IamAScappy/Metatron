//
//  MPEGMediaSlot.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 07.11.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import Foundation

class MPEGMediaIntroSlot<T: TagCreator> {

    // MARK: Instance Properties

    var range: Range<UInt64>

    var tag: T.TagType?

    // MARK: Initializers

    init() {
        self.range = 0..<0
    }

    init?(creator: T, stream: Stream, range: Range<UInt64>) {
        assert(stream.isOpen && stream.isReadable && (range.count > 0), "Invalid stream or range")

        self.range = range

        repeat {
            guard let tag = creator.createTag(fromStream: stream, range: &self.range) else {
                return nil
            }

            if self.range.upperBound == range.upperBound {
                self.range = range.lowerBound..<self.range.lowerBound
            } else {
                self.tag = tag

                break
            }
        }
        while true
    }
}

class MPEGMediaOutroSlot<T: TagCreator> {

    // MARK: Instance Properties

    var range: Range<UInt64>

    var tag: T.TagType?

    // MARK: Initializers

    init() {
        self.range = 0..<0
    }

    init?(creator: T, stream: Stream, range: Range<UInt64>) {
        assert(stream.isOpen && stream.isReadable && (range.count > 0), "Invalid stream or range")

        self.range = range

        repeat {
            guard let tag = creator.createTag(fromStream: stream, range: &self.range) else {
                return nil
            }

            if self.range.upperBound < range.upperBound {
                self.range = self.range.upperBound..<range.upperBound
            } else {
                self.tag = tag

                break
            }
        }
        while true
    }
}
