//
//  RequestListViewController.swift
//  Rest API Client
//
//  Created by KingpiN on 8/24/16.
//  Copyright © 2016 optimusmac4. All rights reserved.
//

import UIKit

protocol RequestListDelegate: class {
    func selectedRowForOptions(indexPath:NSIndexPath);
}

class RequestListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    var dataSourceArray = NSArray()
    var delegate: RequestListDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let requestCell = tableView.dequeueReusableCellWithIdentifier("Cell")! as UITableViewCell
        requestCell.textLabel!.text = dataSourceArray[indexPath.row] as? String
        return requestCell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceArray.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        delegate?.selectedRowForOptions(indexPath)
    }
    

}
