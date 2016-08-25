//
//  RequestHeaderCell.swift
//  Rest API Client
//
//  Created by KingpiN on 8/24/16.
//  Copyright © 2016 optimusmac4. All rights reserved.
//

import UIKit

class RequestHeaderCell: UITableViewCell {
    
    
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var headerAddButton: UIButton!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
