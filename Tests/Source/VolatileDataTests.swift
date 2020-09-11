//
// Wire
// Copyright (C) 2020 Wire Swiss GmbH
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

class VolatileDataTests: XCTestCase {

    func testThatItCanStoreBytes() {
        // Given
        let bytes: [Byte] = [0, 1, 2, 3, 4, 5]
        let sut = VolatileData(bytes: Data(bytes))

        // When
        let storedBytes = Array(UnsafeBufferPointer(start: sut.pointer, count: bytes.count))

        // Then
        XCTAssertEqual(storedBytes, bytes)
    }

    func testThatItZeroesOutMemoryAfterDeinitialization() {
        // Given
        let bytes: [Byte] = [0, 1, 2, 3, 4, 5]
        let pointer: UnsafeBufferPointer<Byte>

        // When sut goes out of scope and deinitializes...
        do {
            let sut = VolatileData(bytes: Data(bytes))

            // Keep a reference to the memory.
            pointer = UnsafeBufferPointer(start: sut.pointer, count: bytes.count)
        }

        // Then
        let bytesInDeallocatedMemory = Array(pointer)
        XCTAssertEqual(bytesInDeallocatedMemory, [0, 0, 0, 0, 0, 0])
    }

}
