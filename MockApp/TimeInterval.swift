//
//  TimeInterval.swift
//  MockApp
//
//  Created by Nuraini Aguse on 4/3/16.
//  Copyright © 2016 Nuraini Aguse. All rights reserved.
//

import UIKit
import CoreLocation
import CoreMotion

class TimeInterval: NSObject {
    
   // var endTime: NSDate
    //var startTime:NSDate
    
    // key is the direction; value is the corresponding time in seconds that the device is pointing to direction
    var heading: [Double:Int]
    var maxDirection: Double?
    var steps: Int = 0
    let pedometer = CMPedometer()
    override init(){
      //  endTime = NSDate()
      //  startTime = NSDate()
        heading = [Double:Int]()
        heading[0.0] = 0
        heading[90.0] = 0
        heading[180.0] = 0
        heading[270.0] = 0
        heading[45.0] = 0
        heading[135.0] = 0
        heading[225.0] = 0
        heading[315.0] = 0
    }
    
    /* Finds the direction in which the device points at the longest
    * for a given duration
    */
    func mostDirectionWithinInterval() -> Double {
        var maxDirection = 0.0
        var maxDuration = 0
        for (direction, duration) in heading {
            if duration > maxDuration {
                maxDuration = duration
                maxDirection = direction
            }
        
        }
        self.maxDirection = maxDirection
        return maxDirection
    }

}
