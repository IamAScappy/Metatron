//
//  ID3v2FrameSet.swift
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

public class ID3v2FrameSet {

	// MARK: Instance Properties

	public private(set) var frames: [ID3v2Frame]

    public var mainFrame: ID3v2Frame {
    	return self.frames[0]
    }

    public var identifier: ID3v2FrameID {
    	return self.mainFrame.identifier
    }

    // MARK: Initializers

    init(frames: [ID3v2Frame]) {
        assert(!frames.isEmpty, "Empty frames")

        self.frames = [frames[0]]

        for i in 1..<frames.count {
            let frame = frames[i]

            if frame.identifier == frames[0].identifier {
                self.frames.append(frame)
            }
        }
    }

    init(identifier: ID3v2FrameID) {
    	self.frames = [ID3v2Frame(identifier: identifier)]
    }

    // MARK: Instance Methods

    @discardableResult
    public func removeFrame(_ frame: ID3v2Frame) -> Bool {
        guard let index = self.frames.index(of: frame) else {
			return false
		}

		self.removeFrame(at: index)

        return true
    }

    public func removeFrame(at index: Int) {
    	if (index == 0) && (self.frames.count == 1) {
            self.frames[0] = ID3v2Frame(identifier: self.identifier)
		} else {
			self.frames.remove(at: index)
		}
    }

    @discardableResult
    public func appendFrame() -> ID3v2Frame {
        let frame = ID3v2Frame(identifier: self.identifier)

        self.frames.append(frame)

        return frame
    }

    public func reset() {
        while self.frames.count > 1 {
            self.removeFrame(at: 1)
        }

        self.frames[0].reset()
    }
}
