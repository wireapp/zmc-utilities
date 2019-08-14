//
//  ZMPropertyValidator.swift
//  WireUtilities
//
//  Created by Nicola Giancecchi on 08.08.19.
//

import Foundation

let ZMObjectValidationErrorDomain = "ZMManagedObjectValidation"

enum ZMManagedObjectValidationErrorCode: Int, Error {
    case tooLong
    case tooShort
    case emailAddressIsInvalid
    case phoneNumberContainsInvalidCharacters
}

public protocol ZMPropertyValidator {
    static func validateValue(_ ioValue: inout Any?) throws -> Bool
}
