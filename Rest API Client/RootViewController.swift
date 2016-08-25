//
//  RequestListViewController.swift
//  Rest API Client
//
//  Created by KingpiN on 8/24/16.
//  Copyright © 2016 optimusmac4. All rights reserved.
//

import UIKit
let POPOVER_ROW_HEIGHT = 45.0

let REQUEST_HEADER_CELL_TAG = 101

class RootViewController : UIViewController, UITableViewDelegate, UITableViewDataSource, RequestListDelegate, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var optionsView: UIView!
    @IBOutlet weak var optionsButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var rootInitialize = String()
    var dataSourceArray: NSArray = ["GET", "POST", "PUT", "DELETE", "HEAD", "OPTIONS", "PATCH"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.allowsSelection = false
        tableView.separatorStyle = .None
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Do any additional setup after loading the view.
        self.tabBarController?.title = "Request"
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let requestHeaderCell = tableView.dequeueReusableCellWithIdentifier("RequestHeaderCell")! as! RequestHeaderCell
        requestHeaderCell.headerAddButton.addTarget(self, action: #selector(self.addHeaderButtonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        requestHeaderCell.tag = REQUEST_HEADER_CELL_TAG
        return requestHeaderCell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    @IBAction func optionsButtonAction(sender: AnyObject) {
        
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let requestListViewController: RequestListViewController = storyboard.instantiateViewControllerWithIdentifier("RequestTableView") as! RequestListViewController
        
        requestListViewController.modalPresentationStyle = .Popover
        requestListViewController.dataSourceArray = dataSourceArray
        
        // Setting height of PopOver max 7 rows or less according to entry counts
        
        let popOverHeight: CGFloat
        if dataSourceArray.count < 7 {
            popOverHeight = CGFloat(dataSourceArray.count) * Constants.POPOVER_ROW_HEIGHT
        } else {
            popOverHeight = Constants.POPOVER_ROW_HEIGHT * 4
        }
        requestListViewController.preferredContentSize = CGSizeMake(optionsView.frame.size.width, popOverHeight)
        requestListViewController.delegate = self
        
        let wherePopOver = requestListViewController.popoverPresentationController
        wherePopOver?.delegate = self
        wherePopOver?.sourceView = self.view
        wherePopOver?.sourceRect = optionsView.frame
        wherePopOver?.permittedArrowDirections = .Up;
        wherePopOver?.backgroundColor = UIColor.whiteColor()
        presentViewController(requestListViewController, animated: true, completion: {
            requestListViewController.tableView.flashScrollIndicators()
        })
        
        
    }
    
    func selectedRowForOptions(indexPath: NSIndexPath) {
        let newString = ((dataSourceArray[indexPath.row] as! String) + "  ▼")
        UIView.animateWithDuration(3, delay: 2, options: .TransitionCrossDissolve, animations: { () -> Void in
            self.optionsButton.setTitle(newString, forState: .Normal)
            }, completion: { (finished: Bool) -> Void in
                print("Hello")
        })
        
        optionsButton.setTitle(newString, forState: .Normal)
        dismissPopOver()
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
    
    func dismissPopOver() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func addHeaderButtonClicked(sender: UIButton) {
        if sender.tag == REQUEST_HEADER_CELL_TAG {
            
        }
    }
    
}
