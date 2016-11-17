//
//  MemoryStream.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 03.11.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import Foundation

public class MemoryStream: Stream {

    // MARK: Instance Properties

    public private(set) var data: [UInt8]

    // MARK:

    public private(set) var isReadable: Bool
    public private(set) var isWritable: Bool

    public var isOpen: Bool {
        return (self.isReadable || self.isWritable)
    }

    // MARK:

    public private(set) var offset: UInt64

    public var length: UInt64 {
        return UInt64(data.count)
    }

    // MARK: Initializers

    public init(data: [UInt8] = []) {
        self.data = data

        self.isReadable = false
        self.isWritable = false

        self.offset = 0
    }

    // MARK: Instance Methods

    @discardableResult
    public func openForReading() -> Bool {
        guard !self.isOpen else {
            return false
        }

        self.isReadable = true
        self.isWritable = false

        self.offset = 0

        return true
    }

    @discardableResult
    public func openForUpdating(truncate: Bool) -> Bool {
        guard !self.isOpen else {
            return false
        }

        if truncate {
            self.data.removeAll()
        }

        self.isReadable = true
        self.isWritable = true

        self.offset = 0

        return true
    }

    @discardableResult
    public func openForWriting(truncate: Bool) -> Bool {
        guard !self.isOpen else {
            return false
        }

        if truncate {
            self.data.removeAll()
        }

        self.isReadable = false
        self.isWritable = true

        self.offset = 0

        return true
    }

    public func synchronize() {
    }

    public func close() {
        self.isReadable = false
        self.isWritable = false

        self.offset = 0
    }

    // MARK:

	@discardableResult
    public func seek(offset: UInt64) -> Bool {
    	guard self.isOpen else {
    		return false
    	}

    	guard offset <= self.length else {
    		return false
    	}

    	self.offset = offset

    	return true
    }

    public func read(maxLength: Int) -> [UInt8] {
        guard self.isReadable && (maxLength > 0) else {
            return []
        }

        let data = [UInt8](self.data.suffix(from: Int(self.offset)).prefix(maxLength))

        self.offset += UInt64(data.count)

        return data
    }

    @discardableResult
    public func write(data: [UInt8]) -> Int {
    	guard self.isWritable && (data.count > 0) else {
    		return 0
    	}

        let offset = Int(self.offset)
        let margin = self.data.count - offset

    	if margin < data.count {
            let dataLength = min(Int.max - offset, data.count)

    		for i in 0..<margin {
                self.data[offset + i] = data[i]
            }

            for i in margin..<dataLength {
                self.data.append(data[i])
            }

            self.offset = UInt64(self.data.count)

            return dataLength
    	} else {
            for i in 0..<data.count {
                self.data[offset + i] = data[i]
            }

            self.offset += UInt64(data.count)

            return data.count
        }
    }

    @discardableResult
    public func truncate(length: UInt64) -> Bool {
        guard self.isWritable else {
            return false
        }

        guard length < self.length else {
            return false
        }

        if self.offset > length {
            self.offset = length
        }

        self.data = [UInt8](self.data.prefix(Int(length)))

        return true
    }

    @discardableResult
    public func insert(data: [UInt8]) -> Bool {
        guard self.isReadable && self.isWritable else {
            return false
        }

        guard Int.max - self.data.count >= data.count else {
            return false
        }

        guard data.count > 0 else {
            return true
        }

        self.data.insert(contentsOf: data, at: Int(self.offset))

        self.offset += UInt64(data.count)

        return true
    }

    @discardableResult
    public func remove(length: UInt64) -> Bool {
        guard self.isReadable && self.isWritable && (length <= self.length - self.offset) else {
            return false
        }

        guard length > 0 else {
            return true
        }

        self.data.removeSubrange(Int(self.offset)..<Int(self.offset + length))

        return true
    }
}
