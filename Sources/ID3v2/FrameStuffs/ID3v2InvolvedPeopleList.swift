//
//  ID3v2InvolvedPeopleList.swift
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

public class ID3v2InvolvedPeopleList: ID3v2FrameStuff {

    // MARK: Instance Properties

    public var textEncoding: ID3v2TextEncoding = ID3v2TextEncoding.utf8

    public var persons: [String] = []

    // MARK:

    public var isEmpty: Bool {
        return self.persons.isEmpty
    }

    // MARK: Initializers

    public init() {
    }

    public required init(fromData data: [UInt8], version: ID3v2Version) {
        guard data.count > 1 else {
            return
        }

        guard let textEncoding = ID3v2TextEncoding(rawValue: data[0]) else {
            return
        }

        var offset = 1

        var persons: [String] = []

        repeat {
            guard let person = textEncoding.decode([UInt8](data.suffix(from: offset))) else {
                return
            }

            persons.append(person.text)

            offset += person.endIndex

            if offset >= data.count {
                if person.terminated {
                    persons.append("")
                }

                break
            }
        }
        while true

        self.textEncoding = textEncoding

        self.persons = persons
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
            return nil
        }

        var data = [textEncoding.rawValue]

        for i in 0..<(self.persons.count - 1) {
            data.append(contentsOf: textEncoding.encode(self.persons[i], termination: true))
        }

        data.append(contentsOf: textEncoding.encode(self.persons.last!, termination: false))

        return data
    }

    public func toData() -> (data: [UInt8], version: ID3v2Version)? {
        guard let data = self.toData(version: ID3v2Version.v4) else {
            return nil
        }

        return (data: data, version: ID3v2Version.v3)
    }
}

public class ID3v2InvolvedPeopleListFormat: ID3v2FrameStuffSubclassFormat {

    // MARK: Type Properties

    public static let regular = ID3v2InvolvedPeopleListFormat()

    // MARK: Instance Methods

    public func createStuffSubclass(fromData data: [UInt8], version: ID3v2Version) -> ID3v2InvolvedPeopleList {
        return ID3v2InvolvedPeopleList(fromData: data, version: version)
    }

    public func createStuffSubclass(fromOther other: ID3v2InvolvedPeopleList) -> ID3v2InvolvedPeopleList {
        let stuff = ID3v2InvolvedPeopleList()

        stuff.textEncoding = other.textEncoding

        stuff.persons = other.persons

        return stuff
    }

    public func createStuffSubclass() -> ID3v2InvolvedPeopleList {
        return ID3v2InvolvedPeopleList()
    }
}
