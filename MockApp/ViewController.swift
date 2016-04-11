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
import Foundation

// define macros
let EAST = 90.0
let WEST = 270.0
let NORTH = 0.0
let SOUTH = 180.0
let NORTHEAST = 45.0
let NORTHWEST = 315.0
let SOUTHEAST = 135.0
let SOUTHWEST = 225.0
let RANGE = 45.0/2     // range that we would consider a change in direction

class ViewController: UIViewController, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    // create an array of time interval objects to populate the cells
    var timeIntervalArray = [TimeInterval]()
    var locationManager = CLLocationManager()
    
    // current time interval object that we are working with - to be appended to timeIntervalArray
    var timeInterval = TimeInterval()
    var currHeading: Double = 0.0
    var generalDirection: Double = 0.0
    var date = NSDate()
    var beginTime: Int = 0
    var endTime: Int = 0
    
    @IBOutlet weak var intervalTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        intervalTableView.dataSource = self
        intervalTableView.delegate = self
        
        // if the heading changed more than 45/2 degrees, then locationManager method will be fired
        locationManager.headingFilter = RANGE
        
        // request authorization from user for app to always use location
        if CLLocationManager.authorizationStatus() == .NotDetermined {
           locationManager.requestAlwaysAuthorization()
        }
        
        // call the afterTimeInterval() function after a set amount of time
        NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(100), target: self, selector: "afterTimeInterval", userInfo: nil, repeats: true)
        
        // start updating the heading
        
    }
  
    
    /* The location manager object calls this method after you initially start the heading service.
    * Subsequent events are delivered when the previously reported value changes by more than
    * the value specified in the headingFilter property of the location manager object.
    */
    func locationManager(_manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        endTime = getTime()
        var duration = endTime - beginTime
        // update the duration that the device was pointing at a certain direction
        timeInterval.heading[generalDirection] =  timeInterval.heading[generalDirection]! + duration
        
        // update to the new heading
        locationManager = _manager
        currHeading = (locationManager.heading?.magneticHeading)!
        generalDirection = checkGeneralDirection()
        beginTime = endTime
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedAlways {
            // authorized location status when app is in use; update current location
            //locationManager.startUpdatingLocation()
            locationManager.startUpdatingHeading()
            currHeading = (locationManager.heading?.magneticHeading)! // get the current heading
            generalDirection = checkGeneralDirection() // get the general direction of where the device is pointing at
            beginTime = getTime()
            intervalTableView.reloadData()
            // implement additional logic if needed...
        }
        // implement logic for other status values if needed...
    }
    
    /* This function is called by NSTimer.scheduledTimerWithTimeInterval */
    func afterTimeInterval() {
        timeInterval.pedometer.startPedometerUpdatesFromDate(date){
            (data: CMPedometerData?, error) -> Void in
            dispatch_async(dispatch_get_main_queue(), {
                () -> Void in
                if error == nil {
                    if let steps = data?.numberOfSteps as? Int{
                        self.timeInterval.steps = steps
                    }
                }
            })
        }
        timeInterval.mostDirectionWithinInterval()
        timeIntervalArray.append(timeInterval) // add the current TimeInterval object to the array
        timeInterval = TimeInterval() // reset the TimeInterval object. is there a better way to do this?
        intervalTableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return timeIntervalArray.count  // need to do error checking
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let currTimeInterval = timeIntervalArray[indexPath.row]
        let cell = intervalTableView.dequeueReusableCellWithIdentifier("intervalCell", forIndexPath: indexPath) as! IntervalCell
        cell.timeInterval = currTimeInterval
        return cell
    }
    
    
    /* Function to check the general direction that the device is pointing to */
    func checkGeneralDirection() -> Double{
        if withinRange(EAST) {
            return EAST
        }
        else if withinRange(WEST) {
            return WEST
        }
        else if withinRange(NORTH) {
            return NORTH
        }
        else if withinRange(SOUTH) {
            return SOUTH
        }
        else if withinRange(NORTHEAST) {
            return NORTHEAST
        }
        else if withinRange(NORTHWEST) {
            return NORTHWEST
        }
        else if withinRange(SOUTHWEST) {
            return SOUTHWEST
        }
        else {
            return SOUTHEAST
        }
    }
    
    /* function to check whether currHeading is within param range*/
    func withinRange(direction: Double) -> Bool {
        let lowrange = (direction - RANGE) % 360
        let highrange = (direction + RANGE) % 360
        if currHeading > lowrange && currHeading <= highrange {
            return true
        }
        return false
    }
    
    
    /* Returns the current minute */
    func getTime() -> Int{
        self.date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let second = calendar.component(NSCalendarUnit.Minute, fromDate: self.date)
        return second
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}

