//
//  ID3v2FrameCache.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 23.09.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import Foundation

public class ID3v2FrameCache {

    // MARK: Instance Properties

    let version: ID3v2Version

    private(set) var dataBuffer: [UInt8]
    private(set) var dataLength: UInt32

    var compression: Int

    var encryption: UInt8?
    var group: UInt8?

    // MARK:

    var value: [UInt8] {
        get {
            if self.encryption == nil {
                if self.compression == 0 {
                    return self.dataBuffer
                } else {
                    return ZLib.inflate(self.dataBuffer) ?? []
                }
            } else {
                return self.dataBuffer
            }
        }

        set {
            if self.encryption == nil {
                if self.compression == 0 {
                    self.dataBuffer = newValue
                } else {
                    self.dataBuffer = ZLib.deflate(newValue, level: self.compression) ?? []
                }
            } else {
                self.dataBuffer = newValue
            }
        }
    }

    // MARK:

    var isEmpty: Bool {
        return self.dataBuffer.isEmpty
    }

    // MARK: Initializers

    init(version: ID3v2Version, dataBuffer: [UInt8] = [], dataLength: UInt32 = 0) {
        self.version = version

        self.dataBuffer = dataBuffer
        self.dataLength = dataLength

        self.compression = 0
    }

    init?(fromData data: [UInt8], version: ID3v2Version, header: ID3v2FrameHeader) {
        guard UInt64(header.valueLength) <= UInt64(data.count) else {
            return nil
        }

        let valueLength = Int(header.valueLength)

        self.version = version

        switch self.version {
        case ID3v2Version.v2:
            self.dataBuffer = [UInt8](data.prefix(valueLength))
            self.dataLength = 0

            self.compression = 0

            self.encryption = nil
            self.group = nil

        case ID3v2Version.v3:
            var valueStart = 0

            var dataLength: UInt32 = 0

            if header.compression {
                self.compression = -1

                guard valueStart <= valueLength - 4 else {
                    return nil
                }

                dataLength = UInt32(data[valueStart + 3])

                dataLength |= UInt32(data[valueStart + 2]) << 8
                dataLength |= UInt32(data[valueStart + 1]) << 16
                dataLength |= UInt32(data[valueStart + 0]) << 24

                valueStart += 4
            } else {
                self.compression = 0
            }

            self.dataLength = dataLength

            if header.encryption {
                guard valueStart < valueLength else {
                    return nil
                }

                self.encryption = data[valueStart]

                valueStart += 1
            }

            if header.group {
                guard valueStart < valueLength else {
                    return nil
                }

                self.group = data[valueStart]

                valueStart += 1
            }

            guard valueStart <= valueLength else {
                return nil
            }

            self.dataBuffer = [UInt8](data[valueStart..<valueLength])

        case ID3v2Version.v4:
            var valueStart = 0

            if header.group {
                guard valueStart < valueLength else {
                    return nil
                }

                self.group = data[valueStart]

                valueStart += 1
            }

            var dataLength: UInt32 = 0

            if header.compression {
                self.compression = -1

                guard valueStart <= valueLength - 4 else {
                    return nil
                }

                dataLength = ID3v2Unsynchronisation.uint28FromData([UInt8](data[valueStart..<(valueStart + 4)]))

                valueStart += 4
            } else {
                self.compression = 0
            }

            if header.encryption {
                guard valueStart < valueLength else {
                    return nil
                }

                self.encryption = data[valueStart]

                valueStart += 1
            }

            if (!header.compression) && header.dataLengthIndicator {
                guard valueStart <= valueLength - 4 else {
                    return nil
                }

                dataLength = ID3v2Unsynchronisation.uint28FromData([UInt8](data[valueStart..<(valueStart + 4)]))

                valueStart += 4
            }

            self.dataLength = dataLength

            guard valueStart <= valueLength else {
                return nil
            }

            if header.unsynchronisation {
                self.dataBuffer = ID3v2Unsynchronisation.decode([UInt8](data[valueStart..<valueLength]))
            } else {
                self.dataBuffer = [UInt8](data[valueStart..<valueLength])
            }
        }
    }

    // MARK: Instance Methods

    func toData(header: ID3v2FrameHeader) -> [UInt8]? {
        guard !self.isEmpty else {
            return nil
        }

        var data: [UInt8] = []

        switch self.version {
        case ID3v2Version.v2:
            guard self.encryption == nil else {
                return nil
            }

            data = self.value

            guard data.count < 16777216 else {
                return nil
            }

        case ID3v2Version.v3:
            if self.compression != 0 {
                header.compression = true

                var dataLength = UInt64(self.dataLength)

                if dataLength == 0 {
                    guard self.encryption == nil else {
                        return nil
                    }

                    dataLength = UInt64(self.value.count)

                    guard (dataLength > 0) && (dataLength <= UInt64(UInt32.max)) else {
                        return nil
                    }
                }

                data.append(contentsOf: [UInt8((dataLength >> 24) & 255),
                                         UInt8((dataLength >> 16) & 255),
                                         UInt8((dataLength >> 8) & 255),
                                         UInt8((dataLength) & 255)])
            } else {
                header.compression = false
            }

            if let encryption = self.encryption {
                header.encryption = true

                data.append(encryption)
            } else {
                header.encryption = false
            }

            if let group = self.group {
                header.group = true

                data.append(group)
            } else {
                header.group = false
            }

            data.append(contentsOf: self.dataBuffer)

            guard UInt64(data.count) <= UInt64(UInt32.max) else {
                return nil
            }

        case ID3v2Version.v4:
            if let group = self.group {
                header.group = true

                data.append(group)
            } else {
                header.group = false
            }

            if self.compression != 0 {
                header.compression = true

                var dataLength = UInt64(self.dataLength)

                if dataLength == 0 {
                    guard self.encryption == nil else {
                        return nil
                    }

                    dataLength = UInt64(self.value.count)

                    guard (dataLength > 0) && (dataLength < 268435456) else {
                        return nil
                    }
                }

                guard dataLength < 268435456 else {
                    return nil
                }

                data.append(contentsOf: ID3v2Unsynchronisation.dataFromUInt28(UInt32(dataLength)))
            } else {
                header.compression = false
            }

            if let encryption = self.encryption {
                header.encryption = true

                data.append(encryption)
            } else {
                header.encryption = false
            }

            if (!header.compression) && header.dataLengthIndicator {
                var dataLength = UInt64(self.dataLength)

                if dataLength == 0 {
                    guard self.encryption == nil else {
                        return nil
                    }

                    dataLength = UInt64(self.value.count)

                    guard (dataLength > 0) && (dataLength < 268435456) else {
                        return nil
                    }
                }

                guard dataLength < 268435456 else {
                    return nil
                }

                data.append(contentsOf: ID3v2Unsynchronisation.dataFromUInt28(UInt32(dataLength)))
            }

            if header.unsynchronisation {
                data.append(contentsOf: ID3v2Unsynchronisation.encode(self.dataBuffer))
            } else {
                data.append(contentsOf: self.dataBuffer)
            }

            guard data.count < 268435456 else {
                return nil
            }
        }

        header.valueLength = UInt32(data.count)

        guard !data.isEmpty else {
            return nil
        }

        return data
    }

    // MARK:

    func reset() {
        self.dataBuffer.removeAll()
        self.dataLength = 0

        self.compression = 0

        self.encryption = nil
        self.group = nil
    }
}
