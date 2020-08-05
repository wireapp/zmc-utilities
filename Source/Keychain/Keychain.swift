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

import Foundation
import Security
import LocalAuthentication


public protocol KeychainItem {
    func setQuery<T>(value: T) -> [CFString: Any]
    var getQuery: [CFString: Any] { get }
}

public enum Keychain {
        
    public enum KeychainError: Error {
        case failedToStoreItemInKeychain(OSStatus)
        case failedToFetchItemFromKeychain(OSStatus)
        case failedToDeleteItemFromKeychain(OSStatus)
    }
    
    // MARK: - Keychain access

    public static func storeItem<T>(_ item: KeychainItem, value: T) throws {
        let query = item.setQuery(value: value) as CFDictionary
        let status = SecItemAdd(query, nil)
        
        guard status == errSecSuccess else {
            throw KeychainError.failedToStoreItemInKeychain(status)
        }
    }
    
    public static func fetchItem<T>(_ item: KeychainItem) throws -> T {
        var value: CFTypeRef? = nil
        let status = SecItemCopyMatching(item.getQuery as CFDictionary, &value)
        
        guard status == errSecSuccess else {
            throw KeychainError.failedToFetchItemFromKeychain(status)
        }
                
        return value as! T
    }
    
    public static func deleteItem(_ item: KeychainItem) throws {
        let status = SecItemDelete(item.getQuery as CFDictionary)
        
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw KeychainError.failedToDeleteItemFromKeychain(status)
        }
    }
    
    public static func updateItem<T>(_ item: KeychainItem, value: T) throws {
        try deleteItem(item)
        try storeItem(item, value: value)
    }
}
