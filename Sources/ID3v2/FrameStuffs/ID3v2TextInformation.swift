//
//  ID3v2TextInformation.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 06.09.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import Foundation

open class ID3v2BaseTextInformation: ID3v2FrameStuff {

    // MARK: Instance Properties

    public var textEncoding: ID3v2TextEncoding = ID3v2TextEncoding.utf8

    public var fields: [String] = []

    // MARK:

    public var isEmpty: Bool {
        return self.fields.isEmpty
    }

    // MARK: Initializers

    public init() {
    }

    public required init(fromData data: [UInt8], version: ID3v2Version) {
        guard data.count > 1 else {
            return
        }

        guard let textEncoding = ID3v2TextEncoding(rawValue: data[0]) else {
            return
        }

        var offset = 1

        var fields: [String] = []

        repeat {
            guard let field = textEncoding.decode([UInt8](data.suffix(from: offset))) else {
                return
            }

            fields.append(field.text)

            offset += field.endIndex

            if offset >= data.count {
                if field.terminated {
                    fields.append("")
                }

                break
            }
        }
        while true

        self.textEncoding = textEncoding

        self.fields = self.deserialize(fields: fields, version: version)
    }

    // MARK: Instance Methods

    public func toData(version: ID3v2Version) -> [UInt8]? {
        guard !self.isEmpty else {
            return nil
        }

        let fields = self.serialize(fields: self.fields, version: version)

        let textEncoding: ID3v2TextEncoding

        switch version {
        case ID3v2Version.v2, ID3v2Version.v3:
            if self.textEncoding == ID3v2TextEncoding.latin1 {
                textEncoding = ID3v2TextEncoding.latin1
            } else {
                textEncoding = ID3v2TextEncoding.utf16
            }

        case ID3v2Version.v4:
            textEncoding = self.textEncoding
        }

        var data = [textEncoding.rawValue]

        for i in 0..<(fields.count - 1) {
            data.append(contentsOf: textEncoding.encode(fields[i], termination: true))
        }

        data.append(contentsOf: textEncoding.encode(fields.last!, termination: false))

        return data
    }

    public func toData() -> (data: [UInt8], version: ID3v2Version)? {
        guard let data = self.toData(version: ID3v2Version.v4) else {
            return nil
        }

        return (data: data, version: ID3v2Version.v4)
    }

    // MARK:

    open func deserialize(fields: [String], version: ID3v2Version) -> [String] {
        return fields
    }

    open func serialize(fields: [String], version: ID3v2Version) -> [String] {
        return fields
    }
}

public class ID3v2TextInformation: ID3v2BaseTextInformation {

    // MARK: Instance Methods

    public override func deserialize(fields: [String], version: ID3v2Version) -> [String] {
        return fields
    }

    public override func serialize(fields: [String], version: ID3v2Version) -> [String] {
        return fields
    }
}

public class ID3v2TextInformationFormat: ID3v2FrameStuffSubclassFormat {

    // MARK: Type Properties

    public static let regular = ID3v2TextInformationFormat()

    // MARK: Instance Methods

    public func createStuffSubclass(fromData data: [UInt8], version: ID3v2Version) -> ID3v2TextInformation {
        return ID3v2TextInformation(fromData: data, version: version)
    }

    public func createStuffSubclass(fromOther other: ID3v2TextInformation) -> ID3v2TextInformation {
        let stuff = ID3v2TextInformation()

        stuff.textEncoding = other.textEncoding

        stuff.fields = other.fields

        return stuff
    }

    public func createStuffSubclass() -> ID3v2TextInformation {
        return ID3v2TextInformation()
    }
}
