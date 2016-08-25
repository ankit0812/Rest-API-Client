//
//  RequestListViewController.swift
//  Rest API Client
//
//  Created by KingpiN on 8/24/16.
//  Copyright © 2016 optimusmac4. All rights reserved.
//

import UIKit

class AboutViewController : UIViewController {
    
    @IBOutlet weak var headerOutlet: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        headerOutlet.backgroundColor = UIColor(patternImage: UIImage(named: "orange_header")!)
        imageView.layer.cornerRadius = imageView.bounds.size.width/2
        imageView.layer.masksToBounds = true
    }
}
