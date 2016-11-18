//
//  ID3v1TagExtension.swift
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

extension ID3v1Tag: Tag {

	// MARK: Type Properties

	public var identifier: String {
        return "ID3v1Tag"
    }

    // MARK:

    public var artists: [String] {
        get {
            if !self.artist.isEmpty {
                return [self.artist]
            }

            return []
        }

        set {
            self.artist = newValue.revised.joined(separator: ", ")
        }
    }

    public var genres: [String] {
        get {
            if !self.genre.isEmpty {
                return [self.genre]
            }

            return []
        }

        set {
            self.genre.removeAll()

            for genre in newValue {
                if !genre.isEmpty {
                    self.genre = genre

                    break
                }
            }
        }
    }

    public var comments: [String] {
        get {
            if !self.comment.isEmpty {
                return [self.comment]
            }

            return []
        }

        set {
            self.comment = newValue.joined(separator: "\n")
        }
    }

	// MARK:

	public var supportsTitle: Bool {
        return true
    }

    public var supportsArtists: Bool {
        return true
    }

    public var supportsAlbum: Bool {
        return true
    }

    public var supportsGenres: Bool {
        return true
    }

    public var supportsReleaseDate: Bool {
        return true
    }

    public var supportsTrackNumber: Bool {
        return true
    }

    public var supportsComments: Bool {
        return true
    }
}
