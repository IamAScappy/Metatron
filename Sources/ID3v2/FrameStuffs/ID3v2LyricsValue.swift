//
//  ID3v2LyricsValue.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 11.10.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
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
