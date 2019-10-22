//
//  MedicationController.swift
//  MedicationTrackerLite
//
//  Created by Dennis Rudolph on 10/21/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class MedicationController {
    
    var delegate: MedicationTableViewController?
    
    var medications: [Medication] = []
    
    var sundaySelected: [Medication] {
        return medications.filter { $0.takenMonday == true}
    }
    var mondaySelected: [Medication] {
        return medications.filter { $0.takenMonday == true}
    }
    var tuesdaySelected: [Medication] {
        return medications.filter { $0.takenMonday == true}
    }
    var wednesdaySelected: [Medication] {
        return medications.filter { $0.takenMonday == true}
    }
    var thursdaySelected: [Medication] {
        return medications.filter { $0.takenMonday == true}
    }
    var fridaySelected: [Medication] {
        return medications.filter { $0.takenMonday == true}
    }
    var saturdaySelected: [Medication] {
        return medications.filter { $0.takenMonday == true}
    }
    
    // MARK: - Methods:
    
    func create(medName: String, medInstruction: String, medPillCount: Int, takenSunday: Bool, takenMonday: Bool, takenTuesday: Bool, takenWednesday: Bool, takenThursday: Bool, takenFriday: Bool, takenSaturday: Bool) {
        let medication = Medication(name: medName, medicationInstructions: medInstruction, pillCount: medPillCount, takenSunday: takenSunday, takenMonday: takenMonday, takenTuesday: takenTuesday, takenWednesday: takenWednesday, takenThursday: takenThursday, takenFriday: takenFriday, takenSaturday: takenSaturday)
        medications.append(medication)
        saveToPersistentStore()
        delegate?.tableView.reloadData()
    }
        
    func update(_ medication: Medication, medName: String, medInstruction: String, medPillCount: Int, takenSunday: Bool, takenMonday: Bool, takenTuesday: Bool, takenWednesday: Bool, takenThursday: Bool, takenFriday: Bool, takenSaturday: Bool) {
            
        }
    
    func hasBeenTaken(for medication: Medication) {
        guard let medicationIndex = medications.firstIndex(of: medication) else { return }
        
        medications[medicationIndex].hasBeenTaken.toggle()
        saveToPersistentStore()
    }
    
    
    
    // MARK: - Persistence
    
    private var medicationListURL: URL? {
        let fm = FileManager.default
        guard let dir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return dir.appendingPathComponent("MedicineList.plist")
    }
    
        func saveToPersistentStore() {
            guard let url = medicationListURL else { return }
            
            do {
                let encoder = PropertyListEncoder()
                let medicineData = try encoder.encode(medications)
                try  medicineData.write(to: url)
            } catch {
                print("Error loading medicine item data: \(error)")
                
            }
        }
        
         func loadFromPersistenceStore(){
            guard let url = medicationListURL else { return }
            do {
                let decoder = PropertyListDecoder()
                let data = try Data(contentsOf: url)
                let decodedItems = try decoder.decode([Medication].self, from: data)
                medications = decodedItems
            } catch {
                print("Error loading medicine item data: \(error)")
            }
        }
    
    
    
}
