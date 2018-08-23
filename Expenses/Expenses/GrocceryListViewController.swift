//
//  GrocceryListViewController.swift
//  Expenses
//
//  Created by sumit prasad on 25/07/18.
//  Copyright © 2018 Philips. All rights reserved.
//

import UIKit
import Firebase

class GrocceryListViewController: UIViewController {
    
    let ref = Database.database().reference(withPath: "grocery-items")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
