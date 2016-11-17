//
//  MPEGMediaExtension.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 13.10.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import Foundation

extension MPEGMedia: Media {

    // MARK: Instance Properties
    
    public var title: String {
    	get {
            if let tag = self.introID3v2Tag {
                return tag.title
                
            } else if let tag = self.outroID3v2Tag {
                return tag.title
                
            } else if let tag = self.outroAPETag {
                return tag.title
                
            } else if let tag = self.outroLyrics3Tag {
                return tag.title
                
            } else if let tag = self.outroID3v1Tag {
                return tag.title
                
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
            if let tag = self.introID3v2Tag {
                return tag.artists
                
            } else if let tag = self.outroID3v2Tag {
                return tag.artists
                
            } else if let tag = self.outroAPETag {
                return tag.artists
                
            } else if let tag = self.outroLyrics3Tag {
                return tag.artists
                
            } else if let tag = self.outroID3v1Tag {
                return tag.artists
                
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
            if let tag = self.introID3v2Tag {
                return tag.album
                
            } else if let tag = self.outroID3v2Tag {
                return tag.album
                
            } else if let tag = self.outroAPETag {
                return tag.album
                
            } else if let tag = self.outroLyrics3Tag {
                return tag.album
                
            } else if let tag = self.outroID3v1Tag {
                return tag.album
                
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
            if let tag = self.introID3v2Tag {
                return tag.genres
                
            } else if let tag = self.outroID3v2Tag {
                return tag.genres
                
            } else if let tag = self.outroAPETag {
                return tag.genres
                
            } else if let tag = self.outroID3v1Tag {
                return tag.genres
                
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
            if let tag = self.introID3v2Tag {
                return tag.releaseDate
                
            } else if let tag = self.outroID3v2Tag {
                return tag.releaseDate
                
            } else if let tag = self.outroAPETag {
                return tag.releaseDate
                
            } else if let tag = self.outroID3v1Tag {
                return tag.releaseDate
                
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
            if let tag = self.introID3v2Tag {
                return tag.trackNumber
                
            } else if let tag = self.outroID3v2Tag {
                return tag.trackNumber
                
            } else if let tag = self.outroAPETag {
                return tag.trackNumber
                
            } else if let tag = self.outroID3v1Tag {
                return tag.trackNumber
                
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
            if let tag = self.introID3v2Tag {
                return tag.discNumber
                
            } else if let tag = self.outroID3v2Tag {
                return tag.discNumber
                
            } else if let tag = self.outroAPETag {
                return tag.discNumber
                
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
            if let tag = self.introID3v2Tag {
                return tag.coverArt
                
            } else if let tag = self.outroID3v2Tag {
                return tag.coverArt
                
            } else if let tag = self.outroAPETag {
                return tag.coverArt
                
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
            if let tag = self.introID3v2Tag {
                return tag.copyrights
                
            } else if let tag = self.outroID3v2Tag {
                return tag.copyrights
                
            } else if let tag = self.outroAPETag {
                return tag.copyrights
                
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
            if let tag = self.introID3v2Tag {
                return tag.comments
                
            } else if let tag = self.outroID3v2Tag {
                return tag.comments
                
            } else if let tag = self.outroAPETag {
                return tag.comments
                
            } else if let tag = self.outroLyrics3Tag {
                return tag.comments
                
            } else if let tag = self.outroID3v1Tag {
                return tag.comments
                
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
            if let tag = self.introID3v2Tag {
                return tag.lyrics
                
            } else if let tag = self.outroID3v2Tag {
                return tag.lyrics
                
            } else if let tag = self.outroAPETag {
                return tag.lyrics
                
            } else if let tag = self.outroLyrics3Tag {
                return tag.lyrics
                
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
