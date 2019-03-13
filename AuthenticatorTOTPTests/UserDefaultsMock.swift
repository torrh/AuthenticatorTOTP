//
//  UserDefaultsMock.swift
//  AuthenticatorTOTPTests
//
//  Created by HAWER TORRES on 3/13/19.
//  Copyright © 2019 HAWER TORRES. All rights reserved.
//

import Foundation

class UserDefaultsMock: UserDefaults {
    
    var info: [String: String] = [:]
    
    override func setValue(_ value: Any?, forKeyPath keyPath: String) {
        guard let valueString = value as? String else  {
            return
        }
        
        info.updateValue(valueString, forKey: keyPath)
    }
    
    func getValue(forkey key: String) -> String? {
        return info[key] ?? nil
    }
}
