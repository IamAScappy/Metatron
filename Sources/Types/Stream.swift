//
//  Stream.swift
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
