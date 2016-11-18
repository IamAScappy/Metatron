//
//  Lyrics3TextInformation.swift
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

public class Lyrics3TextInformation: Lyrics3FieldStuff {

    // MARK: Instance Properties

    public var content: String = ""

    // MARK:

    public var isEmpty: Bool {
    	return self.content.isEmpty
    }

    // MARK: Initializers

    public init() {
    }

    public required init(fromData data: [UInt8]) {
        guard !data.isEmpty else {
            return
        }

        var revised: [UInt8] = []

        for i in 0..<(data.count - 1) {
            if data[i] == 0 {
                break
            }

            if (data[i] != 13) || (data[i + 1] != 10) {
                revised.append(data[i])
            }
        }

        if data.last! != 0 {
            revised.append(data.last!)
        }

        guard let content = ID3v1Latin1TextEncoding.regular.decode(revised) else {
            return
        }

    	self.content = content
    }

    // MARK: Instance Methods

    public func toData() -> [UInt8]? {
        guard !self.isEmpty else {
            return nil
        }

        let revised = ID3v1Latin1TextEncoding.regular.encode(self.content)

        guard !revised.isEmpty else {
            return nil
        }

        var data: [UInt8]

        if revised[0] != 10 {
            data = [revised[0]]
        } else {
            data = [13, 10]
        }

        for i in 1..<revised.count {
            if revised[i] != 10 {
                data.append(revised[i])
            } else {
                if data.last! != 13 {
                    data.append(13)
                }

                data.append(10)
            }
        }

        return data
    }
}

public class Lyrics3TextInformationFormat: Lyrics3FieldStuffSubclassFormat {

    // MARK: Type Properties

    public static let regular = Lyrics3TextInformationFormat()

    // MARK: Instance Methods

    public func createStuffSubclass(fromData data: [UInt8]) -> Lyrics3TextInformation {
        return Lyrics3TextInformation(fromData: data)
    }

    public func createStuffSubclass(fromOther other: Lyrics3TextInformation) -> Lyrics3TextInformation {
        let stuff = Lyrics3TextInformation()

        stuff.content = other.content

        return stuff
    }

    public func createStuffSubclass() -> Lyrics3TextInformation {
        return Lyrics3TextInformation()
    }
}
