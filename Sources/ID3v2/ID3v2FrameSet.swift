//
//  ID3v2FrameSet.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 16.08.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
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
