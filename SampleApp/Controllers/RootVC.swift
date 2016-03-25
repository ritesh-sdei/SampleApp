//
//  RootVC.swift
//  SampleApp
//
//  Created by Ritesh Chopra on 02/02/16.
//  Copyright © 2016 Gurdev Singh. All rights reserved.
//

import UIKit

class RootVC: UIViewController,SlideNavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
        self.navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Slide Right Menu Delegate
    func slideNavigationControllerShouldDisplayLeftMenu() -> Bool {
        
        return true
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
