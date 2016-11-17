//
//  ID3v2DateValue.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 07.10.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import Foundation

public extension ID3v2TextInformation {

    // MARK: Instance Properties

	public var dateValue: TagDate {
		get {
			guard let field = self.fields.first else {
                return TagDate()
            }

            let characters = [Character](field.characters)

            let parts = characters.split(separator: "-", maxSplits: 2, omittingEmptySubsequences: false)

            guard (parts[0].count == 4) && (characters[0] != "-") else {
                return TagDate()
            }

            guard let year = Int(String(parts[0])) else {
                return TagDate()
            }

            if parts.count == 1 {
                return TagDate(year: year)
            }

            guard (parts[1].count == 2) && (characters[5] != "-") else {
                return TagDate()
            }

            guard let month = Int(String(parts[1])) else {
                return TagDate()
            }

            if parts.count == 2 {
                return TagDate(year: year, month: month)
            }

            if parts[2].count > 3 {
                guard (characters[8] != "-") && ((characters[10] == "T") || (characters[10] == " ")) else {
                    return TagDate()
                }

                guard let day = Int(String(parts[2].prefix(2))) else {
                    return TagDate()
                }

                let timeCharacters = characters.suffix(from: 11)

                let timeParts = timeCharacters.split(separator: ":", maxSplits: 2, omittingEmptySubsequences: false)

                guard (timeParts[0].count == 2) && (characters[11] != "-") else {
                    return TagDate()
                }

                guard let hour = Int(String(timeParts[0])) else {
                    return TagDate()
                }

                if timeParts.count == 1 {
                    return TagDate(year: year, month: month, day: day, time: TagTime(hour: hour))
                }

                guard (timeParts[1].count == 2) && (characters[14] != "-") else {
                    return TagDate()
                }

                guard let minute = Int(String(timeParts[1])) else {
                    return TagDate()
                }

                if timeParts.count == 2 {
                    return TagDate(year: year, month: month, day: day, time: TagTime(hour: hour, minute: minute))
                }

                guard (timeParts[2].count == 2) && (characters[17] != "-") else {
                    return TagDate()
                }

                guard let second = Int(String(timeParts[2])) else {
                    return TagDate()
                }

                let time = TagTime(hour: hour, minute: minute, second: second)

                return TagDate(year: year, month: month, day: day, time: time)
            }

            guard (parts[2].count == 2) && (characters[8] != "-")else {
                return TagDate()
            }

            guard let day = Int(String(parts[2])) else {
                return TagDate()
            }

            return TagDate(year: year, month: month, day: day)
		}

		set {
			if newValue.isValid {
            	var field = String(format: "%04d", newValue.year)

            	if newValue.time.second > 0 {
		        	field.append(String(format: "-%02d", newValue.month))
                    field.append(String(format: "-%02d", newValue.day))

                    field.append(String(format: "T%02d", newValue.time.hour))
                    field.append(String(format: ":%02d", newValue.time.minute))
                    field.append(String(format: ":%02d", newValue.time.second))
            	} else if newValue.time.minute > 0 {
		            field.append(String(format: "-%02d", newValue.month))
                    field.append(String(format: "-%02d", newValue.day))

                    field.append(String(format: "T%02d", newValue.time.hour))
                    field.append(String(format: ":%02d", newValue.time.minute))
		        } else if newValue.time.hour > 0 {
		            field.append(String(format: "-%02d", newValue.month))
                    field.append(String(format: "-%02d", newValue.day))

                    field.append(String(format: "T%02d", newValue.time.hour))
		        } else if newValue.day > 1 {
		            field.append(String(format: "-%02d", newValue.month))
                    field.append(String(format: "-%02d", newValue.day))
		        } else if newValue.month > 1 {
		            field.append(String(format: "-%02d", newValue.month))
		        }

		        self.fields = [field]
            } else {
            	self.fields.removeAll()
            }
		}
	}
}
