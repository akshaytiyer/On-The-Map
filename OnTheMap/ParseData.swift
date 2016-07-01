//
//  ParseData.swift
//  OnTheMap
//
//  Created by Akshay Iyer on 6/28/16.
//  Copyright © 2016 akshaytiyer. All rights reserved.
//

struct ParseData {
    
    //MARK: Properties
    let uniqueKey: String!
    let firstName: String!
    let lastName: String!
    let mapString: String!
    let mediaURL: String!
    let latitude: Double!
    let longitude: Double!
    let objectID: String!
    
    //MARK: Initializers
    
    // Construct a data from a Dictionary
    init(dictionary: [String:AnyObject]) {
        uniqueKey = dictionary[ParseClient.JSONResponseKeys.UniqueID] as! String
        firstName = dictionary[ParseClient.JSONResponseKeys.FirstName] as! String
        lastName = dictionary[ParseClient.JSONResponseKeys.LastName] as! String
        mapString = dictionary[ParseClient.JSONResponseKeys.MapString] as! String
        mediaURL = dictionary[ParseClient.JSONResponseKeys.MediaURL] as! String
        latitude = dictionary[ParseClient.JSONResponseKeys.Latitude] as! Double
        longitude = dictionary[ParseClient.JSONResponseKeys.Longitude] as! Double
        objectID = dictionary[ParseClient.JSONResponseKeys.ObjectID] as! String
    }
    
    //MARK: Helper Method
    static func parseDataFromResults(results: [[String: AnyObject]]) -> [ParseData]
    {
        var parse = [ParseData]()
        for result in results {
            parse.append(ParseData(dictionary: result))
            let uniqueID = result[ParseClient.JSONResponseKeys.UniqueID] as? String
            let objectID = result[ParseClient.JSONResponseKeys.ObjectID] as? String
            if uniqueID! == AppDelegate.sharedInstance().udacityData.uniqueKey
            {
                AppDelegate.sharedInstance().flag = true
                AppDelegate.sharedInstance().parse.objectID = objectID
            }
        }
        
        return parse
    }
}

// MARK: - ParseData: Equatable

extension ParseData: Equatable {}

func ==(lhs: ParseData, rhs: ParseData) -> Bool {
    return lhs.uniqueKey == rhs.uniqueKey
}



