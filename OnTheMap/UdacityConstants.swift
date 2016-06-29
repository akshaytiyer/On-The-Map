//
//  UdacityConstants.swift
//  OnTheMap
//
//  Created by Akshay Iyer on 6/27/16.
//  Copyright © 2016 akshaytiyer. All rights reserved.
//

import Foundation

extension UdacityClient {

    struct Constants {
        //MARK: URLs
        static let ApiScheme = "https"
        static let ApiHost = "www.udacity.com"
        static let ApiPath = "/api"
    }
    
    struct Methods {
        static let Session = "/session"
        static let Users = "/users"
    }
    
    struct JSONResponseKeys {
        static let LastName = "last_name"
        static let FirstName = "first_name"
        static let UniqueKey = "key"
    }

    struct JSONParameterKeys {
        static let User = "user"
        static let Key = "key"
        static let Account = "account"
    }
}