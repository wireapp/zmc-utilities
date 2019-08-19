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

import WireTesting
@testable import WireUtilities

class ZMPhoneNumberValidatorTests: ZMTBaseTest {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testThatValidNumbersPassValidation() {
     
        let validPhoneNumbers = [
            "123456789012345678", // normal length
            "+4915233336668",
            "+49 152 3333 6668",
            "+49 (0) 152 3333 6668",
            "(152) 3333-6668",
            "415.456.456",
            "+1 415.456.456",
            "00 1 415.456.456",
            ""
        ]
        
        var isValid: Bool = false
        var isValidWithNonMutableCheck: Bool = false
        
        for phone in validPhoneNumbers {
            var validatedPhone: Any? = phone
            do {
                try isValid = ZMPhoneNumberValidator.validateValue(&validatedPhone)
            } catch {
                XCTAssertNil(error)
            }
            
            isValidWithNonMutableCheck = ZMPhoneNumberValidator.isValidPhoneNumber(validatedPhone as! String)
            XCTAssertTrue(isValid, "failed for \(phone)")
            XCTAssertTrue(isValidWithNonMutableCheck, "isValidEmailAddress failed for \(phone)")
        }
    }
    
    func testThatInvalidNumbersDoNotPassValidation() {
        
        let invalidPhoneNumbers = [
            "1234@1234", // Invalid character
            "1234a1234", // Invalid character
            "1234%1234", // Invalid character
            "1234^1234", // Invalid character
        ]
        
        var isValid: Bool = false
        var isValidWithNonMutableCheck: Bool = false
        
        for phone in invalidPhoneNumbers {
            var validatedPhone: Any? = phone
            do {
                try isValid = ZMPhoneNumberValidator.validateValue(&validatedPhone)
            } catch {
                XCTAssertNotNil(error)
            }
            
            isValidWithNonMutableCheck = ZMPhoneNumberValidator.isValidPhoneNumber(validatedPhone as! String)
            XCTAssertFalse(isValid, "failed for \(phone)")
            XCTAssertFalse(isValidWithNonMutableCheck, "isValidEmailAddress failed for \(phone)")
        }
    }
    
    func testThatItRemovesAllNonNumericCharacters() {
        
        let phoneNumbers = [
            "+49123(45)678",
            " + 4 9 1 2 3 4 5 6 7 8",
            "(+49)123-456-78",
            "+49.123.456.78"
        ]
        let expectedNumber = "+4912345678"
        
        for number in phoneNumbers {
            var ioNumber: Any? = number
            
            XCTAssertTrue(try ZMPhoneNumberValidator.validateValue(&ioNumber))
            XCTAssertEqual(ioNumber as! String, expectedNumber, String(format: "%@ was not normalized to %@ (was %@ instead)", number, expectedNumber, ioNumber as! CVarArg))
        }
    }
}
