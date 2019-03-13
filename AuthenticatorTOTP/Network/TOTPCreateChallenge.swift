//
//  TOTPCreateChallenge.swift
//  AuthenticatorTOTP
//
//  Created by HAWER TORRES on 3/12/19.
//  Copyright © 2019 HAWER TORRES. All rights reserved.
//

import Foundation

class TOTPCreateChallege: TOTPRequestService {
    var httpBody: String?
    var httpMethod = "POST"
    var factorSid: String
    
    init(factorSid: String) {
        self.factorSid = factorSid
    }
    
    var endpoint: String {
        get {
            return "https://authy.twilio.com/v1/Services/\(API.sid)/Entities/\(API.username)/Factors/\(factorSid)"
        }
        set(newValue) {
            
        }
    }
}
