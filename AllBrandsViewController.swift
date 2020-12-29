//
//  AllBrandsViewController.swift
//  My cars
//
//  Created by Lazzat Seiilova on 12/26/20.
//  Copyright © 2020 Lazzat Seiilova. All rights reserved.
//

import UIKit

class AllBrandsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var allBrandsTableView: UITableView?
    @IBOutlet weak var searchBar: UISearchBar?

    
    var data = CarInfoLoader().jsonCarData
    
    var car: Car!
    var filteredData: [Car] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        allBrandsTableView?.delegate = self
        allBrandsTableView?.dataSource = self
        searchBar?.delegate = self

        filteredData = data                     
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let allBrandsCell = allBrandsTableView!.dequeueReusableCell(withIdentifier: "allBrandsCell", for: indexPath)
        allBrandsCell.textLabel?.text = filteredData[indexPath.row].name
        return allBrandsCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let carBrandVC = storyboard?.instantiateViewController(identifier: "carBrandVC") as! CarBrandInfo
        carBrandVC.myCarBrandName = filteredData[indexPath.row].name
        carBrandVC.myCarBrandLogoURL = filteredData[indexPath.row].logo
        navigationController?.pushViewController(carBrandVC, animated: true)
        //self.dismiss(animated: true, completion: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredData = data
        } else {
            filteredData = []
            for searchingBrand in data {
                if searchingBrand.name.lowercased().contains(searchText.lowercased()) {
                    filteredData.append(searchingBrand)
                }
            }
        }
        allBrandsTableView?.reloadData()
    }
    
}


public class CarInfoLoader {
    
    @Published var jsonCarData = [Car]()
    
    init() {
        load()
    }
    
    // MARK: DataLoader
    
    func load() {
        let fileLocation = Bundle.main.path(forResource: "car_brands", ofType: "json")
        let url = URL(fileURLWithPath: fileLocation!)
        
        do {
            let data = try Data(contentsOf: url)
            let jsonData = try JSONDecoder().decode([Car].self, from: data)
            
            self.jsonCarData = jsonData
            
        }
        catch let error {
            print("\(error) while decoding json file")
        }
        
    }
}

struct Car: Codable {
    var logo: String
    var name: String
}

