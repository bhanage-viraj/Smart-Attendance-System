//
//  TokenManager.swift
//  Smart-Attendance-Tracker
//
//  Created by Viraj Bhanage on 19/03/25.
//


import Foundation
import Security

class TokenManager {
    // MARK: - Configuration
    private enum StorageKey {
        static let token = "jwt_token"
    }
    
    private enum KeychainAttributes {
        static let accessLevel = kSecAttrAccessibleWhenUnlocked
        static let matchLimit = kSecMatchLimitOne
    }
    
    // MARK: - Error Types
    enum TokenError: Error {
        case encodingFailed
        case keychainOperationFailed(OSStatus)
    }
    
    // MARK: - Public Interface
    
    /// Checks if a token exists and returns authentication status
    static func isLoggedIn() -> Bool {
        do {
            return try getTokenFromKeychain() != nil
        } catch {
            print("Error checking login status: \(error)")
            return false
        }
    }
    
    /// Save token to both UserDefaults (for quick access) and Keychain (for security)
    static func saveToken(_ token: String) {
        // Save to UserDefaults for quick access
        UserDefaults.standard.set(token, forKey: StorageKey.token)
        
        // Also save to Keychain for security
        do {
            try saveTokenToKeychain(token)
        } catch {
            print("Error saving token to keychain: \(error)")
        }
    }
    
    /// Get token from UserDefaults (quicker than Keychain)
    static func getToken() -> String? {
        return UserDefaults.standard.string(forKey: StorageKey.token)
    }
    
    /// Remove token from both UserDefaults and Keychain
    static func deleteToken() {
        // Remove from UserDefaults
        UserDefaults.standard.removeObject(forKey: StorageKey.token)
        
        // Also remove from Keychain
        do {
            try deleteTokenFromKeychain()
        } catch {
            print("Error deleting token from keychain: \(error)")
        }
    }
    
    // MARK: - Keychain Storage
    /// Securely saves token to Keychain
    static func saveTokenToKeychain(_ token: String) throws {
        guard let data = token.data(using: .utf8) else {
            throw TokenError.encodingFailed
        }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: StorageKey.token,
            kSecValueData as String: data,
            kSecAttrAccessible as String: KeychainAttributes.accessLevel
        ]
        
        // Remove existing token first
        _ = try? deleteTokenFromKeychain()
        
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else {
            throw TokenError.keychainOperationFailed(status)
        }
    }
    
    /// Retrieves token from Keychain
    static func getTokenFromKeychain() throws -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: StorageKey.token,
            kSecReturnData as String: true,
            kSecMatchLimit as String: KeychainAttributes.matchLimit
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status == errSecSuccess else {
            if status == errSecItemNotFound {
                return nil
            }
            throw TokenError.keychainOperationFailed(status)
        }
        
        guard let data = result as? Data,
              let token = String(data: data, encoding: .utf8) else {
            throw TokenError.encodingFailed
        }
        
        return token
    }
    
    /// Deletes token from Keychain
    @discardableResult
    static func deleteTokenFromKeychain() throws -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: StorageKey.token
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        switch status {
        case errSecSuccess:
            return true
        case errSecItemNotFound:
            return false
        default:
            throw TokenError.keychainOperationFailed(status)
        }
    }
}
