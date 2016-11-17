//
//  ID3v2TimeValue.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 07.10.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import Foundation

public extension ID3v2TextInformation {

    // MARK: Instance Properties

    public var timeValue: TagTime {
        get {
        	guard let field = self.fields.first else {
                return TagTime()
            }

            let characters = [Character](field.characters)

            guard characters.count == 4 else {
                return TagTime()
            }

            guard let hour = Int(String(characters.prefix(2))) else {
                return TagTime()
            }

            guard let minute = Int(String(characters.suffix(2))) else {
                return TagTime()
            }

            return TagTime(hour: hour, minute: minute)
        }

        set {
        	if newValue.isValid && ((newValue.hour > 0) || (newValue.minute > 0)) {
        		self.fields = [String(format: "%02d%02d", newValue.hour, newValue.minute)]
        	} else {
        		self.fields.removeAll()
        	}
        }
    }
}
