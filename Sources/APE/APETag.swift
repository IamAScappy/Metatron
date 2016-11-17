//
//  APETag.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 13.07.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import Foundation

public class APETag {

    // MARK: Instance Properties

    private let header: APEHeader

    // MARK:

    public var version: APEVersion {
        get {
            return self.header.version
        }

        set {
            self.header.version = newValue
        }
    }

    public var headerPresent: Bool {
        get {
            return self.header.headerPresent
        }

        set {
            self.header.headerPresent = newValue
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

    private var itemKeys: [String: Int]

    public private(set) var itemList: [APEItem]

    // MARK:

    public var isEmpty: Bool {
        return self.itemList.isEmpty
    }

    // MARK: Initializers

    private init?(bodyData: [UInt8], header: APEHeader, dataLength: Int) {
        assert(UInt64(bodyData.count) == UInt64(header.bodyLength), "Invalid data")

        self.header = header

        self.fillingLength = 0

        self.itemKeys = [:]
        self.itemList = []

        var offset = 0

        for _ in 0..<self.header.itemCount {
            if let item = APEItem(fromBodyData: bodyData, offset: &offset, version: self.header.version) {
                let key = item.identifier.lowercased()

                if key == "dummy" {
                    self.fillingLength = dataLength
                } else if let index = self.itemKeys[key] {
                    self.itemList[index] = item
                } else {
                    self.itemKeys.updateValue(self.itemList.count, forKey: key)
                    self.itemList.append(item)
                }

                if offset >= bodyData.count {
                    break
                }
            } else {
                self.fillingLength = dataLength

                break
            }
        }
    }

    // MARK:

    public init(version: APEVersion = APEVersion.v2) {
        self.header = APEHeader(version: version)

        self.fillingLength = 0

        self.itemKeys = [:]
        self.itemList = []
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

        let anyDataLength = UInt64(APEHeader.anyDataLength)
        let maxDataLength = UInt64(range.count)

        guard anyDataLength <= maxDataLength else {
            return nil
        }

        guard stream.seek(offset: range.upperBound - anyDataLength) else {
            return nil
        }

        if let header = APEHeader(fromData: stream.read(maxLength: APEHeader.anyDataLength)) {
            guard header.position == APEHeader.Position.footer else {
                return nil
            }

            let dataLength: UInt64
            let bodyStart: UInt64

            if header.headerPresent {
                dataLength = anyDataLength * 2 + UInt64(header.bodyLength)
                bodyStart = anyDataLength
            } else {
                dataLength = anyDataLength + UInt64(header.bodyLength)
                bodyStart = 0
            }

            guard (dataLength <= UInt64(Int.max)) && (dataLength <= maxDataLength) else {
                return nil
            }

            guard stream.seek(offset: range.upperBound - dataLength + bodyStart) else {
                return nil
            }

            let bodyData = stream.read(maxLength: Int(header.bodyLength))

            guard bodyData.count == Int(header.bodyLength) else {
                return nil
            }

            self.init(bodyData: bodyData, header: header, dataLength: Int(dataLength))

            range = (range.upperBound - dataLength)..<range.upperBound
        } else {
            guard stream.seek(offset: range.lowerBound) else {
                return nil
            }

            guard let header = APEHeader(fromData: stream.read(maxLength: APEHeader.anyDataLength)) else {
                return nil
            }

            guard header.position == APEHeader.Position.header else {
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
        }
    }

    // MARK: Instance Methods

    public func toData() -> [UInt8]? {
        guard !self.isEmpty else {
            return nil
        }

        self.header.bodyLength = 0
        self.header.itemCount = 0

        guard self.header.isValid else {
            return nil
        }

        var bodyData: [UInt8] = []

        var itemCount = 0

        for item in self.itemList {
            if let itemData = item.toData(version: self.version) {
                if itemData.count <= APEHeader.maxBodyLength - bodyData.count {
                    bodyData.append(contentsOf: itemData)

                    itemCount += 1
                }
            }
        }

        guard (itemCount > 0) && (bodyData.count > 0) else {
            return nil
        }

        var padding = self.fillingLength - APEHeader.anyDataLength - bodyData.count

        switch version {
        case APEVersion.v1:
            break

        case APEVersion.v2:
            if self.header.headerPresent && self.header.footerPresent {
                padding -= APEHeader.anyDataLength
            }
        }

        padding = min(padding, APEHeader.maxBodyLength - bodyData.count)

        if padding > 0 {
            if padding > 14 {
                if let item = APEItem(identifier: "Dummy") {
                    item.value = Array<UInt8>(repeating: 0, count: padding - 14)

                    if let itemData = item.toData(version: self.version) {
                        if itemData.count <= APEHeader.maxBodyLength - bodyData.count {
                            bodyData.append(contentsOf: itemData)

                            itemCount += 1
                        }
                    }
                }
            } else {
                bodyData.append(contentsOf: Array<UInt8>(repeating: 0, count: padding))
            }
        }

        self.header.bodyLength = UInt32(bodyData.count)
        self.header.itemCount = UInt32(itemCount)

        guard let headerData = self.header.toData() else {
            return nil
        }

        return headerData.header + bodyData + headerData.footer
    }

    // MARK:

    @discardableResult
    public func appendItem(_ identifier: String) -> APEItem? {
        let key = identifier.lowercased()

        if let index = self.itemKeys[key] {
            return self.itemList[index]
        } else {
            guard key != "dummy" else {
                return nil
            }

            guard let item = APEItem(identifier: identifier) else {
                return nil
            }

            self.itemKeys.updateValue(self.itemList.count, forKey: key)
            self.itemList.append(item)

            return item
        }
    }

    @discardableResult
    public func resetItem(_ identifier: String) -> APEItem? {
        let key = identifier.lowercased()

        if let index = self.itemKeys[key] {
            let item = self.itemList[index]

            item.reset()

            return item
        } else {
            guard key != "dummy" else {
                return nil
            }

            guard let item = APEItem(identifier: identifier) else {
                return nil
            }

            self.itemKeys.updateValue(self.itemList.count, forKey: key)
            self.itemList.append(item)

            return item
        }
    }

    @discardableResult
    public func removeItem(_ identifier: String) -> Bool {
        guard let index = self.itemKeys.removeValue(forKey: identifier.lowercased()) else {
            return false
        }

        for i in (index + 1)..<self.itemList.count {
            self.itemKeys.updateValue(i - 1, forKey: self.itemList[i].identifier.lowercased())
        }

        self.itemList.remove(at: index)

        return true
    }

    public func revise() {
        for item in self.itemList {
            if (!item.isValid) || item.isEmpty {
                if let index = self.itemKeys.removeValue(forKey: item.identifier.lowercased()) {
                    for i in index..<(self.itemList.count - 1) {
                        self.itemKeys.updateValue(i, forKey: self.itemList[i + 1].identifier.lowercased())
                    }

                    self.itemList.remove(at: index)
                }
            }
        }
    }

    public func clear() {
        self.itemKeys.removeAll()
        self.itemList.removeAll()
    }

    // MARK: Subscripts

    public subscript(identifier: String) -> APEItem? {
        let key = identifier.lowercased()

        guard let index = self.itemKeys[key] else {
            return nil
        }

        return self.itemList[index]
    }
}
