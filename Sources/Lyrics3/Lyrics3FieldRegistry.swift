//
//  Lyrics3FieldRegistry.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 24.10.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import Foundation

public class Lyrics3FieldRegistry {

	// MARK: Type Properties

    public static let regular = Lyrics3FieldRegistry()

    // MARK: Instance Properties

    public private(set) var nativeIDs: [String: Lyrics3FieldID]
    public private(set) var customIDs: [String: Lyrics3FieldID]

    public private(set) var stuffs: [Lyrics3FieldID: Lyrics3FieldStuffFormat]

    // MARK: Initializers

    private init() {
        self.nativeIDs = ["IND": Lyrics3FieldID.ind,

						  "LYR": Lyrics3FieldID.lyr,
						  "INF": Lyrics3FieldID.inf,
						  "AUT": Lyrics3FieldID.aut,

						  "EAL": Lyrics3FieldID.eal,
						  "EAR": Lyrics3FieldID.ear,
						  "ETT": Lyrics3FieldID.ett,

						  "IMG": Lyrics3FieldID.img]

        self.customIDs = [:]

        self.stuffs = [Lyrics3FieldID.ind: Lyrics3IndicationsFormat.regular,

                       Lyrics3FieldID.lyr: Lyrics3TextInformationFormat.regular,
                       Lyrics3FieldID.inf: Lyrics3TextInformationFormat.regular,
                       Lyrics3FieldID.aut: Lyrics3TextInformationFormat.regular,

                       Lyrics3FieldID.eal: Lyrics3TextInformationFormat.regular,
                       Lyrics3FieldID.ear: Lyrics3TextInformationFormat.regular,
                       Lyrics3FieldID.ett: Lyrics3TextInformationFormat.regular,

                       Lyrics3FieldID.img: Lyrics3TextInformationFormat.regular]
    }

    // MARK: Instance Methods

    public func identifySignature(_ signature: [UInt8]) -> Lyrics3FieldID? {
        guard !signature.isEmpty else {
            return nil
        }

        for (_, customID) in self.customIDs {
            if customID.signature == signature {
                return customID
            }
        }

        for (_, nativeID) in self.nativeIDs {
            if nativeID.signature == signature {
                return nativeID
            }
        }

        guard let identifier = String(bytes: signature, encoding: String.Encoding.isoLatin1) else {
            return nil
        }

        return Lyrics3FieldID(customID: identifier, signature: signature)
    }

    @discardableResult
    public func registerCustomID(_ name: String, signature: [UInt8]) -> Lyrics3FieldID? {
        guard self.customIDs[name] == nil else {
            return nil
        }

        for (_, customID) in self.customIDs {
            guard customID.signature != signature else {
                return nil
            }
        }

        guard let customID = Lyrics3FieldID(customID: name, signature: signature) else {
            return nil
        }

        self.customIDs[name] = customID

        return customID
    }

    @discardableResult
    public func registerStuff(format: Lyrics3FieldStuffFormat, identifier: Lyrics3FieldID) -> Bool {
        guard self.stuffs[identifier] == nil else {
            return false
        }

        self.stuffs[identifier] = format

        return true
    }
}
