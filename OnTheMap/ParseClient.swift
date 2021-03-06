//
//  ParseClient.swift
//  OnTheMap
//
//  Created by Akshay Iyer on 6/27/16.
//  Copyright © 2016 akshaytiyer. All rights reserved.
//

import Foundation

//Mark: -ParseClient: NSObject

class ParseClient: NSObject {
    
    
    
    //MARK: Initializers
    override init() {
        super.init()
    }
    
    //MARK: GET
     func taskForGETMethod(method: String, completionHandlerForGET: (result: AnyObject!, error: String?) -> Void) -> NSURLSessionDataTask {
        /* 1. Build the URL, Configure the Request */
        let methodParameters: [String: String] = [
            ParseClient.JSONParameterKeys.Order:ParseClient.JSONResponseKeys.UpdatedAt
        ]
        let request = NSMutableURLRequest(URL: parseURLFromParameters(methodParameters, withPathExtension: method))
        request.addValue(ParseClient.Constants.ApplicationID, forHTTPHeaderField: ParseClient.HTTPHeaderFields.ApplicationID)
        request.addValue(ParseClient.Constants.RESTAPIKey, forHTTPHeaderField: ParseClient.HTTPHeaderFields.RESTAPIKey)
        let task = AppDelegate.sharedInstance().session.dataTaskWithRequest(request) { (data, response, error) in
            
            func sendError(error: String) {
                completionHandlerForGET(result: nil, error: error)
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                sendError(error!.localizedDescription)
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2xx!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                print("No data was returned by the request!")
                return
            }
            
            self.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandlerForGET)
        }
        
        task.resume()
        return task
    }
    
    //MARK: POST
     func taskForPOSTMethod(method: String, jsonData: String, completionHandlerForPOST: (result: AnyObject!, error: String?) -> Void) -> NSURLSessionDataTask {
        let request = NSMutableURLRequest(URL: parseURLFromParameters([:],withPathExtension: method))
        request.HTTPMethod = "POST"
        request.addValue(ParseClient.Constants.ApplicationID, forHTTPHeaderField: ParseClient.HTTPHeaderFields.ApplicationID)
        request.addValue(ParseClient.Constants.RESTAPIKey, forHTTPHeaderField: ParseClient.HTTPHeaderFields.RESTAPIKey)
        request.HTTPBody = jsonData.dataUsingEncoding(NSUTF8StringEncoding)
        let task = AppDelegate.sharedInstance().session.dataTaskWithRequest(request) { (data, response, error) in
            func sendError(error: String) {
                print(error)
                completionHandlerForPOST(result: nil, error: error)
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                sendError(error!.localizedDescription)
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2xx!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
            self.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandlerForPOST)
        }
        
        task.resume()
        return task
    }
    
    //MARK: PUT
    func taskForPUTMethod(method: String, jsonData: String, completionHandlerForPUT: (result: AnyObject!, error: String?) -> Void) -> NSURLSessionDataTask {
        let request = NSMutableURLRequest(URL: parseURLFromParameters([:],withPathExtension: method))
        request.HTTPMethod = "PUT"
        request.addValue(ParseClient.Constants.ApplicationID, forHTTPHeaderField: ParseClient.HTTPHeaderFields.ApplicationID)
        request.addValue(ParseClient.Constants.RESTAPIKey, forHTTPHeaderField: ParseClient.HTTPHeaderFields.RESTAPIKey)
        request.HTTPBody = jsonData.dataUsingEncoding(NSUTF8StringEncoding)
        let task = AppDelegate.sharedInstance().session.dataTaskWithRequest(request) { (data, response, error) in
            func sendError(error: String) {
                print(error)
                completionHandlerForPUT(result: nil, error: error)
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                sendError(error!.localizedDescription)
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2xx!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }

            self.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandlerForPUT)
        }
        task.resume()
        return task
    }
    
    
    //MARK: Helpers
    //Convert the Raw JSONData to a Reusable Foundation Object
    private func convertDataWithCompletionHandler(data: NSData, completionHandlerForConvertData: (result: AnyObject!, error: String?) -> Void) {
        var parsedResult: AnyObject!
        do {
            parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
        } catch {
            completionHandlerForConvertData(result: nil, error: "Could not parse the data as JSON: '\(data)'")
        }
        completionHandlerForConvertData(result: parsedResult, error: nil)
    }
    
    //Create a URL from Parameters
    func parseURLFromParameters(parameters: [String: AnyObject], withPathExtension: String? = nil) -> NSURL {
        let components = NSURLComponents()
        components.scheme = ParseClient.Constants.ApiScheme
        components.host = ParseClient.Constants.ApiHost
        components.path = ParseClient.Constants.ApiPath + (withPathExtension ?? "")
        components.queryItems = [NSURLQueryItem]()
        for (key, value) in parameters {
            let queryItem = NSURLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        return components.URL!
    }
    
    // MARK: Shared Instance
    class func sharedInstance() -> ParseClient {
        struct Singleton {
            static var sharedInstance = ParseClient()
        }
        return Singleton.sharedInstance
    }
}
