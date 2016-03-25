

//
//  SignInViewController.swift
//  QScore
//
//  Created by Navjot Cheema on 13/12/14.
//  Copyright (c) 2014 Gurdev Singh. All rights reserved.
//

import UIKit
import Accounts
import Social
import TwitterKit

class SignInViewController: BaseViewController {
    
    @IBOutlet weak var  signScrollView:UIScrollView!
    @IBOutlet weak var ErrroLabel: UILabel!
    @IBOutlet weak var FBButton: UIButton!
    @IBOutlet weak var TwitterButton : UIButton!
    @IBOutlet weak var HeadingLabel : UILabel!
    @IBOutlet weak var ButtonLogin: UIButton!
    @IBOutlet weak var signInView: UIView!
    @IBOutlet weak var textFieldEmail:UITextField!
    @IBOutlet weak var textFieldPassword:UITextField!
    @IBOutlet weak var MainView: UIView!
    @IBOutlet weak var lblEmail : UILabel!
    @IBOutlet weak var buttonForgotPassword: UIButton!
    @IBOutlet weak var lblPwd : UILabel!
    @IBOutlet weak var lableOR: UILabel!
    
    let useACAccount = true
    var destinationViewController:SignupViewController?
    var checkInt : Int!
    var viewUP : Int!
    var frame: CGRect!
    var pushView : UIViewController!
   

    required  init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    //MARK: UIview LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Add padding in UITextfields
        let paddingViewEmail = UIView(frame: CGRectMake(0, 0, 10, 20))
        textFieldEmail.leftView = paddingViewEmail
        textFieldEmail.leftViewMode = UITextFieldViewMode.Always
        
        let paddingViewPassword = UIView(frame: CGRectMake(0, 0, 10, 20))
        textFieldPassword.leftView = paddingViewPassword
        textFieldPassword.leftViewMode = UITextFieldViewMode.Always
        
        
        
    }
    override func viewDidAppear(animated: Bool) {
        beginAppearanceTransition(false, animated:true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- Login Buttons Actions
    //Normal Login
    @IBAction func tappedLoginNormal(sender: AnyObject) {
        
        ErrroLabel.text = ""
        
        let errorStrEmail = super.istextfieldEmpty(textFieldEmail,type: enTextFieldType.Email)
        let errorStrPass = super.istextfieldEmpty(textFieldPassword,type: enTextFieldType.Password)
        if !errorStrEmail.isEmpty {
            ErrroLabel.text = errorStrEmail
            
        }
        else if !errorStrPass.isEmpty {
            ErrroLabel.text = errorStrPass
            
        }
        else {
            if Reachability.isConnectedToNetwork() {
                super.showProgressView("Logging In",view: self.view)
                self.doLogin(self.textFieldEmail.text!, password:self.textFieldPassword.text!)
            }
            else {
                ErrroLabel.text = STRINGVALUES.CHECK_INTERNET_CONNECTION
                
            }
        }
    }
    
    //Login method
    func doLogin(name:String,password:String) {
        let u:User=User()
        u.email = name
        u.password = password
        AppInstance.applicationInstance.user = u
        NSUserDefaults.standardUserDefaults().setObject(self.textFieldPassword.text, forKey: "Password")
        NSUserDefaults.standardUserDefaults().synchronize()
        let bizObject:BusinessLayer=BusinessLayer()
        // code here
        bizObject.loginNormal { (success) -> Void in
            super.hideProgressView(self.view)
            if(success) {
                Helper.printLog("Login Successful")
                self.navigateToDashboardVC()
            }
            else {
                self.ErrroLabel.textColor = UIColor.redColor()
                self.ErrroLabel.text = STRINGVALUES.INVALID_CREDENTIALS
                Helper.printLog("Error in login")
            }
        }
    }
    
    //Facebook Button Action
    @IBAction func tappedLoginWithFacebook(sender:AnyObject) {
        super.showProgressView("Logging In",view: self.view)

        FB.doFBLogin({ (success, fbUserObject) -> Void in
            
            self.hideProgressView(self.view)
            
            if(success) {
                
                //FB login successful
                self.navigateToDashboardVC()
                
            }
            else {
                
                Helper.printLog("FB Login failed in SignInVC")
            }
        })
    }
    
    //Twitter Button Action
    @IBAction func tappedLoginWithTwitter(sender: AnyObject) {
        
        super.showProgressView("Logging In",view: self.view)
        Twitter.sharedInstance().logInWithCompletion { session, error in
            super.hideProgressView(self.view)
            if session != nil {
                print("signed in as \(session!.userName)")
                self.navigateToDashboardVC()
            } else {
                print("error: \(error!.localizedDescription)")
            }
        }

    }
    
    //Forgot password Action
    @IBAction func forgotPassword(sender:AnyObject) {
        let ForgotPwdView = self.storyboard?.instantiateViewControllerWithIdentifier("FPVCID") as? ForgotPasswordVC
        let animation:CATransition = CATransition()
        animation.duration=1.5
        animation.type=kCATransitionPush
        animation.subtype=kCATransitionFromBottom
        animation.timingFunction=CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        self.navigationController?.view.layer .addAnimation(animation, forKey:nil)
        self.navigationController?.pushViewController(ForgotPwdView!, animated:false)
    }
    
    //MARK:- TextField delegate methods
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        ErrroLabel.text = ""
        textField.textColor = UIColor.blackColor()
        return true
    }

    
    @IBAction func backButtonTapped(sender: AnyObject) {
        //Helper.AddScreenTracking(SCREENS.LOG_IN, destScreen: SCREENS.ENTRY, isScreen: true)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
}
