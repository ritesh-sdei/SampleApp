//
//  LeftMenuVC.swift
//  QScore
//
//  Created by Gurdev Singh on 12/22/14.
//  Copyright (c) 2014 Gurdev Singh. All rights reserved.
//

import UIKit
import MessageUI
import AudioToolbox.AudioServices

@objc protocol LeftMenuDelegate
{
    func LogouteMenu(Index:Int)
    
    
}

class LeftMenuVC: UIViewController,MFMailComposeViewControllerDelegate,UITableViewDataSource,UITableViewDelegate {
    
    
    @IBOutlet weak var labelVersion: UILabel!
    var SelectedIndex : Int?
    var delegate:LeftMenuDelegate?
    
    var items: [String] = [String]()
    var dashboard:String = "Dashboard"
    var logOut:String = "LogOut"
    var profile:String = "Profile"
    var settings:String = "Settings"
    
    @IBOutlet weak var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        offMenuItems()
    }
    
    func updateNotificationSentLabel(notification:NSNotification)
    {
        Helper.printLog("Called")
        offMenuItems()
        self.tableView.reloadData()
    }
    
    func offMenuItems()
    {
        items = [dashboard,profile,settings,logOut]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell! = tableView .dequeueReusableCellWithIdentifier("cell")
        
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier:"cell")
        }
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.textLabel?.font = UIFont(name:"Lato-Regular", size:18)
        cell.textLabel?.text = self.items[indexPath.row]
        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel?.textColor = UIColor.whiteColor()
        let imageName = "off_page_item_grey_" + String(indexPath.row)
        cell.imageView?.image = UIImage(named: imageName)
        
        return cell
        // Configure the cell...
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let mainStoryboard: UIStoryboard = Helper.getMainStoryboard()
        
        var VC:UIViewController!
        
        if indexPath.row == 0
        {
            VC = mainStoryboard.instantiateViewControllerWithIdentifier("rootController") as! RootVC
        }
      else  if indexPath.row == 1
        {
            VC = mainStoryboard.instantiateViewControllerWithIdentifier("profileView") as! ProfileViewController
        }
        
       else if indexPath.row == 2
        {
             VC = mainStoryboard.instantiateViewControllerWithIdentifier("passcodeSettingsView") as! PasscodeSettingsViewController
        }
        else
        {
            NSUserDefaults.standardUserDefaults().removeObjectForKey("login")
            NSUserDefaults.standardUserDefaults().synchronize()
            SlideNavigationController.sharedInstance().popToRootViewControllerAnimated(true)
            return
        }
        
         SlideNavigationController.sharedInstance().popToRootAndSwitchToViewController(VC, withCompletion: nil)
    }
    
    func openMailComposer()
    {
        let mailComposer = configuredMailComposeViewController()
        
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposer, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["support@quealth.zendesk.com"])
        mailComposerVC.setSubject("")
        mailComposerVC.setMessageBody("", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
}
