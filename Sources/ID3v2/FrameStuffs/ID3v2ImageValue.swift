//
//  ID3v2ImageValue.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 11.10.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
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
