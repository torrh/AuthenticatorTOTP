//
//  AuthenticatorTOTPTests.swift
//  AuthenticatorTOTPTests
//
//  Created by HAWER TORRES on 3/11/19.
//  Copyright © 2019 HAWER TORRES. All rights reserved.
//

import XCTest
@testable import AuthenticatorTOTP

class AuthenticatorTOTPTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testStoreFactorSecret() {
        let secret = "DFSFDERR"
        let mock = UserDefaultsMock()
        TOTPHelper.storeFactorSecret(secret: secret, userDefaults: mock, key: "FactorSecretKey")
        
        let result = mock.getValue(forkey: "FactorSecretKey")
        
        XCTAssertEqual(secret, result, "Deben ser iguales")
    }
    
    func testCreateFactor() {
        let factorSecret = "LBVGU3CSKVKGQSCULBIG2WLDOA======"
        let friendlyName = "My service test"
        let factorType = "totp"
        
        let exp = expectation(description: "Create factor")
        
        let factorController = TOTPCreateFactor(factorSecret: factorSecret, friendlyName: friendlyName, factorType: factorType)
        factorController.requestService() { (response, error) in
            XCTAssertNil(error)
            
            if let responseData = response, let factorSid = responseData["sid"] as? String {
                print(factorSid)
                exp.fulfill()
            } else {
                XCTFail("Not factor sid returned by service")
            }
        }
        
        waitForExpectations(timeout: 20, handler: nil)
    }
    
    func testCreateChallenge() {
        let factorSid = "YF027d152b520b72fc6fa8f49d5dc0cdf5"
        
        let exp = expectation(description: "Create challenge")
        
        let challengeController = TOTPCreateChallege(factorSid: factorSid)
        challengeController.requestService() { (response, error) in
            XCTAssertNil(error)
            
            if let responseData = response, let factorSid = responseData["sid"] as? String {
                print(factorSid)
                exp.fulfill()
            } else {
                XCTFail("Not factor sid returned by service")
            }
        }
        
        waitForExpectations(timeout: 20, handler: nil)
    }
    
    func testVerifyChallenge() {
        let factorSid = "YF027d152b520b72fc6fa8f49d5dc0cdf5"
        let passcode = "980133"
        
        let exp = expectation(description: "Create challenge")
        
        let challengeController = TOTPVerifyChallenge(authPayload: passcode, factorSid: factorSid)
        challengeController.requestService() { (response, error) in
            XCTAssertNil(error)
            
            if let responseData = response, let factorSid = responseData["sid"] as? String {
                print(factorSid)
                exp.fulfill()
            } else {
                XCTFail("Not factor sid returned by service")
            }
        }

        waitForExpectations(timeout: 20, handler: nil)
    }
}
