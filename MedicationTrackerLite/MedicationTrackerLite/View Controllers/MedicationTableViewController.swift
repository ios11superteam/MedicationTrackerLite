//
//  MedicationTableViewController.swift
//  MedicationTrackerLite
//
//  Created by Niranjan Kumar on 10/22/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class MedicationTableViewController: UITableViewController, MedicationTableViewDelegate {
    
    // MARK: - Properties:
    
    var medicationController = MedicationController()
    
    // MARK: - Methods:
    
    // Runs once view loads. Sets the day in user defaults and sets the controllers delegate to itself.
    override func viewDidLoad() {
        let defaults = UserDefaults.standard
        defaults.set(medicationController.today, forKey: "day")
        super.viewDidLoad()
        medicationController.delegate = self
        }
    
    // Runs before the view will appear. Compares current day to saved day in order to run resetDay() method.
    override func viewWillAppear(_ animated: Bool) {
        let day = UserDefaults.standard.string(forKey: "day") ?? ""
        let newDay = medicationController.getToday()
        if newDay != day {
            medicationController.resetDay()
        }
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // Using the inputted cell, this gets its respective medication and updates its hasBeenTaken property.
    func hasBeenTaken(for cell: MedicationTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let medication = medicationFor(indexPath)
        medicationController.updateHasBeenTaken(for: medication)
        tableView.reloadData()
    }
    
    // Finds the specific medication relative to the cells indexPath.
    func medicationFor( _ indexPath: IndexPath) -> Medication {
        if indexPath.section == 0 {
            return medicationController.todaysMedications[indexPath.row]
        } else {
            return medicationController.restOfMedications[indexPath.row]
        }
    }
    

    
    // MARK: - Table view data source
    
    // Returns the number of sections in the table. (Today's Medications and the Rest of Medications)
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // Returns the number of rows in each section of the table based on the amount of medications taken today
    // and the amount of medications that aren't taken today
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return medicationController.todaysMedications.count
        } else {
            return medicationController.restOfMedications.count
        }
    }
    
    // Allows for cells to be reused, downcasts to our MedicationTableViewCell, sets the medication and two delegates in that class.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MedicationCell", for: indexPath) as? MedicationTableViewCell else { return UITableViewCell() }
        
        let medication = medicationFor(indexPath)
        cell.medication = medication
        cell.delegate = self
        cell.refillDelegate = self
        
        return cell
    }
    
    // Sets the titles for each section.
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "\(medicationController.today)'s Medications"
        } else {
            return "All Medications"
        }
    }
    // Calls the delete function when the user swipes to delete.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            medicationController.delete(medication: medicationFor(indexPath))
            tableView.reloadData()
        }
    }
        
    // MARK: - Navigation
    
    // Prepares each destination with appropriate info based on their segue. In this case a MedicationController and a Medication.
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
