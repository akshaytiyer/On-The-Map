//
//  ParseConstants.swift
//  OnTheMap
//
//  Created by Akshay Iyer on 6/27/16.
//  Copyright © 2016 akshaytiyer. All rights reserved.
//

//MARK: ParseClient (Constants)

extension ParseClient {
    
    //MARK: Constants
    struct Constants {
        
        //MARK: API Key
        static let RESTAPIKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
        static let ApplicationID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        
        //MARK: URLs
        static let ApiScheme = "https"
        static let ApiHost = "api.parse.com"
        static let ApiPath = "/1/classes"
    }
    
    //MARK: Header Fields
    struct HTTPHeaderFields {
        static let ApplicationID = "X-Parse-Application-Id"
        static let RESTAPIKey = "X-Parse-REST-API-Key"
    }
    
    //MARK: Methods
    struct Methods {
        
        //MARK: StudentLocation
        static let StudentLocation = "/StudentLocation"
    }
    
    //MARK: ParameterKeys
    struct ParameterKeys {
        static let Limit = "limit"
        static let Skip  = "skip"
        static let Order = "order"
    }
    
    struct JSONParameterKeys {
        static let Where = "where"
    }
    
    //MARK: JSONParameterValues
    struct JSONParameterValues {
        static let uniqueID = "{\"uniqueKey\":\"02225542471\"}"
    }
    
    //MARK: JSONBodyKeys
    struct JSONBodyKeys {
        
    }
}