//
//  MedicationController.swift
//  MedicationTrackerLite
//
//  Created by Dennis Rudolph on 10/21/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class MedicationController {
    var medications: [Medication] = []
    var mondaySelected: [Medication] {
        return medications.filter { $0.takenMonday == true}
}
}
