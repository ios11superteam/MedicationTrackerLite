//
//  MedicationTableViewController.swift
//  MedicationTrackerLite
//
//  Created by Niranjan Kumar on 10/22/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class MedicationTableViewController: UITableViewController, MedicationTableViewDelegate {
   
    
    func hasBeenTaken(for cell: MedicationTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let medication = medicationFor(indexPath)
        medicationController.updateHasBeenTaken(for: medication)
        tableView.reloadData()
    }
    
    
    var medicationController = MedicationController()

    override func viewDidLoad() {
        let defaults = UserDefaults.standard
        defaults.set(medicationController.today, forKey: "day")
        super.viewDidLoad()
        medicationController.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        let day = UserDefaults.standard.string(forKey: "day") ?? ""
        let newDay = medicationController.getToday()
        if newDay != day {
            medicationController.resetDay()
        }
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func medicationFor( _ indexPath: IndexPath) -> Medication {
        if indexPath.section == 0 {
            return medicationController.todaysMedications[indexPath.row]
    } else {
            return medicationController.restOfMedications[indexPath.row]
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return medicationController.todaysMedications.count
        } else {
            return medicationController.restOfMedications.count
        }
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MedicationCell", for: indexPath) as? MedicationTableViewCell else { return UITableViewCell() }

        
        let medication = medicationFor(indexPath)
        cell.medication = medication
        cell.delegate = self
        cell.refillDelegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "\(medicationController.today)'s Medications"
        } else {
            return "All Medications"
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                medicationController.delete(medication: medicationFor(indexPath))
                tableView.reloadData()
            }
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddSegue" {
            if let addVC = segue.destination as? AddDetailViewController {
                addVC.medicationController = medicationController
            }
        } else if segue.identifier == "DetailSegue" {
            if let indexPath = tableView.indexPathForSelectedRow,
                let DetailVC = segue.destination as? AddDetailViewController {
                
                DetailVC.medication = medicationFor(indexPath)
                DetailVC.medicationController = medicationController
            }
            
        }
        
    }
    
}
