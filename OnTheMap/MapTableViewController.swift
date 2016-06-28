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
    
    var parseData: [ParseData] = [ParseData]()
    
    @IBOutlet var parseTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
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
                print(error)
            }
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parseData.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ParseTableViewCell", forIndexPath: indexPath)
        let data = parseData[indexPath.row]
        cell.textLabel?.text = "\(data.firstName) \(data.lastName)"
        cell.imageView?.image = UIImage(named: "map")
        return cell
    }
}
