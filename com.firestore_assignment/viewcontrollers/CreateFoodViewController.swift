//
//  CreateFoodViewController.swift
//  com.firestore_assignment
//
//  Created by tunlukhant on 10/25/19.
//  Copyright © 2019 tunlukhant. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage
import SDWebImage
//import Kingfisher

class CreateFoodViewController: UIViewController {
    
    static let DB_COLLECTION_PATH = "Assignment"
    
    static let identifier = "CreateFoodViewController"
    
    var imageReference: StorageReference!
    
    var imageRoute: String?

    @IBOutlet weak var ivFoodImage: UIImageView!
    @IBOutlet weak var tfFoodName: UITextField!
    @IBOutlet weak var tfRating: UITextField!
    @IBOutlet weak var tfWaiting: UITextField!
    @IBOutlet weak var tfAmount: UITextField!
    @IBAction func btnUpload(_ sender: Any) {
        ImagePickerManager().pickImage(self) { (image) in
            self.ivFoodImage.image = image
            guard let image = self.ivFoodImage.image, let data = image.jpegData(compressionQuality: 0.8) else {
                return
            }
            
            self.imageReference.putData(data, metadata: nil) { (metadata, err) in
                if let err = err {
                    print(err.localizedDescription)
                    return
                }
                self.imageReference.downloadURL { (url, error) in
                    if let err = error {
                        print(err.localizedDescription)
                        return
                    }
                    
                    guard let url = url else {
                        return
                    }
                    
                    self.imageRoute = url.absoluteString
                }
            }
            
//            self.showAlertDialog(title: "Success", msg: "Your image is successfully upload to cloud storage")
//            self.imageReference.downloadURL { (url, error) in
//                if let err = error {
//                    print(err.localizedDescription)
//                    return
//                }
//
//                self.imageRoute = url?.path
//
//            }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageName = UUID().uuidString
        imageReference = Storage.storage().reference().child("images").child(imageName)
        // Do any additional setup after loading the view.
        
        
    }
    

    @IBAction func btnCreate(_ sender: Any) {
        let db = Firestore.firestore()
        db.collection(CreateFoodViewController.DB_COLLECTION_PATH).addDocument(data:
        [
            "amount": tfAmount.text ?? "",
            "food_name": tfFoodName.text ?? "",
            "imageUrl": imageRoute ,
            "rating": tfRating.text ?? "",
            "waiting_time": tfWaiting.text ?? ""
        ])
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: FoodMainController.identifier) as! FoodMainController
        
        self.present(vc, animated: true, completion: nil)
    }
    
    func showAlertDialog(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (result) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        present(alert, animated: true)  {
            
        }
    }

}
