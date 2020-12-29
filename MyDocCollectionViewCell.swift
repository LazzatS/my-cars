//
//  MyDocCollectionViewCell.swift
//  My cars
//
//  Created by Lazzat Seiilova on 12/27/20.
//  Copyright © 2020 Lazzat Seiilova. All rights reserved.
//

import UIKit

class MyDocCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var docImageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.docImageView.image = nil
    }

    
}
