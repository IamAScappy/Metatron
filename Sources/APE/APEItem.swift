//
//  APEItem.swift
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

public class APEItem {

    // MARK: Nested Types

    public enum Access: UInt8 {
        case readWrite
        case readOnly
    }

    public enum Format: UInt8 {
        case textual
        case binary
        case locator
        case reserved
    }

    // MARK: Type Properties

    static let minDataLength: Int = 10

    // MARK: Instance Properties

    public let identifier: String

    public var access: Access
    public var format: Format

    public var value: [UInt8]

    // MARK:

    public var stringValue: String? {
        get {
            return APESerialization.stringFromData(self.value)
        }

        set {
            if let string = newValue {
                self.value = APESerialization.dataFromString(string)
            } else {
                self.value.removeAll()
            }
        }
    }

    public var stringListValue: [String]? {
        get {
            return APESerialization.stringListFromData(self.value)
        }

        set {
            if let stringList = newValue {
                self.value = APESerialization.dataFromStringList(stringList)
            } else {
                self.value.removeAll()
            }
        }
    }

    public var imageValue: TagImage? {
        get {
            return APESerialization.imageFromData(self.value)
        }

        set {
            if let image = newValue {
                self.value = APESerialization.dataFromImage(image)
            } else {
                self.value.removeAll()
            }
        }
    }

    public var numberValue: TagNumber? {
        get {
            return APESerialization.numberFromData(self.value)
        }

        set {
            if let number = newValue {
                self.value = APESerialization.dataFromNumber(number)
            } else {
                self.value.removeAll()
            }
        }
    }

    public var timeValue: TagTime? {
        get {
            return APESerialization.timeFromData(self.value)
        }

        set {
            if let time = newValue {
                self.value = APESerialization.dataFromTime(time)
            } else {
                self.value.removeAll()
            }
        }
    }

    public var timePeriodValue: TagTimePeriod? {
        get {
            return APESerialization.timePeriodFromData(self.value)
        }

        set {
            if let timePeriod = newValue {
                self.value = APESerialization.dataFromTimePeriod(timePeriod)
            } else {
                self.value.removeAll()
            }
        }
    }

    public var dateValue: TagDate? {
        get {
            return APESerialization.dateFromData(self.value)
        }

        set {
            if let date = newValue {
                self.value = APESerialization.dataFromDate(date)
            } else {
                self.value.removeAll()
            }
        }
    }

    public var datePeriodValue: TagDatePeriod? {
        get {
            return APESerialization.datePeriodFromData(self.value)
        }

        set {
            if let datePeriod = newValue {
                self.value = APESerialization.dataFromDatePeriod(datePeriod)
            } else {
                self.value.removeAll()
            }
        }
    }

    public var timeStampValue: UInt? {
        get {
            return APESerialization.timeStampFromData(self.value)
        }

        set {
            if let timeStamp = newValue {
                self.value = APESerialization.dataFromTimeStamp(timeStamp)
            } else {
                self.value.removeAll()
            }
        }
    }

    public var lyricsValue: TagLyrics? {
        get {
            return APESerialization.lyricsFromData(self.value)
        }

        set {
            if let lyrics = newValue {
                self.value = APESerialization.dataFromLyrics(lyrics)
            } else {
                self.value.removeAll()
            }
        }
    }

    // MARK:

    public var isValid: Bool {
        return APEItem.checkIdentifier(self.identifier)
    }

    public var isEmpty: Bool {
        return self.value.isEmpty
    }

    // MARK: Initializers

    init?(identifier: String, access: Access = Access.readWrite, format: Format = Format.textual) {
        guard APEItem.checkIdentifier(identifier) else {
            return nil
        }

        self.identifier = identifier

        self.access = access
        self.format = format

        self.value = []
    }

    init?(fromBodyData bodyData: [UInt8], offset: inout Int, version: APEVersion) {
        assert(offset < bodyData.count, "Invalid data offset")

        let itemData = [UInt8](bodyData.suffix(from: offset))

        guard (itemData.count >= APEItem.minDataLength) && (itemData[8] != 0) else {
            return nil
        }

        var valueLength = UInt64(itemData[0])

        valueLength |= UInt64(itemData[1]) << 8
        valueLength |= UInt64(itemData[2]) << 16
        valueLength |= UInt64(itemData[3]) << 24

        let itemDataBound = min(UInt64(UInt32.max), UInt64(itemData.count))

        guard valueLength <= itemDataBound - 10 else {
            return nil
        }

        guard let terminator = itemData[9..<Int(itemDataBound - valueLength)].index(of: 0) else {
            return nil
        }

        guard let identifier = String(bytes: itemData[8..<terminator], encoding: String.Encoding.isoLatin1) else {
            return nil
        }

        self.identifier = identifier

        self.access = Access(rawValue: (itemData[4] & 1))!
        self.format = Format(rawValue: (itemData[4] >> 1) & 3)!

        let valueStart = terminator + 1
        let valueEnd = valueStart + Int(valueLength)

        self.value = [UInt8](itemData[valueStart..<valueEnd])

        offset += valueEnd
    }

    // MARK: Type Methods

    static func checkIdentifier(_ identifier: String) -> Bool {
        switch identifier.lowercased() {
        case "id3":
            return false

        case "tag":
            return false

        case "oggs":
            return false

        case "mp+":
            return false

        default:
            break
        }

        let identifierData = identifier.utf8

        if (identifierData.count < 2) || (identifierData.count > 255) {
            return false
        }

        if identifierData.count != identifier.characters.count {
            return false
        }

        for byte in identifierData {
            if (byte < 32) || (byte > 126) {
                return false
            }
        }

        return true
    }

    // MARK: Instance Methods

    func toData(version: APEVersion) -> [UInt8]? {
        guard (!self.isEmpty) && self.isValid else {
            return nil
        }

        guard (version != APEVersion.v1) || (self.format == Format.textual) else {
            return nil
        }

        let identifierData = self.identifier.utf8

        guard UInt64(self.value.count) <= UInt64(UInt32.max) - UInt64(identifierData.count) - 9 else {
            return nil
        }

        let valueLength = UInt32(self.value.count)

        var data = [UInt8((valueLength) & 255),
                    UInt8((valueLength >> 8) & 255),
                    UInt8((valueLength >> 16) & 255),
                    UInt8((valueLength >> 24) & 255),
                    0, 0, 0, 0]

        switch version {
        case APEVersion.v1:
            break

        case APEVersion.v2:
            data[4] = self.access.rawValue | (self.format.rawValue << 1)
        }

        data.append(contentsOf: identifierData)
        data.append(0)
        data.append(contentsOf: self.value)

        return data
    }

    // MARK:

    public func reset() {
        self.access = Access.readWrite
        self.format = Format.textual

        self.value.removeAll()
    }
}
