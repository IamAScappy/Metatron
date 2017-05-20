//
//  APESerialization.swift
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

class APESerialization {

    // MARK: Type Properties

    static let maxTimeStamp: UInt = 2147483647

    // MARK: Type Methods

    static func stringFromData(_ data: [UInt8]) -> String? {
        guard !data.isEmpty else {
            return nil
        }

        if let terminator = data.index(of: 0) {
            return String(bytes: data.prefix(terminator), encoding: String.Encoding.utf8)
        }

        return String(bytes: data, encoding: String.Encoding.utf8)
    }

    static func stringListFromData(_ data: [UInt8]) -> [String]? {
        guard !data.isEmpty else {
            return nil
        }

        var stringList: [String] = []

        for stringData in data.split(separator: 0, omittingEmptySubsequences: false) {
            guard let string = String(bytes: stringData, encoding: String.Encoding.utf8) else {
                return nil
            }

            stringList.append(string)
        }

        return stringList
    }

    static func numberFromData(_ data: [UInt8]) -> TagNumber? {
        guard !data.isEmpty else {
            return nil
        }

        let dataParts = data.split(separator: 47, maxSplits: 1, omittingEmptySubsequences: false)

        guard let value = Int(String(bytes: dataParts[0], encoding: String.Encoding.utf8) ?? "") else {
            return nil
        }

        if dataParts.count == 1 {
            return TagNumber(value)
        }

        guard let total = Int(String(bytes: dataParts[1], encoding: String.Encoding.utf8) ?? "") else {
            return nil
        }

        return TagNumber(value, total: total)
    }

    static func timeFromData(_ data: [UInt8]) -> TagTime? {
        guard !data.isEmpty else {
            return nil
        }

        let dataParts = data.split(separator: 58, maxSplits: 2, omittingEmptySubsequences: false)

        guard (dataParts[0].count == 2) && (data[0] != 45) else {
            return nil
        }

        guard let hour = Int(String(bytes: dataParts[0], encoding: String.Encoding.utf8) ?? "") else {
            return nil
        }

        if dataParts.count == 1 {
            return TagTime(hour: hour)
        }

        guard (dataParts[1].count == 2) && (data[3] != 45) else {
            return nil
        }

        guard let minute = Int(String(bytes: dataParts[1], encoding: String.Encoding.utf8) ?? "") else {
            return nil
        }

        if dataParts.count == 2 {
            return TagTime(hour: hour, minute: minute)
        }

        guard (dataParts[2].count == 2) && (data[6] != 45) else {
            return nil
        }

        guard let second = Int(String(bytes: dataParts[2], encoding: String.Encoding.utf8) ?? "") else {
            return nil
        }

        return TagTime(hour: hour, minute: minute, second: second)
    }

    static func timePeriodFromData(_ data: [UInt8]) -> TagTimePeriod? {
        guard !data.isEmpty else {
            return nil
        }

        let dataParts = data.split(separator: 46, maxSplits: 3, omittingEmptySubsequences: false)

        guard (dataParts.count == 4) && dataParts[1].isEmpty && dataParts[2].isEmpty else {
            return nil
        }

        guard let startTime = APESerialization.timeFromData([UInt8](dataParts[0])) else {
            return nil
        }

        guard let endTime = APESerialization.timeFromData([UInt8](dataParts[3])) else {
            return nil
        }

        return TagTimePeriod(start: startTime, end: endTime)
    }

    static func dateFromData(_ data: [UInt8]) -> TagDate? {
        guard !data.isEmpty else {
            return nil
        }

        let dataParts = data.split(separator: 45, maxSplits: 2, omittingEmptySubsequences: false)

        guard (dataParts[0].count == 4) && (data[0] != 45) else {
            return nil
        }

        guard let year = Int(String(bytes: dataParts[0], encoding: String.Encoding.utf8) ?? "") else {
            return nil
        }

        if dataParts.count == 1 {
            return TagDate(year: year)
        }

        if dataParts[1].count == 3 {
            guard (dataParts.count == 2) && (data[5] == 87) else {
                return nil
            }

            guard let week = Int(String(bytes: dataParts[1].suffix(2), encoding: String.Encoding.utf8) ?? "") else {
                return nil
            }

            guard (week > 0) && (week < 54) else {
                return nil
            }

            return TagDate(year: year)
        }

        guard (dataParts[1].count == 2) && (data[5] != 45) else {
            return nil
        }

        guard let month = Int(String(bytes: dataParts[1], encoding: String.Encoding.utf8) ?? "") else {
            return nil
        }

        if dataParts.count == 2 {
            return TagDate(year: year, month: month)
        }

        if dataParts[2].count > 3 {
            guard (data[8] != 45) && ((data[10] == 32) || (data[10] == 84)) else {
                return nil
            }

            guard let time = APESerialization.timeFromData([UInt8](data.suffix(from: 11))) else {
                return nil
            }

            guard let day = Int(String(bytes: dataParts[2].prefix(2), encoding: String.Encoding.utf8) ?? "") else {
                return nil
            }

            return TagDate(year: year, month: month, day: day, time: time)
        }

        guard (dataParts[2].count == 2) && (data[8] != 45) else {
            return nil
        }

        guard let day = Int(String(bytes: dataParts[2], encoding: String.Encoding.utf8) ?? "") else {
            return nil
        }

        return TagDate(year: year, month: month, day: day)
    }

    static func datePeriodFromData(_ data: [UInt8]) -> TagDatePeriod? {
        guard !data.isEmpty else {
            return nil
        }

        let dataParts = data.split(separator: 46, maxSplits: 3, omittingEmptySubsequences: false)

        guard (dataParts.count == 4) && dataParts[1].isEmpty && dataParts[2].isEmpty else {
            return nil
        }

        guard let startDate = APESerialization.dateFromData([UInt8](dataParts[0])) else {
            return nil
        }

        guard let endDate = APESerialization.dateFromData([UInt8](dataParts[3])) else {
            return nil
        }

        return TagDatePeriod(start: startDate, end: endDate)
    }

    static func imageFromData(_ data: [UInt8]) -> TagImage? {
        guard !data.isEmpty else {
            return nil
        }

        guard let terminator = data.index(of: 0) else {
            return nil
        }

        guard let fileName = String(bytes: data.prefix(terminator), encoding: String.Encoding.utf8) else {
            return nil
        }

        return TagImage(data: [UInt8](data.suffix(from: terminator + 1)), description: fileName)
    }

    static func timeStampFromData(_ data: [UInt8]) -> UInt? {
        guard !data.isEmpty else {
            return nil
        }

        var timeStamp: UInt = 0

        let dataParts = data.split(separator: 58, maxSplits: 2, omittingEmptySubsequences: false)

        if let separator = dataParts.last!.index(of: 46) {
            let precision = min(data.count - separator - 1, 6)

            guard precision > 0 else {
                return nil
            }

            let millisecondsData = dataParts.last!.suffix(from: separator + 1).prefix(precision)

            guard let milliseconds = UInt(String(bytes: millisecondsData, encoding: String.Encoding.utf8) ?? "") else {
                return nil
            }

            timeStamp = milliseconds * 1000

            for _ in 0..<precision {
                timeStamp /= 10
            }

            let secondsData = dataParts.last!.prefix(upTo: separator)

            guard let seconds = UInt(String(bytes: secondsData, encoding: String.Encoding.utf8) ?? "") else {
                return nil
            }

            guard seconds < APESerialization.maxTimeStamp / 1000 else {
                return nil
            }

            timeStamp += seconds * 1000
        } else {
            guard let seconds = UInt(String(bytes: dataParts.last!, encoding: String.Encoding.utf8) ?? "") else {
                return nil
            }

            guard seconds < APESerialization.maxTimeStamp / 1000 else {
                return nil
            }

            timeStamp = seconds * 1000
        }

        switch dataParts.count {
        case 2:
            guard let minutes = UInt(String(bytes: dataParts[0], encoding: String.Encoding.utf8) ?? "") else {
                return nil
            }

            guard minutes < (APESerialization.maxTimeStamp - timeStamp) / 60000 else {
                return nil
            }

            return timeStamp + minutes * 60000

        case 3:
            guard let minutes = UInt(String(bytes: dataParts[1], encoding: String.Encoding.utf8) ?? "") else {
                return nil
            }

            guard minutes < (APESerialization.maxTimeStamp - timeStamp) / 60000 else {
                return nil
            }

            timeStamp += minutes * 60000

            guard let hours = UInt(String(bytes: dataParts[0], encoding: String.Encoding.utf8) ?? "") else {
                return nil
            }

            guard hours < (APESerialization.maxTimeStamp - timeStamp) / 3600000 else {
                return nil
            }

            return timeStamp + hours * 3600000

        default:
            return timeStamp
        }
    }

    static func lyricsFromData(_ data: [UInt8]) -> TagLyrics? {
        guard !data.isEmpty else {
            return nil
        }

        if (data.count < 3) || (data[0] != 91) {
            let terminator = data.index(of: 0) ?? data.count

            guard let text = String(bytes: data.prefix(terminator), encoding: String.Encoding.utf8) else {
                return nil
            }

            return TagLyrics(pieces: [TagLyrics.Piece(text)])
        }

        var nextTimeStamp: UInt

        var scanStart: Int
        var textStart: Int

        if let separator = data.suffix(from: 2).index(of: 93) {
            if let timeStamp = APESerialization.timeStampFromData([UInt8](data[1..<separator])) {
                nextTimeStamp = timeStamp

                scanStart = separator + 1
                textStart = scanStart
            } else {
                let terminator = data.index(of: 0) ?? data.count

                guard let text = String(bytes: data.prefix(terminator), encoding: String.Encoding.utf8) else {
                    return nil
                }

                return TagLyrics(pieces: [TagLyrics.Piece(text)])
            }
        } else {
            let terminator = data.index(of: 0) ?? data.count

            guard let text = String(bytes: data.prefix(terminator), encoding: String.Encoding.utf8) else {
                return nil
            }

            return TagLyrics(pieces: [TagLyrics.Piece(text)])
        }

        var lyrics = TagLyrics()

        while let nextStart = data.suffix(from: scanStart).index(of: 91) {
            scanStart = nextStart + 1

            if let separator = data.suffix(from: scanStart).index(of: 93) {
                if let timeStamp = APESerialization.timeStampFromData([UInt8](data[scanStart..<separator])) {
                    var textEnd = data[textStart..<nextStart].index(of: 0) ?? nextStart

                    if data[textEnd - 1] == 10 {
                        textEnd -= 1
                    }

                    if data[textStart] == 32 {
                        textStart += 1
                    }

                    guard let text = String(bytes: data[textStart..<textEnd], encoding: String.Encoding.utf8) else {
                        return nil
                    }

                    lyrics.pieces.append(TagLyrics.Piece(text, timeStamp: nextTimeStamp))

                    nextTimeStamp = timeStamp

                    scanStart = separator + 1
                    textStart = scanStart
                }
            } else {
                break
            }
        }

        if textStart < data.count {
            var textEnd = data[textStart..<data.count].index(of: 0) ?? data.count

            if data[textEnd - 1] == 10 {
                textEnd -= 1
            }

            if data[textStart] == 32 {
                textStart += 1
            }

            guard let text = String(bytes: data[textStart..<textEnd], encoding: String.Encoding.utf8) else {
                return nil
            }

            lyrics.pieces.append(TagLyrics.Piece(text, timeStamp: nextTimeStamp))
        } else {
            lyrics.pieces.append(TagLyrics.Piece("", timeStamp: nextTimeStamp))
        }

        return lyrics
    }

    // MARK:

    static func dataFromString(_ string: String) -> [UInt8] {
        guard !string.isEmpty else {
            return []
        }

        return [UInt8](string.utf8)
    }

    static func dataFromStringList(_ stringList: [String]) -> [UInt8] {
        guard !stringList.isEmpty else {
            return []
        }

        var data: [UInt8] = []

        for string in stringList {
            data.append(contentsOf: string.utf8)
            data.append(0)
        }

        if !data.isEmpty {
            data.removeLast()
        }

        return data
    }

    static func dataFromNumber(_ number: TagNumber) -> [UInt8] {
        guard number.isValid else {
            return []
        }

        if number.total > 0 {
            return [UInt8](String(format: "%d/%d", number.value, number.total).utf8)
        }

        return [UInt8](String(format: "%d", number.value).utf8)
    }

    static func dataFromTime(_ time: TagTime) -> [UInt8] {
        guard time.isValid else {
            return []
        }

        if time.second > 0 {
            return [UInt8](String(format: "%02d:%02d:%02d", time.hour, time.minute, time.second).utf8)
        } else if time.minute > 0 {
            return [UInt8](String(format: "%02d:%02d", time.hour, time.minute).utf8)
        } else if time.hour > 0 {
            return [UInt8](String(format: "%02d:00", time.hour, time.minute).utf8)
        }

        return [48, 48, 58, 48, 48]
    }

    static func dataFromTimePeriod(_ timePeriod: TagTimePeriod) -> [UInt8] {
        guard timePeriod.isValid else {
            return []
        }

        var data: [UInt8] = []

        data.append(contentsOf: APESerialization.dataFromTime(timePeriod.start))
        data.append(contentsOf: [46, 46, 46])
        data.append(contentsOf: APESerialization.dataFromTime(timePeriod.end))

        return data
    }

    static func dataFromDate(_ date: TagDate) -> [UInt8] {
        guard date.isValid else {
            return []
        }

        let time = date.time

        if time.second > 0 {
            var data: [UInt8] = []

            data.append(contentsOf: String(format: "%04d-%02d-%02d ", date.year, date.month, date.day).utf8)
            data.append(contentsOf: String(format: "%02d:%02d:%02d", time.hour, time.minute, time.second).utf8)

            return data
        }
        else if time.minute > 0 {
            var data: [UInt8] = []

            data.append(contentsOf: String(format: "%04d-%02d-%02d ", date.year, date.month, date.day).utf8)
            data.append(contentsOf: String(format: "%02d:%02d", time.hour, time.minute).utf8)

            return data
        } else if time.hour > 0 {
            var data: [UInt8] = []

            data.append(contentsOf: String(format: "%04d-%02d-%02d ", date.year, date.month, date.day).utf8)
            data.append(contentsOf: String(format: "%02d:00", time.hour).utf8)

            return data
        } else if date.day > 1 {
            return [UInt8](String(format: "%04d-%02d-%02d", date.year, date.month, date.day).utf8)
        } else if date.month > 1 {
            return [UInt8](String(format: "%04d-%02d", date.year, date.month).utf8)
        } else if date.year > 1 {
            return [UInt8](String(format: "%04d", date.year).utf8)
        }

        return [48, 48, 48, 49]
    }

    static func dataFromDatePeriod(_ datePeriod: TagDatePeriod) -> [UInt8] {
        guard datePeriod.isValid else {
            return []
        }

        var data: [UInt8] = []

        data.append(contentsOf: APESerialization.dataFromDate(datePeriod.start))
        data.append(contentsOf: [46, 46, 46])
        data.append(contentsOf: APESerialization.dataFromDate(datePeriod.end))

        return data
    }

    static func dataFromImage(_ image: TagImage) -> [UInt8] {
        guard !image.isEmpty else {
            return []
        }

        var data: [UInt8] = []

        data.append(contentsOf: image.description.utf8)
        data.append(0)
        data.append(contentsOf: image.data)

        return data
    }

    static func dataFromTimeStamp(_ timeStamp: UInt) -> [UInt8] {
        guard timeStamp != 0 else {
            return [48]
        }

        let milliseconds = timeStamp % 1000

        if milliseconds != 0 {
            if (milliseconds % 100) == 0 {
                return [UInt8](String(format: "%d.%01d", timeStamp / 1000, milliseconds / 100).utf8)
            } else if (milliseconds % 10) == 0 {
                return [UInt8](String(format: "%d.%02d", timeStamp / 1000, milliseconds / 10).utf8)
            } else {
                return [UInt8](String(format: "%d.%03d", timeStamp / 1000, milliseconds).utf8)
            }
        } else {
            return [UInt8](String(format: "%d", timeStamp / 1000).utf8)
        }
    }

    static func dataFromLyrics(_ lyrics: TagLyrics) -> [UInt8] {
        guard !lyrics.isEmpty else {
            return []
        }

        var data: [UInt8] = []

        for piece in lyrics.pieces {
            data.append(91)
            data.append(contentsOf: APESerialization.dataFromTimeStamp(piece.timeStamp))
            data.append(93)

            data.append(32)
            data.append(contentsOf: piece.text.utf8)
            data.append(10)
        }

        return data
    }
}
