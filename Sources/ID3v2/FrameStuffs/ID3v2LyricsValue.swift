//
//  ID3v2LyricsValue.swift
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

public extension ID3v2SyncedLyrics {

    // MARK: Instance Properties

	public var lyricsValue: TagLyrics {
		get {
			var pieces: [TagLyrics.Piece] = []

            if self.timeStampFormat == ID3v2TimeStampFormat.absoluteMilliseconds {
                for syllable in self.syllables {
                    pieces.append(TagLyrics.Piece(syllable.text, timeStamp: UInt(syllable.timeStamp)))
                }
            } else {
                for syllable in self.syllables {
                    pieces.append(TagLyrics.Piece(syllable.text))
                }
            }

			return TagLyrics(pieces: pieces)
		}

        set {
            self.syllables.removeAll()

            for piece in newValue.pieces {
            	let timeStamp = UInt32(min(UInt64(piece.timeStamp), UInt64(UInt32.max)))

            	self.syllables.append(Syllable(piece.text, timeStamp: timeStamp))
            }

            self.timeStampFormat = ID3v2TimeStampFormat.absoluteMilliseconds
        }
	}
}

public extension ID3v2UnsyncedLyrics {

    // MARK: Instance Properties

    public var lyricsValue: TagLyrics {
        get {
            if !self.content.isEmpty {
                return TagLyrics(pieces: [TagLyrics.Piece(self.content)])
            }

            return TagLyrics()
        }

        set {
            self.content = newValue.description
        }
    }
}
