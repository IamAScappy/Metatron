//
//  ID3v2Popularimeter.swift
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

public class ID3v2Popularimeter: ID3v2FrameStuff {

    // MARK: Instance Properties

    public var userEmail: String = ""

    public var rating: UInt8 = 0
    public var counter: UInt64 = 0

    // MARK:

    public var isEmpty: Bool {
    	return (self.rating == 0) && (self.counter == 0)
    }

    // MARK: Initializers

    public init() {
    }

    public required init(fromData data: [UInt8], version: ID3v2Version) {
        guard data.count > 5 else {
            return
        }

        guard let userEmail = ID3v2TextEncoding.latin1.decode(data) else {
            return
        }

        guard userEmail.endIndex < data.count - 4 else {
            return
        }

        guard data.count - userEmail.endIndex < 10 else {
            return
        }

        self.userEmail = userEmail.text

        self.rating = data[userEmail.endIndex]

        self.counter = UInt64(data[userEmail.endIndex + 1]) << 56

        self.counter |= UInt64(data[userEmail.endIndex + 2]) << 48
        self.counter |= UInt64(data[userEmail.endIndex + 3]) << 40

        var shift: UInt64 = 32

        for i in (userEmail.endIndex + 4)..<(data.count - 1) {
        	self.counter |= UInt64(data[i]) << shift

        	shift -= 8
        }

        self.counter = (self.counter >> shift) | UInt64(data.last!)
    }

    // MARK: Instance Methods

    public func toData(version: ID3v2Version) -> [UInt8]? {
        guard !self.isEmpty else {
            return nil
        }

        var data = ID3v2TextEncoding.latin1.encode(self.userEmail, termination: true)

        data.append(self.rating)

        var shift: UInt64 = 56

        for i in stride(from: 7, through: 4, by: -1) {
            let byte = UInt8((self.counter >> shift) & 255)

            if byte != 0 {
            	data.append(byte)

            	for _ in stride(from: i - 1, through: 4, by: -1) {
        			shift -= 8

        			data.append(UInt8((self.counter >> shift) & 255))
        		}

        		break
            }

            shift -= 8
        }

        data.append(contentsOf: [UInt8((self.counter >> 24) & 255),
                                 UInt8((self.counter >> 16) & 255),
                                 UInt8((self.counter >> 8) & 255),
                                 UInt8((self.counter) & 255)])

        return data
    }

    public func toData() -> (data: [UInt8], version: ID3v2Version)? {
        guard let data = self.toData(version: ID3v2Version.v4) else {
            return nil
        }

        return (data: data, version: ID3v2Version.v4)
    }
}

public class ID3v2PopularimeterFormat: ID3v2FrameStuffSubclassFormat {

    // MARK: Type Properties

    public static let regular = ID3v2PopularimeterFormat()

    // MARK: Instance Methods

    public func createStuffSubclass(fromData data: [UInt8], version: ID3v2Version) -> ID3v2Popularimeter {
        return ID3v2Popularimeter(fromData: data, version: version)
    }

    public func createStuffSubclass(fromOther other: ID3v2Popularimeter) -> ID3v2Popularimeter {
        let stuff = ID3v2Popularimeter()

        stuff.userEmail = other.userEmail

        stuff.rating = other.rating
        stuff.counter = other.counter

        return stuff
    }

    public func createStuffSubclass() -> ID3v2Popularimeter {
        return ID3v2Popularimeter()
    }
}
