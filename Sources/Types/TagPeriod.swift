//
//  TagPeriod.swift
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

public protocol TagPeriodable : Comparable, Equatable {

    // MARK: Instance Properties

    var isValid: Bool {get}

    // MARK: Initializers

    init()

    // MARK: Instance Methods

    mutating func reset()
}

public struct TagPeriod<T: TagPeriodable> : Comparable, Equatable {

	// MARK: Instance Properties

    public var start: T
    public var end: T

    // MARK:

    public var isValid: Bool {
    	if !self.start.isValid {
            return false
        }

        if !self.end.isValid {
            return false
        }

        if self.start > self.end {
        	return false
        }

        return true
    }

    // MARK: Initializers

    public init(start: T, end: T) {
        self.start = start
        self.end = end
    }

    public init() {
        self.start = T()
        self.end = T()
    }

    // MARK: Instance Methods

    public mutating func reset() {
        self.start.reset()
        self.end.reset()
    }
}

public func > <T: TagPeriodable>(left: TagPeriod<T>, right: TagPeriod<T>) -> Bool {
    return (left.start > right.start)
}

public func < <T: TagPeriodable>(left: TagPeriod<T>, right: TagPeriod<T>) -> Bool {
    return (left.start < right.start)
}

public func >= <T: TagPeriodable>(left: TagPeriod<T>, right: TagPeriod<T>) -> Bool {
    return (left.start >= right.start)
}

public func <= <T: TagPeriodable>(left: TagPeriod<T>, right: TagPeriod<T>) -> Bool {
    return (left.start <= right.start)
}

public func == <T: TagPeriodable>(left: TagPeriod<T>, right: TagPeriod<T>) -> Bool {
    if left.start != right.start {
        return false
    }

    if left.end != right.end {
        return false
    }

    return true
}

public func != <T: TagPeriodable>(left: TagPeriod<T>, right: TagPeriod<T>) -> Bool {
    return !(left == right)
}

extension TagTime: TagPeriodable {}
extension TagDate: TagPeriodable {}

public typealias TagTimePeriod = TagPeriod<TagTime>
public typealias TagDatePeriod = TagPeriod<TagDate>
