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

public extension UUID {
    
    /// return a Data representation of this UUID
    var uuidData: Data {
        let bytes: [UInt8] = [uuid.0,
                              uuid.1,
                              uuid.2,
                              uuid.3,
                              uuid.4,
                              uuid.5,
                              uuid.6,
                              uuid.7,
                              uuid.8,
                              uuid.9,
                              uuid.10,
                              uuid.11,
                              uuid.12,
                              uuid.13,
                              uuid.14,
                              uuid.15]
        let data = Data(bytes: bytes)
        
        return data
    }

    
    /// Create an UUID from Data. Fails when Data is not in valid format
    ///
    /// - Parameter data: a data with count = 16.
    init?(data: Data) {
        guard data.count == 16 else { return nil }

        let bytes = data

        let uuidTuple: uuid_t = (bytes[0],
                                 bytes[1],
                                 bytes[2],
                                 bytes[3],
                                 bytes[4],
                                 bytes[5],
                                 bytes[6],
                                 bytes[7],
                                 bytes[8],
                                 bytes[9],
                                 bytes[10],
                                 bytes[11],
                                 bytes[12],
                                 bytes[13],
                                 bytes[14],
                                 bytes[15])

        self.init(uuid: uuidTuple)
    }
}
