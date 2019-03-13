//
//  TOTPHelper.swift
//  AuthenticatorTOTP
//
//  Created by HAWER TORRES on 3/12/19.
//  Copyright © 2019 HAWER TORRES. All rights reserved.
//

import Foundation
import SwiftOTP

class TOTPHelper {
    
    enum Constants {
        static let FactorSecretKey = "FactorSecretKey"
    }

    static func randomString(length: Int) -> String {
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        return String((0..<length).map{ _ in
            characters.randomElement()!
        })
    }
    
    static func factorSecretData(factorSecret: String) -> Data? {
        guard let randomData = factorSecret.data(using: .utf8) else {
            return nil
        }
        
        return randomData
    }
    
    static func randomStringData(randomString: String) -> Data? {
        guard let randomData = randomString.data(using: .utf8) else {
            return nil
        }
        
        return randomData
    }
    
    static func dataBase32Encode(data: Data) -> String? {
        let dataEncoded = base32Encode(data)
        
        return dataEncoded
    }
    
    static func storeFactorSecret(secret: String, userDefaults: UserDefaults, key: String) {
        userDefaults.setValue(secret, forKeyPath: key)
    }

    static func getTOTPObject(data: Data) -> String {
        let totp = TOTP(secret: data, digits: 6, timeInterval: 30, algorithm: .sha1)
        let passcode = totp?.generate(time: Date())
        
        return passcode ?? ""
    }
}

