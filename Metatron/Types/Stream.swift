//
//  Stream.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 02.11.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import Foundation

public protocol Stream: class {

	// MARK: Instance Properties

    var isReadable: Bool {get}
    var isWritable: Bool {get}

    var isOpen: Bool {get}

	// MARK:

    var offset: UInt64 {get}
    var length: UInt64 {get}

	// MARK: Instance Methods

	@discardableResult
    func openForReading() -> Bool

    @discardableResult
    func openForUpdating(truncate: Bool) -> Bool

    @discardableResult
    func openForWriting(truncate: Bool) -> Bool

    func synchronize()
	func close()

	@discardableResult
	func seek(offset: UInt64) -> Bool

	func read(maxLength: Int) -> [UInt8]

	@discardableResult
	func write(data: [UInt8]) -> Int

    @discardableResult
	func truncate(length: UInt64) -> Bool

    @discardableResult
    func insert(data: [UInt8]) -> Bool

	@discardableResult
	func remove(length: UInt64) -> Bool
}
