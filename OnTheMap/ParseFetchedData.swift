//
//  ParseFetchedData.swift
//  OnTheMap
//
//  Created by Akshay Iyer on 6/30/16.
//  Copyright © 2016 akshaytiyer. All rights reserved.
//

import Foundation

class ParseFetchedData: NSObject
{
    var parseData: [ParseData] = [ParseData]()

    // MARK: Shared Instance
    class func sharedInstance() -> ParseFetchedData {
        struct Singleton {
            static var sharedInstance = ParseFetchedData()
        }
        return Singleton.sharedInstance
    }
}
