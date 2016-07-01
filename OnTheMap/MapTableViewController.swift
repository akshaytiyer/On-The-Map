//
//  MapTableViewController.swift
//  OnTheMap
//
//  Created by Akshay Iyer on 6/28/16.
//  Copyright © 2016 akshaytiyer. All rights reserved.
//

import UIKit

class MapTableViewController: UITableViewController
{
    //MARK: Properties
    var parseData = ParseFetchedData.sharedInstance().parseData
    
    //MARK: Outlets
    @IBOutlet var parseTableView: UITableView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        ParseClient.sharedInstance().getParseData { (result, error) in
            if let result = result {
                self.parseData = result
            performUIUpdatesOnMain({ 
                self.parseTableView.reloadData()
            })
            }
            else {
                self.dismissApp()
            }
        }
    }
    
    //MARK: UITableViewDelegate Methods
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parseData.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ParseTableViewCell", forIndexPath: indexPath)
        let data = parseData[indexPath.row]
        cell.textLabel?.text = "\(data.firstName) \(data.lastName)"
        cell.imageView?.image = UIImage(named: "pin")
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let data = parseData[indexPath.row]
        let mediaURL = data.mediaURL
        let app = UIApplication.sharedApplication()
        if app.canOpenURL(NSURL(string: mediaURL)!) == false {
            self.errorAlertBox()
        }
        else
        {
        app.openURL(NSURL(string: mediaURL)!)
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
    
    //Logout
    private func dismissApp()
    {
        let alertController = UIAlertController(title: "Error", message: "Unexpected Server Side Error Encountered", preferredStyle: .Alert)
        let CancelAction = UIAlertAction(title: "Logout", style: .Default) { (action) in
            UdacityClient.sharedInstance().deleteUdacityUserData { (success, errorString) in
                if success {
                    self.completeLogout()
                }
            }
        }
        alertController.addAction(CancelAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    //MARK: Login Button
    private func completeLogout() {
        performUIUpdatesOnMain {
            let controller = self.storyboard!.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
            self.presentViewController(controller, animated: false, completion: nil)
        }
    }
    
}
