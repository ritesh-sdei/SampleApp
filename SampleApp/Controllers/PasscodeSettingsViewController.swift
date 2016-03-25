//
//  PasscodeSettingsViewController.swift
//  PasscodeLockDemo
//
//  Created by Yanko Dimitrov on 8/29/15.
//  Copyright © 2015 Yanko Dimitrov. All rights reserved.
//

import UIKit
//import PasscodeLock

class PasscodeSettingsViewController: UIViewController {
  
    @IBOutlet var tableView: UITableView!
    
    private let configuration: PasscodeLockConfigurationType
    
    init(configuration: PasscodeLockConfigurationType) {
        
        self.configuration = configuration
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        let repository = UserDefaultsPasscodeRepository()
        configuration = PasscodeLockConfiguration(repository: repository)
        
        super.init(coder: aDecoder)
    }
    
    // MARK: - UIView Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updatePasscodeView", name:"updatePasscodeButton", object: nil)
    }
    
    func updatePasscodeView() {
        
        self.tableView.reloadData()
        
    }
    
    //MARK:- Slide Right Menu Delegate
    func slideNavigationControllerShouldDisplayLeftMenu() -> Bool {
        
        return true
    }
    
    // MARK: - Table view data source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        if section == 0
        {
            return 2
        }
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell! = tableView .dequeueReusableCellWithIdentifier("passcode")
        
//        if (cell == nil) {
//            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier:"cell")
//        }
       
        // Configure the cell...
        let textColor = UIColor(red: 0/255.0, green: 122/255.0, blue: 255/255.0, alpha: 1.0)
        
        cell.textLabel?.textColor = textColor
        let hasPasscode = configuration.repository.hasPasscode
        switch(indexPath.section)
        {
            
        case 0:
            switch(indexPath.row)
            {
            case 0:
                if (hasPasscode)
                {
                    cell.textLabel?.text = "Turn Passcode Off"
                    
                }
                else
                {
                    cell.textLabel?.text = "Turn Passcode On"
                }
                
                break
                
            case 1:
                cell.textLabel?.text = "Change Passcode"
                if (hasPasscode)
                {
                    cell.textLabel?.textColor = textColor
                }
                else
                {
                    cell.textLabel?.textColor = UIColor.lightGrayColor()
                }
                
                break
                
            default:
                break
                
            }
            
        default:
            cell.textLabel?.text = "Use Touch Id"
            break
        }
        return cell
        
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        switch(indexPath.section)
        {
        case 0:
            switch(indexPath.row)
            {
            case 0:
                let passcodeVC: PasscodeLockViewController
                
                if !configuration.repository.hasPasscode {
                    
                    passcodeVC = PasscodeLockViewController(state: .SetPasscode, configuration: configuration)
                    
                    
                } else {
                    
                    passcodeVC = PasscodeLockViewController(state: .RemovePasscode, configuration: configuration)
                    
                    passcodeVC.successCallback = { lock in
                        
                        lock.repository.deletePasscode()
                    }
                }
                
                presentViewController(passcodeVC, animated: true, completion: nil)
                
            case 1:
                
                let repo = UserDefaultsPasscodeRepository()
                let config = PasscodeLockConfiguration(repository: repo)
                
                let passcodeLock = PasscodeLockViewController(state: .ChangePasscode, configuration: config)
                
                presentViewController(passcodeLock, animated: true, completion: nil)
            default:
                break
            }
            
        default:
            break
        }
        
        
    }
 
    
}
