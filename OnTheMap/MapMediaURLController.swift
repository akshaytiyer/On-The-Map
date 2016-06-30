//
//  MapMediaURLController.swift
//  OnTheMap
//
//  Created by Akshay Iyer on 6/29/16.
//  Copyright © 2016 akshaytiyer. All rights reserved.
//

import UIKit
import MapKit
class MapMediaURLController: UIViewController, MKMapViewDelegate, UITextFieldDelegate {
    
    //MARK: Properties
    let instance = AppDelegate.sharedInstance()
    
    //MARK: Outlets
    @IBOutlet var mediaURLTextField: UITextField!
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        mediaURLTextField.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let coordinates = CLLocationCoordinate2D(latitude: self.instance.parse.latitude, longitude: self.instance.parse.longitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinates
        annotation.title = "\(self.instance.parse.firstName) \(self.instance.parse.lastName)"
        performUIUpdatesOnMain({
            let span = MKCoordinateSpanMake(0.05, 0.05)
            let region = MKCoordinateRegion(center: coordinates, span: span)
            self.mapView.setRegion(region, animated: true)
            self.mapView.addAnnotation(annotation)
        })
    }
    
    //MARK: Update the data available in Parse
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

    //MARK: Helper, to create JSONData
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
    
    //MARK: MKMapViewDelegate
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = UIColor.darkGrayColor()
            pinView!.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }

    //MARK: Return to home screen
    private func returnToHome() {
        performUIUpdatesOnMain {
            let controller = self.storyboard!.instantiateViewControllerWithIdentifier("NavigationController") as! UINavigationController
            self.presentViewController(controller, animated: true, completion: nil)
        }
    }
    
    //UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
