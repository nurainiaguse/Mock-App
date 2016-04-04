//
//  IntervalCell.swift
//  MockApp
//
//  Created by Nuraini Aguse on 4/3/16.
//  Copyright © 2016 Nuraini Aguse. All rights reserved.
//

import UIKit

class IntervalCell: UITableViewCell {
    
    var timeInterval = TimeInterval()
    
    var direction = [Double:String]()

    @IBOutlet weak var timeIntervalLabel: UILabel!
    
    @IBOutlet weak var directionLabel: UILabel!
    
    @IBOutlet weak var stepsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        direction[0.0] = "North"
        direction[90.0] = "East"
        direction[180.0] = "South"
        direction[270.0] = "West"
        direction[45.0] = "NorthEast"
        direction[135.0] = "SouthEast"
        direction[225.0] = "SouthWest"
        direction[315.0] = "NorthWest"
        directionLabel.text = direction[timeInterval.maxDirection!]
        stepsLabel.text = String(timeInterval.steps)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
