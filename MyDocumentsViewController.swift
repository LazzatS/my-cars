//
//  MyDocumentsViewController.swift
//  My cars
//
//  Created by Lazzat Seiilova on 12/25/20.
//  Copyright © 2020 Lazzat Seiilova. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase
import SDWebImage

class MyDocumentsViewController: UIViewController, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var myDocsCollectionView: UICollectionView!
    
    var docs = [DocImage]()
    var dbReference: DatabaseReference!
    
    let picker = UIImagePickerController()
    private let storage = Storage.storage().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 350, height: 250)
        myDocsCollectionView.frame = view.bounds
        myDocsCollectionView.collectionViewLayout = layout
        
        dbReference = Database.database().reference().child("images")
        
        picker.delegate = self
        myDocsCollectionView.dataSource = self
        loadDatabase()
    }
    
    func  loadDatabase() {
        
        dbReference.observe(DataEventType.value, with: {(snapshot) in
            var newImages = [DocImage]()
            
            for docSnapshot in snapshot.children {
                let docObject = DocImage(snapshot: docSnapshot as! DataSnapshot)
                newImages.append(docObject)
            }
            
            self.docs = newImages
            self.myDocsCollectionView.reloadData()
        })
        
        myDocsCollectionView.backgroundColor = .white
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return docs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let docCell = myDocsCollectionView.dequeueReusableCell(withReuseIdentifier: "docCell", for: indexPath) as! MyDocCollectionViewCell
        let doc = docs[indexPath.row]
        docCell.docImageView.sd_setImage(with: URL(string: doc.url), placeholderImage: UIImage(named: "image1"))
        return docCell
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        picker.dismiss(animated: true, completion: nil)
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            var data = Data()
            data = pickedImage.jpegData(compressionQuality: 0.8)!
            let imageReference = Storage.storage().reference().child("images/" + randomString(20))
            imageReference.putData(data, metadata: nil) { (metadata, error) in
                guard metadata != nil else {
                    print("error while uploading the data to the path images/randomString")
                    return
                }

                //let size = metadata.size
                //print(downloadURL)

                let key = self.dbReference.childByAutoId().key
                imageReference.downloadURL(completion: { (url, error) in
                    guard let downloadURL = url else {
                        return
                    }

                    let image = ["url" : downloadURL.absoluteString]
                    let childUpdates = ["/\(key!)": image]
                    self.dbReference.updateChildValues(childUpdates)

                })
            }
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    
    @IBAction func didTapAddDoc(_ sender: Any) {
        
        picker.sourceType = .photoLibrary
        picker.allowsEditing = false
        
        present(picker, animated: true, completion: nil)
    }
    
    func randomString(_ length: Int) -> String {
        let letters: NSString = "abcdefghijklmnoprstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        return randomString
    }
    
}
