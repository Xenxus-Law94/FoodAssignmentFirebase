//
//  FoodTableViewCell.swift
//  com.firestore_assignment
//
//  Created by tunlukhant on 10/25/19.
//  Copyright © 2019 tunlukhant. All rights reserved.
//

import UIKit
import SDWebImage
import FirebaseStorage
import Kingfisher

class FoodTableViewCell: UITableViewCell {

    static let identifier = "FoodTableViewCell"
    
//    var mFoods : AssignmentVO? {
//        if let foods = self.mFoods {
//            ivFood.sd_setImage(with: URL(string: foods.imageUrl ?? "")) { (image, error, cacheType, url) in
//                self.ivFood.image = image
//            }
//            self.ivFoodName.text = foods.foodName
//           self.lblWaitingTime.text = "Prep in \(foods.waitingTime ?? "")"
//           self.lblAmount.text = "$ \(foods.amount ?? "")"
//
//        }
//    }
    
//    var imageReference: StorageReference!
    
    var mFoods: AssignmentVO? {
        didSet {
            if let mFoods = mFoods {
                let url = URL(string: mFoods.imageUrl ?? "")!
                let resources = ImageResource(downloadURL: url)
                self.ivFood.kf.setImage(with: resources) { (result) in
                    switch result {
                        
                    case .success(_):
                        print("success")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
//                ivFood.sd_setImage(with: URL(string: mFoods.imageUrl ?? "")) { (image, error, cacheType, url) in
//                     self.ivFood.image = image
//                 }
                 self.ivFoodName.text = mFoods.foodName
                 self.lblWaitingTime.text = "Prep in \(mFoods.waitingTime ?? "")"
                 self.lblAmount.text = "$ \(mFoods.amount ?? "")"
                
                switch mFoods.rating {
                case "1":
                    self.ivRating.image = UIImage(named: "1stars")
                case "2":
                    self.ivRating.image = UIImage(named: "2stars")
                case "3":
                    self.ivRating.image = UIImage(named: "3stars")
                case "4":
                    self.ivRating.image = UIImage(named: "4stars")
                case "5":
                    self.ivRating.image = UIImage(named: "5stars")
                default:
                    break
                }
            }
        }
    }
    
    @IBOutlet weak var ivFood: UIImageView!
    @IBOutlet weak var ivFoodName: UILabel!
    @IBOutlet weak var ivRating: UIImageView!
    @IBOutlet weak var lblWaitingTime: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
