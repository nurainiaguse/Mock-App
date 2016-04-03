//
//  LocationManager.swift
//  MockApp
//
//  Created by Nuraini Aguse on 4/3/16.
//  Copyright © 2016 Nuraini Aguse. All rights reserved.
//

import UIKit
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    class var sharedInstance : LocationManager {
        struct Static {
            static let instance : LocationManager = LocationManager()
        }
        return Static.instance
    }
    
    var locationManager:CLLocationManager?
    
    override init() {
        super.init()
        self.locationManager = CLLocationManager()
        self.locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        // if the heading changed more than 45 degrees, then the didchange method will be fired
        self.locationManager?.headingFilter = 45
        self.locationManager?.delegate = self
    }
    
    func startUpdatingHeading(){
        self.locationManager?.startUpdatingHeading()
    }
    
    func stopUpdatingHeading(){
        self.locationManager?.stopUpdatingHeading()
    }
    
    /* this function returns the current direction that the device is
    *  pointing at. It starts at 0 if it's pointing to North, 90 to East, and so on
    */
    func getHeading() -> Double {
        var heading = locationManager?.heading?.magneticHeading
        return heading!
    }
    
    

}
