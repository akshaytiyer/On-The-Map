//
//  MapMapViewController.swift
//  OnTheMap
//
//  Created by Akshay Iyer on 6/28/16.
//  Copyright © 2016 akshaytiyer. All rights reserved.
//

import UIKit
import MapKit

class MapMapViewController: UIViewController, MKMapViewDelegate
{
    //MARK: Properties
    var parseData = ParseFetchedData.sharedInstance().parseData
    var annotations = [MKPointAnnotation]()
    
    //MARK: Methods
    @IBOutlet var parseMapView: MKMapView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        ParseClient.sharedInstance().getParseData { (result, error) in
            if let result = result {
                self.parseData = result
                for data in self.parseData {
                    let lattitude = CLLocationDegrees(data.latitude)
                    let longitude = CLLocationDegrees(data.longitude)
                    let coordinates = CLLocationCoordinate2D(latitude: lattitude, longitude: longitude)
                    
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coordinates
                    annotation.title = "\(data.firstName) \(data.lastName)"
                    annotation.subtitle = data.mediaURL
                    
                   self.annotations.append(annotation)
                }
                
                performUIUpdatesOnMain({
                    self.parseMapView.addAnnotations(self.annotations)
                })
            }
            else {
                self.dismissApp()
            }
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
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.sharedApplication()
            if let toOpen = view.annotation?.subtitle! {
            if app.canOpenURL(NSURL(string: toOpen)!) == false {
                    self.errorAlertBox()
                }
            else {
                    app.openURL(NSURL(string: toOpen)!)
                }
                
            }
        }
    }

    private func errorAlertBox()
    {
        let alertController = UIAlertController(title: "Error", message: "Cannot open, no valid URL Available", preferredStyle: .Alert)
        let CancelAction = UIAlertAction(title: "Return", style: .Default) { (action) in
            alertController.dismissViewControllerAnimated(true, completion: nil)
        }
        alertController.addAction(CancelAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    private func dismissApp()
    {
        let alertController = UIAlertController(title: "Error", message: "Unexpected Server Side Error Encountered", preferredStyle: .Alert)
        let CancelAction = UIAlertAction(title: "Exit", style: .Default) { (action) in
            UdacityClient.sharedInstance().deleteUdacityUserData { (success, errorString) in
                if success {
                    self.completeLogout()
                }
                else {
                    self.completeLogout()
                }
            }
        }
        alertController.addAction(CancelAction)
        performUIUpdatesOnMain {
            self.presentViewController(alertController, animated: true, completion: nil)
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
