//
//  Lyrics3Tag.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 20.10.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import Foundation

fileprivate func ~=<T: Equatable> (left: [T], right: [T]) -> Bool {
    return (left == right)
}

public class Lyrics3Tag {

	// MARK: Type Properties

	static let dataMarker: [UInt8] = [76, 89, 82, 73, 67, 83, 66, 69, 71, 73, 78]

	static let dataSignatureV1: [UInt8] = [76, 89, 82, 73, 67, 83, 69, 78, 68]
    static let dataSignatureV2: [UInt8] = [76, 89, 82, 73, 67, 83, 50, 48, 48]

    static let maxSignatureLength: Int = 15

    static let maxDataLengthV1: Int = 5100
    static let maxDataLengthV2: Int = 1000014

    static let minDataLength: Int = 20

	// MARK: Instance Properties

    public var version: Lyrics3Version

    // MARK:

    private var fieldKeys: [Lyrics3FieldID: Int]

    public private(set) var fieldList: [Lyrics3Field]

    // MARK:

    public var isEmpty: Bool {
    	return self.fieldList.isEmpty
    }

    // MARK: Initializers

    private init?(bodyData: [UInt8], version: Lyrics3Version) {
        assert(bodyData.starts(with: Lyrics3Tag.dataMarker), "Invalid data")

        self.version = version

        self.fieldKeys = [:]
        self.fieldList = []

        var offset = Lyrics3Tag.dataMarker.count

        while offset < bodyData.count {
            if let field = Lyrics3Field(fromBodyData: bodyData, offset: &offset, version: self.version) {
                if let index = self.fieldKeys[field.identifier] {
                    self.fieldList[index] = field
                } else {
                    self.fieldKeys.updateValue(self.fieldList.count, forKey: field.identifier)
                    self.fieldList.append(field)
                }
            } else {
                break
            }
        }
    }

    // MARK:

    public init(version: Lyrics3Version = Lyrics3Version.v2) {
        self.version = version

        self.fieldKeys = [:]
        self.fieldList = []
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

        let minDataLength = UInt64(Lyrics3Tag.minDataLength)
        let maxDataLength = UInt64(range.count)

        guard minDataLength <= maxDataLength else {
            return nil
        }

        guard stream.seek(offset: range.upperBound - UInt64(Lyrics3Tag.maxSignatureLength)) else {
            return nil
        }

        let signature = stream.read(maxLength: Lyrics3Tag.maxSignatureLength)

        guard signature.count == Lyrics3Tag.maxSignatureLength else {
            return nil
        }

        switch [UInt8](signature.suffix(Lyrics3Tag.dataSignatureV1.count)) {
        case Lyrics3Tag.dataSignatureV1:
            let dataLength = min(maxDataLength, UInt64(Lyrics3Tag.maxDataLengthV1))
            let dataStart = range.upperBound - dataLength

            guard stream.seek(offset: dataStart) else {
                return nil
            }

            let data = stream.read(maxLength: Int(dataLength))

            guard data.count == Int(dataLength) else {
                return nil
            }

            let bodyEnd = data.count - Lyrics3Tag.dataSignatureV1.count

            guard let bodyStart = data.lastOccurrence(of: Lyrics3Tag.dataMarker) else {
                return nil
            }

            self.init(bodyData: [UInt8](data[bodyStart..<bodyEnd]), version: Lyrics3Version.v1)

            range = (dataStart + UInt64(bodyStart))..<range.upperBound

        case Lyrics3Tag.dataSignatureV2:
            guard let bodyLength = Int(ID3v1Latin1TextEncoding.regular.decode(signature.prefix(6)) ?? "") else {
                return nil
            }

            let dataLength = UInt64(bodyLength + Lyrics3Tag.maxSignatureLength)

            guard dataLength <= maxDataLength else {
                return nil
            }

            guard stream.seek(offset: range.upperBound - dataLength) else {
                return nil
            }

            let bodyData = stream.read(maxLength: bodyLength)

            guard bodyData.count == bodyLength else {
                return nil
            }

            guard bodyData.starts(with: Lyrics3Tag.dataMarker) else {
                return nil
            }

            self.init(bodyData: bodyData, version: Lyrics3Version.v2)

            range = (range.upperBound - dataLength)..<range.upperBound

        default:
            return nil
        }
    }

    // MARK: Instance Methods

    public func toData() -> [UInt8]? {
        guard !self.isEmpty else {
            return nil
        }

        var data = Lyrics3Tag.dataMarker

        switch self.version {
        case Lyrics3Version.v1:
            let maxBodyLength = Lyrics3Tag.maxDataLengthV1 - Lyrics3Tag.dataSignatureV1.count

            for field in self.fieldList {
                if let fieldData = field.toData(version: self.version) {
                    if fieldData.count <= maxBodyLength - data.count {
                        data.append(contentsOf: fieldData)
                    }
                }
            }

            guard data.count > Lyrics3Tag.dataMarker.count else {
                return nil
            }

            data.append(contentsOf: Lyrics3Tag.dataSignatureV1)

        case Lyrics3Version.v2:
            let maxBodyLength = Lyrics3Tag.maxDataLengthV2 - Lyrics3Tag.maxSignatureLength

            if let index = self.fieldKeys[Lyrics3FieldID.ind] {
                if let fieldData = self.fieldList[index].toData(version: self.version) {
                    if fieldData.count <= maxBodyLength - data.count {
                        data.append(contentsOf: fieldData)
                    }
                }
            }

            for field in self.fieldList {
                if field.identifier != Lyrics3FieldID.ind {
                    if let fieldData = field.toData(version: self.version) {
                        if fieldData.count <= maxBodyLength - data.count {
                            data.append(contentsOf: fieldData)
                        }
                    }
                }
            }

            guard data.count > Lyrics3Tag.dataMarker.count else {
                return nil
            }

            data.append(contentsOf: ID3v1Latin1TextEncoding.regular.encode(String(format: "%06d", data.count)))
            data.append(contentsOf: Lyrics3Tag.dataSignatureV2)
        }

		return data
    }

    @discardableResult
    public func appendField(_ identifier: Lyrics3FieldID) -> Lyrics3Field {
        if let index = self.fieldKeys[identifier] {
            return self.fieldList[index]
        } else {
            let field = Lyrics3Field(identifier: identifier)

            self.fieldKeys.updateValue(self.fieldList.count, forKey: identifier)
            self.fieldList.append(field)

            return field
        }
    }

    @discardableResult
    public func resetField(_ identifier: Lyrics3FieldID) -> Lyrics3Field {
        if let index = self.fieldKeys[identifier] {
            let field = self.fieldList[index]

            field.reset()

            return field
        } else {
            let field = Lyrics3Field(identifier: identifier)

            self.fieldKeys.updateValue(self.fieldList.count, forKey: identifier)
            self.fieldList.append(field)

            return field
        }
    }

    @discardableResult
    public func removeField(_ identifier: Lyrics3FieldID) -> Bool {
        guard let index = self.fieldKeys.removeValue(forKey: identifier) else {
            return false
        }

        for i in (index + 1)..<self.fieldList.count {
            self.fieldKeys.updateValue(i - 1, forKey: self.fieldList[i].identifier)
        }

        self.fieldList.remove(at: index)

        return true
    }

    public func revise() {
        for field in self.fieldList {
            if field.isEmpty {
                if let index = self.fieldKeys.removeValue(forKey: field.identifier) {
                    for i in index..<(self.fieldList.count - 1) {
                        self.fieldKeys.updateValue(i, forKey: self.fieldList[i + 1].identifier)
                    }

                    self.fieldList.remove(at: index)
                }
            }
        }
    }

    public func clear() {
        self.fieldKeys.removeAll()
        self.fieldList.removeAll()
    }

    // MARK: Subscripts

    public subscript(identifier: Lyrics3FieldID) -> Lyrics3Field? {
        guard let index = self.fieldKeys[identifier] else {
            return nil
        }

        return self.fieldList[index]
    }
}
