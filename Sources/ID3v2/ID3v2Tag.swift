//
//  ID3v2Tag.swift
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

public class ID3v2Tag {

	// MARK: Instance Properties

    private let header: ID3v2Header

    //MARK:

    public var version: ID3v2Version {
    	get {
            return self.header.version
        }

        set {
            self.header.version = newValue
        }
    }

    public var revision: UInt8 {
    	get {
            return self.header.revision
        }

        set {
            self.header.revision = newValue
        }
    }

    public var experimentalIndicator: Bool {
    	get {
            return self.header.experimentalIndicator
        }

        set {
            self.header.experimentalIndicator = newValue
        }
    }

    public var footerPresent: Bool {
    	get {
            return self.header.footerPresent
        }

        set {
            self.header.footerPresent = newValue
        }
    }

    public var fillingLength: Int

    // MARK:

    private var frameSetKeys: [ID3v2FrameID: Int]

    public private(set) var frameSetList: [ID3v2FrameSet]

    // MARK:

    public var isEmpty: Bool {
        return self.frameSetList.isEmpty
    }

    // MARK: Initializers

    private init?(bodyData: [UInt8], header: ID3v2Header, dataLength: Int) {
        assert(UInt64(bodyData.count) == UInt64(header.bodyLength), "Invalid data")

        self.header = header

        var bodyData = bodyData

        switch self.header.version {
        case ID3v2Version.v2:
            if self.header.unsynchronisation {
                bodyData = ID3v2Unsynchronisation.decode(bodyData)
            }

            if self.header.compression {
                guard let decompressed = ZLib.inflate(bodyData) else {
                    return nil
                }

                bodyData = decompressed
            }

        case ID3v2Version.v3:
            if self.header.unsynchronisation {
                bodyData = ID3v2Unsynchronisation.decode(bodyData)
            }

        case ID3v2Version.v4:
            break
        }

        var offset = 0

        if self.header.extHeaderPresent {
            guard let extHeader = ID3v2ExtHeader(fromData: bodyData, version: self.header.version) else {
                return nil
            }

            guard UInt64(extHeader.ownDataLength) < UInt64(bodyData.count) else {
                return nil
            }

            offset = Int(extHeader.ownDataLength)
        }

        self.fillingLength = 0

        self.frameSetKeys = [:]
        self.frameSetList = []

        var frameSets: [ID3v2FrameID: [ID3v2Frame]] = [:]

        while offset < bodyData.count {
            if let frame = ID3v2Frame(fromBodyData: bodyData, offset: &offset, version: self.header.version) {
                if var frames = frameSets[frame.identifier] {
                    frames.append(frame)

                    frameSets[frame.identifier] = frames
                } else {
                    frameSets[frame.identifier] = [frame]
                }
            } else {
                self.fillingLength = dataLength

                break
            }
        }

        for (identifier, frames) in frameSets {
            self.frameSetKeys.updateValue(self.frameSetList.count, forKey: identifier)
            self.frameSetList.append(ID3v2FrameSet(frames: frames))
        }
    }

    // MARK:

    public init(version: ID3v2Version = ID3v2Version.v4) {
        self.header = ID3v2Header(version: version)

        self.fillingLength = 0

        self.frameSetKeys = [:]
        self.frameSetList = []
    }

    public convenience init?(fromData data: [UInt8]) {
        let stream = MemoryStream(data: data)

        guard stream.openForReading() else {
            return nil
        }

        var range = Range<UInt64>(0..<UInt64(data.count))

        self.init(fromStream: stream, range: &range)
    }

    public convenience init?(fromStream stream: Stream, range: inout Range<UInt64>) {
        assert(stream.isOpen && stream.isReadable && (stream.length >= range.upperBound), "Invalid stream")

        guard range.lowerBound < range.upperBound else {
            return nil
        }

        let anyDataLength = UInt64(ID3v2Header.anyDataLength)
        let maxDataLength = UInt64(range.count)

        guard anyDataLength <= maxDataLength else {
            return nil
        }

        guard stream.seek(offset: range.lowerBound) else {
            return nil
        }

        if let header = ID3v2Header(fromData: stream.read(maxLength: ID3v2Header.anyDataLength)) {
            guard header.position == ID3v2Header.Position.header else {
                return nil
            }

            let dataLength: UInt64

            if header.footerPresent {
                dataLength = anyDataLength * 2 + UInt64(header.bodyLength)
            } else {
                dataLength = anyDataLength + UInt64(header.bodyLength)
            }

            guard (dataLength <= UInt64(Int.max)) && (dataLength <= maxDataLength) else {
                return nil
            }

            guard stream.seek(offset: range.lowerBound + anyDataLength) else {
                return nil
            }

            let bodyData = stream.read(maxLength: Int(header.bodyLength))

            guard bodyData.count == Int(header.bodyLength) else {
                return nil
            }

            self.init(bodyData: bodyData, header: header, dataLength: Int(dataLength))

            range = range.lowerBound..<(range.lowerBound + dataLength)
        } else {
            guard stream.seek(offset: range.upperBound - anyDataLength) else {
                return nil
            }

            guard let header = ID3v2Header(fromData: stream.read(maxLength: ID3v2Header.anyDataLength)) else {
                return nil
            }

            guard header.position == ID3v2Header.Position.footer else {
                return nil
            }

            let dataLength = anyDataLength * 2 + UInt64(header.bodyLength)

            guard (dataLength <= UInt64(Int.max)) && (dataLength <= maxDataLength) else {
                return nil
            }

            guard stream.seek(offset: range.upperBound - dataLength + anyDataLength) else {
                return nil
            }

            let bodyData = stream.read(maxLength: Int(header.bodyLength))

            guard bodyData.count == Int(header.bodyLength) else {
                return nil
            }

            self.init(bodyData: bodyData, header: header, dataLength: Int(dataLength))

            range = (range.upperBound - dataLength)..<range.upperBound
        }
    }

    // MARK: Instance Methods

    public func toData() -> [UInt8]? {
        guard !self.isEmpty else {
            return nil
        }

        self.header.bodyLength = 0

        self.header.unsynchronisation = true
        self.header.compression = false

        self.header.extHeaderPresent = false

        guard self.header.isValid else {
            return nil
        }

        var bodyData: [UInt8] = []

        for frameSet in self.frameSetList {
            for frame in frameSet.frames {
                if !frame.unsynchronisation {
                    self.header.unsynchronisation = false
                }

                if let frameData = frame.toData(version: self.version) {
                    if frameData.count <= ID3v2Header.maxBodyLength - bodyData.count {
                        bodyData.append(contentsOf: frameData)
                    }
                }
            }
        }

        var padding = self.fillingLength - ID3v2Header.anyDataLength - bodyData.count

        switch version {
        case ID3v2Version.v2, ID3v2Version.v3:
            if self.header.unsynchronisation {
                bodyData = ID3v2Unsynchronisation.encode(bodyData)
            }

        case ID3v2Version.v4:
            if self.header.footerPresent {
                padding -= ID3v2Header.anyDataLength
            }
        }

        guard (bodyData.count > 0) && (bodyData.count <= ID3v2Header.maxBodyLength) else {
            return nil
        }

        padding = min(padding, ID3v2Header.maxBodyLength - bodyData.count)

        if padding > 0 {
            bodyData.append(contentsOf: Array<UInt8>(repeating: 0, count: padding))
        }

        guard bodyData.count <= ID3v2Header.maxBodyLength else {
            return nil
        }

        self.header.bodyLength = UInt32(bodyData.count)

        guard let headerData = self.header.toData() else {
            return nil
        }

        return headerData.header + bodyData + headerData.footer
    }

    // MARK:

    @discardableResult
    public func appendFrameSet(_ identifier: ID3v2FrameID) -> ID3v2FrameSet {
        if let index = self.frameSetKeys[identifier] {
            return self.frameSetList[index]
        } else {
            let frameSet = ID3v2FrameSet(identifier: identifier)

            self.frameSetKeys.updateValue(self.frameSetList.count, forKey: identifier)
            self.frameSetList.append(frameSet)

            return frameSet
        }
    }

    @discardableResult
    public func resetFrameSet(_ identifier: ID3v2FrameID) -> ID3v2FrameSet {
        if let index = self.frameSetKeys[identifier] {
            let frameSet = self.frameSetList[index]

            frameSet.reset()

            return frameSet
        } else {
            let frameSet = ID3v2FrameSet(identifier: identifier)

            self.frameSetKeys.updateValue(self.frameSetList.count, forKey: identifier)
            self.frameSetList.append(frameSet)

            return frameSet
        }
    }

    @discardableResult
    public func removeFrameSet(_ identifier: ID3v2FrameID) -> Bool {
        guard let index = self.frameSetKeys.removeValue(forKey: identifier) else {
            return false
        }

        for i in (index + 1)..<self.frameSetList.count {
            self.frameSetKeys.updateValue(i - 1, forKey: self.frameSetList[i].identifier)
        }

        self.frameSetList.remove(at: index)

        return true
    }

    public func revise() {
    	for frameSet in self.frameSetList {
            for frame in frameSet.frames {
                if frame.isEmpty {
                    frameSet.removeFrame(frame)
                }
            }

            if (frameSet.frames.count < 2) && (frameSet.mainFrame.isEmpty) {
                if let index = self.frameSetKeys.removeValue(forKey: frameSet.identifier) {
                    for i in index..<(self.frameSetList.count - 1) {
                        self.frameSetKeys.updateValue(i, forKey: self.frameSetList[i + 1].identifier)
                    }

                    self.frameSetList.remove(at: index)
                }
            }
        }
    }

    public func clear() {
        self.frameSetKeys.removeAll()
        self.frameSetList.removeAll()
    }

    // MARK: Subscripts

    public subscript(identifier: ID3v2FrameID) -> ID3v2FrameSet? {
        guard let index = self.frameSetKeys[identifier] else {
            return nil
        }

        return self.frameSetList[index]
    }
}
