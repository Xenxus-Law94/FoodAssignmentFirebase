//
//  AssignmentVO.swift
//  com.firestore_assignment
//
//  Created by tunlukhant on 10/25/19.
//  Copyright © 2019 tunlukhant. All rights reserved.
//

import Foundation

struct AssignmentVO {
    var amount: String?
    var foodName: String?
    var imageUrl: String?
    var rating: String?
    var waitingTime: String?
    var id: String
    var dictionary: [String: Any] {
        return [
            "amount": amount!,
            "food_name": foodName!,
            "imageUrl": imageUrl!,
            "rating": rating!,
            "waiting_time": waitingTime!
        ]
    }
}

extension AssignmentVO {
    init?(dictionary: [String: Any], id: String) {
        guard let amount = dictionary["amount"] as? String, let foodName = dictionary["food_name"] as? String,
        let imageUrl = dictionary["imageUrl"] as? String, let rating = dictionary["rating"] as? String,
            let waitingTime = dictionary["waiting_time"] as? String else {
                return nil
        }
        self.init(amount: amount, foodName: foodName, imageUrl: imageUrl, rating: rating, waitingTime: waitingTime, id: id)
    }
}
