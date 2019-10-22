//
//  MedicationTableViewCell.swift
//  MedicationTrackerLite
//
//  Created by Dennis Rudolph on 10/21/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class MedicationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var medicationNameLabel: UILabel!
    @IBOutlet weak var pillCountLabel: UILabel!
    @IBOutlet weak var takenButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func takenButtonTapped(_ sender: UIButton) {
        
    }
    
    
}
