//
//  MPEGMediaTest.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 11.11.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import XCTest

@testable import Metatron

class MPEGMediaTest: XCTestCase {

    // MARK: Instance Methods

    func testSave() {
        guard let sampleMediaPath = Bundle(for: type(of: self)).path(forResource: "sample_media", ofType: "mp3") else {
            return XCTFail()
        }

        let newFilePath = FileManager.default.currentDirectoryPath + "/temp_file.test"

        let introID3v2Tag = ID3v2Tag()
        let outroID3v2Tag = ID3v2Tag()
        let outroLyrics3Tag = Lyrics3Tag()
        let outroAPETag = APETag()
        let outroID3v1Tag = ID3v1Tag()

        introID3v2Tag.title = "Title"
        introID3v2Tag.artists = ["Artist"]

        outroID3v2Tag.title = "Title"
        outroID3v2Tag.artists = ["Artist"]

        outroLyrics3Tag.title = "Title"
        outroLyrics3Tag.artists = ["Artist"]

        outroAPETag.title = "Title"
        outroAPETag.artists = ["Artist"]

        outroID3v1Tag.title = "Title"
        outroID3v1Tag.artists = ["Artist"]

        do {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: sampleMediaPath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            do {
                guard let media = try? MPEGMedia(fromFilePath: newFilePath, readOnly: true) else {
                    try? FileManager.default.removeItem(atPath: newFilePath)

                    return XCTFail()
                }

                XCTAssert(media.save() == false)

                media.introID3v2Tag = introID3v2Tag
                media.outroID3v2Tag = outroID3v2Tag
                media.outroLyrics3Tag = outroLyrics3Tag
                media.outroAPETag = outroAPETag
                media.outroID3v1Tag = outroID3v1Tag

                XCTAssert(media.save() == false)
            }

            do {
                guard let other = try? MPEGMedia(fromFilePath: newFilePath, readOnly: true) else {
                    try? FileManager.default.removeItem(atPath: newFilePath)

                    return XCTFail()
                }

                XCTAssert(other.introID3v2Tag == nil)
                XCTAssert(other.outroID3v2Tag == nil)
                XCTAssert(other.outroLyrics3Tag == nil)
                XCTAssert(other.outroAPETag == nil)
                XCTAssert(other.outroID3v1Tag == nil)
            }
        }

        do {
            try? FileManager.default.removeItem(atPath: newFilePath)

            guard (try? FileManager.default.copyItem(atPath: sampleMediaPath, toPath: newFilePath)) != nil else {
                return XCTFail()
            }

            do {
                guard let media = try? MPEGMedia(fromFilePath: newFilePath, readOnly: false) else {
                    try? FileManager.default.removeItem(atPath: newFilePath)

                    return XCTFail()
                }

                XCTAssert(media.save() == true)

                media.introID3v2Tag = introID3v2Tag
                media.outroID3v2Tag = outroID3v2Tag
                media.outroLyrics3Tag = outroLyrics3Tag
                media.outroAPETag = outroAPETag
                media.outroID3v1Tag = outroID3v1Tag

                XCTAssert(media.save() == true)
            }

            do {
                guard let other = try? MPEGMedia(fromFilePath: newFilePath, readOnly: true) else {
                    try? FileManager.default.removeItem(atPath: newFilePath)

                    return XCTFail()
                }

                guard let introID3v2Tag = other.introID3v2Tag else {
                    try? FileManager.default.removeItem(atPath: newFilePath)

                    return XCTFail()
                }

                XCTAssert(introID3v2Tag.title == "Title")
                XCTAssert(introID3v2Tag.artists == ["Artist"])

                guard let outroID3v2Tag = other.outroID3v2Tag else {
                    try? FileManager.default.removeItem(atPath: newFilePath)

                    return XCTFail()
                }

                XCTAssert(outroID3v2Tag.title == "Title")
                XCTAssert(outroID3v2Tag.artists == ["Artist"])

                guard let outroLyrics3Tag = other.outroLyrics3Tag else {
                    try? FileManager.default.removeItem(atPath: newFilePath)

                    return XCTFail()
                }

                XCTAssert(outroLyrics3Tag.title == "Title")
                XCTAssert(outroLyrics3Tag.artists == ["Artist"])

                guard let outroAPETag = other.outroAPETag else {
                    try? FileManager.default.removeItem(atPath: newFilePath)

                    return XCTFail()
                }

                XCTAssert(outroAPETag.title == "Title")
                XCTAssert(outroAPETag.artists == ["Artist"])

                guard let outroID3v1Tag = other.outroID3v1Tag else {
                    try? FileManager.default.removeItem(atPath: newFilePath)

                    return XCTFail()
                }

                XCTAssert(outroID3v1Tag.title == "Title")
                XCTAssert(outroID3v1Tag.artists == ["Artist"])
            }
        }

        try? FileManager.default.removeItem(atPath: newFilePath)
    }

    // MARK:

    func testXingHeaderCBRFile() {
        guard let filePath = Bundle(for: type(of: self)).path(forResource: "xing_header_cbr", ofType: "mp3") else {
            return XCTFail()
        }

        guard let media = try? MPEGMedia(fromFilePath: filePath, readOnly: true) else {
            return XCTFail()
        }

        XCTAssert(media.version == MPEGVersion.v1)
        XCTAssert(media.layer == MPEGLayer.layer3)

        XCTAssert(Int(media.duration + 0.5) == 1887190)

        XCTAssert(media.bitRate == 64)
        XCTAssert(media.sampleRate == 44100)

        XCTAssert(media.channelMode == MPEGChannelMode.singleChannel)

        XCTAssert(media.copyrighted == false)
        XCTAssert(media.original == true)

        XCTAssert(media.emphasis == MPEGEmphasis.none)

        XCTAssert(media.bitRateMode == MPEGBitRateMode.constant)

        XCTAssert(media.xingHeader != nil)
        XCTAssert(media.vbriHeader == nil)
        
        XCTAssert(media.channels == 1)

        XCTAssert(media.introID3v2Tag != nil)
        XCTAssert(media.outroID3v2Tag == nil)
        XCTAssert(media.outroLyrics3Tag == nil)
        XCTAssert(media.outroAPETag == nil)
        XCTAssert(media.outroID3v1Tag == nil)
    }

    func testXingHeaderVBRFile() {
        guard let filePath = Bundle(for: type(of: self)).path(forResource: "xing_header_vbr", ofType: "mp3") else {
            return XCTFail()
        }

        guard let media = try? MPEGMedia(fromFilePath: filePath, readOnly: true) else {
            return XCTFail()
        }

        XCTAssert(media.version == MPEGVersion.v1)
        XCTAssert(media.layer == MPEGLayer.layer3)

        XCTAssert(Int(media.duration + 0.5) == 1887164)

        XCTAssert(media.bitRate == 70)
        XCTAssert(media.sampleRate == 44100)

        XCTAssert(media.channelMode == MPEGChannelMode.singleChannel)

        XCTAssert(media.copyrighted == false)
        XCTAssert(media.original == true)

        XCTAssert(media.emphasis == MPEGEmphasis.none)

        XCTAssert(media.bitRateMode == MPEGBitRateMode.variable)

        XCTAssert(media.xingHeader != nil)
        XCTAssert(media.vbriHeader == nil)

        XCTAssert(media.channels == 1)
        
        XCTAssert(media.introID3v2Tag != nil)
        XCTAssert(media.outroID3v2Tag == nil)
        XCTAssert(media.outroLyrics3Tag == nil)
        XCTAssert(media.outroAPETag == nil)
        XCTAssert(media.outroID3v1Tag == nil)
    }

    func testXingHeaderV2File() {
        guard let filePath = Bundle(for: type(of: self)).path(forResource: "xing_header_v2", ofType: "mp3") else {
            return XCTFail()
        }

        guard let media = try? MPEGMedia(fromFilePath: filePath, readOnly: true) else {
            return XCTFail()
        }

        XCTAssert(media.version == MPEGVersion.v2)
        XCTAssert(media.layer == MPEGLayer.layer3)

        XCTAssert(Int(media.duration + 0.5) == 5387285)

        XCTAssert(media.bitRate == 25)
        XCTAssert(media.sampleRate == 22050)

        XCTAssert(media.channelMode == MPEGChannelMode.singleChannel)

        XCTAssert(media.copyrighted == false)
        XCTAssert(media.original == true)

        XCTAssert(media.emphasis == MPEGEmphasis.none)

        XCTAssert(media.bitRateMode == MPEGBitRateMode.variable)

        XCTAssert(media.xingHeader != nil)
        XCTAssert(media.vbriHeader == nil)
        
        XCTAssert(media.channels == 1)

        XCTAssert(media.introID3v2Tag == nil)
        XCTAssert(media.outroID3v2Tag == nil)
        XCTAssert(media.outroLyrics3Tag == nil)
        XCTAssert(media.outroAPETag == nil)
        XCTAssert(media.outroID3v1Tag == nil)
    }

    func testVBRIHeaderFile() {
        guard let filePath = Bundle(for: type(of: self)).path(forResource: "vbri_header", ofType: "mp3") else {
            return XCTFail()
        }

        guard let media = try? MPEGMedia(fromFilePath: filePath, readOnly: true) else {
            return XCTFail()
        }

        XCTAssert(media.version == MPEGVersion.v1)
        XCTAssert(media.layer == MPEGLayer.layer3)

        XCTAssert(Int(media.duration + 0.5) == 222198)

        XCTAssert(media.bitRate == 233)
        XCTAssert(media.sampleRate == 44100)

        XCTAssert(media.channelMode == MPEGChannelMode.stereo)

        XCTAssert(media.copyrighted == false)
        XCTAssert(media.original == true)

        XCTAssert(media.emphasis == MPEGEmphasis.none)

        XCTAssert(media.bitRateMode == MPEGBitRateMode.variable)

        XCTAssert(media.xingHeader == nil)
        XCTAssert(media.vbriHeader != nil)

        XCTAssert(media.channels == 2)
        
        XCTAssert(media.introID3v2Tag != nil)
        XCTAssert(media.outroID3v2Tag == nil)
        XCTAssert(media.outroLyrics3Tag == nil)
        XCTAssert(media.outroAPETag == nil)
        XCTAssert(media.outroID3v1Tag == nil)
    }

    func testMinimalCBRFile() {
        guard let filePath = Bundle(for: type(of: self)).path(forResource: "minimal_cbr", ofType: "mp3") else {
            return XCTFail()
        }

        guard let media = try? MPEGMedia(fromFilePath: filePath, readOnly: true) else {
            return XCTFail()
        }

        XCTAssert(media.version == MPEGVersion.v1)
        XCTAssert(media.layer == MPEGLayer.layer3)

        XCTAssert(Int(media.duration + 0.5) == 3553)

        XCTAssert(media.bitRate == 64)
        XCTAssert(media.sampleRate == 44100)

        XCTAssert(media.channelMode == MPEGChannelMode.singleChannel)

        XCTAssert(media.copyrighted == false)
        XCTAssert(media.original == true)

        XCTAssert(media.emphasis == MPEGEmphasis.none)

        XCTAssert(media.bitRateMode == MPEGBitRateMode.constant)

        XCTAssert(media.xingHeader == nil)
        XCTAssert(media.vbriHeader == nil)
        
        XCTAssert(media.channels == 1)

        XCTAssert(media.introID3v2Tag == nil)
        XCTAssert(media.outroID3v2Tag == nil)
        XCTAssert(media.outroLyrics3Tag == nil)
        XCTAssert(media.outroAPETag == nil)
        XCTAssert(media.outroID3v1Tag == nil)
    }

    func testInvalidFrames1File() {
        guard let filePath = Bundle(for: type(of: self)).path(forResource: "invalid_frames_1", ofType: "mp3") else {
            return XCTFail()
        }

        guard let media = try? MPEGMedia(fromFilePath: filePath, readOnly: true) else {
            return XCTFail()
        }

        XCTAssert(media.version == MPEGVersion.v1)
        XCTAssert(media.layer == MPEGLayer.layer3)

        XCTAssert(Int(media.duration + 0.5) == 392)

        XCTAssert(media.bitRate == 160)
        XCTAssert(media.sampleRate == 44100)

        XCTAssert(media.channelMode == MPEGChannelMode.jointStereo(stereoCoding: MPEGStereoCoding.midSideOnly))

        XCTAssert(media.copyrighted == true)
        XCTAssert(media.original == true)

        XCTAssert(media.emphasis == MPEGEmphasis.none)

        XCTAssert(media.bitRateMode == MPEGBitRateMode.constant)

        XCTAssert(media.xingHeader == nil)
        XCTAssert(media.vbriHeader == nil)
        
        XCTAssert(media.channels == 2)

        XCTAssert(media.introID3v2Tag == nil)
        XCTAssert(media.outroID3v2Tag == nil)
        XCTAssert(media.outroLyrics3Tag == nil)
        XCTAssert(media.outroAPETag == nil)
        XCTAssert(media.outroID3v1Tag == nil)
    }

    func testInvalidFrames2File() {
        guard let filePath = Bundle(for: type(of: self)).path(forResource: "invalid_frames_2", ofType: "mp3") else {
            return XCTFail()
        }

        guard let media = try? MPEGMedia(fromFilePath: filePath, readOnly: true) else {
            return XCTFail()
        }

        XCTAssert(media.version == MPEGVersion.v1)
        XCTAssert(media.layer == MPEGLayer.layer3)

        XCTAssert(Int(media.duration + 0.5) == 314)

        XCTAssert(media.bitRate == 192)
        XCTAssert(media.sampleRate == 44100)

        XCTAssert(media.channelMode == MPEGChannelMode.stereo)

        XCTAssert(media.copyrighted == false)
        XCTAssert(media.original == true)

        XCTAssert(media.emphasis == MPEGEmphasis.none)

        XCTAssert(media.bitRateMode == MPEGBitRateMode.constant)

        XCTAssert(media.xingHeader == nil)
        XCTAssert(media.vbriHeader == nil)
        
        XCTAssert(media.channels == 2)

        XCTAssert(media.introID3v2Tag == nil)
        XCTAssert(media.outroID3v2Tag == nil)
        XCTAssert(media.outroLyrics3Tag == nil)
        XCTAssert(media.outroAPETag == nil)
        XCTAssert(media.outroID3v1Tag == nil)
    }

    func testInvalidFrames3File() {
        guard let filePath = Bundle(for: type(of: self)).path(forResource: "invalid_frames_3", ofType: "mp3") else {
            return XCTFail()
        }

        guard let media = try? MPEGMedia(fromFilePath: filePath, readOnly: true) else {
            return XCTFail()
        }

        XCTAssert(media.version == MPEGVersion.v1)
        XCTAssert(media.layer == MPEGLayer.layer3)

        XCTAssert(Int(media.duration + 0.5) == 181)

        XCTAssert(media.bitRate == 320)
        XCTAssert(media.sampleRate == 44100)

        XCTAssert(media.channelMode == MPEGChannelMode.jointStereo(stereoCoding: MPEGStereoCoding.none))

        XCTAssert(media.copyrighted == false)
        XCTAssert(media.original == false)

        XCTAssert(media.emphasis == MPEGEmphasis.none)

        XCTAssert(media.bitRateMode == MPEGBitRateMode.constant)

        XCTAssert(media.xingHeader == nil)
        XCTAssert(media.vbriHeader == nil)
        
        XCTAssert(media.channels == 2)

        XCTAssert(media.introID3v2Tag == nil)
        XCTAssert(media.outroID3v2Tag == nil)
        XCTAssert(media.outroLyrics3Tag == nil)
        XCTAssert(media.outroAPETag == nil)
        XCTAssert(media.outroID3v1Tag == nil)
    }

    func testDoubleID3v2TagFile() {
        guard let filePath = Bundle(for: type(of: self)).path(forResource: "double_id3v2_tag", ofType: "mp3") else {
            return XCTFail()
        }

        guard let media = try? MPEGMedia(fromFilePath: filePath, readOnly: true) else {
            return XCTFail()
        }

        XCTAssert(media.version == MPEGVersion.v1)
        XCTAssert(media.layer == MPEGLayer.layer3)

        XCTAssert(Int(media.duration + 0.5) == 131)

        XCTAssert(media.bitRate == 128)
        XCTAssert(media.sampleRate == 44100)

        XCTAssert(media.channelMode == MPEGChannelMode.jointStereo(stereoCoding: MPEGStereoCoding.midSideOnly))

        XCTAssert(media.copyrighted == false)
        XCTAssert(media.original == true)

        XCTAssert(media.emphasis == MPEGEmphasis.none)

        XCTAssert(media.bitRateMode == MPEGBitRateMode.constant)

        XCTAssert(media.xingHeader == nil)
        XCTAssert(media.vbriHeader == nil)
        
        XCTAssert(media.channels == 2)

        XCTAssert(media.introID3v2Tag != nil)
        XCTAssert(media.outroID3v2Tag == nil)
        XCTAssert(media.outroLyrics3Tag == nil)
        XCTAssert(media.outroAPETag == nil)
        XCTAssert(media.outroID3v1Tag == nil)
    }

    func testAPETagFile() {
        guard let filePath = Bundle(for: type(of: self)).path(forResource: "ape_tag", ofType: "mp3") else {
            return XCTFail()
        }

        guard let media = try? MPEGMedia(fromFilePath: filePath, readOnly: true) else {
            return XCTFail()
        }

        XCTAssert(media.version == MPEGVersion.v1)
        XCTAssert(media.layer == MPEGLayer.layer3)

        XCTAssert(Int(media.duration + 0.5) == 2052)

        XCTAssert(media.bitRate == 32)
        XCTAssert(media.sampleRate == 44100)

        XCTAssert(media.channelMode == MPEGChannelMode.jointStereo(stereoCoding: MPEGStereoCoding.midSideOnly))

        XCTAssert(media.copyrighted == false)
        XCTAssert(media.original == true)

        XCTAssert(media.emphasis == MPEGEmphasis.none)

        XCTAssert(media.bitRateMode == MPEGBitRateMode.constant)

        XCTAssert(media.xingHeader == nil)
        XCTAssert(media.vbriHeader == nil)
        
        XCTAssert(media.channels == 2)

        XCTAssert(media.introID3v2Tag == nil)
        XCTAssert(media.outroID3v2Tag == nil)
        XCTAssert(media.outroLyrics3Tag == nil)
        XCTAssert(media.outroAPETag != nil)
        XCTAssert(media.outroID3v1Tag == nil)
    }

    func testAPEAndID3v1TagsFile() {
        guard let filePath = Bundle(for: type(of: self)).path(forResource: "ape_id3v1_tags", ofType: "mp3") else {
            return XCTFail()
        }

        guard let media = try? MPEGMedia(fromFilePath: filePath, readOnly: true) else {
            return XCTFail()
        }

        XCTAssert(media.version == MPEGVersion.v1)
        XCTAssert(media.layer == MPEGLayer.layer3)

        XCTAssert(Int(media.duration + 0.5) == 2052)

        XCTAssert(media.bitRate == 32)
        XCTAssert(media.sampleRate == 44100)

        XCTAssert(media.channelMode == MPEGChannelMode.jointStereo(stereoCoding: MPEGStereoCoding.midSideOnly))

        XCTAssert(media.copyrighted == false)
        XCTAssert(media.original == true)

        XCTAssert(media.emphasis == MPEGEmphasis.none)

        XCTAssert(media.bitRateMode == MPEGBitRateMode.constant)

        XCTAssert(media.xingHeader == nil)
        XCTAssert(media.vbriHeader == nil)
        
        XCTAssert(media.channels == 2)

        XCTAssert(media.introID3v2Tag == nil)
        XCTAssert(media.outroID3v2Tag == nil)
        XCTAssert(media.outroLyrics3Tag == nil)
        XCTAssert(media.outroAPETag != nil)
        XCTAssert(media.outroID3v1Tag != nil)
    }

    func testAPEAndID3v2TagFile() {
        guard let filePath = Bundle(for: type(of: self)).path(forResource: "ape_id3v2_tags", ofType: "mp3") else {
            return XCTFail()
        }

        guard let media = try? MPEGMedia(fromFilePath: filePath, readOnly: true) else {
            return XCTFail()
        }

        XCTAssert(media.version == MPEGVersion.v1)
        XCTAssert(media.layer == MPEGLayer.layer3)

        XCTAssert(Int(media.duration + 0.5) == 2052)

        XCTAssert(media.bitRate == 32)
        XCTAssert(media.sampleRate == 44100)

        XCTAssert(media.channelMode == MPEGChannelMode.jointStereo(stereoCoding: MPEGStereoCoding.midSideOnly))

        XCTAssert(media.copyrighted == false)
        XCTAssert(media.original == true)

        XCTAssert(media.emphasis == MPEGEmphasis.none)

        XCTAssert(media.bitRateMode == MPEGBitRateMode.constant)

        XCTAssert(media.xingHeader == nil)
        XCTAssert(media.vbriHeader == nil)
        
        XCTAssert(media.channels == 2)

        XCTAssert(media.introID3v2Tag != nil)
        XCTAssert(media.outroID3v2Tag == nil)
        XCTAssert(media.outroLyrics3Tag == nil)
        XCTAssert(media.outroAPETag != nil)
        XCTAssert(media.outroID3v1Tag == nil)
    }

    func testBrokenLengthFile() {
        guard let filePath = Bundle(for: type(of: self)).path(forResource: "broken_length", ofType: "mp3") else {
            return XCTFail()
        }

        XCTAssert((try? MPEGMedia(fromFilePath: filePath, readOnly: true)) == nil)
    }

    func testExcessiveAllocFile() {
        guard let filePath = Bundle(for: type(of: self)).path(forResource: "excessive_alloc", ofType: "mp3") else {
            return XCTFail()
        }

        XCTAssert((try? MPEGMedia(fromFilePath: filePath, readOnly: true)) == nil)
    }
}
