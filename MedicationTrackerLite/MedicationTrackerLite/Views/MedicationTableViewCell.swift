//
//  MedicationTableViewCell.swift
//  MedicationTrackerLite
//
//  Created by Dennis Rudolph on 10/21/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class MedicationTableViewCell: UITableViewCell {
    
    var delegate: MedicationTableViewDelegate?
    
    @IBOutlet weak var medicationNameLabel: UILabel!
    @IBOutlet weak var pillCountLabel: UILabel!
    @IBOutlet weak var takenButton: UIButton!
    
    
    var medication: Medication? {
        didSet {
            updateViews()
        }
    }
    
    
    func updateViews() {
        guard let medication = medication else { return }
        medicationNameLabel.text = medication.name
        pillCountLabel.text = "Tablets remaining: \(medication.pillCount)"
        let medicationStatus = medication.hasBeenTaken
        if medicationStatus {
            takenButton.setImage(UIImage(named: "checked"), for: .normal)
        } else {
            takenButton.setImage(UIImage(named: "unchecked"), for: .normal)
        }
   
    }
     
    
    @IBAction func takenButtonTapped(_ sender: UIButton) {
        delegate?.hasBeenTaken(for: self)
    }
}
    

