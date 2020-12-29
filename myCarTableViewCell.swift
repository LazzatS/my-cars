//
//  myCarTableViewCell.swift
//  My cars
//
//  Created by Lazzat Seiilova on 12/28/20.
//  Copyright © 2020 Lazzat Seiilova. All rights reserved.
//

import UIKit

class myCarTableViewCell: UITableViewCell {

    @IBOutlet weak var myCarHomeImageView: UIImageView!
    @IBOutlet weak var myCarHomeNameLabel: UILabel!
    @IBOutlet weak var myCarHomeNotesLabel: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
