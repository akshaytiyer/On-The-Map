//
//  MapLocationViewController.swift
//  OnTheMap
//
//  Created by Akshay Iyer on 6/28/16.
//  Copyright © 2016 akshaytiyer. All rights reserved.
//

import UIKit
import CoreLocation

class MapLocationViewController: UIViewController, UITextFieldDelegate
{
    //MARK: Properties
    let instance = AppDelegate.sharedInstance()
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    //MARK: Outlets
    @IBOutlet var mapLocation: UITextField!
    
    override func viewDidLoad() {
        mapLocation.delegate = self
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
    }
    
    override func viewWillAppear(animated: Bool) {
        instance.parse.firstName = instance.udacityData.firstName
        instance.parse.lastName = instance.udacityData.lastName
        instance.parse.uniqueKey = instance.udacityData.uniqueKey
    }
    
    //Get the location based on the text input
    @IBAction func getLocation(sender: AnyObject) {
        activityIndicator.hidden = false
        activityIndicator.startAnimating()
        let address = self.mapLocation.text!
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address, completionHandler: {(placemarks, error) -> Void in
            if((error) != nil){
                self.cancelAlertBox()
                self.activityIndicator.stopAnimating()
            }
            if let placemark = placemarks?.first {
                let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                self.instance.parse.latitude = coordinates.latitude
                self.instance.parse.longitude = coordinates.longitude
                self.instance.parse.mapString = self.mapLocation.text
                self.instance.parse.mediaURL = nil
                self.enterMediaURLPage()
                self.activityIndicator.stopAnimating()
            }
        })
        
    }
    
    //MARK: Helper
    //Switch to the next page
    private func enterMediaURLPage() {
        performUIUpdatesOnMain {
            let controller = self.storyboard!.instantiateViewControllerWithIdentifier("MapMediaURLController") as! MapMediaURLController
            self.presentViewController(controller, animated: true, completion: nil)
        }
    }
    
    //MARK: Cancel Function
    private func cancelAlertBox()
    {
        let alertController = UIAlertController(title: "Error", message: "Could not find location", preferredStyle: .Alert)
        let CancelAction = UIAlertAction(title: "Return", style: .Default) { (action) in
            alertController.dismissViewControllerAnimated(true, completion: nil)
        }
        alertController.addAction(CancelAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func backButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}

