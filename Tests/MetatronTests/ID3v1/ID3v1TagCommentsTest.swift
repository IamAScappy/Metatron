//
//  ID3v1TagCommentsTest.swift
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

import XCTest

@testable import Metatron

class ID3v1TagCommentsTest: XCTestCase {

    // MARK: Instance Methods

    func test() {
        let textEncoding = ID3v1Latin1TextEncoding.regular

        let tag = ID3v1Tag()

        do {
            let value: [String] = []

            tag.comments = value

            XCTAssert(tag.comments == [])
            XCTAssert(tag.comment == value.joined(separator: "\n"))

            do {
                tag.version = ID3v1Version.v0

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = ID3v1Version.v1

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = ID3v1Version.vExt0

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = ID3v1Version.vExt1

                XCTAssert(tag.toData() == nil)
            }
        }

        do {
            let value = [""]

            tag.comments = value

            XCTAssert(tag.comments == [])
            XCTAssert(tag.comment == value.joined(separator: "\n"))

            do {
                tag.version = ID3v1Version.v0

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = ID3v1Version.v1

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = ID3v1Version.vExt0

                XCTAssert(tag.toData() == nil)
            }

            do {
                tag.version = ID3v1Version.vExt1

                XCTAssert(tag.toData() == nil)
            }
        }

        do {
            let value = ["Abc 123"]

            let joined = value.joined(separator: "\n")

            tag.comments = value

            XCTAssert(tag.comments == [joined])
            XCTAssert(tag.comment == joined)

            do {
                tag.version = ID3v1Version.v0

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comment == joined.deencoded(with: textEncoding).prefix(30))
            }

            do {
                tag.version = ID3v1Version.v1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comment == joined.deencoded(with: textEncoding).prefix(28))
            }

            do {
                tag.version = ID3v1Version.vExt0

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comment == joined.deencoded(with: textEncoding).prefix(30))
            }

            do {
                tag.version = ID3v1Version.vExt1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comment == joined.deencoded(with: textEncoding).prefix(28))
            }
        }

        do {
            let value = ["Абв 123"]

            let joined = value.joined(separator: "\n")

            tag.comments = value

            XCTAssert(tag.comments == [joined])
            XCTAssert(tag.comment == joined)

            do {
                tag.version = ID3v1Version.v0

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comment == joined.deencoded(with: textEncoding).prefix(30))
            }

            do {
                tag.version = ID3v1Version.v1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comment == joined.deencoded(with: textEncoding).prefix(28))
            }

            do {
                tag.version = ID3v1Version.vExt0

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comment == joined.deencoded(with: textEncoding).prefix(30))
            }

            do {
                tag.version = ID3v1Version.vExt1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comment == joined.deencoded(with: textEncoding).prefix(28))
            }
        }

        do {
            let value = ["Abc 1", "Abc 2"]

            let joined = value.joined(separator: "\n")

            tag.comments = value

            XCTAssert(tag.comments == [joined])
            XCTAssert(tag.comment == joined)

            do {
                tag.version = ID3v1Version.v0

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comment == joined.deencoded(with: textEncoding).prefix(30))
            }

            do {
                tag.version = ID3v1Version.v1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comment == joined.deencoded(with: textEncoding).prefix(28))
            }

            do {
                tag.version = ID3v1Version.vExt0

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comment == joined.deencoded(with: textEncoding).prefix(30))
            }

            do {
                tag.version = ID3v1Version.vExt1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comment == joined.deencoded(with: textEncoding).prefix(28))
            }
        }

        do {
            let value = ["", "Abc 2"]

            let joined = value.joined(separator: "\n")

            tag.comments = value

            XCTAssert(tag.comments == [joined])
            XCTAssert(tag.comment == joined)

            do {
                tag.version = ID3v1Version.v0

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comment == joined.deencoded(with: textEncoding).prefix(30))
            }

            do {
                tag.version = ID3v1Version.v1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comment == joined.deencoded(with: textEncoding).prefix(28))
            }

            do {
                tag.version = ID3v1Version.vExt0

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comment == joined.deencoded(with: textEncoding).prefix(30))
            }

            do {
                tag.version = ID3v1Version.vExt1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comment == joined.deencoded(with: textEncoding).prefix(28))
            }
        }

        do {
            let value = ["Abc 1", ""]

            let joined = value.joined(separator: "\n")

            tag.comments = value

            XCTAssert(tag.comments == [joined])
            XCTAssert(tag.comment == joined)

            do {
                tag.version = ID3v1Version.v0

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comment == joined.deencoded(with: textEncoding).prefix(30))
            }

            do {
                tag.version = ID3v1Version.v1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comment == joined.deencoded(with: textEncoding).prefix(28))
            }

            do {
                tag.version = ID3v1Version.vExt0

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comment == joined.deencoded(with: textEncoding).prefix(30))
            }

            do {
                tag.version = ID3v1Version.vExt1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comment == joined.deencoded(with: textEncoding).prefix(28))
            }
        }

        do {
            let value: [String] = ["", ""]

            let joined = value.joined(separator: "\n")

            tag.comments = value

            XCTAssert(tag.comments == [joined])
            XCTAssert(tag.comment == joined)

            do {
                tag.version = ID3v1Version.v0

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comment == joined.deencoded(with: textEncoding).prefix(30))
            }

            do {
                tag.version = ID3v1Version.v1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comment == joined.deencoded(with: textEncoding).prefix(28))
            }

            do {
                tag.version = ID3v1Version.vExt0

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comment == joined.deencoded(with: textEncoding).prefix(30))
            }

            do {
                tag.version = ID3v1Version.vExt1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comment == joined.deencoded(with: textEncoding).prefix(28))
            }
        }

        do {
            let value = [Array<String>(repeating: "Abc", count: 123).joined(separator: "\n")]

            let joined = value.joined(separator: "\n")

            tag.comments = value

            XCTAssert(tag.comments == [joined])
            XCTAssert(tag.comment == joined)

            do {
                tag.version = ID3v1Version.v0

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comment == joined.deencoded(with: textEncoding).prefix(30))
            }

            do {
                tag.version = ID3v1Version.v1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comment == joined.deencoded(with: textEncoding).prefix(28))
            }

            do {
                tag.version = ID3v1Version.vExt0

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comment == joined.deencoded(with: textEncoding).prefix(30))
            }

            do {
                tag.version = ID3v1Version.vExt1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comment == joined.deencoded(with: textEncoding).prefix(28))
            }
        }

        do {
            let value = Array<String>(repeating: "Abc", count: 123)

            let joined = value.joined(separator: "\n")

            tag.comments = value

            XCTAssert(tag.comments == [joined])
            XCTAssert(tag.comment == joined)

            do {
                tag.version = ID3v1Version.v0

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comment == joined.deencoded(with: textEncoding).prefix(30))
            }

            do {
                tag.version = ID3v1Version.v1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comment == joined.deencoded(with: textEncoding).prefix(28))
            }

            do {
                tag.version = ID3v1Version.vExt0

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comment == joined.deencoded(with: textEncoding).prefix(30))
            }

            do {
                tag.version = ID3v1Version.vExt1

                guard let data = tag.toData() else {
                    return XCTFail()
                }

                guard let other = ID3v1Tag(fromData: data) else {
                    return XCTFail()
                }

                XCTAssert(other.comment == joined.deencoded(with: textEncoding).prefix(28))
            }
        }

        do {
            tag.comment = ""

            XCTAssert(tag.comments == [])
        }

        do {
            tag.comment = "Abc 1, Abc 2"

            XCTAssert(tag.comments == ["Abc 1, Abc 2"])
        }
    }
}
