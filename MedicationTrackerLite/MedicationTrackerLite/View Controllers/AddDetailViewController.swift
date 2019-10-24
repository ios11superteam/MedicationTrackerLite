//
//  AddDetailViewController.swift
//  MedicationTrackerLite
//
//  Created by Niranjan Kumar on 10/21/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class AddDetailViewController: UIViewController {
    
    // MARK: - Properties:

    @IBOutlet weak var medicationName: UITextField!
    
    @IBOutlet weak var numberofPills: UITextField!
    
    @IBOutlet weak var sundayButton: UIButton!
    
    @IBOutlet weak var mondayButton: UIButton!
    @IBOutlet weak var tuesdayButton: UIButton!
    @IBOutlet weak var wednesdayButton: UIButton!
    @IBOutlet weak var thursdayButton: UIButton!
    @IBOutlet weak var fridayButton: UIButton!
    @IBOutlet weak var saturdayButton: UIButton!

    
    var medicationController: MedicationController?
    var medication: Medication?

    @IBOutlet weak var instructionsTextField: UITextView!
    
    
    // MARK: - Methods:

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
    }
    
    // viewWillDisappear is the method where the viewController goes away no matter how (whether through a back button, or a save button)
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        save()
    }
    
    
        // the higher level method that changes the boolean value of each day
    private func clicked(button: UIButton) -> Bool {
        let wasClicked: Bool
        if button.isSelected == true {
                   wasClicked = true
               } else {
                   wasClicked = false
               }
        return wasClicked
    }
    
    
        // Because our save method is in the viewWillDisappear, we only need to make this IBAction pop back to the rootViewController, which will cause the vWD func to occur
    @IBAction func savebuttonTapped(_ sender: UIBarButtonItem) {
        navigationController?.popToRootViewController(animated: true)
    }

    
    // For each day, we have created the abiliy to change the "checkmark" image based on the value of that button.
    @IBAction func sundayTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected == true {
            let circleFillImage = UIImage(systemName: "checkmark.circle")
            sender.setImage(circleFillImage, for: .selected)
        } else {
            let circleImage = UIImage(systemName: "circle")
            sender.setImage(circleImage, for: .normal)
        }
    }
    @IBAction func mondayTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected == true {
            let circleFillImage = UIImage(systemName: "checkmark.circle")
            sender.setImage(circleFillImage, for: .selected)
        } else {
            let circleImage = UIImage(systemName: "circle")
            sender.setImage(circleImage, for: .normal)
        }
        
    }
    @IBAction func tuesdayTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected == true {
            let circleFillImage = UIImage(systemName: "checkmark.circle")
            sender.setImage(circleFillImage, for: .selected)
        } else {
            let circleImage = UIImage(systemName: "circle")
            sender.setImage(circleImage, for: .normal)
        }
    }
    @IBAction func wednesdayTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected == true {
            let circleFillImage = UIImage(systemName: "checkmark.circle")
            sender.setImage(circleFillImage, for: .selected)
        } else {
            let circleImage = UIImage(systemName: "circle")
            sender.setImage(circleImage, for: .normal)
        }
    }
    @IBAction func thursdayTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected == true {
            let circleFillImage = UIImage(systemName: "checkmark.circle")
            sender.setImage(circleFillImage, for: .selected)
        } else {
            let circleImage = UIImage(systemName: "circle")
            sender.setImage(circleImage, for: .normal)
        }
    }
    @IBAction func fridayTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected == true {
            let circleFillImage = UIImage(systemName: "checkmark.circle")
            sender.setImage(circleFillImage, for: .selected)
        } else {
            let circleImage = UIImage(systemName: "circle")
            sender.setImage(circleImage, for: .normal)
        }
    }
    @IBAction func saturdayTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected == true {
            let circleFillImage = UIImage(systemName: "checkmark.circle")
            sender.setImage(circleFillImage, for: .selected)
        } else {
            let circleImage = UIImage(systemName: "circle")
            sender.setImage(circleImage, for: .normal)
        }
    }
    
    
    // This unwraps the textfield values and changes the medication.takenXday value by calling the respective day UIButton
     func updateViews() {
        if let medication = medication {
            medicationName.text = medication.name
            numberofPills.text = String(medication.pillCount)
            instructionsTextField.text = medication.medicationInstructions
            self.title = "Detail"
            if medication.takenSunday {
                sundayTapped(sundayButton)
            }
            if medication.takenMonday {
                mondayTapped(mondayButton)
            }
            if medication.takenTuesday {
                tuesdayTapped(tuesdayButton)
            }
            if medication.takenWednesday {
                wednesdayTapped(wednesdayButton)
            }
            if medication.takenThursday {
                thursdayTapped(thursdayButton)
            }
            if medication.takenFriday {
                fridayTapped(fridayButton)
            }
            if medication.takenSaturday {
                saturdayTapped(saturdayButton)
            }
        }
    }
    
        // Using our higher level clicked method, we call in each days's value to actually change the boolean value of each day.
    func save() {
        guard let name = medicationName.text, !name.isEmpty else { return }
        guard let numberString = numberofPills.text, !numberString.isEmpty else { return }
        guard let number = Int(numberString) else { return }
        guard let instructions = instructionsTextField.text else { return }
        let sunday = clicked(button: sundayButton)
        let monday = clicked(button: mondayButton)
        let tuesday = clicked(button: tuesdayButton)
        let wednesday = clicked(button: wednesdayButton)
        let thursday = clicked(button: thursdayButton)
        let friday = clicked(button: fridayButton)
        let saturday = clicked(button: saturdayButton)
        
        
        // Over here, we pass in that information dependent on whether the medication has been created, or is being updated.
        if let medication = medication {
            medicationController?.update(medication, medName: name, medInstruction: instructions, medPillCount: number, takenSunday: sunday, takenMonday: monday, takenTuesday: tuesday, takenWednesday: wednesday, takenThursday: thursday, takenFriday: friday, takenSaturday: saturday)
        } else {
            medicationController?.create(medName: name, medInstruction: instructions, medPillCount: number, takenSunday: sunday, takenMonday: monday, takenTuesday: tuesday, takenWednesday: wednesday, takenThursday: thursday, takenFriday: friday, takenSaturday: saturday)
        }
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
