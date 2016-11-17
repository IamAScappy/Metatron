//
//  MediaError.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 15.11.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import Foundation

public enum MediaError: Error, CustomStringConvertible {
	case invalidFormat

	case invalidStream
    case invalidFile
    case invalidData

    // MARK: Instance Properties

    public var localizedDescription: String {
    	switch self {
    	case .invalidFormat:
    		return "Invalid Media Format"

    	case .invalidStream:
    		return "Invalid Media Stream"

    	case .invalidFile:
    		return "Invalid Media File"

    	case .invalidData:
    		return "Invalid Media Data"
    	}
    }

    public var description: String {
        return self.localizedDescription
    }
}
