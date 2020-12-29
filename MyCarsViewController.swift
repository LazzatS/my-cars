//
//  MyCarsViewController.swift
//  My cars
//
//  Created by Lazzat Seiilova on 12/25/20.
//  Copyright © 2020 Lazzat Seiilova. All rights reserved.
//

import UIKit

class MyCarsViewController: UIViewController {
    
    @IBOutlet weak var myCarsTableView: UITableView!
    @IBOutlet weak var introLabel: UILabel!
    
    var cars: [(title: String, notes: String, dates: Date)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myCarsTableView.delegate = self
        myCarsTableView.dataSource = self
    }
    
    
    @IBAction func didTapAddCar(_ sender: Any) {        
        
        guard let myCarEntryVC = storyboard?.instantiateViewController(identifier: "myCarEntryVC") as? MyCarEntryViewController else {
            return
        }
        
        myCarEntryVC.completion = {carName, carNote, carDate in
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
                self.cars.append((title: carName, notes: carNote, dates: carDate))
                self.introLabel.isHidden = true
                self.myCarsTableView.isHidden = false
                self.myCarsTableView.reloadData()
            }
            
        }
        
        navigationController?.pushViewController(myCarEntryVC, animated: true)
    }
}

extension MyCarsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myCarsTableView.deselectRow(at: indexPath, animated: true)
        
        let car = cars[indexPath.row]
        
        guard let myCarSettingsVC = storyboard?.instantiateViewController(identifier: "myCarSettingsVC") as? MyCarSettingsViewController else {
            return
        }
        
        myCarSettingsVC.carName = car.title
        myCarSettingsVC.carNotes = car.notes
        myCarSettingsVC.carDates = car.dates
        
        navigationController?.pushViewController(myCarSettingsVC, animated: true)
    }
}

extension MyCarsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let carCell = myCarsTableView.dequeueReusableCell(withIdentifier: "carCell", for: indexPath) as! myCarTableViewCell
        carCell.textLabel?.text = cars[indexPath.row].title
        let note = cars[indexPath.row].notes
        let date = cars[indexPath.row].dates
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM, dd, YYYY"
        carCell.detailTextLabel?.text = "You planned \(note) on \(formatter.string(from: date))"
        return carCell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            myCarsTableView.beginUpdates()
            cars.remove(at: indexPath.row)
            myCarsTableView.deleteRows(at: [indexPath], with: .fade)
            myCarsTableView.endUpdates()
        }
    }
}

