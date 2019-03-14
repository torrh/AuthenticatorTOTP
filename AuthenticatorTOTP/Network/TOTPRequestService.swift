//
//  RequestServiceTOTP.swift
//  AuthenticatorTOTP
//
//  Created by HAWER TORRES on 3/12/19.
//  Copyright © 2019 HAWER TORRES. All rights reserved.
//

import Foundation
import KeychainSwift

typealias DataDictionary = [String: Any]

public enum API {
    static let sid = ""
    static let accountSid = ""
    static let authToken = ""
    static let username = "Hawer"
}

protocol TOTPRequestService {
    var endpoint: String { get set }
    var httpMethod: String { get set }
    var httpBody: String? { get }
}

enum TOTPRequestServiceError: Error {
    case invalidURL(String)
    case invalidResponse()
}

extension TOTPRequestService {
    func requestService(completionHandler: @escaping (DataDictionary?, Error?) -> Void ) {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        guard let url = URL(string: endpoint) else {
            completionHandler(nil, TOTPRequestServiceError.invalidURL(endpoint))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        
        if let httpBodyRequest = httpBody, let dataEncoding = httpBodyRequest.data(using: String.Encoding.ascii, allowLossyConversion: true) {
            request.httpBody = dataEncoding
            let length = String(format: "%d", dataEncoding.count)
            request.setValue(length, forHTTPHeaderField: "Content-Length")
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        }

        //Authorization: Basic
        let authorizationData = "\(API.accountSid):\(API.authToken)"
        let authorizationDataUtf8 = authorizationData.data(using: .utf8)
        
        guard let authorizationEncoded = authorizationDataUtf8?.base64EncodedString() else {
            return
        }
    
        request.setValue("Basic \(authorizationEncoded)", forHTTPHeaderField: "Authorization")
        
        let dataTask = session.dataTask(with: request) { (data, respose, error) in
            guard error == nil else {
                return
            }
            
            guard let dataResponse = data else {
                return
            }
            
            do{
   
                guard let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: []) as? DataDictionary else {
                    completionHandler(nil, TOTPRequestServiceError.invalidResponse())
                    return
                }
                
                completionHandler(jsonResponse, nil)
                
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        
        dataTask.resume()
    }
    
    func authTokenAndSid(authKey: String, accountKey: String) -> (String, String)? {
        let keychain = KeychainSwift()
        
        guard let token = keychain.get(authKey), let accountSid = keychain.get(accountKey) else  {
            return nil
        }
        
        return (token, accountSid)
    }
    
}
