//
// Wire
// Copyright (C) 2019 Wire Swiss GmbH
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see http://www.gnu.org/licenses/.
//


import UIKit

public class ZMAccentColorValidator: ZMPropertyValidator {

    public static func validateValue(_ ioValue: inout Any?) throws -> Bool {
        
        let value = ioValue as? ZMAccentColor
        
        if value == nil ||
            value?.rawValue < ZMAccentColor.min.rawValue ||
            ZMAccentColor.max.rawValue < value?.rawValue {
            let color = ZMAccentColor(rawValue:
                ZMAccentColor.min.rawValue +
                    Int16(arc4random_uniform(UInt32(ZMAccentColor.max.rawValue - ZMAccentColor.min.rawValue))))
            ioValue = color
        }
        
        return true
    }
    
}
