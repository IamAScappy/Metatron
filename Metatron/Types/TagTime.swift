//
//  TagTime.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 22.07.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import Foundation

public struct TagTime: Comparable, Equatable, CustomStringConvertible {

    // MARK: Instance Properties

    public var hour: Int
    public var minute: Int
    public var second: Int

    // MARK:

    public var description: String {
        guard self.isValid else {
            return ""
        }

        if self.second > 0 {
            return String(format: "%02d:%02d:%02d", self.hour, self.minute, self.second)
        } else {
            return String(format: "%02d:%02d", self.hour, self.minute)
        }
    }

    // MARK:

    public var isMidnight: Bool {
        if self.hour != 0 {
            return false
        }

        if self.minute != 0 {
            return false
        }

        if self.second != 0 {
            return false
        }

        return true
    }

    public var isValid: Bool {
        if (self.hour < 0) || (self.hour > 23) {
            return false
        }

        if (self.minute < 0) || (self.minute > 59) {
            return false
        }

        if (self.second < 0) || (self.second > 59) {
            return false
        }

        return true
    }

    public var revised: TagTime {
        if (self.hour < 0) || (self.hour > 23) {
            return TagTime()
        }

        if (self.minute < 0) || (self.minute > 59) {
            return TagTime(hour: self.hour)
        }

        if (self.second < 0) || (self.second > 59) {
            return TagTime(hour: self.hour, minute: self.minute)
        }

        return self
    }

    // MARK: Initializers

    public init(hour: Int, minute: Int = 0, second: Int = 0) {
        self.hour = hour
        self.minute = minute
        self.second = second
    }

    public init() {
        self.init(hour: 0)
    }

    // MARK: Instance Methods

    public mutating func reset() {
        self.hour = 0
        self.minute = 0
        self.second = 0
    }
}

public func > (left: TagTime, right: TagTime) -> Bool {
    if left.hour != right.hour {
        return (left.hour > right.hour)
    } else if left.minute != right.minute {
        return (left.minute > right.minute)
    } else {
        return (left.second > right.second)
    }
}

public func < (left: TagTime, right: TagTime) -> Bool {
    if left.hour != right.hour {
        return (left.hour < right.hour)
    } else if left.minute != right.minute {
        return (left.minute < right.minute)
    } else {
        return (left.second < right.second)
    }
}

public func >= (left: TagTime, right: TagTime) -> Bool {
    return !(left < right)
}

public func <= (left: TagTime, right: TagTime) -> Bool {
    return !(left > right)
}

public func == (left: TagTime, right: TagTime) -> Bool {
    if left.hour != right.hour {
        return false
    }

    if left.minute != right.minute {
        return false
    }

    if left.second != right.second {
        return false
    }

    return true
}

public func != (left: TagTime, right: TagTime) -> Bool {
    return !(left == right)
}
