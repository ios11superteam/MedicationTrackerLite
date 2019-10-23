//
//  MedicationTableViewCell.swift
//  MedicationTrackerLite
//
//  Created by Niranjan Kumar on 10/21/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class MedicationTableViewCell: UITableViewCell {
    
    var delegate: MedicationTableViewDelegate?
    var refillDelegate: UITableViewController?
    
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
        if medication.pillCount < 1 {
            pillCountLabel.text = "Delete or Refill"
        }
        if medication.pillCount <= 5 {
            pillCountLabel.textColor = .red
            
        } else {
            pillCountLabel.textColor = .black
        }
        if medication.pillCount == 5 || medication.pillCount == 1 {
            refillAlert()
        }
    }
 
    
    @IBAction func takenButtonTapped(_ sender: UIButton) {
        delegate?.hasBeenTaken(for: self)
    }
    
    func refillAlert() {
        let alert = UIAlertController(title: "Medication Running Low!", message: "Don't forget to refill and update your medication.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default, handler: nil)

        alert.addAction(action)
        guard let validDelegate = refillDelegate else { return }
        validDelegate.present(alert, animated: true, completion: nil)
    }
}
    


