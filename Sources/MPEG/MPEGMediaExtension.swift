//
//  MPEGMediaExtension.swift
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

extension MPEGMedia: Media {

    // MARK: Instance Properties

    public var title: String {
    	get {
            if !(self.introID3v2Tag?.title.isEmpty ?? true) {
                return self.introID3v2Tag!.title

            } else if !(self.outroID3v2Tag?.title.isEmpty ?? true) {
                return self.outroID3v2Tag!.title

            } else if !(self.outroAPETag?.title.isEmpty ?? true) {
                return self.outroAPETag!.title

            } else if !(self.outroLyrics3Tag?.title.isEmpty ?? true) {
                return self.outroLyrics3Tag!.title

            } else if !(self.outroID3v1Tag?.title.isEmpty ?? true) {
                return self.outroID3v1Tag!.title

            } else {
                return ""
            }
    	}

    	set {
            if self.introID3v2Tag == nil {
                self.introID3v2Tag = ID3v2Tag()
            }

            if self.outroID3v1Tag == nil {
                self.outroID3v1Tag = ID3v1Tag()
            }

            if let tag = self.introID3v2Tag {
                tag.title = newValue
            }

            if let tag = self.outroID3v2Tag {
                tag.title = newValue
            }

            if let tag = self.outroAPETag {
                tag.title = newValue
            }

            if let tag = self.outroLyrics3Tag {
                tag.title = newValue
            }

            if let tag = self.outroID3v1Tag {
                tag.title = newValue
            }
    	}
    }

    public var artists: [String] {
    	get {
            if !(self.introID3v2Tag?.artists.isEmpty ?? true) {
                return self.introID3v2Tag!.artists

            } else if !(self.outroID3v2Tag?.artists.isEmpty ?? true) {
                return self.outroID3v2Tag!.artists

            } else if !(self.outroAPETag?.artists.isEmpty ?? true) {
                return self.outroAPETag!.artists

            } else if !(self.outroLyrics3Tag?.artists.isEmpty ?? true) {
                return self.outroLyrics3Tag!.artists

            } else if !(self.outroID3v1Tag?.artists.isEmpty ?? true) {
                return self.outroID3v1Tag!.artists

            } else {
                return []
            }
    	}

        set {
            if self.introID3v2Tag == nil {
                self.introID3v2Tag = ID3v2Tag()
            }

            if self.outroID3v1Tag == nil {
                self.outroID3v1Tag = ID3v1Tag()
            }

            if let tag = self.introID3v2Tag {
                tag.artists = newValue
            }

            if let tag = self.outroID3v2Tag {
                tag.artists = newValue
            }

            if let tag = self.outroAPETag {
                tag.artists = newValue
            }

            if let tag = self.outroLyrics3Tag {
                tag.artists = newValue
            }

            if let tag = self.outroID3v1Tag {
                tag.artists = newValue
            }
        }
    }

    public var album: String {
    	get {
            if !(self.introID3v2Tag?.album.isEmpty ?? true) {
                return self.introID3v2Tag!.album

            } else if !(self.outroID3v2Tag?.album.isEmpty ?? true) {
                return self.outroID3v2Tag!.album

            } else if !(self.outroAPETag?.album.isEmpty ?? true) {
                return self.outroAPETag!.album

            } else if !(self.outroLyrics3Tag?.album.isEmpty ?? true) {
                return self.outroLyrics3Tag!.album

            } else if !(self.outroID3v1Tag?.album.isEmpty ?? true) {
                return self.outroID3v1Tag!.album

            } else {
                return ""
            }
    	}

        set {
            if self.introID3v2Tag == nil {
                self.introID3v2Tag = ID3v2Tag()
            }

            if self.outroID3v1Tag == nil {
                self.outroID3v1Tag = ID3v1Tag()
            }

            if let tag = self.introID3v2Tag {
                tag.album = newValue
            }

            if let tag = self.outroID3v2Tag {
                tag.album = newValue
            }

            if let tag = self.outroAPETag {
                tag.album = newValue
            }

            if let tag = self.outroLyrics3Tag {
                tag.album = newValue
            }

            if let tag = self.outroID3v1Tag {
                tag.album = newValue
            }
        }
    }

    public var genres: [String] {
    	get {
            if !(self.introID3v2Tag?.genres.isEmpty ?? true) {
                return self.introID3v2Tag!.genres

            } else if !(self.outroID3v2Tag?.genres.isEmpty ?? true) {
                return self.outroID3v2Tag!.genres

            } else if !(self.outroAPETag?.genres.isEmpty ?? true) {
                return self.outroAPETag!.genres

            } else if !(self.outroID3v1Tag?.genres.isEmpty ?? true) {
                return self.outroID3v1Tag!.genres

            } else {
                return []
            }
    	}

        set {
            if self.introID3v2Tag == nil {
                self.introID3v2Tag = ID3v2Tag()
            }

            if self.outroID3v1Tag == nil {
                self.outroID3v1Tag = ID3v1Tag()
            }

            if let tag = self.introID3v2Tag {
                tag.genres = newValue
            }

            if let tag = self.outroID3v2Tag {
                tag.genres = newValue
            }

            if let tag = self.outroAPETag {
                tag.genres = newValue
            }

            if let tag = self.outroID3v1Tag {
                tag.genres = newValue
            }
        }
    }

    public var releaseDate: TagDate {
    	get {
            if self.introID3v2Tag?.releaseDate.isValid ?? false {
                return self.introID3v2Tag!.releaseDate

            } else if self.outroID3v2Tag?.releaseDate.isValid ?? false {
                return self.outroID3v2Tag!.releaseDate

            } else if self.outroAPETag?.releaseDate.isValid ?? false {
                return self.outroAPETag!.releaseDate

            } else if self.outroID3v1Tag?.releaseDate.isValid ?? false {
                return self.outroID3v1Tag!.releaseDate

            } else {
                return TagDate()
            }
    	}

        set {
            if self.introID3v2Tag == nil {
                self.introID3v2Tag = ID3v2Tag()
            }

            if self.outroID3v1Tag == nil {
                self.outroID3v1Tag = ID3v1Tag()
            }

            if let tag = self.introID3v2Tag {
                tag.releaseDate = newValue
            }

            if let tag = self.outroID3v2Tag {
                tag.releaseDate = newValue
            }

            if let tag = self.outroAPETag {
                tag.releaseDate = newValue
            }

            if let tag = self.outroID3v1Tag {
                tag.releaseDate = newValue
            }
        }
    }

    public var trackNumber: TagNumber {
    	get {
            if self.introID3v2Tag?.trackNumber.isValid ?? false {
                return self.introID3v2Tag!.trackNumber

            } else if self.outroID3v2Tag?.trackNumber.isValid ?? false {
                return self.outroID3v2Tag!.trackNumber

            } else if self.outroAPETag?.trackNumber.isValid ?? false {
                return self.outroAPETag!.trackNumber

            } else if self.outroID3v1Tag?.trackNumber.isValid ?? false {
                return self.outroID3v1Tag!.trackNumber

            } else {
                return TagNumber()
            }
    	}

        set {
            if self.introID3v2Tag == nil {
                self.introID3v2Tag = ID3v2Tag()
            }

            if self.outroID3v1Tag == nil {
                self.outroID3v1Tag = ID3v1Tag()
            }

            if let tag = self.introID3v2Tag {
                tag.trackNumber = newValue
            }

            if let tag = self.outroID3v2Tag {
                tag.trackNumber = newValue
            }

            if let tag = self.outroAPETag {
                tag.trackNumber = newValue
            }

            if let tag = self.outroID3v1Tag {
                tag.trackNumber = newValue
            }
        }
    }

    public var discNumber: TagNumber {
    	get {
            if self.introID3v2Tag?.discNumber.isValid ?? false {
                return self.introID3v2Tag!.discNumber

            } else if self.outroID3v2Tag?.discNumber.isValid ?? false {
                return self.outroID3v2Tag!.discNumber

            } else if self.outroAPETag?.discNumber.isValid ?? false {
                return self.outroAPETag!.discNumber

            } else {
                return TagNumber()
            }
    	}

        set {
            if self.introID3v2Tag == nil {
                self.introID3v2Tag = ID3v2Tag()
            }

            if let tag = self.introID3v2Tag {
                tag.discNumber = newValue
            }

            if let tag = self.outroID3v2Tag {
                tag.discNumber = newValue
            }

            if let tag = self.outroAPETag {
                tag.discNumber = newValue
            }
        }
    }

    public var coverArt: TagImage {
    	get {
            if !(self.introID3v2Tag?.coverArt.isEmpty ?? true) {
                return self.introID3v2Tag!.coverArt

            } else if !(self.outroID3v2Tag?.coverArt.isEmpty ?? true) {
                return self.outroID3v2Tag!.coverArt

            } else if !(self.outroAPETag?.coverArt.isEmpty ?? true) {
                return self.outroAPETag!.coverArt

            } else {
                return TagImage()
            }
    	}

        set {
            if self.introID3v2Tag == nil {
                self.introID3v2Tag = ID3v2Tag()
            }

            if let tag = self.introID3v2Tag {
                tag.coverArt = newValue
            }

            if let tag = self.outroID3v2Tag {
                tag.coverArt = newValue
            }

            if let tag = self.outroAPETag {
                tag.coverArt = newValue
            }
        }
    }

    public var copyrights: [String] {
    	get {
            if !(self.introID3v2Tag?.copyrights.isEmpty ?? true) {
                return self.introID3v2Tag!.copyrights

            } else if !(self.outroID3v2Tag?.copyrights.isEmpty ?? true) {
                return self.outroID3v2Tag!.copyrights

            } else if !(self.outroAPETag?.copyrights.isEmpty ?? true) {
                return self.outroAPETag!.copyrights

            } else {
                return []
            }
    	}

        set {
            if self.introID3v2Tag == nil {
                self.introID3v2Tag = ID3v2Tag()
            }

            if let tag = self.introID3v2Tag {
                tag.copyrights = newValue
            }

            if let tag = self.outroID3v2Tag {
                tag.copyrights = newValue
            }

            if let tag = self.outroAPETag {
                tag.copyrights = newValue
            }
        }
    }

    public var comments: [String] {
    	get {
            if !(self.introID3v2Tag?.comments.isEmpty ?? true) {
                return self.introID3v2Tag!.comments

            } else if !(self.outroID3v2Tag?.comments.isEmpty ?? true) {
                return self.outroID3v2Tag!.comments

            } else if !(self.outroAPETag?.comments.isEmpty ?? true) {
                return self.outroAPETag!.comments

            } else if !(self.outroLyrics3Tag?.comments.isEmpty ?? true) {
                return self.outroLyrics3Tag!.comments

            } else if !(self.outroID3v1Tag?.comments.isEmpty ?? true) {
                return self.outroID3v1Tag!.comments

            } else {
                return []
            }
    	}

        set {
            if self.introID3v2Tag == nil {
                self.introID3v2Tag = ID3v2Tag()
            }

            if self.outroID3v1Tag == nil {
                self.outroID3v1Tag = ID3v1Tag()
            }

            if let tag = self.introID3v2Tag {
                tag.comments = newValue
            }

            if let tag = self.outroID3v2Tag {
                tag.comments = newValue
            }

            if let tag = self.outroAPETag {
                tag.comments = newValue
            }

            if let tag = self.outroLyrics3Tag {
                tag.comments = newValue
            }

            if let tag = self.outroID3v1Tag {
                tag.comments = newValue
            }
        }
    }

    public var lyrics: TagLyrics {
    	get {
            if !(self.introID3v2Tag?.lyrics.isEmpty ?? true) {
                return self.introID3v2Tag!.lyrics

            } else if !(self.outroID3v2Tag?.lyrics.isEmpty ?? true) {
                return self.outroID3v2Tag!.lyrics

            } else if !(self.outroAPETag?.lyrics.isEmpty ?? true) {
                return self.outroAPETag!.lyrics

            } else if !(self.outroLyrics3Tag?.lyrics.isEmpty ?? true) {
                return self.outroLyrics3Tag!.lyrics

            } else {
                return TagLyrics()
            }
        }

        set {
            if self.introID3v2Tag == nil {
                self.introID3v2Tag = ID3v2Tag()
            }

            if let tag = self.introID3v2Tag {
                tag.lyrics = newValue
            }

            if let tag = self.outroID3v2Tag {
                tag.lyrics = newValue
            }

            if let tag = self.outroAPETag {
                tag.lyrics = newValue
            }

            if let tag = self.outroLyrics3Tag {
                tag.lyrics = newValue
            }
        }
    }
}
