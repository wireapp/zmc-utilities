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

final class UUIDDataConversionTests: XCTestCase {
    func testThatUUIDisConvertedToData() {
        let uuid = UUID(uuidString: "00010203-0405-0607-0809-0a0b0c0d0e0f")

        let data = uuid?.toData

        XCTAssertEqual(data?.count, 16)

        let bytes = [UInt8](data!)
        XCTAssertEqual(bytes, [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15])
    }

    func testThatDataisConvertedToUUID() {
        let bytes: [UInt8] = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
        let data = Data(bytes: bytes)

        let uuid = data.toUUID

        XCTAssertEqual(uuid, UUID(uuidString: "00010203-0405-0607-0809-0a0b0c0d0e0f"))
    }


    func testThatDataWithIncorrectLengthIsNotConverted() {
        let bytes: [UInt8] = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17]
        let data = Data(bytes: bytes)

        let uuid = data.toUUID

        XCTAssertNil(uuid)
    }
}
