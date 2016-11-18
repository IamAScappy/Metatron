//
//  SampleMedias.swift
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
import Metatron

class SampleMedias {

    // MARK: Type Properties

    static let regular = SampleMedias()

    // MARK: Instance Properties

    var medias: [MPEGMedia]

    // MARK: Initializers

    private init() {
        self.medias = []

        if let filePath = Bundle(for: type(of: self)).path(forResource: "sample_media_1", ofType: "mp3") {
            if let media = try? MPEGMedia(fromFilePath: filePath, readOnly: false) {
                self.medias.append(media)
            }
        }

        if let filePath = Bundle(for: type(of: self)).path(forResource: "sample_media_2", ofType: "mp3") {
            if let media = try? MPEGMedia(fromFilePath: filePath, readOnly: false) {
                self.medias.append(media)
            }
        }

        if let filePath = Bundle(for: type(of: self)).path(forResource: "sample_media_3", ofType: "mp3") {
            if let media = try? MPEGMedia(fromFilePath: filePath, readOnly: false) {
                self.medias.append(media)
            }
        }
    }
}
