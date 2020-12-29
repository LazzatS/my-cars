//
//  MyCarSettingsViewController.swift
//  My cars
//
//  Created by Lazzat Seiilova on 12/29/20.
//  Copyright © 2020 Lazzat Seiilova. All rights reserved.
//

import UIKit

class MyCarSettingsViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var myCarNameLabel: UILabel!
    @IBOutlet weak var myCarNotesLabel: UILabel!
    @IBOutlet weak var myCarDatesLabel: UILabel!
    

    public var carName: String = ""
    public var carNotes: String = ""
    public var carDates: Date?
    var myCarBrandName: String?
    var myCarBrandLogoURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM, dd, YYYY"
        
        myCarNameLabel.text = carName
        myCarNotesLabel.text = carNotes
        myCarDatesLabel.text = formatter.string(from: carDates!)
        
    }
}
