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


import Foundation


public typealias Byte = UInt8

/// A container for sensitive data.
///
/// `VolatileData` holds a collection of bytes that are required to exist only during the lifetime
/// of the instance. When the instance is deinitialized, the memory containing the bytes is
/// zeroed-out before being deallocated.
///
/// **Important**
///
/// Only the memory allocated by an instance of `VolatileData` will be zeroed-out. It is the responsibility
/// of the developer to prevent data from leaking by creating copies into other types, espcially types with
/// value semantics (such as `Array` and `Data`) as further copies are made each time the values are passed
/// around.

public class VolatileData {

    // MARK: - Properties

    /// A pointer to the first byte.

    public let pointer: UnsafeMutablePointer<Byte>

    /// The number of contiguous bytes in the container.

    public let byteCount: Int

    // MARK: - Life Cycle

    /// Initialize the container with the given bytes.

    public init(bytes: Data) {
        pointer = UnsafeMutablePointer<Byte>.allocate(capacity: bytes.count)
        byteCount = bytes.count

        zeroOut()

        for (index, byte) in bytes.enumerated() {
            pointer.advanced(by: index).pointee = byte
        }
    }

    deinit {
        zeroOut()
        pointer.deinitialize(count: byteCount)
        pointer.deallocate()
    }

    // MARK: - Helpers

    private func zeroOut() {
        pointer.initialize(repeating: .zero, count: byteCount)
    }

}
