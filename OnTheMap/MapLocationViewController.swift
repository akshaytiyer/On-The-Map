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
    
    //MARK: Outlets
    @IBOutlet var mapLocation: UITextField!
    
    override func viewDidLoad() {
        mapLocation.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        instance.parse.firstName = instance.udacityData.firstName
        instance.parse.lastName = instance.udacityData.lastName
        instance.parse.uniqueKey = instance.udacityData.uniqueKey
    }
    
    //Get the location based on the text input
    @IBAction func getLocation(sender: AnyObject) {
        let address = self.mapLocation.text!
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address, completionHandler: {(placemarks, error) -> Void in
            if((error) != nil){
                print("Error", error)
            }
            if let placemark = placemarks?.first {
                let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                self.instance.parse.latitude = coordinates.latitude
                self.instance.parse.longitude = coordinates.longitude
                self.instance.parse.mapString = self.mapLocation.text
                self.instance.parse.mediaURL = nil
                self.enterMediaURLPage()
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
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

}

