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
    
    
    //MARK: Main method to authenticate user
    
    func authenticateWithViewController(hostViewController: UIViewController, loginParameters: [String: String!] ,completionHandlerForAuth: (success: Bool, errorString: String?) -> Void) {

    getUniqueID(loginParameters) { (success, uniqueID, sessionID, errorString) in
        if success {
                self.instance.udacityData.uniqueKey = uniqueID
                self.instance.sessionID = sessionID
                completionHandlerForAuth(success: success, errorString: nil)
            } else {
                completionHandlerForAuth(success: success, errorString: errorString)
            }
        }
    }
    
    //MARK: Get Session ID
    
    private func getUniqueID(loginParameters: [String: String!],completionHandlerForUniqueID: (success: Bool, uniqueID: String!,sessionID: String!, errorString: String!) -> Void) {
        
        taskForPOSTMethod(UdacityClient.Methods.Session, parameters: loginParameters, jsonData: "") { (result, error) in
            if let error = error {
                completionHandlerForUniqueID(success: false, uniqueID: nil, sessionID: nil, errorString: "Did not fetch data correctly \(error.localizedDescription)")
            } else {
                guard let account = result[UdacityClient.JSONParameterKeys.Account] as? [String: AnyObject!],
                let results = account[UdacityClient.JSONParameterKeys.Key] as? String else {
                   completionHandlerForUniqueID(success: false, uniqueID: nil, sessionID: nil, errorString: "Did not fetch data correctly \(error!.localizedDescription)")
                    return
                }
                
                guard let session = result[UdacityClient.JSONParameterKeys.Session] as? [String: AnyObject!],
                    let id = session[UdacityClient.JSONParameterKeys.SessionID] as? String else {
                        completionHandlerForUniqueID(success: false, uniqueID: nil, sessionID: nil, errorString: "Did not fetch data correctly \(error!.localizedDescription)")
                        return
                }
                
                completionHandlerForUniqueID(success: true, uniqueID: results, sessionID: id, errorString: nil)
            }
        }
    }
    
    //MARK: Get User Details
    
    func getUdacityUserData(uniqueID: String!, completionHandlerForUserData: (success: Bool, result: [String: AnyObject!]!, errorString: String!) -> Void) {
        let uniqueKeyMethod = "\(UdacityClient.Methods.Users)/\(uniqueID)"
        taskForGETMethod(uniqueKeyMethod, jsonData: "") { (result, error) in
            if let error = error {
                completionHandlerForUserData(success: false, result: nil, errorString: "Did not fetch data correctly \(error)")
            }
            else
            {
                guard let userData = result[UdacityClient.JSONParameterKeys.User] as? [String: AnyObject!] else {
                    completionHandlerForUserData(success: false, result: nil, errorString: "Did not fetch data correctly \(error)")
                    return
                }
                completionHandlerForUserData(success: true, result: userData, errorString: nil)
            }
        }
   
    }
    
    //MARK: Log Out
    
    func deleteUdacityUserData(completionHandlerForUserData: (success: Bool, errorString: String!) -> Void) {
        taskForDELETEMethod(UdacityClient.Methods.Session, jsonData: "") { (result, error) in
            if let error = error {
                completionHandlerForUserData(success: false, errorString: "Did not fetch data correctly \(error)")
            }
            else
            {
                completionHandlerForUserData(success: true, errorString: nil)
            }
        }
    }
}