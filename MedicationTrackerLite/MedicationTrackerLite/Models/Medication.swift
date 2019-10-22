//
//  Medication.swift
//  MedicationTrackerLite
//
//  Created by Niranjan Kumar on 10/21/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct Medication: Codable , Equatable {
    
    var name: String
    var medicationInstructions: String
    var pillCount: Int
    var hasBeenTaken: Bool = false
    var takenSunday: Bool = false
    var takenMonday: Bool = false
    var takenTuesday: Bool = false
    var takenWednesday: Bool = false
    var takenThursday: Bool = false
    var takenFriday: Bool = false
    var takenSaturday: Bool = false
  
}
