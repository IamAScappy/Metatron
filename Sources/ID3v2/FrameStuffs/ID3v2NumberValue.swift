//
//  ID3v2NumberValue.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 08.10.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import Foundation

public extension ID3v2TextInformation {

    // MARK: Instance Properties

    public var numberValue: TagNumber {
        get {
        	guard let field = self.fields.first else {
                return TagNumber()
            }

            let parts = field.components(separatedBy: "/")

            guard parts.count < 3 else {
                return TagNumber()
            }

            guard let value = Int(parts[0]) else {
                return TagNumber()
            }

            if parts.count == 1 {
                return TagNumber(value)
            }

            guard let total = Int(parts[1]) else {
                return TagNumber()
            }

            return TagNumber(value, total: total)
        }

        set {
        	if newValue.isValid {
        		if newValue.total > 0 {
                    self.fields = [String(format: "%d/%d", newValue.value, newValue.total)]
                } else {
                    self.fields = [String(format: "%d", newValue.value)]
                }
        	} else {
        		self.fields.removeAll()
        	}
        }
    }
}
