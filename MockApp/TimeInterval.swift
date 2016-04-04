//
//  TimeInterval.swift
//  MockApp
//
//  Created by Nuraini Aguse on 4/3/16.
//  Copyright © 2016 Nuraini Aguse. All rights reserved.
//

import UIKit
import CoreLocation

class TimeInterval: NSObject {
    
    var endTime: NSDate
    var startTime:NSDate
    var heading: NSMutableDictionary
    var steps: Int = 0
    override init(){
        endTime = NSDate()
        startTime = NSDate()
        heading = NSMutableDictionary()
        
        /* heading dictionary stores the number of minutes/seconds that
        * the device is pointing to each location below:
        */
        heading[0.0] = 0
        heading[90.0] = 0
        heading[180.0] = 0
        heading[270.0] = 0
        heading[45.0] = 0
        heading[135.0] = 0
        heading[225.0] = 0
        heading[315.0] = 0
    }
    
    func mostDirectionWithinInterval() -> Double {
        let values = heading.allValues
        
    }

}
