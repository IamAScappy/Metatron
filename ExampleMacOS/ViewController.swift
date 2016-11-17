//
//  ViewController.swift
//  Metatron Example (macOS)
//
//  Created by Almaz Ibragimov on 26.08.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import Cocoa
import Metatron

extension NSImage {

    // MARK: Instance Properties

    var pngRepresentation: Data? {
        guard let tiffData = self.tiffRepresentation else {
            return nil
        }

        return NSBitmapImageRep(data: tiffData)?.representation(using: NSBitmapImageFileType.PNG, properties: [:])
    }

    var jpegRepresentation: Data? {
        guard let tiffData = self.tiffRepresentation else {
            return nil
        }

        return NSBitmapImageRep(data: tiffData)?.representation(using: NSBitmapImageFileType.JPEG, properties: [:])
    }
}

extension NSView {

    // MARK: Instance Methods

    func disableSubviews() {
        self.setSubviewsEnabled(false)
    }

    func enableSubviews() {
        self.setSubviewsEnabled(true)
    }

    func setSubviewsEnabled(_ enabled: Bool) {
        for view in self.subviews {
            if let control = view as? NSControl {
                control.isEnabled = enabled
            }

            view.setSubviewsEnabled(enabled)
            view.display()
        }
    }
}

extension TagNumber {

    // MARK: Initializers

    init(fromString string: String) {
        let components = string.components(separatedBy: "/")

        guard !components.isEmpty else {
            self.init()

            return
        }

        guard let value = Int(components[0]) else {
            self.init()

            return
        }

        if components.count > 1 {
            guard let total = Int(components[1]) else {
                self.init()

                return
            }

            self.init(value, total: total)
        } else {
            self.init(value)
        }
    }
}

extension TagDate {

    // MARK: Initializers

    init(fromString string: String) {
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        if let date = dateFormatter.date(from: string) {
            let year = NSCalendar.current.component(Calendar.Component.year, from: date)
            let month = NSCalendar.current.component(Calendar.Component.month, from: date)
            let day = NSCalendar.current.component(Calendar.Component.day, from: date)

            let hour = NSCalendar.current.component(Calendar.Component.hour, from: date)
            let minute = NSCalendar.current.component(Calendar.Component.minute, from: date)
            let second = NSCalendar.current.component(Calendar.Component.second, from: date)

            self.init(year: year, month: month, day: day, time: TagTime(hour: hour, minute: minute, second: second))
        } else {
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"

            if let date = dateFormatter.date(from: string) {
                let year = NSCalendar.current.component(Calendar.Component.year, from: date)
                let month = NSCalendar.current.component(Calendar.Component.month, from: date)
                let day = NSCalendar.current.component(Calendar.Component.day, from: date)

                let hour = NSCalendar.current.component(Calendar.Component.hour, from: date)
                let minute = NSCalendar.current.component(Calendar.Component.minute, from: date)

                self.init(year: year, month: month, day: day, time: TagTime(hour: hour, minute: minute))
            } else {
                dateFormatter.dateFormat = "yyyy-MM-dd HH"

                if let date = dateFormatter.date(from: string) {
                    let year = NSCalendar.current.component(Calendar.Component.year, from: date)
                    let month = NSCalendar.current.component(Calendar.Component.month, from: date)
                    let day = NSCalendar.current.component(Calendar.Component.day, from: date)

                    let hour = NSCalendar.current.component(Calendar.Component.hour, from: date)

                    self.init(year: year, month: month, day: day, time: TagTime(hour: hour))
                } else {
                    dateFormatter.dateFormat = "yyyy-MM-dd"

                    if let date = dateFormatter.date(from: string) {
                        let year = NSCalendar.current.component(Calendar.Component.year, from: date)
                        let month = NSCalendar.current.component(Calendar.Component.month, from: date)
                        let day = NSCalendar.current.component(Calendar.Component.day, from: date)

                        self.init(year: year, month: month, day: day)
                    } else {
                        dateFormatter.dateFormat = "yyyy-MM"

                        if let date = dateFormatter.date(from: string) {
                            let year = NSCalendar.current.component(Calendar.Component.year, from: date)
                            let month = NSCalendar.current.component(Calendar.Component.month, from: date)

                            self.init(year: year, month: month)
                        } else {
                            dateFormatter.dateFormat = "yyyy"

                            if let date = dateFormatter.date(from: string) {
                                let year = NSCalendar.current.component(Calendar.Component.year, from: date)

                                self.init(year: year)
                            } else {
                                self.init()
                            }
                        }
                    }
                }
            }
        }
    }
}

class ViewController: NSViewController {

    // MARK: Instance Properties

    @IBOutlet weak var filePathField: NSTextField!

    // MARK:

    @IBOutlet weak var durationField: NSTextField!

    @IBOutlet weak var bitRateField: NSTextField!
    @IBOutlet weak var sampleRateField: NSTextField!

    @IBOutlet weak var channelsField: NSTextField!

    // MARK:

    @IBOutlet weak var tagView: NSView!

    @IBOutlet weak var introID3v2TagButton: NSButton!
    @IBOutlet weak var outroID3v2TagButton: NSButton!
    @IBOutlet weak var outroLyrics3TagButton: NSButton!
    @IBOutlet weak var outroAPETagButton: NSButton!
    @IBOutlet weak var outroID3v1TagButton: NSButton!

    @IBOutlet weak var coverArtRemoveButton: NSButton!
    @IBOutlet weak var coverArtSaveAsButton: NSButton!

    @IBOutlet weak var refreshButton: NSButton!
    @IBOutlet weak var saveButton: NSButton!

    // MARK:

    @IBOutlet weak var titleField: NSTextField!
    @IBOutlet weak var artistsField: NSTextField!

    @IBOutlet weak var albumField: NSTextField!
    @IBOutlet weak var genresField: NSTextField!

    @IBOutlet weak var releaseDateField: NSTextField!

    @IBOutlet weak var trackNumberField: NSTextField!
    @IBOutlet weak var discNumberField: NSTextField!

    @IBOutlet weak var coverArtView: NSImageView!

    @IBOutlet weak var copyrightsField: NSTextField!
    @IBOutlet weak var commentsField: NSTextField!

    @IBOutlet weak var lyricsField: NSTextField!

    // MARK:

    var media: MPEGMedia?

    // MARK: Instance Methods

    func clearTagView() {
        self.titleField.stringValue = ""
        self.artistsField.stringValue = ""

        self.albumField.stringValue = ""
        self.genresField.stringValue = ""

        self.releaseDateField.stringValue = ""

        self.trackNumberField.stringValue = ""
        self.discNumberField.stringValue = ""

        self.coverArtView.image = nil

        self.copyrightsField.stringValue = ""
        self.commentsField.stringValue = ""

        self.lyricsField.stringValue = ""
    }

    func applyTag(_ tag: Tag) {
        tag.title = self.titleField.stringValue
        tag.artists = [self.artistsField.stringValue]

        tag.album = self.albumField.stringValue
        tag.genres = [self.genresField.stringValue]

        tag.releaseDate = TagDate(fromString: self.releaseDateField.stringValue)

        tag.trackNumber = TagNumber(fromString: self.trackNumberField.stringValue)
        tag.discNumber = TagNumber(fromString: self.self.discNumberField.stringValue)

        if let jpegData = self.coverArtView.image?.jpegRepresentation {
            tag.coverArt = TagImage(data: [UInt8](jpegData))
        } else {
            tag.coverArt = TagImage()
        }

        tag.copyrights = [self.copyrightsField.stringValue]
        tag.comments = [self.commentsField.stringValue]

        tag.lyrics = TagLyrics(pieces: [TagLyrics.Piece(self.lyricsField.stringValue)])
    }

    func mountTag(_ tag: Tag) {
        self.titleField.stringValue = tag.title
        self.artistsField.stringValue = tag.artists.joined(separator: " & ")

        self.albumField.stringValue = tag.album
        self.genresField.stringValue = tag.genres.joined(separator: "/")

        self.releaseDateField.stringValue = tag.releaseDate.description

        self.trackNumberField.stringValue = tag.trackNumber.description
        self.discNumberField.stringValue = tag.discNumber.description

        self.coverArtView.image = NSImage(data: Data(tag.coverArt.data))

        self.copyrightsField.stringValue = tag.copyrights.joined(separator: "\n")
        self.commentsField.stringValue = tag.comments.joined(separator: "\n")

        self.lyricsField.stringValue = tag.lyrics.description
    }

    func applyCurrentTag() {
        if let media = self.media {
            if self.introID3v2TagButton.state == NSOnState {
                if media.introID3v2Tag == nil {
                    media.introID3v2Tag = ID3v2Tag()
                }

                self.applyTag(media.introID3v2Tag!)
            } else if self.outroID3v2TagButton.state == NSOnState {
                if media.outroID3v2Tag == nil {
                    media.outroID3v2Tag = ID3v2Tag()
                }

                self.applyTag(media.outroID3v2Tag!)
            } else if self.outroLyrics3TagButton.state == NSOnState {
                if media.outroLyrics3Tag == nil {
                    media.outroLyrics3Tag = Lyrics3Tag()
                }

                self.applyTag(media.outroLyrics3Tag!)
            } else if self.outroAPETagButton.state == NSOnState {
                if media.outroAPETag == nil {
                    media.outroAPETag = APETag()
                }

                self.applyTag(media.outroAPETag!)
            } else if self.outroID3v1TagButton.state == NSOnState {
                if media.outroID3v1Tag == nil {
                    media.outroID3v1Tag = ID3v1Tag()
                }

                self.applyTag(media.outroID3v1Tag!)
            }
        }
    }

    func mountCurrentTag() {
        if let media = self.media {
            if self.introID3v2TagButton.state == NSOnState {
                if let tag = media.introID3v2Tag {
                    self.mountTag(tag)
                } else {
                    self.clearTagView()
                }
            } else if self.outroID3v2TagButton.state == NSOnState {
                if let tag = media.outroID3v2Tag {
                    self.mountTag(tag)
                } else {
                    self.clearTagView()
                }
            } else if self.outroLyrics3TagButton.state == NSOnState {
                if let tag = media.outroLyrics3Tag {
                    self.mountTag(tag)
                } else {
                    self.clearTagView()
                }
            } else if self.outroAPETagButton.state == NSOnState {
                if let tag = media.outroAPETag {
                    self.mountTag(tag)
                } else {
                    self.clearTagView()
                }
            } else if self.outroID3v1TagButton.state == NSOnState {
                if let tag = media.outroID3v1Tag {
                    self.mountTag(tag)
                } else {
                    self.clearTagView()
                }
            }
        }
    }

    // MARK:

    @IBAction func browseButtonClick(_ sender: NSButton) {
        let dialog = NSOpenPanel()

        dialog.title = "Choose a .mp3 file"

        dialog.showsResizeIndicator = true
        dialog.showsHiddenFiles = false

        dialog.canChooseDirectories = false
        dialog.canCreateDirectories = true

        dialog.allowsMultipleSelection = false
        dialog.allowedFileTypes = ["mp3"]

        guard dialog.runModal() == NSModalResponseOK else {
            return
        }

        guard let filePath = dialog.url?.path else {
            return
        }

        self.filePathField.stringValue = filePath

        self.refreshButtonClick(sender)
    }

    @IBAction func refreshButtonClick(_ sender: NSButton) {
        do {
            self.media = try MPEGMedia(fromFilePath: self.filePathField.stringValue, readOnly: false)

            self.mountCurrentTag()

            self.tagView.setSubviewsEnabled(true)

            self.coverArtRemoveButton.isEnabled = (self.coverArtView.image != nil)
            self.coverArtSaveAsButton.isEnabled = (self.coverArtView.image != nil)

            self.refreshButton.isEnabled = true
            self.saveButton.isEnabled = true

            let seconds = Int(self.media!.duration / 1000.0 + 0.5)

            self.durationField.stringValue = String(format: "%d:%02d", seconds / 60, seconds % 60)

            self.bitRateField.stringValue = String(self.media!.bitRate)
            self.sampleRateField.stringValue = String(self.media!.sampleRate)

            self.channelsField.stringValue = String(self.media!.channels)
        } catch let error {
            let alert = NSAlert()

            if let mediaError = error as? MediaError {
                alert.messageText = "The operation couldn’t be completed. \(mediaError)"
            } else {
                alert.messageText = "The operation couldn’t be completed. \(error)"
            }

            alert.informativeText = ""
            alert.alertStyle = NSAlertStyle.warning
            alert.addButton(withTitle: "OK")

            alert.runModal()

            self.clearTagView()

            self.tagView.setSubviewsEnabled(false)

            self.coverArtRemoveButton.isEnabled = false
            self.coverArtSaveAsButton.isEnabled = false

            self.refreshButton.isEnabled = false
            self.saveButton.isEnabled = false

            self.filePathField.stringValue = ""
        }
    }

    // MARK:

    @IBAction func introID3v2TagButtonClick(_ sender: NSButton) {
        if self.introID3v2TagButton.state == NSOnState {
            self.introID3v2TagButton.state = NSOffState

            if let media = self.media {
                self.applyCurrentTag()

                self.outroID3v2TagButton.state = NSOffState
                self.outroLyrics3TagButton.state = NSOffState
                self.outroAPETagButton.state = NSOffState
                self.outroID3v1TagButton.state = NSOffState

                if let tag = media.introID3v2Tag {
                    self.mountTag(tag)
                } else {
                    self.clearTagView()
                }
            }

            self.coverArtRemoveButton.isEnabled = (self.coverArtView.image != nil)
            self.coverArtSaveAsButton.isEnabled = (self.coverArtView.image != nil)
        }

        self.introID3v2TagButton.state = NSOnState
    }

    @IBAction func outroID3v2TagButtonClick(_ sender: NSButton) {
        if self.outroID3v2TagButton.state == NSOnState {
            self.outroID3v2TagButton.state = NSOffState

            if let media = self.media {
                self.applyCurrentTag()

                self.introID3v2TagButton.state = NSOffState
                self.outroLyrics3TagButton.state = NSOffState
                self.outroAPETagButton.state = NSOffState
                self.outroID3v1TagButton.state = NSOffState

                if let tag = media.outroID3v2Tag {
                    self.mountTag(tag)
                } else {
                    self.clearTagView()
                }
            }

            self.coverArtRemoveButton.isEnabled = (self.coverArtView.image != nil)
            self.coverArtSaveAsButton.isEnabled = (self.coverArtView.image != nil)
        }

        self.outroID3v2TagButton.state = NSOnState
    }

    @IBAction func outroLyrics3TagButtonClick(_ sender: NSButton) {
        if self.outroLyrics3TagButton.state == NSOnState {
            self.outroLyrics3TagButton.state = NSOffState

            if let media = self.media {
                self.applyCurrentTag()

                self.introID3v2TagButton.state = NSOffState
                self.outroID3v2TagButton.state = NSOffState
                self.outroAPETagButton.state = NSOffState
                self.outroID3v1TagButton.state = NSOffState

                if let tag = media.outroLyrics3Tag {
                    self.mountTag(tag)
                } else {
                    self.clearTagView()
                }
            }

            self.coverArtRemoveButton.isEnabled = (self.coverArtView.image != nil)
            self.coverArtSaveAsButton.isEnabled = (self.coverArtView.image != nil)
        }

        self.outroLyrics3TagButton.state = NSOnState
    }

    @IBAction func outroAPETagButtonClick(_ sender: NSButton) {
        if self.outroAPETagButton.state == NSOnState {
            self.outroAPETagButton.state = NSOffState

            if let media = self.media {
                self.applyCurrentTag()

                self.introID3v2TagButton.state = NSOffState
                self.outroID3v2TagButton.state = NSOffState
                self.outroLyrics3TagButton.state = NSOffState
                self.outroID3v1TagButton.state = NSOffState

                if let tag = media.outroAPETag {
                    self.mountTag(tag)
                } else {
                    self.clearTagView()
                }
            }

            self.coverArtRemoveButton.isEnabled = (self.coverArtView.image != nil)
            self.coverArtSaveAsButton.isEnabled = (self.coverArtView.image != nil)
        }

        self.outroAPETagButton.state = NSOnState
    }

    @IBAction func outroID3v1TagButtonClick(_ sender: NSButton) {
        if self.outroID3v1TagButton.state == NSOnState {
            self.outroID3v1TagButton.state = NSOffState

            if let media = self.media {
                self.applyCurrentTag()

                self.introID3v2TagButton.state = NSOffState
                self.outroID3v2TagButton.state = NSOffState
                self.outroLyrics3TagButton.state = NSOffState
                self.outroAPETagButton.state = NSOffState

                if let tag = media.outroID3v1Tag {
                    self.mountTag(tag)
                } else {
                    self.clearTagView()
                }
            }

            self.coverArtRemoveButton.isEnabled = (self.coverArtView.image != nil)
            self.coverArtSaveAsButton.isEnabled = (self.coverArtView.image != nil)
        }

        self.outroID3v1TagButton.state = NSOnState
    }

    // MARK:

    @IBAction func coverArtBrowseButtonClick(_ sender: NSButton) {
        let dialog = NSOpenPanel()

        dialog.title = "Choose a image file"

        dialog.showsResizeIndicator = true
        dialog.showsHiddenFiles = false

        dialog.canChooseDirectories = false
        dialog.canCreateDirectories = true

        dialog.allowsMultipleSelection = false
        dialog.allowedFileTypes = ["jpg", "png"]

        guard dialog.runModal() == NSModalResponseOK else {
            return
        }

        guard let filePath = dialog.url?.path else {
            return
        }

        self.coverArtView.image = NSImage(contentsOfFile: filePath)

        self.coverArtRemoveButton.isEnabled = (self.coverArtView.image != nil)
        self.coverArtSaveAsButton.isEnabled = (self.coverArtView.image != nil)
    }

    @IBAction func coverArtRemoveButtonClick(_ sender: NSButton) {
        self.coverArtView.image = nil

        self.coverArtRemoveButton.isEnabled = false
        self.coverArtSaveAsButton.isEnabled = false
    }

    @IBAction func coverArtSaveAsButtonClick(_ sender: NSButton) {
        if let image = self.coverArtView.image {
            let dialog = NSSavePanel()

            dialog.title = "Choose a file"

            dialog.showsResizeIndicator = true
            dialog.showsHiddenFiles = false

            dialog.canCreateDirectories = true

            dialog.allowedFileTypes = ["png"]

            guard dialog.runModal() == NSModalResponseOK else {
                return
            }

            guard let fileUrl = dialog.url else {
                return
            }

            try? image.pngRepresentation?.write(to: fileUrl)
        }
    }

    // MARK:

    @IBAction func saveButtonClick(_ sender: NSButton) {
        guard let media = self.media else {
            return
        }

        self.applyCurrentTag()

        guard media.save() else {
            let alert = NSAlert()

            alert.messageText = "The operation couldn’t be completed. \(MediaError.invalidStream)"
            alert.informativeText = ""
            alert.alertStyle = NSAlertStyle.warning
            alert.addButton(withTitle: "OK")

            alert.runModal()

            self.clearTagView()

            self.tagView.setSubviewsEnabled(false)

            self.coverArtRemoveButton.isEnabled = false
            self.coverArtSaveAsButton.isEnabled = false

            self.refreshButton.isEnabled = false
            self.saveButton.isEnabled = false

            self.filePathField.stringValue = ""

            self.media = nil

            return
        }
    }

    @IBAction func closeButtonClick(_ sender: NSButton) {
        self.view.window!.close()
    }

    // MARK:

    override func viewDidLoad() {
        super.viewDidLoad()

        if self.media == nil {
            self.tagView.setSubviewsEnabled(false)

            self.refreshButton.isEnabled = false
            self.saveButton.isEnabled = false
        }
    }

    override func viewDidDisappear() {
        super.viewDidDisappear()
    }
}
