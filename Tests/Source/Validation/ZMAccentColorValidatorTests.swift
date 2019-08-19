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

import XCTest
@testable import WireUtilities

class ZMAccentColorValidatorTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testThatItLimitsTheAccentColorToAValidRange() {
        
        // given
        var color: Any? = ZMAccentColor.brightYellow
        // when
        _ = try! ZMAccentColorValidator.validateValue(&color)
        // then
        XCTAssertEqual((color as! ZMAccentColor).rawValue, ZMAccentColor.brightYellow.rawValue)
        
        // given
        color = ZMAccentColor.undefined
        // when
        _ = try! ZMAccentColorValidator.validateValue(&color)
        // then
        XCTAssertGreaterThanOrEqual((color as! ZMAccentColor).rawValue, ZMAccentColor.min.rawValue)
        XCTAssertLessThanOrEqual((color as! ZMAccentColor).rawValue, ZMAccentColor.max.rawValue)
        
        //given
        color = ZMAccentColor(rawValue: ZMAccentColor.max.rawValue + 1)
        // when
        _ = try! ZMAccentColorValidator.validateValue(&color)
        // then
        XCTAssertGreaterThanOrEqual((color as! ZMAccentColor).rawValue, ZMAccentColor.min.rawValue)
        XCTAssertLessThanOrEqual((color as! ZMAccentColor).rawValue, ZMAccentColor.max.rawValue)
        
    }
}
