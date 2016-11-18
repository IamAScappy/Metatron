//
//  ID3v1TextEncoding.swift
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

public protocol ID3v1TextEncoding {

    // MARK: Instance Methods

    func decode<T : Sequence>(_: T) -> String? where T.Iterator.Element == UInt8

    func encode(_: String) -> [UInt8]
}

public class ID3v1Latin1TextEncoding: ID3v1TextEncoding {

    // MARK: Type Properties

    public static let regular = ID3v1Latin1TextEncoding()

    // MARK: Instance Methods

    public func decode<T : Sequence>(_ data: T) -> String? where T.Iterator.Element == UInt8 {
        return String(bytes: data, encoding: String.Encoding.isoLatin1)
    }

    public func encode(_ string: String) -> [UInt8] {
        let source = string.utf8
        var target: [UInt8] = []

        var offset = 0

        while offset < source.count {
            let firstByte = source[source.index(source.startIndex, offsetBy: offset)]

            if firstByte == 0 {
                break
            }

            var length: UInt32

            if firstByte < 128 {
                length = 1
            } else if (firstByte & 32) == 0 {
                length = 2
            } else if (firstByte & 16) == 0 {
                length = 3
            } else if (firstByte & 8) == 0 {
                length = 4
            } else if (firstByte & 4) == 0 {
                length = 5
            } else {
                length = 6
            }

            if offset > source.count - Int(length) {
                break
            } else if length == 1 {
                target.append(firstByte)
            } else {
                var code = (UInt32(firstByte) & (255 >> (length + 1))) << ((length - 1) * 6)

                while length > 1 {
                    offset += 1
                    length -= 1

                    code |= (UInt32(source[source.index(source.startIndex, offsetBy: offset)]) & 127) << ((length - 1) * 6)
                }

                target.append(UInt8(code & 255))
            }

            offset += 1
        }

        return target
    }
}
