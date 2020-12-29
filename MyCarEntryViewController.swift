//
//  MyCarSettingsViewController.swift
//  My cars
//
//  Created by Lazzat Seiilova on 12/26/20.
//  Copyright © 2020 Lazzat Seiilova. All rights reserved.
//

import UIKit

class MyCarEntryViewController: UIViewController, UITextFieldDelegate {
    
    public var completion: ((String, String, Date) -> Void)?
    
    @IBOutlet weak var myCarNameTextField: UITextField?
    @IBOutlet weak var myCarNotesTextField: UITextField?
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var myCarBrandName: String?
    var myCarBrandLogoURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.updateViewConstraints()
        
        myCarNameTextField?.delegate = self
        myCarNotesTextField?.delegate = self
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveTask()
        return true
    }
    
    @IBAction func saveTask() {
        
        if let textField1 = myCarNameTextField?.text, !textField1.isEmpty,
            let textField2 = myCarNotesTextField?.text, !textField2.isEmpty {
            
            let targetDate = datePicker.date
            
            completion?(textField1,textField2, targetDate)
            
        }
        
    }
    
}
