//
//  FileStream.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 03.11.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import Foundation

public class FileStream: Stream {

    // MARK: Instance Properties

    private var handle: FileHandle?

    public let filePath: String

    // MARK:

    public private(set) var isReadable: Bool
    public private(set) var isWritable: Bool

    public var isOpen: Bool {
        return (self.handle != nil)
    }

    // MARK:

    public var offset: UInt64 {
        if let handle = self.handle {
            return handle.offsetInFile
        }

        return 0
    }

    public var length: UInt64 {
        if let handle = self.handle {
            let offset = handle.offsetInFile
            let length = handle.seekToEndOfFile()

            handle.seek(toFileOffset: offset)

            return length
        } else {
            if let attributes = try? FileManager.default.attributesOfItem(atPath: self.filePath) {
                if let length = attributes[FileAttributeKey.size] as? NSNumber {
                    return length.uint64Value
                }
            }

            return 0
        }
    }

    public var bufferLength: Int

    // MARK: Initializers

    public init(filePath: String) {
        self.filePath = filePath

        self.isReadable = false
        self.isWritable = false

        self.bufferLength = 1024
    }

    // MARK: Deinitializer

    deinit {
        if let handle = self.handle {
            handle.synchronizeFile()
            handle.closeFile()
        }
    }

    // MARK: Instance Methods

    @discardableResult
    public func openForReading() -> Bool {
        guard !self.isOpen else {
            return false
        }

        guard let handle = FileHandle(forReadingAtPath: self.filePath) else {
            return false
        }

        self.handle = handle

        self.isReadable = true
        self.isWritable = false

        return true
    }

    @discardableResult
    public func openForUpdating(truncate: Bool) -> Bool {
        guard !self.isOpen else {
            return false
        }

        if !FileManager.default.fileExists(atPath: self.filePath) {
            let pathCharacters = [Character](self.filePath.characters)

            let directoryPath = String(pathCharacters.prefix(pathCharacters.lastIndex(of: "/") ?? 0))

            if !directoryPath.isEmpty {
                try? FileManager.default.createDirectory(atPath: directoryPath, withIntermediateDirectories: true)
            }

            guard FileManager.default.createFile(atPath: self.filePath, contents: nil) else {
                return false
            }
        }

        guard let handle = FileHandle(forUpdatingAtPath: self.filePath) else {
            return false
        }

        if truncate {
            handle.truncateFile(atOffset: 0)
        }

        self.handle = handle

        self.isReadable = true
        self.isWritable = true

        return true
    }

    @discardableResult
    public func openForWriting(truncate: Bool) -> Bool {
        guard !self.isOpen else {
            return false
        }

        if !FileManager.default.fileExists(atPath: self.filePath) {
            let pathCharacters = [Character](self.filePath.characters)

            let directoryPath = String(pathCharacters.prefix(pathCharacters.lastIndex(of: "/") ?? 0))

            if !directoryPath.isEmpty {
                try? FileManager.default.createDirectory(atPath: directoryPath, withIntermediateDirectories: true)
            }

            guard FileManager.default.createFile(atPath: self.filePath, contents: nil) else {
                return false
            }
        }

        guard let handle = FileHandle(forWritingAtPath: self.filePath) else {
            return false
        }

        if truncate {
            handle.truncateFile(atOffset: 0)
        }

        self.handle = handle

        self.isReadable = false
        self.isWritable = true

        return true
    }

    public func synchronize() {
        if let handle = self.handle {
            handle.synchronizeFile()
        }
    }

    public func close() {
        if let handle = self.handle {
            handle.synchronizeFile()
            handle.closeFile()

            self.handle = nil

            self.isReadable = false
            self.isWritable = false
        }
    }

    // MARK:

    @discardableResult
    public func seek(offset: UInt64) -> Bool {
        guard let handle = self.handle else {
            return false
        }

        guard offset <= self.length else {
            return false
        }

        handle.seek(toFileOffset: offset)

        return true
    }

    public func read(maxLength: Int) -> [UInt8] {
        guard self.isReadable && (maxLength > 0) else {
            return []
        }

        guard let handle = self.handle else {
            return []
        }

        return [UInt8](handle.readData(ofLength: maxLength))
    }

    @discardableResult
    public func write(data: [UInt8]) -> Int {
        guard self.isWritable && (data.count > 0) else {
            return 0
        }

        guard let handle = self.handle else {
            return 0
        }

        let offset = handle.offsetInFile
        let length = min(UInt64.max - offset, UInt64(data.count))

        handle.write(Data(data.prefix(Int(length))))

        return Int(handle.offsetInFile - offset)
    }

    @discardableResult
    public func truncate(length: UInt64) -> Bool {
        guard self.isWritable else {
            return false
        }

        guard let handle = self.handle else {
            return false
        }

        guard length < self.length else {
            return false
        }

        let offset = min(handle.offsetInFile, length)

        handle.truncateFile(atOffset: length)
        handle.seek(toFileOffset: offset)

        return true
    }

    @discardableResult
    public func insert(data: [UInt8]) -> Bool {
        guard self.isReadable && self.isWritable else {
            return false
        }

        guard let handle = self.handle else {
            return false
        }

        guard data.count > 0 else {
            return true
        }

        let maxBufferLength = UInt64(max(self.bufferLength, data.count))

        let offset = handle.offsetInFile
        let length = self.length

        let shift = UInt64(data.count)
        var count = length - offset

        handle.truncateFile(atOffset: length + shift)

        while count > 0 {
            let bufferLength = min(count, maxBufferLength)
            let bufferOffset = offset + count - bufferLength

            handle.seek(toFileOffset: bufferOffset)

            let buffer = handle.readData(ofLength: Int(bufferLength))

            guard buffer.count == Int(bufferLength) else {
                handle.seek(toFileOffset: offset)

                return false
            }

            handle.seek(toFileOffset: bufferOffset + shift)
            handle.write(buffer)

            count -= bufferLength
        }

        handle.seek(toFileOffset: offset)
        handle.write(Data(data))

        return true
    }

    @discardableResult
    public func remove(length: UInt64) -> Bool {
        guard self.isReadable && self.isWritable else {
            return false
        }

        guard let handle = self.handle else {
            return false
        }

        guard length > 0 else {
            return true
        }

        let maxBufferLength = UInt64(max(self.bufferLength, 1))

        let offset = handle.offsetInFile
        let margin = self.length - offset

        guard length <= margin else {
            return false
        }

        var count = margin - length

        while count > 0 {
            let bufferLength = min(count, maxBufferLength)
            let bufferOffset = offset + margin - count

            handle.seek(toFileOffset: bufferOffset)

            let buffer = handle.readData(ofLength: Int(bufferLength))

            guard buffer.count == Int(bufferLength) else {
                handle.seek(toFileOffset: offset)

                return false
            }

            handle.seek(toFileOffset: bufferOffset - length)
            handle.write(buffer)

            count -= bufferLength
        }

        handle.truncateFile(atOffset: handle.offsetInFile)
        handle.seek(toFileOffset: offset)

        return true
    }
}
