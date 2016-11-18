//
//  Lyrics3FieldID.swift
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

public class Lyrics3FieldID: Hashable {

    // MARK: Type Properties

    public static let ind = Lyrics3FieldID(nativeID: "IND", signature: [73, 78, 68])

    public static let lyr = Lyrics3FieldID(nativeID: "LYR", signature: [76, 89, 82])
    public static let inf = Lyrics3FieldID(nativeID: "INF", signature: [73, 78, 70])
    public static let aut = Lyrics3FieldID(nativeID: "AUT", signature: [65, 85, 84])

    public static let eal = Lyrics3FieldID(nativeID: "EAL", signature: [69, 65, 76])
    public static let ear = Lyrics3FieldID(nativeID: "EAR", signature: [69, 65, 82])
    public static let ett = Lyrics3FieldID(nativeID: "ETT", signature: [69, 84, 84])

    public static let img = Lyrics3FieldID(nativeID: "IMG", signature: [73, 77, 71])

    // MARK: Instance Properties

    public let type: Lyrics3FieldType
    public let name: String

    public let signature: [UInt8]

    // MARK:

    public var hashValue: Int {
        return Int(self.signature[0]) | Int(self.signature[1]) << 8 | Int(self.signature[2]) << 16
    }

    // MARK: Initializers

    private init(type: Lyrics3FieldType, name: String, signature: [UInt8]) {
        assert((!name.isEmpty) && (!signature.isEmpty), "Invalid name or signature")

        self.type = type
        self.name = name

        self.signature = signature
    }

    private convenience init(nativeID name: String, signature: [UInt8]) {
        self.init(type: Lyrics3FieldType.native, name: name, signature: signature)
    }

    convenience init?(customID name: String, signature: [UInt8]) {
        guard (!name.isEmpty) && (!signature.isEmpty) else {
            return nil
        }

		guard Lyrics3FieldID.checkSignature(signature) else {
            return nil
        }

        self.init(type: Lyrics3FieldType.custom, name: name, signature: signature)
    }

    // MARK: Type Methods

    public static func checkSignature(_ signature: [UInt8]) -> Bool {
        if signature.count != 3 {
            return false
        }

        for byte in signature {
            if (byte < 65) || (byte > 90) {
                if (byte < 48) || (byte > 57) {
                    return false
                }
            }
        }

        return true
    }
}

extension Lyrics3FieldID: CustomStringConvertible {

    // MARK: Instance Properties

    public var description: String {
        switch self.type {
        case Lyrics3FieldType.native:
            return self.name

        case Lyrics3FieldType.custom:
            return "Custom: " + self.name
        }
    }
}

public func == (left: Lyrics3FieldID, right: Lyrics3FieldID) -> Bool {
    if left === right {
        return true
    }

    if left.signature != right.signature {
        return false
    }

    return true
}

public func != (left: Lyrics3FieldID, right: Lyrics3FieldID) -> Bool {
    return !(left == right)
}
