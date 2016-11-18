//
//  ID3v2ContentType.swift
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

public class ID3v2ContentType: ID3v2BaseTextInformation {

    // MARK: Instance Methods

    public override func deserialize(fields: [String], version: ID3v2Version) -> [String] {
        var genres: [String] = []

        for field in fields {
            let characters = [Character](field.characters)

            if (characters.count >= 2) && (characters[0] == "(") {
                if let separator = characters.suffix(from: 1).index(of: ")") {
                    var nextGenre: String

                    if characters[1] == "(" {
                        nextGenre = String(characters[1...separator])
                    } else {
                        nextGenre = String(characters[1..<separator])

                        if let genreIndex = Int(nextGenre) {
                            if (genreIndex >= 0) && (genreIndex < ID3v1GenreList.count) {
                                nextGenre = ID3v1GenreList[genreIndex]
                            }
                        }
                    }

                    genres.append(nextGenre)

                    var scanStart = separator + 1
                    var textStart = scanStart

                    while let nextStart = characters.suffix(from: scanStart).index(of: "(") {
                        scanStart = nextStart + 1

                        if let separator = characters.suffix(from: scanStart).index(of: ")") {
                            if textStart < nextStart {
                                genres.append(String(characters[textStart..<nextStart]))
                            }

                            if characters[scanStart] == "(" {
                                nextGenre = String(characters[scanStart...separator])
                            } else {
                                nextGenre = String(characters[scanStart..<separator])

                                if let genreIndex = Int(nextGenre) {
                                    if (genreIndex >= 0) && (genreIndex < ID3v1GenreList.count) {
                                        nextGenre = ID3v1GenreList[genreIndex]
                                    }
                                }
                            }

                            genres.append(nextGenre)

                            scanStart = separator + 1
                            textStart = scanStart
                        } else {
                            break
                        }
                    }

                    if textStart < characters.count {
                        genres.append(String(characters.suffix(from: textStart)))
                    }
                } else {
                    var genre = field

                    if let genreIndex = Int(genre) {
                        if (genreIndex >= 0) && (genreIndex < ID3v1GenreList.count) {
                            genre = ID3v1GenreList[genreIndex]
                        }
                    }

                    genres.append(genre)
                }
            } else {
                var genre = field

                if let genreIndex = Int(genre) {
                    if (genreIndex >= 0) && (genreIndex < ID3v1GenreList.count) {
                        genre = ID3v1GenreList[genreIndex]
                    }
                }

                genres.append(genre)
            }
        }

        return genres
    }

    public override func serialize(fields: [String], version: ID3v2Version) -> [String] {
        guard !fields.isEmpty else {
            return []
        }

        switch version {
        case ID3v2Version.v2, ID3v2Version.v3:
            var genres = ""

            for field in fields {
                let components = field.components(separatedBy: "(")

                if !components[0].isEmpty {
                    if let genreIndex = ID3v1GenreList.index(of: components[0]) {
                        genres.append("(\(genreIndex))")
                    } else {
                        genres.append("(\(components[0]))")
                    }
                } else if components.count == 1 {
                    genres.append("()")
                }

                for i in 1..<components.count {
                    genres.append("((\(components[i])")
                }
            }

            return [genres]

        case ID3v2Version.v4:
            var genres: [String] = []

            for field in fields {
                if field.hasPrefix("(") {
                    genres.append("(\(field)")
                } else {
                    genres.append(field)
                }
            }

            return genres
        }
    }
}

public class ID3v2ContentTypeFormat: ID3v2FrameStuffSubclassFormat {

    // MARK: Type Properties

    public static let regular = ID3v2ContentTypeFormat()

    // MARK: Instance Methods

    public func createStuffSubclass(fromData data: [UInt8], version: ID3v2Version) -> ID3v2ContentType {
        return ID3v2ContentType(fromData: data, version: version)
    }

    public func createStuffSubclass(fromOther other: ID3v2ContentType) -> ID3v2ContentType {
        let stuff = ID3v2ContentType()

        stuff.textEncoding = other.textEncoding

        stuff.fields = other.fields

        return stuff
    }

    public func createStuffSubclass() -> ID3v2ContentType {
        return ID3v2ContentType()
    }
}
