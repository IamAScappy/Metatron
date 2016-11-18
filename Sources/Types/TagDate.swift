//
//  TagDate.swift
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

public struct TagDate: Comparable, Equatable, CustomStringConvertible {

    // MARK: Instance Properties

    public var year: Int
    public var month: Int
    public var day: Int

    public var time: TagTime

    // MARK:

    public var description: String {
        guard self.isValid else {
            return ""
        }

        if !self.time.isMidnight {
            return String(format: "%04d-%02d-%02d \(self.time)", self.year, self.month, self.day)
        } else if self.day > 1 {
            return String(format: "%04d-%02d-%02d", self.year, self.month, self.day)
        } else if self.month > 1 {
            return String(format: "%04d-%02d", self.year, self.month)
        } else {
            return String(format: "%04d", self.year)
        }
    }

    // MARK:

    public var daysInYear: Int {
        if (self.year > 0) && (self.year <= 9999) {
            return self.isLeapYear ? 366 : 365
        }

        return 0
    }

    public var daysInMonth: Int {
        switch self.month {
        case 1: //January
            return 31

        case 2: //February
            return self.isLeapYear ? 29 : 28

        case 3: //March
            return 31

        case 4: //April
            return 30

        case 5: //May
            return 31

        case 6: //June
            return 30

        case 7: //July
            return 31

        case 8: //August
            return 31

        case 9: //September
            return 30

        case 10: //October
            return 31

        case 11: //November
            return 30

        case 12: //December
            return 31

        default:
            return 0
        }
    }

    public var isLeapYear: Bool {
        if (self.year > 0) && (self.year <= 9999) {
            if self.year & 3 == 0 {
                if self.year % 100 != 0 {
                    return true
                }

                if self.year % 400 == 0 {
                    return true
                }
            }
        }

        return false
    }

    public var isValid: Bool {
        if (self.year <= 0) || (self.year > 9999) {
            return false
        }

        if (self.day < 1) || (self.day > self.daysInMonth) {
            return false
        }

        if !self.time.isValid {
            return false
        }

        return true
    }

    public var revised: TagDate {
        if (self.year <= 0) || (self.year > 9999) {
            return TagDate()
        }

        if (self.month < 1) || (self.month > 12) {
            return TagDate(year: self.year)
        }

        if (self.day < 1) || (self.day > self.daysInMonth) {
            return TagDate(year: self.year, month: self.month)
        }

        return TagDate(year: self.year, month: self.month, day: self.day, time: self.time.revised)
    }

    // MARK: Initializers

    public init(year: Int, month: Int = 1, day: Int = 1, time: TagTime = TagTime()) {
        self.year = year
        self.month = month
        self.day = day

        self.time = time
    }

    public init() {
        self.init(year: 0)
    }

    // MARK: Instance Methods

    public mutating func reset() {
        self.year = 0
        self.month = 1
        self.day = 1

        self.time.reset()
    }
}

public func > (left: TagDate, right: TagDate) -> Bool {
    if left.year != right.year {
        return (left.year > right.year)
    } else if left.month != right.month {
        return (left.month > right.month)
    } else if left.day != right.day {
        return (left.day > right.day)
    } else {
        return (left.time > right.time)
    }
}

public func < (left: TagDate, right: TagDate) -> Bool {
    if left.year != right.year {
        return (left.year < right.year)
    } else if left.month != right.month {
        return (left.month < right.month)
    } else if left.day != right.day {
        return (left.day < right.day)
    } else {
        return (left.time < right.time)
    }
}

public func >= (left: TagDate, right: TagDate) -> Bool {
    return !(left < right)
}

public func <= (left: TagDate, right: TagDate) -> Bool {
    return !(left > right)
}

public func == (left: TagDate, right: TagDate) -> Bool {
    if left.year != right.year {
        return false
    }

    if left.month != right.month {
        return false
    }

    if left.day != right.day {
        return false
    }

    if left.time != right.time {
        return false
    }

    return true
}

public func != (left: TagDate, right: TagDate) -> Bool {
    return !(left == right)
}
