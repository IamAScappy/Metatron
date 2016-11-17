//
//  TagNumber.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 22.07.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import Foundation

public struct TagNumber: Comparable, Equatable, CustomStringConvertible {

	// MARK: Instance Properties

    public var value: Int
    public var total: Int

    // MARK:

    public var description: String {
        guard self.isValid else {
            return ""
        }

        if self.total > 0 {
            return "\(self.value)/\(self.total)"
        } else {
            return "\(self.value)"
        }
    }

    // MARK:

    public var isValid: Bool {
    	if self.value < 1 {
    		return false
    	}

    	if self.total != 0 {
            if self.total < self.value {
                return false
            }
    	}

        return true
    }

    public var revised: TagNumber {
        if self.value < 1 {
            return TagNumber()
        }

        if self.total < self.value {
            return TagNumber(self.value)
        }

        return self
    }

    // MARK: Initializers

    public init(_ value: Int, total: Int = 0) {
        self.value = value
        self.total = total
    }

    public init() {
        self.init(0)
    }

    // MARK: Instance Methods

    public mutating func reset() {
        self.value = 0
        self.total = 0
    }
}

public func > (left: TagNumber, right: TagNumber) -> Bool {
    return (left.value > right.value)
}

public func < (left: TagNumber, right: TagNumber) -> Bool {
    return (left.value < right.value)
}

public func >= (left: TagNumber, right: TagNumber) -> Bool {
    return (left.value >= right.value)
}

public func <= (left: TagNumber, right: TagNumber) -> Bool {
    return (left.value <= right.value)
}

public func == (left: TagNumber, right: TagNumber) -> Bool {
    if left.value != right.value {
        return false
    }

    if left.total != right.total {
        return false
    }

    return true
}

public func != (left: TagNumber, right: TagNumber) -> Bool {
    return !(left == right)
}
