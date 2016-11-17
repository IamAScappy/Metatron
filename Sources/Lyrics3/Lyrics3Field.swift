//
//  Lyrics3Field.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 22.10.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import Foundation

public class Lyrics3Field {

	// MARK: Instance Properties

	public let identifier: Lyrics3FieldID

	public private(set) var cache: [UInt8]
	public private(set) var stuff: Lyrics3FieldStuff?

    // MARK:

    public var isEmpty: Bool {
        return (self.stuff?.isEmpty ?? self.cache.isEmpty)
    }

    // MARK: Initializers

    init(identifier: Lyrics3FieldID) {
        self.identifier = identifier

        self.cache = []
    }

    init?(fromBodyData bodyData: [UInt8], offset: inout Int, version: Lyrics3Version) {
        assert(offset < bodyData.count, "Invalid data offset")

        let fieldData = [UInt8](bodyData.suffix(from: offset))

        let valueEnd: Int

        switch version {
        case Lyrics3Version.v1:
        	valueEnd = fieldData.count

        	self.identifier = Lyrics3FieldID.lyr

        	self.cache = fieldData

        case Lyrics3Version.v2:
            guard fieldData.count >= 8 else {
                return nil
            }

	        let signature = [UInt8](fieldData.prefix(3))

            guard let identifier = Lyrics3FieldRegistry.regular.identifySignature(signature) else {
                return nil
            }

            guard let valueLength = Int(ID3v1Latin1TextEncoding.regular.decode(fieldData[3..<8]) ?? "") else {
            	return nil
            }

            guard (valueLength >= 0) && (valueLength <= fieldData.count - 8) else {
                return nil
            }

            valueEnd = valueLength + 8

            self.identifier = identifier

            self.cache = [UInt8](fieldData[8..<valueEnd])
		}

		offset += valueEnd
	}

    // MARK: Instance Methods

    func toData(version: Lyrics3Version) -> [UInt8]? {
        let valueData: [UInt8]

        if let stuff = self.stuff {
            guard let data = stuff.toData() else {
                return nil
            }

            valueData = data
        } else {
            valueData = self.cache
        }

        guard !valueData.isEmpty else {
            return nil
        }

        switch version {
        case Lyrics3Version.v1:
            guard self.identifier == Lyrics3FieldID.lyr else {
                return nil
            }

            guard valueData.count <= 5080 else {
                return nil
            }

            return valueData

        case Lyrics3Version.v2:
            guard valueData.count <= 99999 else {
                return nil
            }

            var data = self.identifier.signature

            data.append(contentsOf: ID3v1Latin1TextEncoding.regular.encode(String(format: "%05d", valueData.count)))
            data.append(contentsOf: valueData)

            return data
        }
    }

    // MARK:

    public func stuff<T: Lyrics3FieldStuffSubclassFormat>(format: T) -> T.Stuff {
        if let stuff = self.stuff {
            if stuff is T.Stuff {
                return format.createStuffSubclass(fromOther: stuff as! T.Stuff)
            } else if let data = stuff.toData() {
                return format.createStuffSubclass(fromData: data)
            } else {
                return format.createStuffSubclass()
            }
        } else {
            return format.createStuffSubclass(fromData: self.cache)
        }
    }

    @discardableResult
    public func imposeStuff<T: Lyrics3FieldStuffSubclassFormat>(format: T) -> T.Stuff {
        let newStuff: T.Stuff

        if let stuff = self.stuff {
            if stuff is T.Stuff {
                return stuff as! T.Stuff
            } else if let data = stuff.toData() {
                newStuff = format.createStuffSubclass(fromData: data)
            } else {
                newStuff = format.createStuffSubclass()
            }
        } else {
            newStuff = format.createStuffSubclass(fromData: self.cache)
        }

        self.stuff = newStuff

        return newStuff
    }

    @discardableResult
    public func revokeStuff() -> Lyrics3FieldStuff? {
        if let stuff = self.stuff {
            self.stuff = nil

            return stuff
        }

        return nil
    }

    public func reset() {
        self.cache.removeAll()

        self.stuff = nil
    }
}
