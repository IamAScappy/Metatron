//
//  ZLib.swift
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

private struct ZLibStream {

    // MARK: Instance Properties

    var next_in : UnsafePointer<UInt8>? = nil
    var available_in : CUnsignedInt = 0
    var total_in : CUnsignedLong = 0

    var next_out : UnsafePointer<UInt8>? = nil
    var available_out : CUnsignedInt = 0
    var total_out : CUnsignedLong = 0

    var message : UnsafePointer<CChar>? = nil
    var state : OpaquePointer? = nil

    var zalloc : OpaquePointer? = nil
    var zfree : OpaquePointer? = nil
    var opaque : OpaquePointer? = nil

    var format : CInt = 0
    var adler : CUnsignedLong = 0

    var reserved : CUnsignedLong = 0
}

@_silgen_name("zlibVersion") private func zlibVersion() -> OpaquePointer

@discardableResult @_silgen_name("deflateInit_")
private func zlibDeflateInit(_ stream: UnsafeMutableRawPointer, level: CInt, version: OpaquePointer, streamSize: CInt) -> CInt

@discardableResult @_silgen_name("deflate")
private func zlibDeflate(_ stream: UnsafeMutableRawPointer, flush: CInt) -> CInt

@discardableResult @_silgen_name("deflateEnd")
private func zlibDeflateEnd(_ stream: UnsafeMutableRawPointer) -> CInt

@discardableResult @_silgen_name("inflateInit_")
private func zlibInflateInit(_ stream: UnsafeMutableRawPointer, version: OpaquePointer, streamSize: CInt) -> CInt

@discardableResult @_silgen_name("inflate")
private func zlibInflate(_ stream: UnsafeMutableRawPointer, flush: CInt) -> CInt

@discardableResult @_silgen_name("inflateEnd")
private func zlibInflateEnd(_ stream: UnsafeMutableRawPointer) -> CInt

class ZLib {

    // MARK: Type Properties

    fileprivate static let streamSize = CInt(MemoryLayout<ZLibStream>.size)
    fileprivate static let bufferSize = 1024

    // MARK: Type Methods

    static func inflate(_ data: [UInt8]) -> [UInt8]? {
        guard !data.isEmpty else {
            return nil
        }

        var stream = ZLibStream()

        guard zlibInflateInit(&stream, version: zlibVersion(), streamSize: streamSize) == 0 else {
            return nil
        }

        var buffer = Array<UInt8>(repeating: 0, count: ZLib.bufferSize)

        var inData = data

        stream.available_in = CUnsignedInt(inData.count)
        stream.next_in = &inData+0

        var outData: [UInt8] = []

        repeat {
            stream.available_out = CUnsignedInt(buffer.count)
            stream.next_out = &buffer+0

            let state  = zlibInflate(&stream, flush: 0)

            guard (state >= 0) && (state != 2) else {
                zlibInflateEnd(&stream)

                return nil
            }

            if buffer.count > Int(stream.available_out) {
                outData.append(contentsOf: buffer.prefix(buffer.count - Int(stream.available_out)))
            }
        }
        while stream.available_out == 0

        zlibInflateEnd(&stream)

        return outData
    }

    static func deflate(_ data: [UInt8], level: Int = -1) -> [UInt8]? {
        assert((level >= -1) && (level < 10), "Invalid level")

        guard !data.isEmpty else {
            return []
        }

        var stream = ZLibStream()

        guard zlibDeflateInit(&stream, level: CInt(level), version: zlibVersion(), streamSize: streamSize) == 0 else {
            return nil
        }

        var buffer = Array<UInt8>(repeating: 0, count: ZLib.bufferSize)

        var inData = data

        stream.available_in = CUnsignedInt(inData.count)
        stream.next_in = &inData+0

        var outData: [UInt8] = []

        repeat {
            stream.available_out = CUnsignedInt(buffer.count)
            stream.next_out = &buffer+0

            let state = zlibDeflate(&stream, flush: 4)

            guard (state >= 0) && (state != 2) else {
                zlibDeflateEnd(&stream)

                return nil
            }

            if buffer.count > Int(stream.available_out) {
                outData.append(contentsOf: buffer.prefix(buffer.count - Int(stream.available_out)))
            }
        }
        while stream.available_out == 0

        zlibDeflateEnd(&stream)

        return outData
    }
}

