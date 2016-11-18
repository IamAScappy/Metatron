//
//  TagNumber.swift
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
