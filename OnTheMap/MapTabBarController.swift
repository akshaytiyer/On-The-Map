//
//  MapTabBarController.swift
//  OnTheMap
//
//  Created by Akshay Iyer on 6/29/16.
//  Copyright © 2016 akshaytiyer. All rights reserved.
//

import UIKit

class MapTabBarController: UITabBarController {
    
    //MARK: Update the user location button
    @IBAction func updateUdacityUserLocation(sender: AnyObject) {
        if AppDelegate.sharedInstance().flag! == true {
            let alertController = UIAlertController(title: "Warning", message: "You have already posted your student location, would you like to override that student location", preferredStyle: .Alert)
            let OKAction = UIAlertAction(title: "Overwrite", style: .Default) { (action) in
                let ViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MapLocationViewController") as! MapLocationViewController
                self.presentViewController(ViewController, animated: true, completion: nil)
            }
            let CancelAction = UIAlertAction(title: "Cancel", style: .Default) { (action) in
                alertController.dismissViewControllerAnimated(true, completion: nil)
            }
            alertController.addAction(OKAction)
            alertController.addAction(CancelAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        else {
            let ViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MapLocationViewController") as! MapLocationViewController
            self.presentViewController(ViewController, animated: true, completion: nil)
        }
    }
    
    //MARK: The logout button
    @IBAction func logoutButton(sender: AnyObject) {
        UdacityClient.sharedInstance().deleteUdacityUserData { (success, errorString) in
            if success {
                self.completeLogout()
            }
        }
    }
    
    //MARK: Login Button
    private func completeLogout() {
        performUIUpdatesOnMain {
            let controller = self.storyboard!.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
            self.presentViewController(controller, animated: false, completion: nil)
        }
    }
}
