//
//  UdacityConvenience.swift
//  OnTheMap
//
//  Created by Akshay Iyer on 6/28/16.
//  Copyright © 2016 akshaytiyer. All rights reserved.
//

import UIKit
import Foundation

extension UdacityClient {
    
    
    func authenticateWithViewController(hostViewController: UIViewController, loginParameters: [String: String!] ,completionHandlerForAuth: (success: Bool, errorString: String?) -> Void) {

    getUniqueID(loginParameters) { (success, uniqueID, errorString) in
        if success {
                AppDelegate.sharedInstance().uniqueID = uniqueID
                completionHandlerForAuth(success: success, errorString: nil)
            } else {
                completionHandlerForAuth(success: success, errorString: errorString)
            }
        }
}
    
    private func getUniqueID(loginParameters: [String: String!],completionHandlerForUniqueID: (success: Bool, uniqueID: String!, errorString: String!) -> Void) {
        
        taskForPOSTMethod(UdacityClient.Methods.Session, parameters: loginParameters, jsonData: "") { (result, error) in
            if let error = error {
                completionHandlerForUniqueID(success: false, uniqueID: nil, errorString: "Did not fetch data correctly \(error)")
            } else {
                print(result)
                guard let account = result[UdacityClient.JSONParameterKeys.Account] as? [String: AnyObject!],
                let results = account[UdacityClient.JSONParameterKeys.Key] as? String else {
                   completionHandlerForUniqueID(success: false, uniqueID: nil, errorString: "Did not fetch data correctly \(error)")
                    return
                }
                completionHandlerForUniqueID(success: true, uniqueID: results, errorString: nil)
            }
        }
    }
    
    private func getUdacityUserData(uniqueID: String!, completionHandlerForUserData: (success: Bool, result: [UdacityData]?, errorString: String!) -> Void) {
        let uniqueKeyMethod = "\(UdacityClient.Methods.Users)/\(uniqueID)"
        taskForGETMethod(uniqueKeyMethod, parameters: [:], jsonData: "") { (result, error) in
            if let error = error {
                completionHandlerForUserData(success: false, result: nil, errorString: "Did not fetch data correctly \(error)")
            }
            else
            {
                
            }
        }
        
        
    }
}