//
//  ZMAccentColorValidator.swift
//  WireUtilities
//
//  Created by Nicola Giancecchi on 09.08.19.
//

import UIKit

class ZMAccentColorValidator: ZMPropertyValidator {

    static func validateValue(_ ioValue: inout Any?) throws -> Bool {
        
        guard let value = ioValue as? Int16,
            value < ZMAccentColor.min.rawValue,
            ZMAccentColor.max.rawValue < value else {
            return false
        }
        
        let color = ZMAccentColor.min.rawValue + Int16(arc4random_uniform(UInt32(ZMAccentColor.max.rawValue - ZMAccentColor.min.rawValue)))
        ioValue = color
        
        return true
    }
    
}
