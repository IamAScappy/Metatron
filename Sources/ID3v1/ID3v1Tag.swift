//
//  ID3v1Tag.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 21.07.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import Foundation

public class ID3v1Tag {

	// MARK: Type Properties

	public static var textEncoding: ID3v1TextEncoding = ID3v1Latin1TextEncoding.regular

	// MARK:

    static let baseDataMarker: [UInt8] = [84, 65, 71]
    static let extDataMarker: [UInt8] = [84, 65, 71, 43]

    static let baseDataLength: Int = 128
    static let extDataLength: Int = 355

	// MARK: Instance Properties

    public var version: ID3v1Version

    // MARK:

    public var title: String
    public var artist: String

    public var album: String
    public var genre: String

    public var releaseDate: TagDate

	public var trackNumber: TagNumber

	public var comment: String

	public var velocity: UInt
	public var startTime: UInt
	public var endTime: UInt

    // MARK:

    public var isEmpty: Bool {
    	if !self.title.isEmpty {
			return false
		}

		if !self.artist.isEmpty {
			return false
		}

		if !self.album.isEmpty {
			return false
		}

		if !self.genre.isEmpty {
			return false
		}

		if (self.releaseDate.year > 0) && (self.releaseDate.year < 10000) {
			return false
		}

		if (self.trackNumber.value > 0) && (self.trackNumber.value < 256) {
			return false
		}

		if !self.comment.isEmpty {
			return false
		}

		if (self.velocity > 0) && (self.velocity < 256) {
			return false
		}

		if (self.startTime > 0) && (self.startTime < 60000) {
			return false
		}

		if (self.endTime > 0) && (self.endTime < 60000) {
			return false
		}

		return true
    }

    // MARK: Initializers

    public init(version: ID3v1Version = ID3v1Version.v1) {
        self.version = version

        self.title = ""
		self.artist = ""

		self.album = ""
		self.genre = ""

		self.releaseDate = TagDate()

		self.trackNumber = TagNumber()

		self.comment = ""

		self.velocity = 0
		self.startTime = 0
		self.endTime = 0
    }

    public init?(fromData data: [UInt8]) {
        guard data.count >= ID3v1Tag.baseDataLength else {
        	return nil
        }

        let baseData = data.suffix(ID3v1Tag.baseDataLength)

    	guard baseData.starts(with: ID3v1Tag.baseDataMarker) else {
            return nil
        }

        var valueStart = baseData.startIndex + 3
		var valueEnd = baseData.startIndex + 33

		let titleTerminator = baseData[valueStart..<valueEnd].index(of: 0)

        self.title = ID3v1Tag.textEncoding.decode(baseData[valueStart..<(titleTerminator ?? valueEnd)]) ?? ""

        valueStart = valueEnd
		valueEnd = valueStart + 30

		let artistTerminator = baseData[valueStart..<valueEnd].index(of: 0)

        self.artist = ID3v1Tag.textEncoding.decode(baseData[valueStart..<(artistTerminator ?? valueEnd)]) ?? ""

        valueStart = valueEnd
		valueEnd = valueStart + 30

		let albumTerminator = baseData[valueStart..<valueEnd].index(of: 0)

        self.album = ID3v1Tag.textEncoding.decode(baseData[valueStart..<(albumTerminator ?? valueEnd)]) ?? ""

        valueStart = valueEnd
		valueEnd = valueStart + 4

		if let terminator = baseData[valueStart..<valueEnd].index(of: 0) {
	        if let releaseYear = ID3v1Tag.textEncoding.decode(baseData[valueStart..<terminator]) {
	            self.releaseDate = TagDate(year: Int(releaseYear) ?? 0)
	        } else {
	            self.releaseDate = TagDate()
	        }
	    } else {
	    	if let releaseYear = ID3v1Tag.textEncoding.decode(baseData[valueStart..<valueEnd]) {
	            self.releaseDate = TagDate(year: Int(releaseYear) ?? 0)
	        } else {
	            self.releaseDate = TagDate()
	        }
	    }

	    valueStart = valueEnd
		valueEnd = valueStart + 30

	    if let terminator = baseData[valueStart..<valueEnd].index(of: 0) {
            self.comment = ID3v1Tag.textEncoding.decode(baseData[valueStart..<terminator]) ?? ""

	    	if baseData[valueEnd - 2] == 0 {
                self.version = ID3v1Version.v1

                self.trackNumber = TagNumber(Int(baseData[valueEnd - 1]))
            } else {
                self.version = ID3v1Version.v0

                self.trackNumber = TagNumber()
            }
	    } else {
            self.version = ID3v1Version.v0

            self.comment = ID3v1Tag.textEncoding.decode(baseData[valueStart..<valueEnd]) ?? ""

            self.trackNumber = TagNumber()
	    }

        let genreIndex = Int(baseData[valueEnd])

	    if (genreIndex >= 0) && (genreIndex < ID3v1GenreList.count) {
            self.genre = ID3v1GenreList[genreIndex]
	    } else {
	    	self.genre = ""
	    }

	    self.velocity = 0
    	self.startTime = 0
    	self.endTime = 0

        if data.count >= ID3v1Tag.extDataLength {
	    	let extData = data.suffix(ID3v1Tag.extDataLength)

            if extData.starts(with: ID3v1Tag.extDataMarker) {
                switch self.version {
                case ID3v1Version.v0:
                    self.version = ID3v1Version.vExt0

                case ID3v1Version.v1:
                    self.version = ID3v1Version.vExt1

                case ID3v1Version.vExt0, ID3v1Version.vExt1:
                    break
                }

                valueStart = extData.startIndex + 4
                valueEnd = extData.startIndex + 64

	        	if (titleTerminator == nil) && (extData[valueStart] != 0) {
		    		let terminator = extData[valueStart..<valueEnd].index(of: 0) ?? valueEnd

		    		if let title = ID3v1Tag.textEncoding.decode(extData[valueStart..<terminator]) {
		    			self.title.append(title)
		    		}
		    	}

                valueStart = valueEnd
                valueEnd = valueStart + 60

		    	if (artistTerminator == nil) && (extData[valueStart] != 0) {
		    		let terminator = extData[valueStart..<valueEnd].index(of: 0) ?? valueEnd

		    		if let artist = ID3v1Tag.textEncoding.decode(extData[valueStart..<terminator]) {
		    			self.artist.append(artist)
		    		}
		    	}

                valueStart = valueEnd
                valueEnd = valueStart + 60

		    	if (albumTerminator == nil) && (extData[valueStart] != 0) {
		    		let terminator = extData[valueStart..<valueEnd].index(of: 0) ?? valueEnd

		    		if let album = ID3v1Tag.textEncoding.decode(extData[valueStart..<terminator]) {
		    			self.album.append(album)
		    		}
		    	}

                self.velocity = UInt(extData[valueEnd])

                valueStart = valueEnd + 1
                valueEnd = valueStart + 30

		    	if self.genre.isEmpty && (extData[valueStart] != 0) {
		    		let terminator = extData[valueStart..<valueEnd].index(of: 0) ?? valueEnd

		    		if let genre = ID3v1Tag.textEncoding.decode(extData[valueStart..<terminator]) {
		    			self.genre = genre
		    		}
				}

				valueStart = valueEnd
                valueEnd = valueStart + 3

                if (extData[valueStart] != 0) && (extData[valueStart] != 0) && (extData[valueEnd] == 58) {
                	if let minute = ID3v1Tag.textEncoding.decode(extData[valueStart..<valueEnd]) {
	        			if let second = ID3v1Tag.textEncoding.decode(extData[(valueEnd + 1)..<(valueEnd + 3)]) {
	        				self.startTime = (UInt(minute) ?? 0) * 60 + (UInt(second) ?? 0)
		    			}
		    		}
		    	}

		    	valueStart = valueEnd + 3
                valueEnd = valueStart + 3

                if (extData[valueStart] != 0) && (extData[valueStart] != 0) && (extData[valueEnd] == 58) {
                	if let minute = ID3v1Tag.textEncoding.decode(extData[valueStart..<valueEnd]) {
	        			if let second = ID3v1Tag.textEncoding.decode(extData[(valueEnd + 1)..<(valueEnd + 3)]) {
	        				self.endTime = (UInt(minute) ?? 0) * 60 + (UInt(second) ?? 0)
                        }
		    		}
		    	}
	        }
	    }
    }

    public convenience init?(fromStream stream: Stream, range: inout Range<UInt64>) {
        assert(stream.isOpen && stream.isReadable && (stream.length >= range.upperBound), "Invalid stream")

        guard range.lowerBound < range.upperBound else {
            return nil
        }

        let baseDataLength = UInt64(ID3v1Tag.baseDataLength)
        let extDataLength = UInt64(ID3v1Tag.extDataLength)

        let maxDataLength = UInt64(range.count)

        if extDataLength <= maxDataLength {
            guard stream.seek(offset: range.upperBound - extDataLength) else {
                return nil
            }

            self.init(fromData: stream.read(maxLength: ID3v1Tag.extDataLength))
        } else {
        	guard baseDataLength <= maxDataLength else {
                return nil
            }

            guard stream.seek(offset: range.upperBound - baseDataLength) else {
                return nil
            }

            self.init(fromData: stream.read(maxLength: ID3v1Tag.baseDataLength))
        }

        switch self.version {
        case ID3v1Version.v0, ID3v1Version.v1:
            range = (range.upperBound - baseDataLength)..<range.upperBound

        case ID3v1Version.vExt0, ID3v1Version.vExt1:
            range = (range.upperBound - extDataLength)..<range.upperBound
        }
    }

    // MARK: Instance Methods

    public func toData() -> [UInt8]? {
    	var baseData = ID3v1Tag.baseDataMarker
        var extData = ID3v1Tag.extDataMarker

        var extVersion: Bool

        switch self.version {
        case ID3v1Version.v0:
            extVersion = false

        case ID3v1Version.v1:
            extVersion = false

        case ID3v1Version.vExt0:
            extVersion = true

        case ID3v1Version.vExt1:
            extVersion = true
        }

    	if !self.title.isEmpty {
	    	let itemData = ID3v1Tag.textEncoding.encode(self.title)

		    if !itemData.isEmpty {
	            baseData.append(contentsOf: itemData.prefix(30))

	            if extVersion && itemData.count > 30 {
	                extData.append(contentsOf: itemData.suffix(from: 30).prefix(60))
	            }
	        }
		}

		if !self.artist.isEmpty {
	        let itemData = ID3v1Tag.textEncoding.encode(self.artist)

	        if !itemData.isEmpty {
	            if baseData.count < 33 {
	                baseData.append(contentsOf: Array<UInt8>(repeating: 0, count: 33 - baseData.count))
	            }

	            baseData.append(contentsOf: itemData.prefix(30))

	            if extVersion && (itemData.count > 30) {
	                if extData.count < 64 {
	                    extData.append(contentsOf: Array<UInt8>(repeating: 0, count: 64 - extData.count))
	                }

	                extData.append(contentsOf: itemData.suffix(from: 30).prefix(60))
	            }
	        }
		}

		if !self.album.isEmpty {
			let itemData = ID3v1Tag.textEncoding.encode(self.album)

	        if !itemData.isEmpty {
	            if baseData.count < 63 {
	                baseData.append(contentsOf: Array<UInt8>(repeating: 0, count: 63 - baseData.count))
	            }

	            baseData.append(contentsOf: itemData.prefix(30))

	            if extVersion && itemData.count > 30 {
	                if extData.count < 124 {
	                    extData.append(contentsOf: Array<UInt8>(repeating: 0, count: 124 - extData.count))
	                }

	                extData.append(contentsOf: itemData.suffix(from: 30).prefix(60))
	            }
	        }
	    }

        if (self.releaseDate.year > 0) && (self.releaseDate.year < 10000) {
            let itemData = ID3v1Tag.textEncoding.encode(String(self.releaseDate.year))

            if (!itemData.isEmpty) && (itemData.count < 5) {
                if baseData.count < 93 {
                    baseData.append(contentsOf: Array<UInt8>(repeating: 0, count: 93 - baseData.count))
                }

                baseData.append(contentsOf: itemData)
            }
        }

        if !self.comment.isEmpty {
        	let itemData = ID3v1Tag.textEncoding.encode(self.comment)

            if !itemData.isEmpty {
                if baseData.count < 97 {
                    baseData.append(contentsOf: Array<UInt8>(repeating: 0, count: 97 - baseData.count))
                }

                switch self.version {
                case ID3v1Version.v0, ID3v1Version.vExt0:
                    baseData.append(contentsOf: itemData.prefix(30))

                case ID3v1Version.v1, ID3v1Version.vExt1:
                    baseData.append(contentsOf: itemData.prefix(28))
                }
            }
        }

        switch self.version {
        case ID3v1Version.v0, ID3v1Version.vExt0:
        	break

        case ID3v1Version.v1, ID3v1Version.vExt1:
            if (self.trackNumber.value > 0) && (self.trackNumber.value < 256) {
                if baseData.count < 126 {
                    baseData.append(contentsOf: Array<UInt8>(repeating: 0, count: 126 - baseData.count))
                }

                baseData.append(UInt8(self.trackNumber.value))
            }
        }

		if extVersion && (self.velocity > 0) && (self.velocity < 256) {
			if extData.count < 184 {
                extData.append(contentsOf: Array<UInt8>(repeating: 0, count: 184 - extData.count))
            }

            extData.append(UInt8(self.velocity))
		}

		if !self.genre.isEmpty {
			if baseData.count < 127 {
                baseData.append(contentsOf: Array<UInt8>(repeating: 0, count: 127 - baseData.count))
            }

            if let genreIndex = ID3v1GenreList.index(of: self.genre) {
				baseData.append(UInt8(genreIndex))
			} else if extVersion {
				let itemData = ID3v1Tag.textEncoding.encode(self.genre)

		    	if !itemData.isEmpty {
					baseData.append(255)

					if extData.count < 185 {
		                extData.append(contentsOf: Array<UInt8>(repeating: 0, count: 185 - extData.count))
		            }

					extData.append(contentsOf: itemData.prefix(30))
				}
			}
		}

		if extVersion {
			if (self.startTime > 0) && (self.startTime < 60000) {
				if extData.count < 215 {
	                extData.append(contentsOf: Array<UInt8>(repeating: 0, count: 215 - extData.count))
	            }

	            let minuteData = ID3v1Tag.textEncoding.encode(String(format: "%03d:", self.startTime / 60))
	            let secondData = ID3v1Tag.textEncoding.encode(String(format: "%02d", self.startTime % 60))

	            if (minuteData.count == 4) && (secondData.count == 2) {
	            	extData.append(contentsOf: minuteData)
	            	extData.append(contentsOf: secondData)
	            }
			}

			if (self.endTime > 0) && (self.endTime < 60000) {
				if extData.count < 221 {
	            	extData.append(contentsOf: Array<UInt8>(repeating: 0, count: 221 - extData.count))
	            }

	            let minuteData = ID3v1Tag.textEncoding.encode(String(format: "%03d:", self.endTime / 60))
	            let secondData = ID3v1Tag.textEncoding.encode(String(format: "%02d", self.endTime % 60))

	            if (minuteData.count == 4) && (secondData.count == 2) {
	            	extData.append(contentsOf: minuteData)
	            	extData.append(contentsOf: secondData)
	            }
			}
		}

		if extData.count > 4 {
			if(extData.count < 227) {
				extData.append(contentsOf: Array<UInt8>(repeating: 0, count: 227 - extData.count))
			}

			extData.append(contentsOf: baseData)

			if extData.count < 355 {
				if extData.count < 354 {
	                extData.append(contentsOf: Array<UInt8>(repeating: 0, count: 354 - extData.count))
	            }

				extData.append(255)
			}

			return extData
		}

		if baseData.count > 3 {
			if baseData.count < 128 {
				if baseData.count < 127 {
					baseData.append(contentsOf: Array<UInt8>(repeating: 0, count: 127 - baseData.count))
				}

				baseData.append(255)
			}

			return baseData
		}

		return nil
    }

    // MARK:

    public func clear() {
    	self.title.removeAll()
		self.artist.removeAll()

		self.album.removeAll()
		self.genre.removeAll()

		self.releaseDate.reset()

		self.trackNumber.reset()

		self.comment.removeAll()

		self.velocity = 0
		self.startTime = 0
		self.endTime = 0
    }
}
