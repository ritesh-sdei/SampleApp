//
//  SignupViewController.swift
//  QScore
//
//  Created by Navjot Cheema on 17/12/14.
//  Copyright (c) 2014 Gurdev Singh. All rights reserved.
//

import UIKit
import Accounts
import Social
import TwitterKit

class SignupViewController: BaseViewController{
    
    @IBOutlet weak var labelOR: UILabel!
    @IBOutlet weak var btnTermsandCond: UIButton!
    @IBOutlet weak var btnPrivacyPolicy: UIButton!
    @IBOutlet weak var OrImageView: UIImageView!
    @IBOutlet weak var buttonSignup: UIButton!
    @IBOutlet weak var buttonSignupWithTwitter: UIButton!
    @IBOutlet weak var buttonSignupWithFacebook: UIButton!
    @IBOutlet weak var ErrorLabel: UILabel!
    @IBOutlet weak var TextFieldName : UITextField!
    @IBOutlet weak var TextFieldEmail : UITextField!
    @IBOutlet weak var TextFieldPassword : UITextField!
    @IBOutlet weak var TextFieldConfirmPassword : UITextField!
    @IBOutlet weak var SignupHeading:UILabel!
    @IBOutlet weak var termsAndConditionLabel : UILabel!
    @IBOutlet weak var privacyPolicy : UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPwd: UILabel!
    @IBOutlet weak var lblCnfrmPawd: UILabel!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var strengthLabel: UILabel!
    @IBOutlet var passwordStrengthView: UIView!
    
    var socialId:String?
    var socialType:String?
    var termsTapped : Bool = false
    var login:Bool = false
    var socialSignUp:Bool?
    var SignInView : SignInViewController?
    
    var dictSocialFields:NSMutableDictionary?
    var tap: UITapGestureRecognizer!
    var arrayImageViews : Array<UIImageView> = []
    var Next: UIBarButtonItem!
    var frameView: UIView!
    var frame: CGRect!
    var y : CGFloat!
    var StrengthIcon:UIImageView!
    var liClient: LIALinkedInHttpClient!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Add strength images in password strength view
        self.PasswordIcons()
        
        //Notification fired on typing in uitextfield
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(
            self,
            selector: "txtDidChange:",
            name:UITextFieldTextDidChangeNotification,
            object: nil
        )
        
        //Add padding in UITextfields
        let paddingViewName = UIView(frame: CGRectMake(0, 0, 10, 20))
        let paddingViewEmail = UIView(frame: CGRectMake(0, 0, 10, 20))
        let paddingViewPassword = UIView(frame: CGRectMake(0, 0, 10, 20))
        let paddingViewConfirmPassword = UIView(frame: CGRectMake(0, 0, 10, 20))
        
        TextFieldName.leftView = paddingViewName
        TextFieldName.leftViewMode = UITextFieldViewMode.Always
        
        TextFieldEmail.leftView = paddingViewEmail
        TextFieldEmail.leftViewMode = UITextFieldViewMode.Always
        
        TextFieldPassword.leftView = paddingViewPassword
        TextFieldPassword.leftViewMode = UITextFieldViewMode.Always
        
        TextFieldConfirmPassword.leftView = paddingViewConfirmPassword
        TextFieldConfirmPassword.leftViewMode = UITextFieldViewMode.Always
        
    }
    
    override func viewDidAppear(animated: Bool) {
        scrollView.setContentOffset(CGPointMake(0,0), animated: true)
    }
    override func viewWillAppear(animated: Bool) {
        
        Helper.TrackScreenName("Sign up")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Social Logins
    //Twitter Login
    @IBAction func tapTwitterSignupButton(sender: AnyObject) {
        
      super.showProgressView("Please Wait",view: self.view)
        
        Twitter.sharedInstance().logInWithCompletion { session, error in
            
            super.hideProgressView(self.view)
            
            if session != nil {
                // Here you have a valid session you can use.
                print("signed in as \(session!.userName)")
                self.navigateToDashboardVC()
            }
            else {
                
                print("error: \(error!.localizedDescription)")
            }
        }
        
    }
    //MARK:- LinkedIn Login
    @IBAction func tapLinkedInBtn(sender: AnyObject) {
        super.showProgressView("Please Wait",view: self.view)
        
        LoginWithLinkedIn({ (success, UserObject) -> Void in
            
            self.hideProgressView(self.view)
            
            if(success) {
                
                //LinkedIn login successful
                print("\(UserObject)")
                self.navigateToDashboardVC()
                
            }
            else {
                
                Helper.printLog("LinkedIn Login failed in SignInVC")
            }
        })

    }
    
       

    //Facebook Login
    @IBAction func tapFacebookSignupButton(sender:UIButton) {
        
         super.showProgressView("Please Wait",view: self.view)
        
        FB.doFBLogin({ (success, fbUserObject) -> Void in
            
            self.hideProgressView(self.view)
            
            if(success) {
                print("\(fbUserObject)")
                //FB login successful
                self.navigateToDashboardVC()
                
            }
            else {
                
                Helper.printLog("FB Login failed in SignInVC")
            }
        })
        
    }

    //MARK: Terms&Conditions Button Action
    @IBAction func btnActionTermsAndConditions(sender: AnyObject) {
    
    }
    //MARK: Back Button Action
    @IBAction func tappedBackButton(sender: AnyObject) {
        TextFieldName.resignFirstResponder()
        TextFieldEmail.resignFirstResponder()
        TextFieldPassword.resignFirstResponder()
        TextFieldConfirmPassword.resignFirstResponder()
        self.navigationController?.popViewControllerAnimated(true)

    }
    
    //MARK: SignUp Button Action
    @IBAction func tappedSignupNormal(sender: AnyObject) {
        
        ErrorLabel.text = ""
        
        if Reachability.isConnectedToNetwork() {
            
            if(validateData()) {
                
                NSUserDefaults.standardUserDefaults().setObject(self.TextFieldPassword.text, forKey: "Password")
                NSUserDefaults.standardUserDefaults().synchronize()
                let u:User=User()
                u.email = self.TextFieldEmail.text  //"gurdevs@smartdatainc.net"
                u.password = self.TextFieldPassword.text   //"saturday"
                u.name = self.TextFieldName.text
                let bizObject:BusinessLayer=BusinessLayer()
                AppInstance.applicationInstance.user = u
                if(socialSignUp==false) {
                    super.showProgressView("Please Wait",view: self.view)
                    dispatch_async(dispatch_get_main_queue(), {
                        // Do UI stuff here
                        bizObject.signUpNormal({ (success, errorMessage) -> Void in
                            if(success) {
                                super.hideProgressView(self.view)
                            }
                            else {
                                super.hideProgressView(self.view)
                                self.ErrorLabel.text = "Email already exists."
                            }
                        })
                        
                         })
                }
                else {
                    super.showProgressView("",view: self.view)
                    let dispatchTime: dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(0.2 * Double(NSEC_PER_SEC)))
                    dispatch_after(dispatchTime, dispatch_get_main_queue(), {
                        if(self.dictSocialFields != nil) {
                            
                        
                        }
                    })
                }
            }
        }
        else {
            ErrorLabel.text = STRINGVALUES.CHECK_INTERNET_CONNECTION
                Helper.printLog("No internet connection, SignUpVC")
        }
    }
    
    //MARK: Validate UITextFields
    func validateData() -> Bool {
        var valid:Bool=false
        let errorStrName = super.istextfieldEmpty(TextFieldName,type: enTextFieldType.Name)
        let errorStrEmail = super.istextfieldEmpty(TextFieldEmail,type: enTextFieldType.Email)
        let errorStrPass = super.istextfieldEmpty(TextFieldPassword,type: enTextFieldType.SignUp_Password)
        let errorStrConfirmPass = super.istextfieldEmpty(TextFieldConfirmPassword,type: enTextFieldType.Confirm_Password)
        
         if !errorStrName.isEmpty {
            ErrorLabel.text = errorStrName
        }
        else  if !errorStrEmail.isEmpty {
            ErrorLabel.text = errorStrEmail
        }
        else if !errorStrPass.isEmpty {
            ErrorLabel.text = errorStrPass
        }
        else if !errorStrConfirmPass.isEmpty {
            ErrorLabel.text = errorStrPass
        }
        else if TextFieldConfirmPassword.text != TextFieldPassword.text {
            ErrorLabel.text = STRINGVALUES.PASSWORD_MISMATCH
            TextFieldConfirmPassword.textColor = UIColor.redColor()
        }
        else {
            valid = true
        }
      
        return valid
    }
    
    //MARK: UITextField Delegates
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool
    {
        ErrorLabel.text = ""
        return true
    }
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        ErrorLabel.text = ""
        textField.textColor = UIColor.blackColor()
        return true
    }

    func textFieldShouldReturn(textField: UITextField!) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    
    
    //MARK: Password Strength Functions
    func txtDidChange(sender : AnyObject) {
        var level:Int?
        for (var i=0;i<self.arrayImageViews.count;i++) {
            let item = self.arrayImageViews[i]
            item.alpha = 0
        }
        var FinalString : NSString = NSString()
        FinalString = self.TextFieldPassword.text!;
        
    if self.TextFieldPassword.text != "" {
            if ((self .isPwdSuperStrong(self.TextFieldPassword.text!)) && (FinalString.length > 5)) {
                 self.strengthLabel.text = "Very Strong"
                level=3
            }
            else  if ((self .isPwdStrongWithNumberAndChar(self.TextFieldPassword.text!)  || self .isPwdStrongWithCharAndSpecialChar(self.TextFieldPassword.text!))  && (FinalString.length > 5)) {
                self.strengthLabel.text = "Strong"
                level=2
        }
            
            else  if ((self .isPwdWeekWithNumeral(self.TextFieldPassword.text!) || self .isPwdWeekWithCharacter(self.TextFieldPassword.text!) || self .isPwdWeekWithSpecialCharacter(self.TextFieldPassword.text!)) && (FinalString.length <= 4)) {
                self.strengthLabel.text = "Weak"
                level=0
        }
        else
            {
                level = 1
                self.strengthLabel.text = "Good"
        }
        }
    else {
        self.strengthLabel.text = ""
      
        }
        
        for var i=0;i<=level;i++ {
            let item = self.arrayImageViews[i]
            item.alpha = 1
        }
    }
    //MARK:- Add images in password strength view
    func PasswordIcons() {
        passwordStrengthView.layoutIfNeeded()
        let n :Int = 4
        var individual_width=(passwordStrengthView.frame.size.width/CGFloat(n))
        var icons:[String]=["Password1","Password2","Password3","Password4"]
        
        for (var i = 0;i < n;i++) {
            StrengthIcon = UIImageView(image: UIImage(named: icons[i]))
            StrengthIcon.frame=CGRectMake(0, 2,individual_width, 5)
            individual_width += individual_width/2
            if i == 0 {
                StrengthIcon.backgroundColor = UIColor(red: 232.0/255.0, green: 78.0/255.0, blue: 27/255.0, alpha: 1.0)
                StrengthIcon.alpha = 0
            }
            if i == 1 {
                StrengthIcon.backgroundColor = UIColor(red: 242.0/255.0, green: 145.0/255.0, blue: 0/255.0, alpha: 1.0)
                
                StrengthIcon.alpha = 0
            }
            if i == 2 {
                StrengthIcon.backgroundColor = UIColor(red: 118.0/255.0, green: 183.0/255.0, blue: 42/255.0, alpha: 1.0)
                StrengthIcon.alpha = 0
            }
            if i == 3 {
                StrengthIcon.backgroundColor = UIColor(red: 0/255.0, green: 149.0/255.0, blue: 64/255.0, alpha: 1.0)
                StrengthIcon.alpha = 0
            }
            self.arrayImageViews.append(StrengthIcon)
            passwordStrengthView.addSubview(StrengthIcon)
        }
    }

    

}
