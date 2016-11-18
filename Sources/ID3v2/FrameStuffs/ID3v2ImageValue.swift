//
//  ID3v2ImageValue.swift
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

public extension ID3v2AttachedPicture {

    // MARK: Instance Properties

	public var imageValue: TagImage {
        get {
            guard self.imageFormat != ImageFormat.link else {
                return TagImage()
            }

            let mimeType = self.imageFormat.mimeType

            if !mimeType.contains("/") {
            	return TagImage(data: self.pictureData, mainMimeType: "image/" + mimeType, description: self.description)
            }

            return TagImage(data: self.pictureData, mainMimeType: mimeType, description: self.description)
		}

        set {
            if !newValue.isEmpty {
            	self.imageFormat = ImageFormat(mimeType: newValue.mimeType)

                self.description = newValue.description
                self.pictureData = newValue.data
            } else {
                self.imageFormat = ImageFormat.other(mimeType: "application/octet-stream")

                self.description.removeAll()
                self.pictureData.removeAll()
            }
        }
	}
}
