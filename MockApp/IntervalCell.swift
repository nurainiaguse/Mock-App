//
//  IntervalCell.swift
//  MockApp
//
//  Created by Nuraini Aguse on 4/3/16.
//  Copyright © 2016 Nuraini Aguse. All rights reserved.
//

import UIKit

class IntervalCell: UITableViewCell {

    @IBOutlet weak var timeIntervalLabel: UILabel!
    
    @IBOutlet weak var directionLabel: UILabel!
    
    @IBOutlet weak var stepsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
