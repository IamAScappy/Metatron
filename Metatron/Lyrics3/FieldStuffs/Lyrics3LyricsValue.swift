//
//  ID3v2LyricsValue.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 27.10.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import Foundation

public extension Lyrics3TextInformation {

    // MARK: Instance Properties

	public var lyricsValue: TagLyrics {
		get {
            let characters = [Character](self.content.characters)

			if characters.count < 7 {
                if !self.content.isEmpty {
                    return TagLyrics(pieces: [TagLyrics.Piece(self.content)])
                } else {
                    return TagLyrics()
                }
			}

			var nextTimeStamp: UInt

            var scanStart: Int
            var textStart: Int

            if let timeStamp = self.timeStampFromCharacters(characters, start: 0) {
            	nextTimeStamp = timeStamp

            	scanStart = 7
				textStart = 7
            } else {
            	nextTimeStamp = 0

            	scanStart = 1
            	textStart = 0
            }

            var pieces: [TagLyrics.Piece] = []

            while let nextStart = characters.suffix(from: scanStart).index(of: "[") {
                if let timeStamp = self.timeStampFromCharacters(characters, start: nextStart) {
                    var textEnd = nextStart

                    if characters[textEnd - 1] == "\n" {
		                textEnd -= 1
		            }

                    if characters[textStart] == " " {
                        textStart += 1
                    }

                    pieces.append(TagLyrics.Piece(String(characters[textStart..<textEnd]), timeStamp: nextTimeStamp))

                    nextTimeStamp = timeStamp

                    scanStart = nextStart + 7
                    textStart = scanStart
                } else {
                	scanStart = nextStart + 1
                }
	        }

            if textStart < characters.count {
            	var textEnd = characters.count

            	if characters[textEnd - 1] == "\n" {
	                textEnd -= 1
	            }

                if characters[textStart] == " " {
                    textStart += 1
                }

                pieces.append(TagLyrics.Piece(String(characters[textStart..<textEnd]), timeStamp: nextTimeStamp))
            } else {
                pieces.append(TagLyrics.Piece("", timeStamp: nextTimeStamp))
            }

            return TagLyrics(pieces: pieces)
		}

		set {
			if (newValue.pieces.count == 1) && (newValue.pieces[0].timeStamp == 0) {
            	self.content = newValue.description
			} else {
				self.content.removeAll()

                for piece in newValue.pieces {
                    let timeStamp = min(piece.timeStamp, 5999000) / 1000

                    self.content.append(String(format: "[%02d:%02d]", timeStamp / 60, timeStamp % 60))
                    self.content.append(piece.text)
                    self.content.append("\n")
                }
			}
		}
	}

	// MARK: Type Methods

	private func timeStampFromCharacters(_ characters: [Character], start: Int) -> UInt? {
        guard characters.count - start >= 7 else {
            return nil
        }

        let colon = start + 3
        let range = start + 6

        guard (characters[start] == "[") && (characters[colon] == ":") && (characters[range] == "]") else {
            return nil
        }

        guard let minutes = Int(String(characters[(start + 1)..<colon])) else {
            return nil
        }

        guard let seconds = Int(String(characters[(start + 4)..<range])) else {
            return nil
        }

        return UInt(minutes * 60 + seconds) * 1000
    }
}
