//
//  DocImages.swift
//  My cars
//
//  Created by Lazzat Seiilova on 12/27/20.
//  Copyright © 2020 Lazzat Seiilova. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct DocImage {
    let key: String!
    let url: String!
    
    let itemReference: DatabaseReference?
    
    init(url: String, key: String) {
        self.key = key
        self.url = url
        self.itemReference = nil
    }
    
    init(snapshot: DataSnapshot) {
        key = snapshot.key
        itemReference = snapshot.ref
        
        let snapshotValue = snapshot.value as? NSDictionary
        
        if let imageURL = snapshotValue?["url"] as? String {
            url = imageURL
        } else {
            url = ""
        }
    }
}
