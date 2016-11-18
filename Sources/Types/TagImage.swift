//
//  TagImage.swift
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

public struct TagImage: Equatable {

	// MARK: Instance Properties

    public var data: [UInt8]

    public var mainMimeType: String
    public var description: String

    // MARK:

    public var mimeType: String {
        if !self.mainMimeType.isEmpty {
            return self.mainMimeType
        } else if !self.data.isEmpty {
            switch self.data[0] {
            case 0xFF:
                return "image/jpeg"

            case 0x89:
                return "image/png"

            case 0x47:
                return "image/gif"

            case 0x49, 0x4D:
                return "image/tiff"

            default:
                return "application/octet-stream"
            }
        } else {
            return "application/octet-stream"
        }
    }

    public var isEmpty: Bool {
    	return self.data.isEmpty
    }

    // MARK: Initializers

    public init(data: [UInt8], mainMimeType: String = "", description: String = "") {
        self.data = data

        self.mainMimeType = mainMimeType
        self.description = description
    }

    public init() {
        self.init(data: [])
    }

    // MARK: Instance Methods

    public mutating func reset() {
        self.data.removeAll()

        self.mainMimeType.removeAll()
        self.description.removeAll()
    }
}

public func == (left: TagImage, right: TagImage) -> Bool {
    if left.data != right.data {
        return false
    }

    if left.mimeType != right.mimeType {
        return false
    }

    if left.description != right.description {
        return false
    }

    return true
}

public func != (left: TagImage, right: TagImage) -> Bool {
    return !(left == right)
}
