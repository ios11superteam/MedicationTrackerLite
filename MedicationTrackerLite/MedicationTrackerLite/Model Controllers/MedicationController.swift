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
    
//    var today = "Thursday"
    var today: String {
        getToday()
    }

    var todaysMedications: [Medication] {
        switch today {
        case "Sunday":
            return medications.filter { $0.takenSunday == true}
        case "Monday":
            return medications.filter { $0.takenMonday == true}
        case "Tuesday":
            return medications.filter { $0.takenTuesday == true}
        case "Wednesday":
            return medications.filter { $0.takenWednesday == true}
        case "Thursday":
            return medications.filter { $0.takenThursday == true}
        case "Friday":
            return medications.filter { $0.takenFriday == true}
        case "Saturday":
            return medications.filter { $0.takenSaturday == true}
        default:
            return []
        }
    }
    var restOfMedications: [Medication] {
        switch today {
        case "Sunday":
            return medications.filter { $0.takenSunday == false}
        case "Monday":
            return medications.filter { $0.takenMonday == false}
        case "Tuesday":
            return medications.filter { $0.takenTuesday == false}
        case "Wednesday":
            return medications.filter { $0.takenWednesday == false}
        case "Thursday":
            return medications.filter { $0.takenThursday == false}
        case "Friday":
            return medications.filter { $0.takenFriday == false}
        case "Saturday":
            return medications.filter { $0.takenSaturday == false}
        default:
            return []
        }
    }

    init() {
        
            loadFromPersistenceStore()
            
       }
    // MARK: - Methods:
    
    func create(medName: String, medInstruction: String, medPillCount: Int, takenSunday: Bool, takenMonday: Bool, takenTuesday: Bool, takenWednesday: Bool, takenThursday: Bool, takenFriday: Bool, takenSaturday: Bool) {
        let medication = Medication(name: medName, medicationInstructions: medInstruction, pillCount: medPillCount, takenSunday: takenSunday, takenMonday: takenMonday, takenTuesday: takenTuesday, takenWednesday: takenWednesday, takenThursday: takenThursday, takenFriday: takenFriday, takenSaturday: takenSaturday)
        medications.append(medication)
        saveToPersistentStore()
        delegate?.tableView.reloadData()
    }
        
    func update(_ medication: Medication, medName: String, medInstruction: String, medPillCount: Int, takenSunday: Bool, takenMonday: Bool, takenTuesday: Bool, takenWednesday: Bool, takenThursday: Bool, takenFriday: Bool, takenSaturday: Bool) {
        guard let index = medications.firstIndex(of: medication) else { return }
        medications[index].name = medName
        medications[index].pillCount = medPillCount
        medications[index].medicationInstructions = medInstruction
        medications[index].takenSunday = takenSunday
        medications[index].takenMonday = takenMonday
        medications[index].takenTuesday = takenTuesday
        medications[index].takenWednesday = takenWednesday
        medications[index].takenThursday = takenThursday
        medications[index].takenFriday = takenFriday
        medications[index].takenSaturday = takenSaturday
        saveToPersistentStore()
            
        }
    
    func delete(medication: Medication) {
          if let index = medications.firstIndex(of: medication) {
              medications.remove(at: index)
          }
          saveToPersistentStore()
      }
    
    func updateHasBeenTaken(for medication: Medication) {
        if let index = medications.firstIndex(of: medication) {
            if medications[index].hasBeenTaken == false {
                medications[index].hasBeenTaken.toggle()
                medications[index].pillCount -= 1
            } else {
                medications[index].hasBeenTaken.toggle()
            }
            saveToPersistentStore()
        }
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
    
    // MARK: - Helper Methods

    func todaysDate() -> String {
        let date = Date()
        let format = DateFormatter()
        format.timeZone = TimeZone(abbreviation: "PST")
        format.dateFormat = "MM-dd-yyyy"
        let formattedDate = format.string(from: date)
        return formattedDate
     }
    func getDayOfWeek(_ today:String) -> Int? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        formatter.timeZone = TimeZone(abbreviation: "PST")
        guard let todayDate = formatter.date(from: today) else { return nil }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        return weekDay
    }

    func getToday() -> String {
       let today = todaysDate()
        let numberDay = getDayOfWeek(today)
        switch numberDay {
        case 1:
            return "Sunday"
        case 2:
            return "Monday"
        case 3:
            return "Tuesday"
        case 4:
            return "Wednesday"
        case 5:
            return "Thursday"
        case 6:
            return "Friday"
        default:
            return "Saturday"
        }
    
    }
    
    func resetDay() {
        for index in medications.indices {
            medications[index].hasBeenTaken = false
        }
    }
    
    
}
