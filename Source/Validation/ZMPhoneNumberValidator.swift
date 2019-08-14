//
//  ZMPhoneNumberValidator.swift
//  WireUtilities
//
//  Created by Nicola Giancecchi on 09.08.19.
//

import UIKit

class ZMPhoneNumberValidator: ZMPropertyValidator {

    static func validateValue(_ ioValue: inout Any?) throws -> Bool {
        
        guard let phoneNumber = ioValue as? NSString,
            phoneNumber.length >= 1 else {
                return true
        }
        
        var validSet = CharacterSet.decimalDigits
        validSet.insert(charactersIn: "+-. ()")
        let invalidSet = validSet.inverted
        
        if phoneNumber.rangeOfCharacter(from: invalidSet, options: .literal).location != NSNotFound {
            let description = "The phone number is invalid."
            let userInfo = [NSLocalizedDescriptionKey: description]
            let error = NSError(domain: ZMObjectValidationErrorDomain,
                                code: ZMManagedObjectValidationErrorCode.phoneNumberContainsInvalidCharacters.rawValue,
                                userInfo: userInfo)
            throw error
        }
        
        var finalPhoneNumber: Any? = ("+".appending(phoneNumber as String) as NSString).stringByRemovingCharacters("+-. ()")
        
        do {
            try StringLengthValidator.validateValue(&finalPhoneNumber,
                                                minimumStringLength: 9,
                                                maximumStringLength: 24,
                                                maximumByteLength: 24)
        } catch {
            return false
        }
        
        if finalPhoneNumber as! NSString != phoneNumber {
            ioValue = finalPhoneNumber
        }

        return false
    }
    
    static func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
        var phoneNumber: Any? = phoneNumber
        return try! validateValue(&phoneNumber)
    }
    
}

extension NSString {
    
    func stringByRemovingCharacters(_ characters:NSString) -> NSString {
        let finalString = self
        for i in 0..<characters.length {
            let toRemove = characters.substring(with: NSMakeRange(i, 1))
            finalString.replacingOccurrences(of: toRemove,
                                             with: "",
                                             options: [],
                                             range: NSMakeRange(0, finalString.length))
        }
        return finalString
    }
}
