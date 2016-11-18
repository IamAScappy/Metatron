//
//  Media.swift
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
