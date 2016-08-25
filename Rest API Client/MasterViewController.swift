//
//  RequestListViewController.swift
//  Rest API Client
//
//  Created by KingpiN on 8/24/16.
//  Copyright © 2016 optimusmac4. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    
    var listMasterView = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        listMasterView = ["","REST Request", "", "APNS", "","Settings", "", "About",""]
        tableView.separatorStyle = .None
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell ()
        cell.selectionStyle = .None
        if indexPath.row % 2 != 0 {
            cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
            cell.textLabel!.font = UIFont(name: "Avenir-Light", size: 24.0)
            cell.textLabel!.text = listMasterView[indexPath.row] as? String
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
            cell.contentView.backgroundColor = UIColor.init(red: 255.0/255.0, green: 87.0/255.0, blue: 34/255.0, alpha: 1)
            cell.accessoryType = .None
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listMasterView.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 1 {
            performSegueWithIdentifier("RestRequestSegue", sender: self)
        } else if indexPath.row == 3 {
            performSegueWithIdentifier("APNSSegue", sender: self)
        } else if indexPath.row == 5 {
            performSegueWithIdentifier("SettingsSegue", sender: self)
        } else if indexPath.row == 7 {
            performSegueWithIdentifier("AboutSegue", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var controller = UIViewController()
        if segue.identifier == "RestRequestSegue" {
            let tabCtrl = segue.destinationViewController as! BaseTabBarController
            tabCtrl.selectedIndex = 0
        } else if segue.identifier == "APNSSegue" {
            controller = segue.destinationViewController as! APNSViewController
        } else if segue.identifier == "SettingsSegue" {
            controller = segue.destinationViewController as! SettingsViewController
        } else if segue.identifier == "AboutSegue" {
            controller = segue.destinationViewController as! AboutViewController
        }
        controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem()
        controller.navigationItem.leftItemsSupplementBackButton = true
    }
}

