//
//  Media.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 10.11.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import Foundation

public protocol Media: class {

    // MARK: Instance Properties

    var title: String {get set}
    var artists: [String] {get set}

    var album: String {get set}
    var genres: [String] {get set}

    var releaseDate: TagDate {get set}

    var trackNumber: TagNumber {get set}
    var discNumber: TagNumber {get set}

    var coverArt: TagImage {get set}

    var copyrights: [String] {get set}
    var comments: [String] {get set}

    var lyrics: TagLyrics {get set}

    // MARK:

    var duration: Double {get}

    var bitRate: Int {get}
    var sampleRate: Int {get}

    var channels: Int {get}

    // MARK:

    var filePath: String {get}

    var isReadOnly: Bool {get}

    // MARK: Instance Methods

    @discardableResult
    func save() -> Bool
}

public protocol MediaFormat: class {

    // MARK: Instance Methods

    func createMedia(fromStream: Stream) throws -> Media

    func createMedia(fromFilePath: String, readOnly: Bool) throws -> Media
    func createMedia(fromData: [UInt8], readOnly: Bool) throws  -> Media
}
