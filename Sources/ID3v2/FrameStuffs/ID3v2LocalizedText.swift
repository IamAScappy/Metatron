//
//  ID3v2LocalizedText.swift
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

public class ID3v2LocalizedText: ID3v2FrameStuff {

    // MARK: Instance Properties

    public var textEncoding: ID3v2TextEncoding = ID3v2TextEncoding.utf8
    public var language: ID3v2Language = ID3v2Language.und

    public var description: String = ""
    public var content: String = ""

    // MARK:

    public var isEmpty: Bool {
        return self.content.isEmpty
    }

    // MARK: Initializers

    public init() {
    }

    public required init(fromData data: [UInt8], version: ID3v2Version) {
        guard data.count > 5 else {
            return
        }

        guard let textEncoding = ID3v2TextEncoding(rawValue: data[0]) else {
            return
        }

        guard let language = ID3v2Language(code: [UInt8](data[1..<4])) else {
            return
        }

        guard let description = textEncoding.decode([UInt8](data.suffix(from: 4))) else {
            return
        }

        let offset = description.endIndex + 4

        guard offset < data.count else {
            return
        }

        guard let content = textEncoding.decode([UInt8](data.suffix(from: offset))) else {
            return
        }

        self.textEncoding = textEncoding
        self.language = language

        self.description = description.text
        self.content = content.text
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

        data.append(contentsOf: language.code)

        data.append(contentsOf: textEncoding.encode(self.description, termination: true))
        data.append(contentsOf: textEncoding.encode(self.content, termination: false))

        return data
    }

    public func toData() -> (data: [UInt8], version: ID3v2Version)? {
        guard let data = self.toData(version: ID3v2Version.v4) else {
            return nil
        }

        return (data: data, version: ID3v2Version.v4)
    }
}

public class ID3v2LocalizedTextFormat: ID3v2FrameStuffSubclassFormat {

    // MARK: Type Properties

    public static let regular = ID3v2LocalizedTextFormat()

    // MARK: Instance Methods

    public func createStuffSubclass(fromData data: [UInt8], version: ID3v2Version) -> ID3v2LocalizedText {
        return ID3v2LocalizedText(fromData: data, version: version)
    }

    public func createStuffSubclass(fromOther other: ID3v2LocalizedText) -> ID3v2LocalizedText {
        let stuff = ID3v2LocalizedText()

        stuff.textEncoding = other.textEncoding
        stuff.language = other.language

        stuff.description = other.description
        stuff.content = other.content

        return stuff
    }

    public func createStuffSubclass() -> ID3v2LocalizedText {
        return ID3v2LocalizedText()
    }
}
