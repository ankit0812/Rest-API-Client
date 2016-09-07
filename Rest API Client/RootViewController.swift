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
    
    @IBOutlet var headerPopOver: UIView!
    @IBOutlet weak var headerOptionsButtonOutlet: UIButton!
    @IBOutlet weak var headerOptionsMainView: UIView!
    
    @IBOutlet weak var acceptValueTextField: UITextField!
    @IBOutlet weak var headerOptionsAcceptView: UIView!
    
    @IBOutlet weak var headerOptionsAuthorizationView: UIView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var headerOptionsCustomView: UIView!
    @IBOutlet weak var headerNameTextField: UITextField!
    @IBOutlet weak var headerValueTextField: UITextField!
    
    @IBOutlet weak var okButtonOutlet: UIButton!
    @IBOutlet weak var cancelButtonOutlet: UIButton!
    @IBOutlet weak var sendButtonOutlet: UIButton!
    
    @IBOutlet weak var optionsView: UIView!
    @IBOutlet weak var optionsButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var wherePopOver: UIPopoverPresentationController!
    var rootInitialize = String()
    var dataSourceArrayForMethod: NSArray = ["GET", "POST", "PUT", "DELETE", "HEAD", "OPTIONS", "PATCH"]
    var dataSourceArrayForHeaderType: NSArray = ["Accept", "Authorization", "Authorization (Basic)", "Content-Type", "Custom"]
    
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
        requestHeaderCell.headerAddButton.tag = REQUEST_HEADER_CELL_TAG
        return requestHeaderCell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    @IBAction func headerOptionButtonAction(sender: AnyObject) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let requestListViewController: RequestListViewController = storyboard.instantiateViewControllerWithIdentifier("RequestTableView") as! RequestListViewController
        
        requestListViewController.modalPresentationStyle = .Popover
        requestListViewController.dataSourceArray = dataSourceArrayForHeaderType
        
        let popOverHeight: CGFloat
        if dataSourceArrayForMethod.count < 3 {
            popOverHeight = CGFloat(dataSourceArrayForMethod.count) * Constants.POPOVER_ROW_HEIGHT
        } else {
            popOverHeight = Constants.POPOVER_ROW_HEIGHT * 3
        }
        requestListViewController.preferredContentSize = CGSizeMake(200, popOverHeight)
        requestListViewController.delegate = self
        
        let wherePopOver = requestListViewController.popoverPresentationController
        wherePopOver?.delegate = self
        wherePopOver?.sourceView = headerPopOver
        wherePopOver?.sourceRect = headerOptionsButtonOutlet.frame
        wherePopOver?.permittedArrowDirections = .Up;
        wherePopOver?.backgroundColor = UIColor.whiteColor()
        presentViewController(requestListViewController, animated: true, completion: {
            requestListViewController.tableView.flashScrollIndicators()
        })
    }
    
    @IBAction func optionsButtonAction(sender: AnyObject) {
        
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let requestListViewController: RequestListViewController = storyboard.instantiateViewControllerWithIdentifier("RequestTableView") as! RequestListViewController
        
        requestListViewController.modalPresentationStyle = .Popover
        requestListViewController.dataSourceArray = dataSourceArrayForMethod
        
        // Setting height of PopOver max 7 rows or less according to entry counts
        
        let popOverHeight: CGFloat
        if dataSourceArrayForMethod.count < 7 {
            popOverHeight = CGFloat(dataSourceArrayForMethod.count) * Constants.POPOVER_ROW_HEIGHT
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
    
    @IBAction func okButtonAction(sender: AnyObject) {
    }
    
    @IBAction func cancelButtonAction(sender: AnyObject) {
        UIView.animateWithDuration(0.3, animations: {
            self.enableUserInteraction()
            self.headerPopOver.removeFromSuperview()
        }) { (finished) in }
    }
    
    @IBAction func sendButtonAction(sender: AnyObject) {
        
    }
    
    func selectedRowForOptions(indexPath: NSIndexPath, dataSourceArray: NSArray) {
        if (dataSourceArray.isEqualToArray(dataSourceArrayForMethod as [AnyObject])) {
            let newString = ((dataSourceArrayForMethod[indexPath.row] as! String) + "  ▼")
            UIView.transitionWithView(self.optionsButton, duration: 0.3, options: .TransitionCrossDissolve, animations: { () -> Void in
                self.optionsButton.setTitle(newString, forState: .Normal)
                self.optionsButton.sizeToFit()
                }, completion: { (finished: Bool) -> Void in
            })
            dismissPopOver()
        } else if (dataSourceArray.isEqualToArray(dataSourceArrayForHeaderType as [AnyObject])) {
            let newString = ((dataSourceArrayForHeaderType[indexPath.row] as! String) + "  ▼")
            UIView.transitionWithView(self.headerOptionsButtonOutlet, duration: 0.3, options: .TransitionCrossDissolve, animations: { () -> Void in
                self.headerOptionsButtonOutlet.setTitle(newString, forState: .Normal)
                self.headerOptionsButtonOutlet.sizeToFit()
                }, completion: { (finished: Bool) -> Void in
            })
            var frame = CGRect()
            if (dataSourceArrayForHeaderType[indexPath.row].isEqualToString("Accept") || dataSourceArrayForHeaderType[indexPath.row].isEqualToString("Authorization") || dataSourceArrayForHeaderType[indexPath.row].isEqualToString("Content-Type")) {
                headerOptionsAcceptView.hidden = false
                headerOptionsCustomView.hidden = true
                headerOptionsAuthorizationView.hidden = true
                frame = headerPopOver.frame
                frame.size = CGSizeMake(280, 220)
            } else if (dataSourceArrayForHeaderType[indexPath.row].isEqualToString("Authorization (Basic)") ) {
                headerOptionsAcceptView.hidden = true
                headerOptionsCustomView.hidden = true
                headerOptionsAuthorizationView.hidden = false
                frame = headerPopOver.frame
                frame.size = CGSizeMake(280,280)
            } else if (dataSourceArrayForHeaderType[indexPath.row].isEqualToString("Custom")) {
                headerOptionsAcceptView.hidden = true
                headerOptionsCustomView.hidden = false
                headerOptionsAuthorizationView.hidden = true
                frame = headerPopOver.frame
                frame.size = CGSizeMake(280,280)
            }
            UIView.animateWithDuration(0.25, animations: {
                self.headerPopOver.frame = frame
                }, completion: { (finished) in
            })
            dismissPopOver()
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
    
    func dismissPopOver() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func addHeaderButtonClicked(sender: UIButton) {
        if sender.tag == REQUEST_HEADER_CELL_TAG {
            customizePopOverForPresentation(dataSourceArrayForHeaderType, arrows: false, preferredSize: CGSizeMake(280, 280), viewController: UIViewController())
        }
    }
    
    func customizePopOverForPresentation(dataSource: NSArray,arrows: Bool, preferredSize: CGSize,viewController : UIViewController) {
        configurePopOverView()
        disableUserInteraction()
        view.addSubview(headerPopOver)
    }
    
    func configurePopOverView() {
        headerOptionsAcceptView.hidden = false
        headerOptionsCustomView.hidden = true
        headerOptionsAuthorizationView.hidden = true
        headerOptionsButtonOutlet.setTitle("Accept " + "  ▼" , forState: .Normal)
        var frame:CGRect = headerPopOver.frame
        frame.size = CGSizeMake(280, 220)
        headerPopOver.frame = frame
        
        headerPopOver.center = CGPointMake(view.bounds.size.width/2, view.bounds.size.height/2)
        headerPopOver.layer.cornerRadius = 10.0
        // border
        headerPopOver.layer.borderColor = UIColor.lightGrayColor().CGColor
        headerPopOver.layer.borderWidth = 1.5
        // drop shadow
        headerPopOver.layer.shadowColor = UIColor.blackColor().CGColor
        headerPopOver.layer.shadowOpacity = 0.8
        headerPopOver.layer.shadowRadius = 3.0
        headerPopOver.layer.shadowOffset = CGSizeMake(2.0, 2.0)
    }
    
    func disableUserInteraction() {
        tableView.userInteractionEnabled = false
        tableView.alpha = 0.3
        sendButtonOutlet.enabled = false
        sendButtonOutlet.alpha = 0.3
        tabBarController?.tabBar.userInteractionEnabled = false
    }
    
    func enableUserInteraction() {
        self.tableView.userInteractionEnabled = true
        self.tableView.alpha = 1
        self.sendButtonOutlet.enabled = true
        self.sendButtonOutlet.alpha = 1
        self.tabBarController?.tabBar.userInteractionEnabled = true
    }
    
    
}
