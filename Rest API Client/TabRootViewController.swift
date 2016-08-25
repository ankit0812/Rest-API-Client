//
//  RequestListViewController.swift
//  Rest API Client
//
//  Created by KingpiN on 8/24/16.
//  Copyright © 2016 optimusmac4. All rights reserved.
//

import UIKit

class TabRootViewController: UIViewController {
    
    var tabRootInitialize = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Do any additional setup after loading the view.
        self.tabBarController?.title = "Response"
    }
}
