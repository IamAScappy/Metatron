//
//  ID3v1TagExtension.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 09.09.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
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
