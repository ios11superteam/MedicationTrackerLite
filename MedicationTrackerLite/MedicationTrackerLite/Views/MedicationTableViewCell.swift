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
    
    
    var medication: Medication? {
        didSet {
            updateViews()
        }
    }
    
    weak var delegate: MedicationTableViewDelegate?
    
    
    func updateViews() {
        guard let medication = medication else { return }
        medicationNameLabel.text = medication.name
        pillCountLabel.text = String(medication.pillCount)
        
        
        
        let boxImage: String
        if medication.hasBeenTaken {
            boxImage = "checked"
        } else {
            boxImage = "unchecked"
        }
        takenButton.setImage(UIImage(named: boxImage), for: .normal)
    }
     
    
    @IBAction func takenButtonTapped(_ sender: UIButton) {
        delegate?.hasBeenTaken(for: self)
        
    }
}
    

