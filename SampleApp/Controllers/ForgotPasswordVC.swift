//
//  ForgotPasswordVC.swift
//  QScore
//
//  Created by Navjot Cheema on 15/04/15.
//  Copyright (c) 2015 Gurdev Singh. All rights reserved.
//

import UIKit

class ForgotPasswordVC: BaseViewController,UITextFieldDelegate {
    
    @IBOutlet weak var textFieldCode:UITextField!
    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var imageViewline4: UIImageView!
    @IBOutlet weak var imageViewLine3: UIImageView!
    @IBOutlet weak var imageViewLine2: UIImageView!
    @IBOutlet weak var scrollViewFVC: UIScrollView!
    @IBOutlet weak var btnRequestCode: UIButton!
    @IBOutlet weak var textFiedConfirmPassword: UITextField!
    @IBOutlet weak var textFieldNewPassword: UITextField!
    @IBOutlet weak var ErrorAlreadyAcc: UILabel!
    @IBOutlet weak var alreadyhaveanAccLabel: UILabel!
    @IBOutlet weak var btnActionReqPassword: UIButton!
    @IBOutlet weak var imageViewLine: UIImageView!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var errorLabelForgotPassword: UILabel!
    @IBOutlet weak var ForgotPasswordLabel: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var headerLabel: UILabel!
    
    var txtActive : UITextField!
    var codeReceived : String!
    var strNewPasword : String = ""
    var rgbBlueColor : String = "#1597BD"
    var BOOLEAN : Bool!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        scrollViewFVC.contentSize=CGSizeMake(scrollViewFVC.frame.size.width,scrollViewFVC.frame.size.height+40)
        scrollViewFVC.contentInset = UIEdgeInsetsMake(0.0,0.0, 100,0.0)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    
    @IBAction func backBtnAction(sender: AnyObject) {
        
        let animation:CATransition = CATransition()
        animation.duration=1.5
        animation.type=kCATransitionPush
        animation.subtype=kCATransitionFromTop
        animation.timingFunction=CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        self.navigationController?.view.layer .addAnimation(animation, forKey:nil)
        self.navigationController?.popViewControllerAnimated(false)
       // Helper.AddScreenTracking(SCREENS.FORGOT_PASSWORD, destScreen: SCREENS.LOG_IN, isScreen: true)
    }
    
    @IBAction func btnActionReqCode(sender: AnyObject) {
        if textFieldEmail.text == "" {
           // ErrorAlreadyAcc.text = Helper.getVariableForKey("missing_email", defaultValue: STRINGVALUES.MISSING_EMAIL)
            ErrorAlreadyAcc.textColor = UIColor.redColor()
        }
        else {
            self.textFieldEmail.resignFirstResponder()
//            if self.isValidEmail(mainInstance.email) {
//                super.showProgressView()
//                codeReceived = "0"
//                    let bizObject:BusinessLayer=BusinessLayer()
//                    bizObject.requestAccessCode(self.textFieldEmail.text!, completionHandler: { (success, status) -> Void in
//                        dispatch_async(dispatch_get_main_queue()) {
//                            if(success) {
//                                self.hideProgressView()
//                                if(status==0) {
//                                    self.ErrorAlreadyAcc.textColor = UIColor.redColor()
//                                    self.ErrorAlreadyAcc.text = Helper.getVariableForKey("access_code_sent", defaultValue: STRINGVALUES.ACCESS_CODE_SENT)
//                                    Helper.saveEmailId(self.textFieldEmail.text!)
//                                }
//                                else if(status == -1) {
//                                    self.ErrorAlreadyAcc.textColor = UIColor.redColor()
//                                    self.ErrorAlreadyAcc.text = Helper.getVariableForKey("no_account_found", defaultValue: STRINGVALUES.USER_DOES_NOT_EXISTS)
//                                }
//                                Helper.printLog(status)
//                            }
//                        }
//                    })
//            }
//            else {
//                ErrorAlreadyAcc.text = Helper.getVariableForKey("invalid_email_entry", defaultValue: STRINGVALUES.INVALID_EMAIL)
//            }
        }
    }
    
    @IBAction func btnActionSendRequest(sender: AnyObject) {
        
//        if textFieldCode.text == "" {
//            //errorLabelForgotPassword.text = Helper.getVariableForKey("enter_access_code", defaultValue: STRINGVALUES.MISSING_ACCESS_CODE)
//        }
//        else if textFieldNewPassword.text == "" {
//           // errorLabelForgotPassword.text = Helper.getVariableForKey("enter_new_password", defaultValue: STRINGVALUES.MISSING_PASSWORD)
//        }
//        else if textFieldNewPassword.text == textFiedConfirmPassword.text {
//            if isPwdStrongWithCharAndSpecialChar(mainInstance.newPwd) || isPwdStrongWithNumberAndChar(mainInstance.newPwd) || isPwdSuperStrong(mainInstance.newPwd) {
//                codeReceived = "1"
//                resetPassword()
//            }
//            else {
//                errorLabelForgotPassword.text = Helper.getVariableForKey("password_must_contain_numbers_and_special_char", defaultValue: STRINGVALUES.PASSWORD_RULE)
//            }
//        }
//        else {
//            if(textFieldNewPassword.text != textFiedConfirmPassword.text) {
//                errorLabelForgotPassword.text = Helper.getVariableForKey("settings_password_mismatched", defaultValue: STRINGVALUES.PASSWORD_MISMATCH)
//                errorLabelForgotPassword.textColor = UIColor.redColor()
//                return
//            }
//        }
    }
    
    func resetPassword() {
//        super.showProgressView()
//        let bizObject:BusinessLayer=BusinessLayer()
//        bizObject.updatePassword(mainInstance.newPwd, accessCode: self.textFieldCode.text!, completionHandler: { (success, responseCode) -> Void in
//            dispatch_async(dispatch_get_main_queue()) {
//                self.hideProgressView()
//                if(success) {
//                    if(responseCode == 0) {
//                        // updated successfully
//                        self.doAttemptFreshLogin()
//                    }
//                    else if(responseCode == -1) {
//                        // backend error
//                        self.errorLabelForgotPassword.text = Helper.getVariableForKey("generic_error", defaultValue: "Some unknown error occurred.")
//                        self.errorLabelForgotPassword.textColor = UIColor.redColor()
//                    }
//                    else if(responseCode == -2) {
//                        // access code expired
//                        self.errorLabelForgotPassword.text = Helper.getVariableForKey("access_code_expired", defaultValue: "Your access code has been expired.")
//                        self.errorLabelForgotPassword.textColor = UIColor.redColor()
//                    }
//                    else if(responseCode == -3) {
//                        // invalid access code
//                        self.errorLabelForgotPassword.text = Helper.getVariableForKey("invalid_access_code", defaultValue: "You have entered invalid access code.")
//                        self.errorLabelForgotPassword.textColor = UIColor.redColor()
//                    }
//                    Helper.printLog(responseCode)
//                }
//            }
//        })
    }
    
    
    func doAttemptFreshLogin() {
      //  let u:User=User()
//        if let email = Helper.readEmailId() {
//            u.email = email
//            u.password = textFieldNewPassword.text
//            AppInstance.applicationInstance.user = u
//            NSUserDefaults.standardUserDefaults().setObject(mainInstance.newPwd, forKey: "Password")
//            NSUserDefaults.standardUserDefaults().synchronize()
//            let bizObject:BusinessLayer=BusinessLayer()
//            bizObject.loginNormal { (success) -> Void in
//                if(success == true) {
//                    // get access token
//                    bizObject.getAccessToken((AppInstance.applicationInstance.user?.email!)!, password: self.textFieldNewPassword.text!, completionHandler: { (success) -> Void in
//                        if(success == true) {
//                            // Fetch all user data
//                            bizObject.fetchCompleteUserData({ (success) -> Void in
//                                if(success == true) {
//                                    Helper.printLog("All OK now")
//                                    self.hideProgressView()
//                                    self.navigateToDashboardVC()
//                                }
//                            })
//                        }
//                    })
//                }
//            }
//        }
    }
    
   
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        let contentInsets:UIEdgeInsets = UIEdgeInsetsZero;
        self.scrollViewFVC.contentInset = contentInsets;
        self.scrollViewFVC.scrollIndicatorInsets = contentInsets;
        return true
    }
    
    
    override func viewWillAppear(animated: Bool) {
        //Helper.AddScreenTracking(SCREENS.LOG_IN, destScreen: SCREENS.FORGOT_PASSWORD, isScreen: true)
        Helper.TrackScreenName("ForgotPasswordScreen")
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
