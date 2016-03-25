//
//  BaseViewController.swift
//  SampleApp
//
//  Created by Ritesh Chopra on 02/02/16.
//  Copyright © 2016 Gurdev Singh. All rights reserved.
//

import UIKit

enum enTextFieldType:Int {
    case Name
    case Email
    case Password
    case SignUp_Password
    case Confirm_Password
}

class BaseViewController: UIViewController {
    var loadingIndicator : UIActivityIndicatorView = UIActivityIndicatorView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showProgressView(strLoadingText:String,view:UIView)
    {
        view.userInteractionEnabled = false
        let vwLoadingIndicator: UIView = UIView()
        vwLoadingIndicator.frame = CGRectMake(0, 0, 250, 110)
        vwLoadingIndicator.center = view.center
        vwLoadingIndicator.backgroundColor = UIColor.blackColor()
        vwLoadingIndicator.alpha = 0.7
        vwLoadingIndicator.layer.cornerRadius = 5
        vwLoadingIndicator.tag = 100
        view.addSubview(vwLoadingIndicator)
        
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        loadingIndicator.frame = CGRectMake(vwLoadingIndicator.frame.size.width/2 - 40/2, 20.0, 40.0, 40.0)
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.White
        loadingIndicator.tag = 101
        vwLoadingIndicator.addSubview(loadingIndicator)
        loadingIndicator.startAnimating()
        
        let lblLoadingIndicator: UILabel! = UILabel()
        let titleSize = CGRect(x: 10, y: vwLoadingIndicator.frame.size.height - 50, width: 230, height: 50)
        lblLoadingIndicator.frame = titleSize
        lblLoadingIndicator.text = strLoadingText + "..."//"Loading..."
        lblLoadingIndicator.textColor = UIColor.whiteColor()
        lblLoadingIndicator.textAlignment = NSTextAlignment.Center
        lblLoadingIndicator.lineBreakMode = NSLineBreakMode.ByWordWrapping
        lblLoadingIndicator.numberOfLines = 0
        lblLoadingIndicator.tag = 111
        vwLoadingIndicator.addSubview(lblLoadingIndicator)
    }
    
    func hideProgressView(view:UIView)
    {
        view.userInteractionEnabled = true
        for vw in view.subviews {
            if vw.tag == 100 {
                for actInd in vw.subviews {
                    if actInd .isKindOfClass(UIActivityIndicatorView) {
                        if actInd.tag == 101 {
                            actInd.removeFromSuperview()
                        }
                    }
                }
                vw.removeFromSuperview()
            }
        }
        
        
    }
    
    
    func istextfieldEmpty(textValue:UITextField,type:enTextFieldType) -> String
    {
        var errorStr = ""
        if textValue.text == "" {
            if  type == enTextFieldType.Name {
                
                errorStr = STRINGVALUES.MISSING_NAME
            }
            else if type == enTextFieldType.Email {
                
                errorStr = STRINGVALUES.MISSING_EMAIL
            }
            else if type == enTextFieldType.Password || type == enTextFieldType.SignUp_Password {
                errorStr = STRINGVALUES.MISSING_PASSWORD
            }
            else if type == enTextFieldType.Confirm_Password {
                errorStr = STRINGVALUES.PASSWORD_MISMATCH
            }
            textValue.textColor = UIColor.redColor()
            return errorStr
            
        }
        else
        {
            if type == enTextFieldType.Email
            {
                if !self.isValidEmail(textValue.text!) {
                    textValue.textColor = UIColor.redColor()
                    let errorStr = STRINGVALUES.INVALID_EMAIL
                    return errorStr
                }
                
            }
            else if type == enTextFieldType.SignUp_Password
            {
                var FinalString : NSString = NSString()
                FinalString = textValue.text!
                if FinalString.length <= 5 {
                    textValue.textColor = UIColor.redColor()
                    let errorStr = STRINGVALUES.PASSWORD_RULE
                    return errorStr
                }
            }
            
            return errorStr
        }
        
        
    }
    //MARK:- data validation methods
    //Email Validation Method
    func isValidEmail(emailID:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let range = emailID.rangeOfString(emailRegEx, options:.RegularExpressionSearch)
        let result = range != nil ? true : false
        return result
    }
    
    //Password Validation Methods
    func isPwdSuperStrong(candidate:String) -> Bool {
        
        let pwdRegEx = "((?=.*\\d)(?=.*[a-z])(?=.*[\\\\@#$%&¥₹£€^<>~*+=?!_|\\-/{}()'•.,:;\"\\[\\]]))"
        let range = candidate.rangeOfString(pwdRegEx, options:.RegularExpressionSearch)
        let result = range != nil ? true : false
        return result
    }
    
    func isPwdStrongWithNumberAndChar(candidate:String) -> Bool {
        let pwdRegEx = "((?=.*\\d)(?=.*[a-z]).{1,50})"
        let range = candidate.rangeOfString(pwdRegEx, options:.RegularExpressionSearch)
        let result = range != nil ? true : false
        return result
    }
    
    func isPwdStrongWithNumberAndSpecialChar(candidate:String) -> Bool {
        let pwdRegEx = "((?=.*\\d)(?=.*[\\\\@#$%&¥₹£€^<>~*+=?!_|\\-/{}()'•.,:;\"\\[\\]]).{1,50})"
        let range = candidate.rangeOfString(pwdRegEx, options:.RegularExpressionSearch)
        let result = range != nil ? true : false
        return result
    }
    
    func isPwdStrongWithCharAndSpecialChar(candidate:String) -> Bool {
        let pwdRegEx = "((?=.*[a-z])(?=.*[\\\\@#$%&¥₹£€^<>~*+=?!_|\\-/{}()'•.,:;\"\\[\\]]).{1,50})"
        let range = candidate.rangeOfString(pwdRegEx, options:.RegularExpressionSearch)
        let result = range != nil ? true : false
        return result
    }
    
    
    func isPwdWeekWithNumeral(candidate:String) -> Bool {
        let pwdRegEx = "(?=.*\\d)"
        let range = candidate.rangeOfString(pwdRegEx, options:.RegularExpressionSearch)
        let result = range != nil ? true : false
        return result
    }
    
    func isPwdWeekWithCharacter(candidate:String) -> Bool {
        let pwdRegEx = "(?=.*[a-z])"
        let range = candidate.rangeOfString(pwdRegEx, options:.RegularExpressionSearch)
        let result = range != nil ? true : false
        return result
    }
    
    func isPwdWeekWithSpecialCharacter(candidate:String) -> Bool {
        let pwdRegEx = "(?=.*[\\\\@#$%&¥₹£€^<>~*+=?!_|\\-/{}()'•.,:;\"\\[\\]])"
        let range = candidate.rangeOfString(pwdRegEx, options:.RegularExpressionSearch)
        let result = range != nil ? true : false
        return result
    }
    
    //MARK: Navigate To Home Screen
    func navigateToDashboardVC() {
        
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "login")
        NSUserDefaults.standardUserDefaults().synchronize()
        let mainStoryboard: UIStoryboard = Helper.getMainStoryboard()
        let VC = mainStoryboard.instantiateViewControllerWithIdentifier("rootController") as! RootVC
        self.navigationController?.pushViewController(VC, animated: true)
        
    }
    
    //MARK:- LinkedIn Login Client
    func client() -> LIALinkedInHttpClient {
        let application = LIALinkedInApplication.applicationWithRedirectURL("http://www.linkedin.com", clientId: STRINGVALUES.LinkedIn_CONSUMER_KEY, clientSecret: STRINGVALUES.LinkedIn_CONSUMER_SECRET, state: "rtetststghbjmkk", grantedAccess: ["r_basicprofile", "r_emailaddress"]) as! LIALinkedInApplication
        
        return LIALinkedInHttpClient(forApplication: application, presentingViewController: nil)
        
    }
    
    func LoginWithLinkedIn(completionHandler:(success:Bool,UserObject:AnyObject?)->Void)
    {
        self.client().getAuthorizationCode({code in
            self.client().getAccessToken(code, success: {accessTokenData in
                let accessToken: String = (accessTokenData["access_token"] as! String)
                
                self.requestMeWithToken(accessToken, completionHandler: { (success, UserObject) -> Void in
                    
                    if(success) {
                        
                       completionHandler(success: true,UserObject: UserObject)
                    }
                    else {
                        
                        Helper.printLog("LinkedIn Login failed in SignInVC")
                    }
                })
                }, failure: {error in
                    NSLog("Quering accessToken failed %@", error)
            })
            }, cancel: {() -> Void in
                print("Authorization was cancelled by user")
                
            }, failure: {error in
                print("Authorization failed \(error)")
        })
    }
    
    func requestMeWithToken(accessToken:String,completionHandler:(success:Bool,UserObject:AnyObject?)->Void) {
            self.client().GET("https://api.linkedin.com/v1/people/~:(id,first-name,last-name,maiden-name,email-address)?oauth2_access_token=\(accessToken)&format=json", parameters: nil, success: {operation, result in
            print("current user \(result)")
            completionHandler(success: true, UserObject: result)
            }, failure: {(operation, error) in
                NSLog("failed to fetch current user %@", error)
        })
        
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
