//
//  ID3v2EventTimingCodes.swift
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

public class ID3v2EventTimingCodes: ID3v2FrameStuff {

	// MARK: Nested Types

    public struct EventType: Hashable {

	    // MARK: Type Properties

	    public static let padding = EventType(0)

	    public static let endOfInitialSilence = EventType(1)
	    public static let introStart = EventType(2)
	    public static let mainPartStart = EventType(3)
	    public static let outroStart = EventType(4)
	    public static let outroEnd = EventType(5)
	    public static let verseStart = EventType(6)
	    public static let refrainStart = EventType(7)
	    public static let interludeStart = EventType(8)
	    public static let themeStart = EventType(9)
	    public static let variationStart = EventType(10)
	    public static let keyChange = EventType(11)
	    public static let timeChange = EventType(12)
	    public static let momentaryUnwantedNoise = EventType(13)
	    public static let sustainedNoise = EventType(14)
	    public static let sustainedNoiseEnd = EventType(15)
	    public static let introEnd = EventType(16)
	    public static let mainPartEnd = EventType(17)
	    public static let verseEnd = EventType(18)
	    public static let refrainEnd = EventType(19)
	    public static let themeEnd = EventType(20)
	    public static let profanity = EventType(21)
	    public static let profanityEnd = EventType(22)

	    public static let notPredefinedSynch1 = EventType(224)
	    public static let notPredefinedSynch2 = EventType(225)
	    public static let notPredefinedSynch3 = EventType(226)
	    public static let notPredefinedSynch4 = EventType(227)

	    public static let notPredefinedSynch5 = EventType(228)
	    public static let notPredefinedSynch6 = EventType(229)
	    public static let notPredefinedSynch7 = EventType(230)
	    public static let notPredefinedSynch8 = EventType(231)

	    public static let notPredefinedSynch9 = EventType(232)
	    public static let notPredefinedSynch10 = EventType(233)
	    public static let notPredefinedSynch11 = EventType(234)
	    public static let notPredefinedSynch12 = EventType(235)

	    public static let notPredefinedSynch13 = EventType(236)
	    public static let notPredefinedSynch14 = EventType(237)
	    public static let notPredefinedSynch15 = EventType(238)
	    public static let notPredefinedSynch16 = EventType(239)

	    public static let audioEnd = EventType(253)
	    public static let audioFileEnds = EventType(254)

	    public static let extraUnknown = EventType(255)

	    // MARK: Instance Properties

	    public let value: UInt8

	    // MARK:

	    public var hashValue: Int {
	        return self.value.hashValue
	    }

	    public var isCustom: Bool {
	        if (self.value >= 224) && (self.value <= 239) {
	            return true
	        }

	        return false
	    }

	    public var isReserved: Bool {
	        if (self.value > 22) && (self.value < 224) {
	            return true
	        }

	        if (self.value > 239) && (self.value < 253) {
	            return true
	        }

	        if self.value == 255 {
	        	return true
	        }

	        return false
	    }

	    // MARK: Initializers

	    init(_ value: UInt8) {
	        self.value = value
	    }
	}

	public struct Event: Equatable {

		// MARK: Instance Properties

		public var type: EventType = EventType.padding

		public var timeStamp: UInt32 = 0

		// MARK: Initializers

		init(_ type: EventType, timeStamp: UInt32) {
			self.type = type

			self.timeStamp = timeStamp
		}

		init() {
		}
	}

    // MARK: Instance Properties

    public var timeStampFormat: ID3v2TimeStampFormat = ID3v2TimeStampFormat.absoluteMilliseconds

    public var events: [Event] = []

    // MARK:

    public var isEmpty: Bool {
        return self.events.isEmpty
    }

    // MARK: Initializers

    public init() {
    }

    public required init(fromData data: [UInt8], version: ID3v2Version) {
    	guard data.count > 5 else {
            return
        }

    	guard let timeStampFormat = ID3v2TimeStampFormat(rawValue: data[0]) else {
            return
        }

        var offset = 1

        var events: [Event] = []

        repeat {
        	let type = EventType(data[offset])

        	if data[offset] == 255 {
        		repeat {
        			offset += 1

        			guard offset <= data.count - 5 else {
		        		return
		        	}
        		}
        		while data[offset] == 255
        	}

        	var timeStamp = UInt32(data[offset + 4])

            timeStamp |= UInt32(data[offset + 3]) << 8
            timeStamp |= UInt32(data[offset + 2]) << 16
            timeStamp |= UInt32(data[offset + 1]) << 24

            events.append(Event(type, timeStamp: timeStamp))

            offset += 5
        }
        while offset <= data.count - 5

        guard offset == data.count else {
            return
        }

        self.timeStampFormat = timeStampFormat

        self.events = events
    }

    // MARK: Instance Methods

    public func toData(version: ID3v2Version) -> [UInt8]? {
        guard !self.isEmpty else {
            return nil
        }

        var data = [self.timeStampFormat.rawValue]

        var timeStamp: UInt32 = 0

        for event in self.events {
        	data.append(event.type.value)

        	if event.type.value == 255 {
        		data.append(0)
        	}

        	if timeStamp < event.timeStamp {
        		timeStamp = event.timeStamp
        	}

        	data.append(contentsOf: [UInt8((timeStamp >> 24) & 255),
									 UInt8((timeStamp >> 16) & 255),
									 UInt8((timeStamp >> 8) & 255),
									 UInt8((timeStamp) & 255)])
        }

        return data
    }

    public func toData() -> (data: [UInt8], version: ID3v2Version)? {
        guard let data = self.toData(version: ID3v2Version.v4) else {
            return nil
        }

        return (data: data, version: ID3v2Version.v4)
    }
}

public class ID3v2EventTimingCodesFormat: ID3v2FrameStuffSubclassFormat {

    // MARK: Type Properties

    public static let regular = ID3v2EventTimingCodesFormat()

    // MARK: Instance Methods

    public func createStuffSubclass(fromData data: [UInt8], version: ID3v2Version) -> ID3v2EventTimingCodes {
        return ID3v2EventTimingCodes(fromData: data, version: version)
    }

    public func createStuffSubclass(fromOther other: ID3v2EventTimingCodes) -> ID3v2EventTimingCodes {
        let stuff = ID3v2EventTimingCodes()

        stuff.timeStampFormat = other.timeStampFormat

        stuff.events = other.events

        return stuff
    }

    public func createStuffSubclass() -> ID3v2EventTimingCodes {
        return ID3v2EventTimingCodes()
    }
}

public func == (left: ID3v2EventTimingCodes.EventType, right: ID3v2EventTimingCodes.EventType) -> Bool {
    return (left.value == right.value)
}

public func != (left: ID3v2EventTimingCodes.EventType, right: ID3v2EventTimingCodes.EventType) -> Bool {
    return (left.value != right.value)
}

public func == (left: ID3v2EventTimingCodes.Event, right: ID3v2EventTimingCodes.Event) -> Bool {
    if left.type != right.type {
        return false
    }

    if left.timeStamp != right.timeStamp {
        return false
    }

    return true
}

public func != (left: ID3v2EventTimingCodes.Event, right: ID3v2EventTimingCodes.Event) -> Bool {
    return !(left == right)
}
