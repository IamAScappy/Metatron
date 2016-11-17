//
//  ID3v2FrameHeader.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 11.08.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import Foundation

class ID3v2FrameHeader {

    // MARK: Instance Properties

	let identifier: ID3v2FrameID

	var tagAlterPreservation: Bool
    var fileAlterPreservation: Bool

    var readOnly: Bool

    var unsynchronisation: Bool
    var dataLengthIndicator: Bool

    var compression: Bool

    var encryption: Bool
    var group: Bool

    var valueLength: UInt32

    // MARK: Initializers

    init(identifier: ID3v2FrameID) {
    	self.identifier = identifier

    	self.tagAlterPreservation = false
    	self.fileAlterPreservation = false

        self.readOnly = false

        self.unsynchronisation = false
        self.dataLengthIndicator = false

        self.compression = false

        self.encryption = false
        self.group = false

        self.valueLength = 0
    }

    init?(fromData data: [UInt8], version: ID3v2Version) {
        switch version {
        case ID3v2Version.v2:
            guard data.count >= 6 else {
                return nil
            }

            let signature = [UInt8](data.prefix(3))

            guard let identifier = ID3v2FrameRegistry.regular.identifySignature(signature, version: version) else {
                return nil
            }

            self.identifier = identifier

            self.valueLength = UInt32(data[5])

            self.valueLength |= UInt32(data[4]) << 8
            self.valueLength |= UInt32(data[3]) << 16

            self.tagAlterPreservation = false
	    	self.fileAlterPreservation = false

	        self.readOnly = false

            self.unsynchronisation = false
            self.dataLengthIndicator = false

	        self.compression = false

	        self.encryption = false
	        self.group = false

        case ID3v2Version.v3:
            guard data.count >= 10 else {
                return nil
            }

            let signature = [UInt8](data.prefix(4))

            guard let identifier = ID3v2FrameRegistry.regular.identifySignature(signature, version: version) else {
                return nil
            }

            self.identifier = identifier

            self.valueLength = UInt32(data[7])

            self.valueLength |= UInt32(data[6]) << 8
            self.valueLength |= UInt32(data[5]) << 16
            self.valueLength |= UInt32(data[4]) << 24

            let statusFlags = data[8]
            let formatFlags = data[9]

            self.tagAlterPreservation = ((statusFlags & 128) != 0)
            self.fileAlterPreservation = ((statusFlags & 64) != 0)

            self.readOnly = ((statusFlags & 32) != 0)

            self.unsynchronisation = false
            self.dataLengthIndicator = false

            self.compression = ((formatFlags & 128) != 0)

            self.encryption = ((formatFlags & 64) != 0)
            self.group = ((formatFlags & 32) != 0)

        case ID3v2Version.v4:
            guard data.count >= 10 else {
                return nil
            }

            let signature = [UInt8](data.prefix(4))

            guard let identifier = ID3v2FrameRegistry.regular.identifySignature(signature, version: version) else {
                return nil
            }

            self.identifier = identifier

            self.valueLength = ID3v2Unsynchronisation.uint28FromData([UInt8](data[4..<8]))

            if (self.valueLength > 127) && (data.count > 10) {
                if Int(self.valueLength) > data.count - 10 {
                    var otherLength = UInt64(data[7])

                    otherLength |= UInt64(data[6]) << 8
                    otherLength |= UInt64(data[5]) << 16
                    otherLength |= UInt64(data[4]) << 24

                    if otherLength == UInt64(data.count - 10) {
                        self.valueLength = UInt32(otherLength)
                    } else if otherLength < UInt64(data.count - 10) {
                        let nextSignature = data.suffix(from: Int(otherLength) + 10).prefix(4)

                        if ID3v2FrameID.checkSignature([UInt8](nextSignature), version: version) {
                            self.valueLength = UInt32(otherLength)
                        }
                    }
                } else if Int(self.valueLength) < data.count - 10 {
                    var nextSignature = data.suffix(from: Int(self.valueLength) + 10).prefix(4)

                    if !ID3v2FrameID.checkSignature([UInt8](nextSignature), version: version) {
                        var otherLength = UInt64(data[7])

                        otherLength |= UInt64(data[6]) << 8
                        otherLength |= UInt64(data[5]) << 16
                        otherLength |= UInt64(data[4]) << 24

                        if otherLength == UInt64(data.count - 10) {
                            self.valueLength = UInt32(otherLength)
                        } else if otherLength < UInt64(data.count - 10) {
                            nextSignature = data.suffix(from: Int(otherLength) + 10).prefix(4)

                            if ID3v2FrameID.checkSignature([UInt8](nextSignature), version: version) {
                                self.valueLength = UInt32(otherLength)
                            }
                        }
                    }
                }
            }

            let statusFlags = data[8]
            let formatFlags = data[9]

            self.tagAlterPreservation = ((statusFlags & 64) != 0)
            self.fileAlterPreservation = ((statusFlags & 32) != 0)

            self.readOnly = ((statusFlags & 16) != 0)

            self.unsynchronisation = ((formatFlags & 2) != 0)
            self.dataLengthIndicator = ((formatFlags & 1) != 0)

            self.compression = ((formatFlags & 8) != 0)

            self.encryption = ((formatFlags & 4) != 0)
            self.group = ((formatFlags & 64) != 0)
        }
    }

    // MARK: Instance Methods

    func toData(version: ID3v2Version) -> [UInt8]? {
        guard self.valueLength > 0 else {
            return nil
        }

    	guard let signature = self.identifier.signatures[version] else {
            return nil
        }

        var data = signature

        switch version {
        case ID3v2Version.v2:
        	guard self.valueLength < 16777216 else {
        		return nil
        	}

            data.append(contentsOf: [UInt8((self.valueLength >> 16) & 255),
                                     UInt8((self.valueLength >> 8) & 255),
                                     UInt8((self.valueLength) & 255)])

        case ID3v2Version.v3:
            data.append(contentsOf: [UInt8((self.valueLength >> 24) & 255),
                                     UInt8((self.valueLength >> 16) & 255),
                                     UInt8((self.valueLength >> 8) & 255),
                                     UInt8((self.valueLength) & 255),
                                     0, 0])

            if self.tagAlterPreservation {
                data[8] |= 128
            }

            if self.fileAlterPreservation {
                data[8] |= 64
            }

            if self.readOnly {
                data[8] |= 32
            }

            if self.compression {
                data[9] |= 128
            }

            if self.encryption {
                data[9] |= 64
            }

            if self.group {
                data[9] |= 32
            }

		case ID3v2Version.v4:
			guard self.valueLength < 268435456 else {
				return nil
			}

            data.append(contentsOf: ID3v2Unsynchronisation.dataFromUInt28(self.valueLength))
			data.append(contentsOf: Array<UInt8>(repeating: 0, count: 2))

            if self.tagAlterPreservation {
                data[8] |= 64
            }

            if self.fileAlterPreservation {
                data[8] |= 32
            }

            if self.readOnly {
                data[8] |= 16
            }

            if self.unsynchronisation {
                data[9] |= 2
            }

            if self.dataLengthIndicator {
                data[9] |= 1
            }

            if self.compression {
            	data[9] |= 8
            }

            if self.encryption {
                data[9] |= 4
            }

            if self.group {
                data[9] |= 64
            }
		}

        return data
    }

    // MARK:

    func reset() {
        self.tagAlterPreservation = false
        self.fileAlterPreservation = false

        self.readOnly = false

        self.unsynchronisation = false
        self.dataLengthIndicator = false

        self.compression = false

        self.encryption = false
        self.group = false

        self.valueLength = 0
    }
}
