//
//  ID3v2Language.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 07.09.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
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
