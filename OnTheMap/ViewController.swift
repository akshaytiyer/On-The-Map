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
        UdacityClient.sharedInstance().taskForGETMethod(UdacityClient.Methods.Users, parameters: [:], jsonData: "") { (result, error) in
            print(result)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

