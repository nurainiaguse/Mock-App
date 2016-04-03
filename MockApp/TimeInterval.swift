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
    var heading: [String:Int]
    var steps: Int = 0
    override init(){
        endTime = NSDate()
        startTime = NSDate()
        heading = [String:Int]()
        
        /* heading dictionary stores the number of minutes/seconds that
        * the device is pointing to each location below:
        */
        heading["North"] = 0
        heading["South"] = 0
        heading["East"] = 0
        heading["West"] = 0
        heading["Northwest"] = 0
        heading["Northeast"] = 0
        heading["Southeast"] = 0
        heading["Southwest"] = 0
    }

}
