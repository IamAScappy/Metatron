//
//  SampleMedias.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 16.11.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import Foundation
import Metatron

class SampleMedias
{
    // MARK: Type Properties
    
    static let regular = SampleMedias()
    
    // MARK: Instance Properties
    
    var medias: [MPEGMedia]
    
    // MARK: Initializers
    
    private init()
    {
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
