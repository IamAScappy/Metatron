//
//  Lyrics3TagExtension.swift
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

extension Lyrics3Tag: Tag {

    // MARK: Instance Properties

    public var identifier: String {
        return "Lyrics3Tag"
    }

    // MARK:

    public var title: String {
    	get {
            if let field = self[Lyrics3FieldID.ett] {
                return field.stuff(format: Lyrics3TextInformationFormat.regular).content.prefix(250)
            }

            return ""
        }

        set {
            if !newValue.isEmpty {
                let field = self.resetField(Lyrics3FieldID.ett)

                field.imposeStuff(format: Lyrics3TextInformationFormat.regular).content = newValue.prefix(250)
            } else {
                self.removeField(Lyrics3FieldID.ett)
            }
        }
    }

    public var artists: [String] {
    	get {
            if let field = self[Lyrics3FieldID.ear] {
                let stuff = field.stuff(format: Lyrics3TextInformationFormat.regular)

                if !stuff.content.isEmpty {
                    return [stuff.content.prefix(250)]
                }
            }

            return []
        }

        set {
            let joined = newValue.revised.joined(separator: ", ")

            if !joined.isEmpty {
                let field = self.resetField(Lyrics3FieldID.ear)

                field.imposeStuff(format: Lyrics3TextInformationFormat.regular).content = joined.prefix(250)
            } else {
                self.removeField(Lyrics3FieldID.ear)
            }
        }
    }

    public var album: String {
    	get {
            if let field = self[Lyrics3FieldID.eal] {
                return field.stuff(format: Lyrics3TextInformationFormat.regular).content.prefix(250)
            }

            return ""
        }

        set {
            if !newValue.isEmpty {
                let field = self.resetField(Lyrics3FieldID.eal)

                field.imposeStuff(format: Lyrics3TextInformationFormat.regular).content = newValue.prefix(250)
            } else {
                self.removeField(Lyrics3FieldID.eal)
            }
        }
    }

    public var comments: [String] {
    	get {
            if let field = self[Lyrics3FieldID.inf] {
                let stuff = field.stuff(format: Lyrics3TextInformationFormat.regular)

                if !stuff.content.isEmpty {
                    return [stuff.content]
                }
            }

            return []
        }

        set {
            let joined = newValue.joined(separator: "\n")

            if !joined.isEmpty {
                let field = self.resetField(Lyrics3FieldID.inf)

                field.imposeStuff(format: Lyrics3TextInformationFormat.regular).content = joined
            } else {
                self.removeField(Lyrics3FieldID.inf)
            }
        }
    }

    public var lyrics: TagLyrics {
    	get {
            if let field = self[Lyrics3FieldID.lyr] {
                return field.stuff(format: Lyrics3TextInformationFormat.regular).lyricsValue.revised
            }

            return TagLyrics()
        }

        set {
            let revised = newValue.revised

            if !revised.isEmpty {
                let field = self.resetField(Lyrics3FieldID.lyr)

                field.imposeStuff(format: Lyrics3TextInformationFormat.regular).lyricsValue = revised
            } else {
                self.removeField(Lyrics3FieldID.lyr)
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
        return true
    }

    public var supportsLyrics: Bool {
        return true
    }
}
