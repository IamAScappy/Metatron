//
//  ID3v2Language.swift
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

public struct ID3v2Language: Hashable {

	// MARK: Type Properties

    public static let und = ID3v2Language(name: "Undetermined", code: [117, 110, 100])

    public static let mis = ID3v2Language(name: "Uncoded", code: [109, 105, 115])
    public static let mul = ID3v2Language(name: "Multiple", code: [109, 117, 108])

    public static let eng = ID3v2Language(name: "English", code: [101, 110, 103])
    public static let deu = ID3v2Language(name: "German", code: [100, 101, 117])
    public static let fra = ID3v2Language(name: "French", code: [102, 114, 97])
    public static let ita = ID3v2Language(name: "Italian", code: [105, 116, 97])
    public static let rus = ID3v2Language(name: "Russian", code: [114, 117, 115])
    public static let tat = ID3v2Language(name: "Tatar", code: [116, 97, 116])

	// MARK: Instance Properties

	public let name: String
	public let code: [UInt8]

    // MARK:

	public var hashValue: Int {
        return Int(self.code[0]) | Int(self.code[1]) << 8 | Int(self.code[2]) << 16
    }

    // MARK: Initializers

    private init(name: String, code: [UInt8]) {
    	assert((!name.isEmpty) && (code.count == 3), "Invalid name or code")

        assert((code[0] >= 97) && (code[0] <= 122), "Invalid code")
        assert((code[1] >= 97) && (code[1] <= 122), "Invalid code")
        assert((code[2] >= 97) && (code[2] <= 122), "Invalid code")

        self.name = name
        self.code = code
    }

    public init?(code: [UInt8]) {
    	guard (code.count == 3) else {
            return nil
        }

        var lowerCode: [UInt8] = []

        for byte in code {
            if (byte >= 97) && (byte <= 122) {
                lowerCode.append(byte)
            } else if (byte >= 65) && (byte <= 90) {
                lowerCode.append(byte + 32)
            } else {
	            return nil
	        }
        }

        guard let name = String(bytes: lowerCode, encoding: String.Encoding.isoLatin1) else {
            return nil
        }

        self.init(name: name, code: lowerCode)
    }
}

public func == (left: ID3v2Language, right: ID3v2Language) -> Bool {
    return (left.code == right.code)
}

public func != (left: ID3v2Language, right: ID3v2Language) -> Bool {
    return (left.code != right.code)
}
