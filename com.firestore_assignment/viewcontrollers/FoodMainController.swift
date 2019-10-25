//
//  ViewController.swift
//  com.firestore_assignment
//
//  Created by tunlukhant on 10/24/19.
//  Copyright © 2019 tunlukhant. All rights reserved.
//

import UIKit
import FirebaseFirestore

class FoodMainController: UIViewController {

    static let identifier = "FoodMainController"
    
    static let DB_COLLECTION_PATH = "Assignment"
    
//    @IBOutlet weak var btnEntrees: UIButton!
    var assignment : [AssignmentVO] = []
    
    var listener : ListenerRegistration!
    
//    @IBOutlet weak var viewRating: UIView!
//    @IBOutlet weak var btnDesserts: UIButton!
//    @IBOutlet weak var btnDrinks: UIButton!
//    @IBOutlet weak var btnMain: UIButton!
//    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnDesserts: UIButton!
    @IBOutlet weak var btnDrinks: UIButton!
    @IBOutlet weak var btnMain: UIButton!
    @IBOutlet weak var btnEntrees: UIButton!
    @IBOutlet weak var viewRating: UIView!
    @IBOutlet weak var tvFoodList: UITableView!
    @IBOutlet weak var btnAddAnimation: UIButton!
    
    @IBAction func btnAdd(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: CreateFoodViewController.identifier) as! CreateFoodViewController
        self.present(vc, animated: true, completion: nil)
    }
    func baseQuery() -> Query {
        return Firestore.firestore().collection(FoodMainController.DB_COLLECTION_PATH)
    }
    
    var query : Query? {
        didSet {
            if let listener = listener {
                listener.remove()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.listener = query?.addSnapshotListener({ (query, err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            
            let result = query?.documents.map({ (document) -> AssignmentVO in
                if let assignment = AssignmentVO(dictionary: document.data(), id: document.documentID) {
                    return assignment
                } else {
                    fatalError()
                }
            })
            
            self.assignment = result ?? []
            self.tvFoodList.reloadData()
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.listener.remove()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.query = baseQuery()
        tvFoodList.delegate = self
        tvFoodList.dataSource = self
        tvFoodList.register(UINib(nibName: FoodTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: FoodTableViewCell.identifier)
    
        btnAddAnimation.layer.cornerRadius = btnAddAnimation.frame.size.width / 2
        viewRating.layer.cornerRadius = viewRating.frame.size.width / 2
        btnEntrees.layer.cornerRadius = 5
        btnDesserts.layer.cornerRadius = 5
        btnDrinks.layer.cornerRadius = 5
        btnMain.layer.cornerRadius = 5
    }

}

extension FoodMainController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let delete = assignment[indexPath.row]
            Firestore.firestore().collection(FoodMainController.DB_COLLECTION_PATH).document(delete.id).delete()
        }
    }
}

extension FoodMainController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           
        let width = tableView.bounds.width * 1/3.5;
        return width + (width/2)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("This is the count \(assignment.count)" )
        return assignment.count
//        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FoodTableViewCell.identifier, for: indexPath) as! FoodTableViewCell
        cell.mFoods = assignment[indexPath.row]
        return cell
    }
    
    
}
