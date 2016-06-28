//
//  ViewController.swift
//  OnTheMap
//
//  Created by Akshay Iyer on 6/27/16.
//  Copyright © 2016 akshaytiyer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let unescapedString = ParseClient.JSONParameterValues.uniqueID
        let escapedString = unescapedString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())
        let methodParameters: [String: AnyObject!] = [
            ParseClient.JSONParameterKeys.Where: unescapedString
        ]
    
        
        // Do any additional setup after loading the view, typically from a nib.
        ParseClient.sharedInstance().taskForGETMethod(ParseClient.Methods.StudentLocation, parameters: methodParameters) { (result, error) in
            print(result)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

