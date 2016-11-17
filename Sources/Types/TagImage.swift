//
//  TagImage.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 14.09.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
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
