//
//  CarBrandInfo.swift
//  My cars
//
//  Created by Lazzat Seiilova on 12/29/20.
//  Copyright © 2020 Lazzat Seiilova. All rights reserved.
//

import UIKit

class CarBrandInfo: UIViewController {
    
    @IBOutlet weak var chosenCarBrandNameLabel: UILabel!
    @IBOutlet weak var chosenCarBrandLogoImage: UIImageView!
    
    var myCarBrandName: String!
    var myCarBrandLogoURL: String!
    let carLogoDefault: String = "https://image.freepik.com/free-vector/car-logo-line-art-design_23-2147492081.jpg"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chosenCarBrandNameLabel.text = myCarBrandName
        logoLoader()
        
    }
    
    func logoLoader() {
        if let logoSource = URL(string: myCarBrandLogoURL ?? carLogoDefault) {
            do {
                let logoData = try Data(contentsOf: logoSource)

                DispatchQueue.main.async {
                    self.chosenCarBrandLogoImage?.image = UIImage(data: logoData)
                }
            }
            catch let error {
                print("\(error) while retrieving url for logo")
            }
        }

    }
}
