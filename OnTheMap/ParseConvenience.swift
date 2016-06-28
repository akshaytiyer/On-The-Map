//
//  ParseConvenience.swift
//  OnTheMap
//
//  Created by Akshay Iyer on 6/28/16.
//  Copyright © 2016 akshaytiyer. All rights reserved.
//

import UIKit
import Foundation

extension ParseClient {


func getParseData(completionHandlerForParseData: (result: [ParseData]?, error: NSError?) -> Void) {

    /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
    let method = ParseClient.Methods.StudentLocation

    taskForGETMethod(method, parameters: [:]) { (result, error) in
        /* 3. Send the desired value(s) to completion handler */
        if let error = error {
            completionHandlerForParseData(result: nil, error: error)
        } else {
            if let results = result[ParseClient.JSONParameterKeys.Results] as? [[String: AnyObject]] {
                let parseData = ParseData.parseDataFromResults(results)
                completionHandlerForParseData(result: parseData, error: nil)
            }
            else {
                completionHandlerForParseData(result: nil, error: NSError(domain: "getParseData parsing'", code: 0, userInfo: [NSLocalizedDescriptionKey : "Could nor parse ParseData"]))
            }
        }
    }
}
}
