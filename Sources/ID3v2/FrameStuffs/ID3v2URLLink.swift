//
//  ID3v2URLLink.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 06.09.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import Foundation

public class ID3v2URLLink: ID3v2FrameStuff {

    // MARK: Instance Properties

    public var url: String = ""

    // MARK:

    public var isEmpty: Bool {
        return self.url.isEmpty
    }

    // MARK: Initializers

    public init() {
    }

    public required init(fromData data: [UInt8], version: ID3v2Version) {
        guard !data.isEmpty else {
            return
        }

        guard let url = ID3v2TextEncoding.latin1.decode(data) else {
            return
        }

        self.url = url.text
    }

    // MARK: Instance Methods

    public func toData(version: ID3v2Version) -> [UInt8]? {
        guard !self.isEmpty else {
            return nil
        }

        return ID3v2TextEncoding.latin1.encode(self.url, termination: false)
    }

    public func toData() -> (data: [UInt8], version: ID3v2Version)? {
        guard let data = self.toData(version: ID3v2Version.v4) else {
            return nil
        }

        return (data: data, version: ID3v2Version.v4)
    }
}

public class ID3v2URLLinkFormat: ID3v2FrameStuffSubclassFormat {

    // MARK: Type Properties

    public static let regular = ID3v2URLLinkFormat()

    // MARK: Instance Methods

    public func createStuffSubclass(fromData data: [UInt8], version: ID3v2Version) -> ID3v2URLLink {
        return ID3v2URLLink(fromData: data, version: version)
    }

    public func createStuffSubclass(fromOther other: ID3v2URLLink) -> ID3v2URLLink {
        let stuff = ID3v2URLLink()

        stuff.url = other.url

        return stuff
    }

    public func createStuffSubclass() -> ID3v2URLLink {
        return ID3v2URLLink()
    }
}
