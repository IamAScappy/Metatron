//
//  ID3v2TagExtension.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 09.09.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import Foundation

extension ID3v2Tag: Tag {

    // MARK: Instance Properties

    public var identifier: String {
        return "ID3v2Tag"
    }

    // MARK:

    public var title: String {
        get {
            if let frame = self[ID3v2FrameID.tit2]?.mainFrame {
                return frame.stuff(format: ID3v2TextInformationFormat.regular).fields.first ?? ""
            }

            return ""
        }

        set {
            if !newValue.isEmpty {
                let frame = self.resetFrameSet(ID3v2FrameID.tit2).mainFrame

                frame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = [newValue]
            } else {
                self.removeFrameSet(ID3v2FrameID.tit2)
            }
        }
    }

    public var artists: [String] {
        get {
            if let frame = self[ID3v2FrameID.tpe1]?.mainFrame {
                return frame.stuff(format: ID3v2TextInformationFormat.regular).fields.revised
            }

            return []
        }

        set {
            let revised = newValue.revised

            if !revised.isEmpty {
                let frame = self.resetFrameSet(ID3v2FrameID.tpe1).mainFrame

                frame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = revised
            } else {
                self.removeFrameSet(ID3v2FrameID.tpe1)
            }
        }
    }

    public var album: String {
        get {
            if let frame = self[ID3v2FrameID.talb]?.mainFrame {
                return frame.stuff(format: ID3v2TextInformationFormat.regular).fields.first ?? ""
            }

            return ""
        }

        set {
            if !newValue.isEmpty {
                let frame = self.resetFrameSet(ID3v2FrameID.talb).mainFrame

                frame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = [newValue]
            } else {
                self.removeFrameSet(ID3v2FrameID.talb)
            }
        }
    }

    public var genres: [String] {
        get {
            if let frame = self[ID3v2FrameID.tcon]?.mainFrame {
                return frame.stuff(format: ID3v2ContentTypeFormat.regular).fields.revised
            }

            return []
        }

        set {
            let revised = newValue.revised

            if !revised.isEmpty {
                let frame = self.resetFrameSet(ID3v2FrameID.tcon).mainFrame

                frame.imposeStuff(format: ID3v2ContentTypeFormat.regular).fields = revised
            } else {
                self.removeFrameSet(ID3v2FrameID.tcon)
            }
        }
    }

    public var releaseDate: TagDate {
        get {
            if let frame = self[ID3v2FrameID.tdrc]?.mainFrame {
                return frame.stuff(format: ID3v2TextInformationFormat.regular).dateValue.revised
            } else {
                guard let yearFrame = self[ID3v2FrameID.tyer]?.mainFrame else {
                    return TagDate()
                }

                guard let yearField = yearFrame.stuff(format: ID3v2TextInformationFormat.regular).fields.first else {
                    return TagDate()
                }

                guard yearField.characters.count == 4 else {
                    return TagDate()
                }

                guard let year = Int(yearField) else {
                    return TagDate()
                }

                if let dayFrame = self[ID3v2FrameID.tdat]?.mainFrame {
                    guard let dayField = dayFrame.stuff(format: ID3v2TextInformationFormat.regular).fields.first else {
                        return TagDate(year: year).revised
                    }

                    let dayCharacters = [Character](dayField.characters)

                    guard dayCharacters.count == 4 else {
                        return TagDate(year: year).revised
                    }

                    guard let day = Int(String(dayCharacters.prefix(2))) else {
                        return TagDate(year: year).revised
                    }

                    guard let month = Int(String(dayCharacters.suffix(2))) else {
                        return TagDate(year: year).revised
                    }

                    if let timeFrame = self[ID3v2FrameID.time]?.mainFrame {
                        let time = timeFrame.stuff(format: ID3v2TextInformationFormat.regular).timeValue

                        return TagDate(year: year, month: month, day: day, time: time).revised
                    } else {
                        return TagDate(year: year, month: month, day: day).revised
                    }
                } else if let timeFrame = self[ID3v2FrameID.time]?.mainFrame {
                    let time = timeFrame.stuff(format: ID3v2TextInformationFormat.regular).timeValue

                    return TagDate(year: year, month: 1, day: 1, time: time).revised
                } else {
                    return TagDate(year: year).revised
                }
            }
        }

        set {
            let revised = newValue.revised

            if revised.isValid {
                let frame = self.resetFrameSet(ID3v2FrameID.tdrc).mainFrame

                frame.imposeStuff(format: ID3v2TextInformationFormat.regular).dateValue = revised

                if (revised.time.hour > 0) || (revised.time.minute > 0) {
                    let timeFrame = self.resetFrameSet(ID3v2FrameID.time).mainFrame
                    let dayFrame = self.resetFrameSet(ID3v2FrameID.tdat).mainFrame

                    let dayField = String(format: "%02d%02d", revised.day, revised.month)

                    timeFrame.imposeStuff(format: ID3v2TextInformationFormat.regular).timeValue = revised.time
                    dayFrame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = [dayField]
                } else {
                    self.removeFrameSet(ID3v2FrameID.time)

                    if (revised.day > 1) || (revised.month > 1) {
                        let dayFrame = self.resetFrameSet(ID3v2FrameID.tdat).mainFrame

                        let dayField = String(format: "%02d%02d", revised.day, revised.month)

                        dayFrame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = [dayField]
                    } else {
                        self.removeFrameSet(ID3v2FrameID.tdat)
                    }
                }

                let yearFrame = self.resetFrameSet(ID3v2FrameID.tyer).mainFrame

                let yearField = String(format: "%04d", revised.year)

                yearFrame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = [yearField]
            } else {
                self.removeFrameSet(ID3v2FrameID.tdrc)

                self.removeFrameSet(ID3v2FrameID.tyer)
                self.removeFrameSet(ID3v2FrameID.tdat)
                self.removeFrameSet(ID3v2FrameID.time)
            }
        }
    }

    public var trackNumber: TagNumber {
        get {
            if let frame = self[ID3v2FrameID.trck]?.mainFrame {
                return frame.stuff(format: ID3v2TextInformationFormat.regular).numberValue.revised
            }

            return TagNumber()
        }

        set {
            let revised = newValue.revised

            if revised.isValid {
                let frame = self.resetFrameSet(ID3v2FrameID.trck).mainFrame

                frame.imposeStuff(format: ID3v2TextInformationFormat.regular).numberValue = revised
            } else {
                self.removeFrameSet(ID3v2FrameID.trck)
            }
        }
    }

    public var discNumber: TagNumber {
        get {
            if let frame = self[ID3v2FrameID.tpos]?.mainFrame {
                return frame.stuff(format: ID3v2TextInformationFormat.regular).numberValue.revised
            }

            return TagNumber()
        }

        set {
            let revised = newValue.revised

            if revised.isValid {
                let frame = self.resetFrameSet(ID3v2FrameID.tpos).mainFrame

                frame.imposeStuff(format: ID3v2TextInformationFormat.regular).numberValue = revised
            } else {
                self.removeFrameSet(ID3v2FrameID.tpos)
            }
        }
    }

    public var coverArt: TagImage {
        get {
            if let frameSet = self[ID3v2FrameID.apic] {
                for frame in frameSet.frames {
                    let stuff = frame.stuff(format: ID3v2AttachedPictureFormat.regular)

                    if stuff.pictureType == ID3v2AttachedPicture.PictureType.frontCover {
                        return stuff.imageValue
                    }
                }

                for frame in frameSet.frames {
                    let stuff = frame.stuff(format: ID3v2AttachedPictureFormat.regular)

                    if stuff.pictureType == ID3v2AttachedPicture.PictureType.backCover {
                        return stuff.imageValue
                    }
                }

                for frame in frameSet.frames {
                    let stuff = frame.stuff(format: ID3v2AttachedPictureFormat.regular)

                    if stuff.pictureType == ID3v2AttachedPicture.PictureType.other {
                        return stuff.imageValue
                    }
                }

                return frameSet.mainFrame.stuff(format: ID3v2AttachedPictureFormat.regular).imageValue
            }

            return TagImage()
        }

        set {
            if let frameSet = self[ID3v2FrameID.apic] {
                if !newValue.isEmpty {
                    let stuff = frameSet.appendFrame().imposeStuff(format: ID3v2AttachedPictureFormat.regular)

                    stuff.pictureType = ID3v2AttachedPicture.PictureType.frontCover
                    stuff.imageValue = newValue
                }

                for frame in frameSet.frames {
                    let pictureType = frame.stuff(format: ID3v2AttachedPictureFormat.regular).pictureType

                    if pictureType == ID3v2AttachedPicture.PictureType.frontCover {
                        if frameSet.frames.count == 1 {
                            if newValue.isEmpty {
                                self.removeFrameSet(ID3v2FrameID.apic)
                            }
                        } else {
                            frameSet.removeFrame(frame)
                        }
                    }
                }
            } else if !newValue.isEmpty {
                let frame = self.appendFrameSet(ID3v2FrameID.apic).mainFrame

                let stuff = frame.imposeStuff(format: ID3v2AttachedPictureFormat.regular)

                stuff.pictureType = ID3v2AttachedPicture.PictureType.frontCover
                stuff.imageValue = newValue
            }
        }
    }

    public var copyrights: [String] {
        get {
            if let frame = self[ID3v2FrameID.tcop]?.mainFrame {
                return frame.stuff(format: ID3v2TextInformationFormat.regular).fields.revised
            }

            return []
        }

        set {
            let revised = newValue.revised

            if !revised.isEmpty {
                let frame = self.resetFrameSet(ID3v2FrameID.tcop).mainFrame

                frame.imposeStuff(format: ID3v2TextInformationFormat.regular).fields = revised
            } else {
                self.removeFrameSet(ID3v2FrameID.tcop)
            }
        }
    }

    public var comments: [String] {
        get {
            if let frameSet = self[ID3v2FrameID.comm] {
                for frame in frameSet.frames {
                    let stuff = frame.stuff(format: ID3v2CommentsFormat.regular)

                    if (stuff.description.isEmpty) && (stuff.language == ID3v2Language.und) {
                        return stuff.content.isEmpty ? [] : [stuff.content]
                    }
                }

                for frame in frameSet.frames {
                    let stuff = frame.stuff(format: ID3v2CommentsFormat.regular)

                    if stuff.description.isEmpty {
                        return stuff.content.isEmpty ? [] : [stuff.content]
                    }
                }
            }

            return []
        }

        set {
            let joined = newValue.joined(separator: "\n")

            if !joined.isEmpty {
                let frame = self.resetFrameSet(ID3v2FrameID.comm).mainFrame

                frame.imposeStuff(format: ID3v2CommentsFormat.regular).content = joined
            } else {
                self.removeFrameSet(ID3v2FrameID.comm)
            }
        }
    }

    public var lyrics: TagLyrics {
        get {
            if let frameSet = self[ID3v2FrameID.sylt] {
                for frame in frameSet.frames {
                    let stuff = frame.stuff(format: ID3v2SyncedLyricsFormat.regular)

                    if stuff.contentType == ID3v2SyncedLyrics.ContentType.lyrics {
                        if (stuff.description.isEmpty) && (stuff.language == ID3v2Language.und) {
                            return stuff.lyricsValue.revised
                        }
                    }
                }

                for frame in frameSet.frames {
                    let stuff = frame.stuff(format: ID3v2SyncedLyricsFormat.regular)

                    if stuff.contentType == ID3v2SyncedLyrics.ContentType.lyrics {
                        if stuff.description.isEmpty {
                            return stuff.lyricsValue.revised
                        }
                    }
                }
            }

            if let frameSet = self[ID3v2FrameID.uslt] {
                for frame in frameSet.frames {
                    let stuff = frame.stuff(format: ID3v2UnsyncedLyricsFormat.regular)

                    if (stuff.description.isEmpty) && (stuff.language == ID3v2Language.und) {
                        return stuff.lyricsValue.revised
                    }
                }

                for frame in frameSet.frames {
                    let stuff = frame.stuff(format: ID3v2UnsyncedLyricsFormat.regular)

                    if stuff.description.isEmpty {
                        return stuff.lyricsValue.revised
                    }
                }
            }

            return TagLyrics()
        }

        set {
            let revised = newValue.revised

            if (revised.pieces.count == 1) && (revised.pieces[0].timeStamp == 0) {
                if let frameSet = self[ID3v2FrameID.sylt] {
                    for frame in frameSet.frames {
                        let contentType = frame.stuff(format: ID3v2SyncedLyricsFormat.regular).contentType

                        if contentType == ID3v2SyncedLyrics.ContentType.lyrics {
                            if frameSet.frames.count == 1 {
                                self.removeFrameSet(ID3v2FrameID.sylt)
                            } else {
                                frameSet.removeFrame(frame)
                            }
                        }
                    }
                }

                let frame = self.resetFrameSet(ID3v2FrameID.uslt).mainFrame

                frame.imposeStuff(format: ID3v2UnsyncedLyricsFormat.regular).lyricsValue = revised
            } else {
                if let frameSet = self[ID3v2FrameID.sylt] {
                    if !revised.isEmpty {
                        let stuff = frameSet.appendFrame().imposeStuff(format: ID3v2SyncedLyricsFormat.regular)

                        stuff.contentType = ID3v2SyncedLyrics.ContentType.lyrics
                        stuff.lyricsValue = revised
                    }

                    for frame in frameSet.frames {
                        let contentType = frame.stuff(format: ID3v2SyncedLyricsFormat.regular).contentType

                        if contentType == ID3v2SyncedLyrics.ContentType.lyrics {
                            if frameSet.frames.count == 1 {
                                if revised.isEmpty {
                                    self.removeFrameSet(ID3v2FrameID.sylt)
                                }
                            } else {
                                frameSet.removeFrame(frame)
                            }
                        }
                    }
                } else if !revised.isEmpty {
                    let frame = self.appendFrameSet(ID3v2FrameID.sylt).mainFrame

                    let stuff = frame.imposeStuff(format: ID3v2SyncedLyricsFormat.regular)

                    stuff.contentType = ID3v2SyncedLyrics.ContentType.lyrics
                    stuff.lyricsValue = revised
                }

                self.removeFrameSet(ID3v2FrameID.uslt)
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
