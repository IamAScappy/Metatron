//
//  ID3v2TextEncoding.swift
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

public enum ID3v2TextEncoding {
    case latin1
	case utf16
    case utf16LE
	case utf16BE
	case utf8

    // MARK: Instance Properties

    var rawValue: UInt8 {
        switch self {
        case .latin1:
            return 0

        case .utf16, .utf16LE:
            return 1

        case .utf16BE:
            return 2

        case .utf8:
            return 3
        }
    }

    // MARK: Initializers

    public init?(rawValue: UInt8) {
        switch rawValue {
        case 0:
            self = .latin1

        case 1:
            self = .utf16

        case 2:
            self = .utf16BE

        case 3:
            self = .utf8

        default:
            return nil
        }
    }

    // MARK: Instance Methods

    public func decode(_ data: [UInt8]) -> (text: String, endIndex: Int, terminated: Bool)? {
        guard !data.isEmpty else {
            return (text: "", endIndex: 0, terminated: false)
        }

        switch self {
        case .latin1:
            if let terminator = data.index(of: 0) {
                guard let text = String(bytes: data.prefix(terminator), encoding: String.Encoding.isoLatin1) else {
                    return nil
                }

                return (text: text, endIndex: terminator + 1, terminated: true)
            } else {
                guard let text = String(bytes: data, encoding: String.Encoding.isoLatin1) else {
                    return nil
                }

                return (text: text, endIndex: data.count, terminated: false)
            }

        case .utf16, .utf16LE, .utf16BE:
            guard data.count > 1 else {
                return nil
            }

            let stringEncoding: String.Encoding

            if self == ID3v2TextEncoding.utf16 {
                stringEncoding = String.Encoding.utf16
            } else if (data[0] == 255) && (data[1] == 254) {
                stringEncoding = String.Encoding.utf16
            } else if (data[0] == 254) && (data[1] == 255) {
                stringEncoding = String.Encoding.utf16
            } else if self == ID3v2TextEncoding.utf16LE {
                stringEncoding = String.Encoding.utf16LittleEndian
            } else if self == ID3v2TextEncoding.utf16BE {
                stringEncoding = String.Encoding.utf16BigEndian
            } else {
                stringEncoding = String.Encoding.utf16
            }

            var endIndex = 0

            while let terminator = data[endIndex..<(data.count - 1)].index(of: 0) {
                if terminator & 1 == 0 {
                    endIndex = terminator + 2

                    if data[endIndex - 1] == 0 {
                        guard let text = String(bytes: data.prefix(terminator), encoding: stringEncoding) else {
                            return nil
                        }

                        return (text: text, endIndex: endIndex, terminated: true)
                    }

                    if endIndex >= data.count - 1 {
                        break
                    }
                } else {
                    endIndex = terminator + 1
                }
            }

            guard let text = String(bytes: data, encoding: stringEncoding) else {
                return nil
            }

            return (text: text, endIndex: data.count, terminated: false)

        case .utf8:
            if let terminator = data.index(of: 0) {
                guard let text = String(bytes: data.prefix(terminator), encoding: String.Encoding.utf8) else {
                    return nil
                }

                return (text: text, endIndex: terminator + 1, terminated: true)
            } else {
                guard let text = String(bytes: data, encoding: String.Encoding.utf8) else {
                    return nil
                }

                return (text: text, endIndex: data.count, terminated: false)
            }
        }
    }

    public func encode(_ string: String, termination: Bool) -> [UInt8] {
        var data: [UInt8] = []

        switch self {
        case .latin1:
            if !string.isEmpty {
                data.append(contentsOf: ID3v1Latin1TextEncoding().encode(string))
            }

        case .utf16, .utf16BE:
            if self == ID3v2TextEncoding.utf16 {
                data.append(contentsOf: [254, 255])
            }

            if !string.isEmpty {
                let unicode = string.utf16

                for code in unicode {
                    data.append(contentsOf: [UInt8((code >> 8) & 255), UInt8(code & 255)])
                }
            }

            if termination {
                data.append(0)
            }

        case .utf16LE:
            data.append(contentsOf: [255, 254])

            if !string.isEmpty {
                let unicode = string.utf16

                for code in unicode {
                    data.append(contentsOf: [UInt8(code & 255), UInt8((code >> 8) & 255)])
                }
            }

            if termination {
                data.append(0)
            }

        case .utf8:
            if !string.isEmpty {
                data.append(contentsOf: string.utf8)
            }
        }

        if termination {
            data.append(0)
        }

        return data
    }
}
