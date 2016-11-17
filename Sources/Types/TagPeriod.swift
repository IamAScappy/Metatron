//
//  TagPeriod.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 22.07.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
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
