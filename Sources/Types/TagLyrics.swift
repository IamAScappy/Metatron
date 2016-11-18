//
//  TagLyrics.swift
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

public struct TagLyrics: Equatable, CustomStringConvertible {

    // MARK: Nested Types

    public struct Piece: Equatable {
    	// MARK: Instance Properties

    	public var text: String

    	public var timeStamp: UInt

        // MARK:

    	public var isEmpty: Bool {
        	return self.text.isEmpty
        }

        // MARK: Initializers

        public init(_ text: String, timeStamp: UInt = 0) {
        	self.text = text

        	self.timeStamp = timeStamp
        }

        public init() {
            self.init("")
        }
    }

    // MARK: Instance Properties

    public var pieces: [Piece]

    // MARK:

    public var description: String {
        guard !self.isEmpty else {
            return ""
        }

        var description: String = self.pieces[0].text

        for i in 1..<self.pieces.count {
            description.append("\n")

            description.append(self.pieces[i].text)
        }

        return description
    }

    // MARK:

    public var isEmpty: Bool {
        return self.pieces.isEmpty
    }

    public var revised: TagLyrics {
        var pieces: [Piece] = []

        var timeStamp: UInt = 0

        for piece in self.pieces {
            if timeStamp < piece.timeStamp {
                timeStamp = piece.timeStamp
            }

            if !piece.isEmpty {
                pieces.append(Piece(piece.text, timeStamp: timeStamp))
            }
        }

        return TagLyrics(pieces: pieces)
    }

    // MARK: Initializers

    public init(pieces: [Piece]) {
        self.pieces = pieces
    }

    public init() {
        self.pieces = []
    }

    // MARK: Instance Methods

    public mutating func reset() {
        self.pieces.removeAll()
    }
}

public func == (left: TagLyrics.Piece, right: TagLyrics.Piece) -> Bool {
    if left.text != right.text {
        return false
    }

    if left.timeStamp != right.timeStamp {
    	return false
    }

    return true
}

public func != (left: TagLyrics.Piece, right: TagLyrics.Piece) -> Bool {
    return !(left == right)
}

public func == (left: TagLyrics, right: TagLyrics) -> Bool {
    if left.pieces.count != right.pieces.count {
        return false
    }

    for i in 0..<left.pieces.count {
        if left.pieces[i] != right.pieces[i] {
            return false
        }
    }

    return true
}

public func != (left: TagLyrics, right: TagLyrics) -> Bool {
    return !(left == right)
}
