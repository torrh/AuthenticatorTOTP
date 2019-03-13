//
//  TOTPVerifyChallenge.swift
//  AuthenticatorTOTP
//
//  Created by HAWER TORRES on 3/12/19.
//  Copyright © 2019 HAWER TORRES. All rights reserved.
//

import Foundation

class TOTPVerifyChallenge: TOTPRequestService {
    var httpMethod = "POST"
    var authPayload: String
    var factorSid: String
    
    init(authPayload: String, factorSid: String) {
        self.authPayload = authPayload
        self.factorSid = factorSid
    }

    var httpBody: String? {
        get {
            return "AuthPayload=\(authPayload)"
        }
    }
    
    var endpoint: String {
        get {
            return "https://authy.twilio.com/v1/Services/\(API.sid)/Entities/\(API.username)/Factors/\(self.factorSid)/Challenges/latest"
        }
        set(newValue) {
            
        }
    }
}
