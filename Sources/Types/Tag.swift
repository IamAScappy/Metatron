//
//  Tag.swift
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

public protocol Tag: class {

    // MARK: Instance Properties

    var identifier: String {get}

    // MARK:

    var title: String {get set}
    var artists: [String] {get set}

    var album: String {get set}
    var genres: [String] {get set}

    var releaseDate: TagDate {get set}

    var trackNumber: TagNumber {get set}
    var discNumber: TagNumber {get set}

    var coverArt: TagImage {get set}

    var copyrights: [String] {get set}
    var comments: [String] {get set}

    var lyrics: TagLyrics {get set}

    // MARK:

    var supportsTitle: Bool {get}
    var supportsArtists: Bool {get}

    var supportsAlbum: Bool {get}
    var supportsGenres: Bool {get}

    var supportsReleaseDate: Bool {get}

    var supportsTrackNumber: Bool {get}
    var supportsDiscNumber: Bool {get}

    var supportsCoverArt: Bool {get}

    var supportsCopyrights: Bool {get}
    var supportsComments: Bool {get}

    var supportsLyrics: Bool {get}

    // MARK:

    var isEmpty: Bool {get}

    // MARK: Instance Methods

    func clear()
}

public extension Tag {

    // MARK: Instance Properties

    public var title: String {
        get {
            return ""
        }

        set {
        }
    }

    public var artists: [String] {
        get {
            return []
        }

        set {
        }
    }

    public var album: String {
        get {
            return ""
        }

        set {
        }
    }

    public var genres: [String] {
        get {
            return []
        }

        set {
        }
    }

    public var releaseDate: TagDate {
        get {
            return TagDate()
        }

        set {
        }
    }

    public var trackNumber: TagNumber {
        get {
            return TagNumber()
        }

        set {
        }
    }

    public var discNumber: TagNumber {
        get {
            return TagNumber()
        }

        set {
        }
    }

    public var coverArt: TagImage {
        get {
            return TagImage()
        }

        set {
        }
    }

    public var copyrights: [String] {
        get {
            return []
        }

        set {
        }
    }

    public var comments: [String] {
        get {
            return []
        }

        set {
        }
    }

    public var lyrics: TagLyrics {
        get {
            return TagLyrics()
        }

        set {
        }
    }

    // MARK:

    public var supportsTitle: Bool {
        return false
    }

    public var supportsArtists: Bool {
        return false
    }

    public var supportsAlbum: Bool {
        return false
    }

    public var supportsGenres: Bool {
        return false
    }

    public var supportsReleaseDate: Bool {
        return false
    }

    public var supportsTrackNumber: Bool {
        return false
    }

    public var supportsDiscNumber: Bool {
        return false
    }

    public var supportsCoverArt: Bool {
        return false
    }

    public var supportsCopyrights: Bool {
        return false
    }

    public var supportsComments: Bool {
        return false
    }

    public var supportsLyrics: Bool {
        return false
    }
}

protocol TagCreator {

    // MARK: Nested Types

    associatedtype TagType: Tag

    // MARK: Instance Methods

    func createTag(fromData: [UInt8]) -> TagType?

    func createTag(fromStream: Stream, range: inout Range<UInt64>) -> TagType?
}
