//
//  InfoViewController.swift
//  MedicationTrackerLite
//
//  Created by Niranjan Kumar on 10/24/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit
import QuartzCore

class InfoViewController: UIViewController {
    
    @IBOutlet weak var howToLabel: UILabel!
    @IBOutlet weak var howToInfoLabel: UILabel!

    var timer: Timer?


    override func viewDidLoad() {
        super.viewDidLoad()
        design()
    }
    
    
    
    private func design() {
        howToLabel.layer.cornerRadius = 5
        howToLabel.layer.masksToBounds = true
        howToInfoLabel.layer.cornerRadius = 5
        howToInfoLabel.layer.masksToBounds = true
    }
    

}
