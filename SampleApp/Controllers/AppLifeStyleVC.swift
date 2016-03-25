//
//  AppLifestyleVC.swift
//  Quealth
//
//  Created by Gurdev Singh on 9/18/15.
//  Copyright (c) 2015 Gurdev Singh. All rights reserved.
//

import UIKit

class AppLifeStyleVC: UIViewController {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var buttonCreateAccount: UIButton!
    @IBOutlet weak var buttonLogin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if (NSUserDefaults.standardUserDefaults().boolForKey("login"))
        {
            let mainStoryboard: UIStoryboard = Helper.getMainStoryboard()
            let VC = mainStoryboard.instantiateViewControllerWithIdentifier("rootController") as! RootVC
            self.navigationController?.pushViewController(VC, animated: false)
        }
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
