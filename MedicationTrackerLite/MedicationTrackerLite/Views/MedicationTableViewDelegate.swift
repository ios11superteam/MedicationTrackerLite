//
//  MedicationTableViewDelegate.swift
//  MedicationTrackerLite
//
//  Created by Dennis Rudolph on 10/22/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

protocol MedicationTableViewDelegate {
    func hasBeenTaken(for cell: MedicationTableViewCell)
}
