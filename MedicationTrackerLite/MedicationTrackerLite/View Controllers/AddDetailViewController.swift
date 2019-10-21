//
//  AddDetailViewController.swift
//  MedicationTrackerLite
//
//  Created by Dennis Rudolph on 10/21/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class AddDetailViewController: UIViewController {

    @IBOutlet weak var medicationName: UITextField!
    
    @IBOutlet weak var numberofPills: UITextField!
    
    @IBOutlet weak var sundayButton: UIButton!
    
    @IBOutlet weak var mondayButton: UIButton!
    @IBOutlet weak var tuesdayButton: UIButton!
    @IBOutlet weak var wednesdayButton: UIButton!
    @IBOutlet weak var thursdayButton: UIButton!
    @IBOutlet weak var fridayButton: UIButton!
    @IBOutlet weak var saturdayButton: UIButton!
    

    @IBOutlet weak var instructionsTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func savebuttonTapped(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func sundayTapped(_ sender: UIButton) {
    }
    @IBAction func mondayTapped(_ sender: UIButton) {
    }
    @IBAction func tuesdayTapped(_ sender: UIButton) {
    }
    @IBAction func wednesdayTapped(_ sender: UIButton) {
    }
    @IBAction func thursdayTapped(_ sender: UIButton) {
    }
    @IBAction func fridayTapped(_ sender: UIButton) {
    }
    @IBAction func saturdayTapped(_ sender: UIButton) {
    }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
