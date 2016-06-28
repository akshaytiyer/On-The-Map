//
//  ParseData.swift
//  OnTheMap
//
//  Created by Akshay Iyer on 6/28/16.
//  Copyright © 2016 akshaytiyer. All rights reserved.
//

struct ParseData {
    
    /* {\"uniqueKey\": \"0222554247\", \"firstName\": \"Priyanka\", \"lastName\": \"Keswani\",\"mapString\": \"Cupertino, CA\", \"mediaURL\": \"https://udacity.com\",\"latitude\": 37.386052, \"longitude\": -122.083851} */
    
    //MARK: Properties
    
    let uniqueKey: String!
    let firstName: String!
    let lastName: String!
    let mapString: String!
    let mediaURL: String!
    let latitude: Double!
    let longitude: Double!

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
    }
    
    static func parseDataFromResults(results: [[String: AnyObject]]) -> [ParseData]
    {
        var parse = [ParseData]()
        for result in results {
            parse.append(ParseData(dictionary: result))
        }
        
        return parse
    }
}
