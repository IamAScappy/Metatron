//
//  ID3v1TextEncoding.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 28.07.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
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
