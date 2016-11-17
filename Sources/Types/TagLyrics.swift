//
//  TagLyrics.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 22.07.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
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
