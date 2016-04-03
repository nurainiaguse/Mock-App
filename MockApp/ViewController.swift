//
//  ViewController.swift
//  MockApp
//
//  Created by Nuraini Aguse on 4/3/16.
//  Copyright © 2016 Nuraini Aguse. All rights reserved.
//

import UIKit
import CoreMotion
import CoreLocation

// define macros
let EAST = 90.0
let WEST = 270.0
let NORTH = 0.0
let SOUTH = 180.0
let NORTHEAST = 45.0
let NORTHWEST = 315.0
let SOUTHEAST = 135.0
let SOUTHWEST = 225.0
let RANGE = 45.0/2

class ViewController: UIViewController, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate {
    // create an array of time interval objectst to populate the cells
    var timeIntervalArray = [TimeInterval]()
    var locationManager = CLLocationManager()
    var timeInterval = TimeInterval() // current time interval object that we are working with
    var currHeading: Double = 0.0
    @IBOutlet weak var intervalTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        intervalTableView.dataSource = self
        intervalTableView.delegate = self
        
        // if the heading changed more than 45 degrees, then didUpdateHeading will be fired
        locationManager.headingFilter = 45
        
        // request authorization from user for app to always use location
        if CLLocationManager.authorizationStatus() == .NotDetermined {
           locationManager.requestAlwaysAuthorization()
        }
        
        // start updating the heading
        locationManager.startUpdatingHeading()
        currHeading = (locationManager.heading?.magneticHeading)! // get the current heading
        intervalTableView.reloadData()
    }
  
    
    /* The location manager object calls this method after you initially start the heading service.
    * Subsequent events are delivered when the previously reported value changes by more than
    * the value specified in the headingFilter property of the location manager object.
    */
    func locationManager(_manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        intervalTableView.reloadData()
    }
    
    
    /* Have to find swift function that can call this function after a period of time*/
    func afterTimeInterval() {
        timeIntervalArray.append(timeInterval) // add the current object to the array
        timeInterval = TimeInterval() // reset the object. is there a better way to do this?
        intervalTableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return timeIntervalArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = intervalTableView.dequeueReusableCellWithIdentifier("intervalCell", forIndexPath: indexPath) as! IntervalCell
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}

