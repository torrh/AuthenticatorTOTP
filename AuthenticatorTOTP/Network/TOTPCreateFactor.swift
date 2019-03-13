//
//  TOPPCreateFactor.swift
//  AuthenticatorTOTP
//
//  Created by HAWER TORRES on 3/12/19.
//  Copyright © 2019 HAWER TORRES. All rights reserved.
//

import Foundation

class TOTPCreateFactor: TOTPRequestService {
    var endpoint = "https://authy.twilio.com/v1/Services/\(API.sid)/Entities/\(API.username)/Factors"
    var httpMethod = "POST"
    var factorSecret: String
    var friendlyName: String
    var factorType: String
    
    init(factorSecret: String, friendlyName: String, factorType: String) {
        self.factorSecret = factorSecret
        self.factorType = factorType
        self.friendlyName = friendlyName
    }

    private func buildBinding(factorSecret: String) -> String {
        return "\(factorSecret)|sha1|30|6"
    }
    
    var httpBody: String? {
        get {
            return "FactorType=\(factorType)&FriendlyName=\(friendlyName)&Binding=\(buildBinding(factorSecret: factorSecret))"
        }
    }
}
