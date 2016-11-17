//
//  APETagExtension.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 09.09.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import Foundation

extension APETag: Tag {

    // MARK: Instance Properties

    public var identifier: String {
        return "APETag"
    }

    // MARK:

    public var title: String {
        get {
            if let item = self["Title"] {
                if let title = item.stringValue {
                    return title
                }
            }

            return ""
        }

        set {
            if !newValue.isEmpty {
                if let item = self.resetItem("Title") {
                    item.stringValue = newValue
                }
            } else {
                self.removeItem("Title")
            }
        }
    }

    public var artists: [String] {
        get {
            if let item = self["Artist"] {
                if let artists = item.stringListValue {
                    return artists.revised
                }
            }

            return []
        }

        set {
            let revised = newValue.revised

            if !revised.isEmpty {
                if let item = self.resetItem("Artist") {
                    item.stringListValue = revised
                }
            } else {
                self.removeItem("Artist")
            }
        }
    }

    public var album: String {
        get {
            if let item = self["Album"] {
                if let album = item.stringValue {
                    return album
                }
            }

            return ""
        }

        set {
            if !newValue.isEmpty {
                if let item = self.resetItem("Album") {
                    item.stringValue = newValue
                }
            } else {
                self.removeItem("Album")
            }
        }
    }

    public var genres: [String] {
        get {
            if let item = self["Genre"] {
                if let genres = item.stringListValue {
                    return genres.revised
                }
            }

            return []
        }

        set {
            let revised = newValue.revised

            if !revised.isEmpty {
                if let item = self.resetItem("Genre") {
                    item.stringListValue = revised
                }
            } else {
                self.removeItem("Genre")
            }
        }
    }

    public var releaseDate: TagDate {
        get {
            if let item = self["Year"] {
                if let releaseDate = item.dateValue {
                    return releaseDate.revised
                }
            }

            return TagDate()
        }

        set {
            let revised = newValue.revised

            if revised.isValid {
                if let item = self.resetItem("Year") {
                    item.dateValue = revised
                }
            } else {
                self.removeItem("Year")
            }
        }
    }

    public var trackNumber: TagNumber {
        get {
            if let item = self["Track"] {
                if let trackNumber = item.numberValue {
                    return trackNumber.revised
                }
            }

            return TagNumber()
        }

        set {
            let revised = newValue.revised

            if revised.isValid {
                if let item = self.resetItem("Track") {
                    item.numberValue = revised
                }
            } else {
                self.removeItem("Track")
            }
        }
    }

    public var discNumber: TagNumber {
        get {
            if let item = self["Disc"] {
                if let discNumber = item.numberValue {
                    return discNumber.revised
                }
            }

            return TagNumber()
        }

        set {
            let revised = newValue.revised

            if revised.isValid {
                if let item = self.resetItem("Disc") {
                    item.numberValue = revised
                }
            } else {
                self.removeItem("Disc")
            }
        }
    }

    public var coverArt: TagImage {
        get {
            if let item = self["Cover Art (Front)"] {
                return item.imageValue ?? TagImage()
            } else if let item = self["Cover Art (Back)"] {
                return item.imageValue ?? TagImage()
            } else {
                for item in self.itemList {
                    let key = item.identifier.lowercased()

                    if key.hasPrefix("cover art") {
                        return item.imageValue ?? TagImage()
                    }
                }
            }

            return TagImage()
        }

        set {
            if !newValue.isEmpty {
                if let item = self.resetItem("Cover Art (Front)") {
                    item.format = APEItem.Format.binary

                    item.imageValue = newValue
                }
            } else {
                self.removeItem("Cover Art (Front)")
            }
        }
    }

    public var copyrights: [String] {
        get {
            if let item = self["Copyright"] {
                if let copyrights = item.stringListValue {
                    return copyrights.revised
                }
            }

            return []
        }

        set {
            let revised = newValue.revised

            if !revised.isEmpty {
                if let item = self.resetItem("Copyright") {
                    item.stringListValue = revised
                }
            } else {
                self.removeItem("Copyright")
            }
        }
    }

    public var comments: [String] {
        get {
            if let item = self["Comment"] {
                if let comments = item.stringListValue {
                    return comments
                }
            }

            return []
        }

        set {
            if (!newValue.isEmpty) && ((newValue.count > 1) || (!newValue[0].isEmpty)) {
                if let item = self.resetItem("Comment") {
                    item.stringListValue = newValue
                }
            } else {
                self.removeItem("Comment")
            }
        }
    }

    public var lyrics: TagLyrics {
        get {
            if let item = self["Lyrics"] {
                if let lyrics = item.lyricsValue {
                    return lyrics.revised
                }
            }

            return TagLyrics()
        }

        set {
            let revised = newValue.revised

            if !revised.isEmpty {
                if let item = self.resetItem("Lyrics") {
                    item.lyricsValue = revised
                }
            } else {
                self.removeItem("Lyrics")
            }
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

    public var supportsDiscNumber: Bool {
        return true
    }

    public var supportsCoverArt: Bool {
        return true
    }

    public var supportsCopyrights: Bool {
        return true
    }

    public var supportsComments: Bool {
        return true
    }

    public var supportsLyrics: Bool {
        return true
    }
}
