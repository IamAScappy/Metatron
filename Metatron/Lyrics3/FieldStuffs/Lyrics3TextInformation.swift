//
//  Lyrics3TextInformation.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 24.10.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import Foundation

public class Lyrics3TextInformation: Lyrics3FieldStuff {

    // MARK: Instance Properties

    public var content: String = ""

    // MARK:

    public var isEmpty: Bool {
    	return self.content.isEmpty
    }

    // MARK: Initializers

    public init() {
    }

    public required init(fromData data: [UInt8]) {
        guard !data.isEmpty else {
            return
        }

        var revised: [UInt8] = []

        for i in 0..<(data.count - 1) {
            if data[i] == 0 {
                break
            }

            if (data[i] != 13) || (data[i + 1] != 10) {
                revised.append(data[i])
            }
        }

        if data.last! != 0 {
            revised.append(data.last!)
        }

        guard let content = ID3v1Latin1TextEncoding.regular.decode(revised) else {
            return
        }

    	self.content = content
    }

    // MARK: Instance Methods

    public func toData() -> [UInt8]? {
        guard !self.isEmpty else {
            return nil
        }

        let revised = ID3v1Latin1TextEncoding.regular.encode(self.content)

        guard !revised.isEmpty else {
            return nil
        }

        var data: [UInt8]

        if revised[0] != 10 {
            data = [revised[0]]
        } else {
            data = [13, 10]
        }

        for i in 1..<revised.count {
            if revised[i] != 10 {
                data.append(revised[i])
            } else {
                if data.last! != 13 {
                    data.append(13)
                }

                data.append(10)
            }
        }

        return data
    }
}

public class Lyrics3TextInformationFormat: Lyrics3FieldStuffSubclassFormat {

    // MARK: Type Properties

    public static let regular = Lyrics3TextInformationFormat()

    // MARK: Instance Methods

    public func createStuffSubclass(fromData data: [UInt8]) -> Lyrics3TextInformation {
        return Lyrics3TextInformation(fromData: data)
    }

    public func createStuffSubclass(fromOther other: Lyrics3TextInformation) -> Lyrics3TextInformation {
        let stuff = Lyrics3TextInformation()

        stuff.content = other.content

        return stuff
    }

    public func createStuffSubclass() -> Lyrics3TextInformation {
        return Lyrics3TextInformation()
    }
}
