//
//  MapMediaURLController.swift
//  OnTheMap
//
//  Created by Akshay Iyer on 6/29/16.
//  Copyright © 2016 akshaytiyer. All rights reserved.
//

import UIKit
class MapMediaURLController: UIViewController {
    
    let instance = AppDelegate.sharedInstance()
    
    @IBOutlet var mediaURLTextField: UITextField!
    @IBAction func updateParseData(sender: AnyObject) {
        instance.parse.mediaURL = mediaURLTextField.text
        createJSONDataForParse(instance.parse, flag: instance.flag) { (jsonData, success, error) in
            if success {
                ParseClient.sharedInstance().updateParseData(self.instance.flag, jsonData: jsonData, completionHandlerForParseData: { (result, error) in
                    if result {
                       self.returnToHome()
                    }
                    else {
                        print(error)
                    }
                })
            }
        }
    }

    private func createJSONDataForParse(parseData: Parse!, flag: Bool!, completionHandlerForParse: (jsonData: String!, success: Bool, error: String!) -> Void) {
        if flag == false {
            
            let results = "{\"\(ParseClient.JSONResponseKeys.UniqueID)\":\"\(parseData.uniqueKey)\",\"\(ParseClient.JSONResponseKeys.FirstName)\": \"\(parseData.firstName)\", \"\(ParseClient.JSONResponseKeys.LastName)\": \"\(parseData.lastName)\",\"\(ParseClient.JSONResponseKeys.MapString)\": \"\(parseData.mapString)\", \"\(ParseClient.JSONResponseKeys.MediaURL)\": \"\(parseData.mediaURL)\",\"\(ParseClient.JSONResponseKeys.Latitude)\": \(parseData.latitude), \"\(ParseClient.JSONResponseKeys.Longitude)\": \(parseData.longitude)}"
            
            completionHandlerForParse(jsonData: results, success: true, error: nil)
        }
        else if flag == true {
            
            let results = "{\"\(ParseClient.JSONResponseKeys.MapString)\": \"\(parseData.mapString)\", \"\(ParseClient.JSONResponseKeys.MediaURL)\": \"\(parseData.mediaURL)\", \"\(ParseClient.JSONResponseKeys.Latitude)\": \(parseData.latitude), \"\(ParseClient.JSONResponseKeys.Longitude)\": \(parseData.longitude)}"
            
            completionHandlerForParse(jsonData: results, success: true, error: nil)
        } else {
            completionHandlerForParse(jsonData: nil, success: false, error: "The Flag is Nil")
        }
        
    }
    
    private func returnToHome() {
        performUIUpdatesOnMain {
            let controller = self.storyboard!.instantiateViewControllerWithIdentifier("NavigationController") as! UINavigationController
            self.presentViewController(controller, animated: true, completion: nil)
        }
    }
}
