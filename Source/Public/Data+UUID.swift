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

extension Data {
    var toUUID: UUID? {
        let bytes = [UInt8](self)

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

        return UUID(uuid: uuidTuple)
    }
}


extension UUID {
    var toData: Data? {
        let uuidTuple = uuid

        let bytes: [UInt8] = [uuidTuple.0,
                              uuidTuple.1,
                              uuidTuple.2,
                              uuidTuple.3,
                              uuidTuple.4,
                              uuidTuple.5,
                              uuidTuple.6,
                              uuidTuple.7,
                              uuidTuple.8,
                              uuidTuple.9,
                              uuidTuple.10,
                              uuidTuple.11,
                              uuidTuple.12,
                              uuidTuple.13,
                              uuidTuple.14,
                              uuidTuple.15]
        let data = Data(bytes: bytes)

        return data
    }
}
