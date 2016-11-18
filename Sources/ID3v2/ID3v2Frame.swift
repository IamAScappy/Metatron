//
//  ID3v2Frame.swift
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

public class ID3v2Frame: Hashable {

    // MARK: Instance Properties

    private let header: ID3v2FrameHeader
    private let cache: ID3v2FrameCache

    public private(set) var stuff: ID3v2FrameStuff?

    //MARK:

	public var identifier: ID3v2FrameID {
		return self.header.identifier
	}

	public var tagAlterPreservation: Bool {
		get {
			return self.header.tagAlterPreservation
		}

		set {
			self.header.tagAlterPreservation = newValue
		}
	}

	public var fileAlterPreservation: Bool {
		get {
			return self.header.fileAlterPreservation
		}

		set {
			self.header.fileAlterPreservation = newValue
		}
	}

	public var readOnly: Bool {
		get {
			return self.header.readOnly
		}

		set {
			self.header.readOnly = newValue
		}
	}

	public var unsynchronisation: Bool {
		get {
			return self.header.unsynchronisation
		}

		set {
			self.header.unsynchronisation = newValue
		}
	}

	public var dataLengthIndicator: Bool {
		get {
			return self.header.dataLengthIndicator
		}

		set {
			self.header.dataLengthIndicator = newValue
		}
	}

    public var compression: Int {
        get {
            return self.cache.compression
        }

        set {
            if self.cache.encryption == nil {
                let decompressed = self.cache.value

                self.cache.compression = newValue

                self.cache.value = decompressed
            } else {
                self.cache.compression = newValue
            }
        }
    }

    public var encryption: UInt8? {
        if self.stuff == nil {
            return self.cache.encryption
        } else {
            return nil
        }
    }

    public var group: UInt8? {
        get {
            return self.cache.group
        }

        set {
            self.cache.group = newValue
        }
    }

    // MARK:

    public var hashValue: Int {
        return ObjectIdentifier(self).hashValue
    }

    public var isEmpty: Bool {
        return (self.stuff?.isEmpty ?? self.cache.isEmpty)
    }

    // MARK: Initializers

    init(identifier: ID3v2FrameID) {
        self.header = ID3v2FrameHeader(identifier: identifier)
        self.cache = ID3v2FrameCache(version: ID3v2Version.v4)
    }

    init?(fromBodyData bodyData: [UInt8], offset: inout Int, version: ID3v2Version) {
        assert(offset < bodyData.count, "Invalid data offset")

        let frameData = [UInt8](bodyData.suffix(from: offset))

        guard let header = ID3v2FrameHeader(fromData: frameData, version: version) else {
        	return nil
        }

        guard UInt64(header.valueLength) <= UInt64(frameData.count) else {
            return nil
        }

        self.header = header

        let valueStart: Int

        switch version {
        case ID3v2Version.v2:
            guard Int(self.header.valueLength) <= frameData.count - 6 else {
                return nil
            }

            valueStart = 6

        case ID3v2Version.v3, ID3v2Version.v4:
            guard Int(self.header.valueLength) <= frameData.count - 10 else {
                return nil
            }

            valueStart = 10
        }

        let valueEnd = valueStart + Int(self.header.valueLength)

        let valueData = [UInt8](frameData[valueStart..<valueEnd])

        guard let cache = ID3v2FrameCache(fromData: valueData, version: version, header: self.header) else {
            return nil
        }

        self.cache = cache

        offset += valueEnd
    }

    // MARK: Instance Methods

    func toData(version: ID3v2Version) -> [UInt8]? {
        let cache: ID3v2FrameCache

        if let stuff = self.stuff {
            guard let data = stuff.toData(version: version) else {
                return nil
            }

            cache = ID3v2FrameCache(version: version, dataBuffer: data)
        } else if self.cache.version != version {
            guard self.cache.encryption == nil else {
                return nil
            }

            let stuff: ID3v2FrameStuff

            if let format = ID3v2FrameRegistry.regular.stuffs[self.identifier] {
                stuff = format.createStuff(fromData: self.cache.value, version: self.cache.version)
            } else {
                stuff = ID3v2UnknownValue(fromData: self.cache.value, version: self.cache.version)
            }

            guard let data = stuff.toData(version: version) else {
                return nil
            }

            cache = ID3v2FrameCache(version: version, dataBuffer: data)
        } else {
            cache = self.cache
        }

        if cache !== self.cache {
            if cache.encryption == nil {
                let decompressed = cache.value

                cache.compression = self.cache.compression

                cache.value = decompressed
            } else {
                cache.compression = self.cache.compression
            }

            cache.group = self.cache.group
        }

        guard let valueData = cache.toData(header: self.header) else {
            return nil
        }

        guard let headerData = self.header.toData(version: version) else {
            return nil
        }

        return headerData + valueData
    }

    // MARK:

    public func stuff<T: ID3v2FrameStuffSubclassFormat>(format: T) -> T.Stuff {
        if let stuff = self.stuff {
            if stuff is T.Stuff {
                return format.createStuffSubclass(fromOther: stuff as! T.Stuff)
            } else if let (data, version) = stuff.toData() {
                return format.createStuffSubclass(fromData: data, version: version)
            } else {
                return format.createStuffSubclass()
            }
        } else if self.cache.encryption == nil {
            return format.createStuffSubclass(fromData: self.cache.value, version: self.cache.version)
        } else {
            return format.createStuffSubclass()
        }
    }

    @discardableResult
    public func imposeStuff<T: ID3v2FrameStuffSubclassFormat>(format: T) -> T.Stuff {
        let newStuff: T.Stuff

        if let stuff = self.stuff {
            if stuff is T.Stuff {
                return stuff as! T.Stuff
            } else if let (data, version) = stuff.toData() {
                newStuff = format.createStuffSubclass(fromData: data, version: version)
            } else {
                newStuff = format.createStuffSubclass()
            }
        } else if self.cache.encryption == nil {
            newStuff = format.createStuffSubclass(fromData: self.cache.value, version: self.cache.version)
        } else {
            newStuff = format.createStuffSubclass()
        }

        self.stuff = newStuff

        return newStuff
    }

    @discardableResult
    public func revokeStuff() -> ID3v2FrameStuff? {
        if let stuff = self.stuff {
            self.stuff = nil

            return stuff
        }

        return nil
    }

    public func reset() {
        self.header.reset()
        self.cache.reset()

        self.stuff = nil
    }
}

public func == (left: ID3v2Frame, right: ID3v2Frame) -> Bool {
    return (left === right)
}

public func != (left: ID3v2Frame, right: ID3v2Frame) -> Bool {
    return (left !== right)
}
