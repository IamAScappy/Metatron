//
//  ID3v2AttachedPicture.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 12.08.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import Foundation

public class ID3v2AttachedPicture: ID3v2FrameStuff {

    // MARK: Nested Types

    public enum PictureType: UInt8 {
        case other

        case fileIcon
        case otherFileIcon

        case frontCover
        case backCover

        case leafletPage
        case media

        case leadArtist
        case artist
        case conductor
        case band
        case composer
        case lyricist

        case recordingLocation

        case duringRecording
        case duringPerformance

        case movieScreenCapture
        case colouredFish
        case illustration

        case bandLogo
        case publisherLogo
    }

    public enum ImageFormat: Hashable {
        case other(mimeType: String)

        case png
        case jpg

        case link

        // MARK: Initializers

        public init(mimeType: String) {
            switch mimeType.lowercased() {
            case "png", "image/png":
                self = .png

            case "jpg", "jpeg", "image/jpg", "image/jpeg":
                self = .jpg

            case "-->":
                self = .link

            default:
                self = .other(mimeType: mimeType)
            }
        }

        // MARK: Instance Properties

        public var hashValue: Int {
            return self.mimeType.hashValue
        }

        public var mimeType: String {
            switch self {
            case .other(let mimeType):
                return mimeType

            case .png:
                return "image/png"

            case .jpg:
                return "image/jpeg"

            case .link:
                return "-->"
            }
        }
    }

    // MARK: Instance Properties

    public var textEncoding: ID3v2TextEncoding = ID3v2TextEncoding.utf8

    public var description: String = ""

    public var imageFormat: ImageFormat = ImageFormat.other(mimeType: "application/octet-stream")
    public var pictureType: PictureType = PictureType.other

    public var pictureData: [UInt8] = []

    // MARK:

    public var isEmpty: Bool {
        return self.pictureData.isEmpty
    }

    // MARK: Initializers

    public init() {
    }

    public required init(fromData data: [UInt8], version: ID3v2Version) {
        guard data.count > 4 else {
            return
        }

        guard let textEncoding = ID3v2TextEncoding(rawValue: data[0]) else {
            return
        }

        var offset: Int

        let imageFormat: ImageFormat

        switch version {
        case ID3v2Version.v2:
            switch String(bytes: data[1..<4], encoding: String.Encoding.isoLatin1) ?? "" {
            case "PNG":
                imageFormat = ImageFormat.png

            case "JPG":
                imageFormat = ImageFormat.jpg

            case "-->":
                imageFormat = ImageFormat.link

            default:
                return
            }

            offset = 4

        case ID3v2Version.v3, ID3v2Version.v4:
            guard let mimeType = ID3v2TextEncoding.latin1.decode([UInt8](data.suffix(from: 1))) else {
                return
            }

            imageFormat = ImageFormat(mimeType: mimeType.text)

            offset = mimeType.endIndex + 1
        }

        guard offset <= data.count - 3 else {
            return
        }

        guard let pictureType = PictureType(rawValue: data[offset]) else {
            return
        }

        offset += 1

        guard let description = textEncoding.decode([UInt8](data.suffix(from: offset))) else {
            return
        }

        offset += description.endIndex

        guard offset < data.count else {
            return
        }

        self.textEncoding = textEncoding

        self.description = description.text

        self.imageFormat = imageFormat
        self.pictureType = pictureType

        self.pictureData = [UInt8](data.suffix(from: offset))
    }

    // MARK: Instance Methods

    public func toData(version: ID3v2Version) -> [UInt8]? {
        guard !self.isEmpty else {
            return nil
        }

        let textEncoding: ID3v2TextEncoding

        switch version {
        case ID3v2Version.v2, ID3v2Version.v3:
            if self.textEncoding == ID3v2TextEncoding.latin1 {
                textEncoding = ID3v2TextEncoding.latin1
            } else {
                textEncoding = ID3v2TextEncoding.utf16
            }

        case ID3v2Version.v4:
            textEncoding = self.textEncoding
        }

        var data = [textEncoding.rawValue]

        switch version {
        case ID3v2Version.v2:
            switch self.imageFormat {
            case ImageFormat.png:
                data.append(contentsOf: [80, 78, 71])

            case ImageFormat.jpg:
                data.append(contentsOf: [74, 80, 71])

            case ImageFormat.link:
                data.append(contentsOf: [45, 45, 62])

            default:
                return nil
            }

        case ID3v2Version.v3, ID3v2Version.v4:
            data.append(contentsOf: ID3v2TextEncoding.latin1.encode(self.imageFormat.mimeType, termination: true))
        }

        data.append(self.pictureType.rawValue)
        data.append(contentsOf: textEncoding.encode(self.description, termination: true))
        data.append(contentsOf: self.pictureData)

        return data
    }

    public func toData() -> (data: [UInt8], version: ID3v2Version)? {
        guard let data = self.toData(version: ID3v2Version.v4) else {
            return nil
        }

        return (data: data, version: ID3v2Version.v4)
    }
}

public class ID3v2AttachedPictureFormat: ID3v2FrameStuffSubclassFormat {

    // MARK: Type Properties

    public static let regular = ID3v2AttachedPictureFormat()

    // MARK: Instance Methods

    public func createStuffSubclass(fromData data: [UInt8], version: ID3v2Version) -> ID3v2AttachedPicture {
        return ID3v2AttachedPicture(fromData: data, version: version)
    }

    public func createStuffSubclass(fromOther other: ID3v2AttachedPicture) -> ID3v2AttachedPicture {
        let stuff = ID3v2AttachedPicture()

        stuff.textEncoding = other.textEncoding

        stuff.description = other.description

        stuff.imageFormat = other.imageFormat
        stuff.pictureType = other.pictureType

        stuff.pictureData = other.pictureData

        return stuff
    }

    public func createStuffSubclass() -> ID3v2AttachedPicture {
        return ID3v2AttachedPicture()
    }
}

public func == (left: ID3v2AttachedPicture.ImageFormat, right: ID3v2AttachedPicture.ImageFormat) -> Bool {
    return (left.mimeType == right.mimeType)
}

public func != (left: ID3v2AttachedPicture.ImageFormat, right: ID3v2AttachedPicture.ImageFormat) -> Bool {
    return (left.mimeType != right.mimeType)
}
