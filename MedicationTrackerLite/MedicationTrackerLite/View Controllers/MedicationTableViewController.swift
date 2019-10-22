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
    
    
    let medicationController = MedicationController()

    override func viewDidLoad() {
        super.viewDidLoad()
        medicationController.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func medicationFor( _ indexPath: IndexPath) -> Medication {
        if indexPath.section == 0 {
            switch medicationController.today {
            case "Sunday":
                return medicationController.sundaySelected[indexPath.row]
            case "Monday":
                return medicationController.mondaySelected[indexPath.row]
            case "Tuesday":
                return medicationController.tuesdaySelected[indexPath.row]
            case "Wednesday":
                return medicationController.wednesdaySelected[indexPath.row]
            case "Thursday":
                return medicationController.thursdaySelected[indexPath.row]
            case "Friday":
                return medicationController.fridaySelected[indexPath.row]
            case "Saturday":
                return medicationController.saturdaySelected[indexPath.row]
            default:
                return medicationController.medications[0]
            }
            
        } else {
            return medicationController.medications[indexPath.row]
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            switch medicationController.today {
            case "Sunday":
                return medicationController.sundaySelected.count
            case "Monday":
                return medicationController.mondaySelected.count
            case "Tuesday":
                return medicationController.tuesdaySelected.count
            case "Wednesday":
                return medicationController.wednesdaySelected.count
            case "Thursday":
                return medicationController.thursdaySelected.count
            case "Friday":
                return medicationController.fridaySelected.count
            case "Saturday":
                return medicationController.saturdaySelected.count
            default:
                return 0
            }
       
        } else {
            return medicationController.medications.count
        }
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MedicationCell", for: indexPath) as? MedicationTableViewCell else { return UITableViewCell() }

        
        let medication = medicationFor(indexPath)
        cell.medication = medication
        cell.delegate = self
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Today's Medications"
        } else {
            return "All Medications"
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddSegue" {
            if let addVC = segue.destination as? AddDetailViewController {
                addVC.medicationController = medicationController
            } else if segue.identifier == "DetailSegue" {
                guard let addVC = segue.destination as? AddDetailViewController,
                    let indexPath = tableView.indexPathForSelectedRow else { return }
                        addVC.medication = medicationFor(indexPath)
                    addVC.medicationController = medicationController
                
                }
            }
            
        }
        
        
        


}
