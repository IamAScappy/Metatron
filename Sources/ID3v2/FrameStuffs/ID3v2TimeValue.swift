//
//  ID3v2TimeValue.swift
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
