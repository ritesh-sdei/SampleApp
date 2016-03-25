//
//  BusinessLayer.swift
//  TestSwift
//
//  Created by Gurdev Singh on 12/15/14.
//  Copyright (c) 2014 Gurdev Singh. All rights reserved.
//

import Foundation


enum enLoginType:Int {
    case enLoginNormal
    case enLoginFacebook
    case enLoginTwitter
}

class BusinessLayer: NSObject {
    
    var commMgr:CommunicationManager
    
    override init() {
        commMgr = CommunicationManager()
    }
    
    func socialLogin(socialmedia_id:String,type:String,completionHandler:(success:Bool) -> Void) {
        let queryString = "/" + socialmedia_id + "/" + type + "?device_id=" + AppInstance.applicationInstance.device_id + "&device_type=1"
        commMgr.GET(API.API_SOCIAL_LOGIN, queryString: queryString, sync: true, completionHandler: { (success, response) -> Void in
            if( success == true ) {
                Helper.printLog("API_SOCIAL_LOGIN response \n"+response)
                var userObject:User?
                userObject <-- response
                
                if(userObject?.email != nil) {

                    AppInstance.applicationInstance.user = userObject!
                    AppInstance.applicationInstance.userLoggedIn = true

                    Helper.SaveUserObjectToFile(userObject!)
                    
                    completionHandler(success: true)
                }
                else {
                    completionHandler(success: false)
                }
            }
        })
    }
    
    func loginNormal(completionHandler:(success:Bool) -> Void) {
        
        if let tempUser = AppInstance.applicationInstance.user
        {
            var queryString = "?email=" + tempUser.email!
            queryString = queryString + "&password=" + tempUser.password!
            
            commMgr.GET(API.API_USER_LOGIN, queryString: queryString, sync: false, completionHandler: { (success, response) -> Void in
                if(success) {
                    var tempUser : User?
                    tempUser <-- response
                    AppInstance.applicationInstance.user = tempUser!
                                        if tempUser?.message == nil {
                                            AppInstance.applicationInstance.userLoggedIn = true
                                            Helper.SaveUserObjectToFile(tempUser!)
                                            completionHandler(success: true)
                                        }
                                        else {
                                            completionHandler(success: false)
                                        }
                }
            })
        }
    }
 
    func socialSignUp(completionHandler:(success:Bool,errorMessage:String) -> Void) {
        
        if let tempUser = AppInstance.applicationInstance.user
        {
            var queryString = "?email=" + tempUser.email!
            queryString = queryString + "&password=" + tempUser.password!
            //queryString = queryString + "&confirm=" + tempUser.confirmPassword!
            queryString = queryString + "&name=" + tempUser.name!
            queryString = queryString + "&username=" + tempUser.name!
            //queryString = queryString + "&language=" + tempUser.language!
           // queryString = queryString + "&country=" + tempUser.country!
            queryString = queryString + "&id=" + tempUser.socialmedia_id!
            //queryString = queryString + "&type=" + tempUser.type!
            queryString = queryString + "&device_id=" + AppInstance.applicationInstance.device_id
            queryString = queryString + "&device_type=1"
            commMgr.GET(API.API_SOCIAL_REGISTER, queryString: queryString, sync: true, completionHandler: { (success, response) -> Void in
                if(success == true) {
                    Helper.printLog("enAPISignUp Response "+response)
                    var tempUser : User?
                    tempUser <-- response
                    Helper.printLog(tempUser?.email)
                    AppInstance.applicationInstance.user = tempUser!
                    
                    Helper.printLog(tempUser?.message)
                    
                    if tempUser?.message == nil {
                        Helper.printLog("Data Saved")
                        AppInstance.applicationInstance.userLoggedIn = true
                        AppInstance.applicationInstance.user = tempUser!
                        Helper.SaveUserObjectToFile(tempUser!)
                        
                        completionHandler(success: true, errorMessage: "")
                        return
                    }
                    else {
                        Helper.printLog("Data not Saved")
                        if let msg = tempUser!.message {
                            completionHandler(success: false, errorMessage: msg)
                            return
                        }
                        else {
                            completionHandler(success: false, errorMessage: "")
                            return
                        }
                    }
                }
            })
        }
    }

    func signUpNormal(completionHandler:(success:Bool,errorMessage:String?) -> Void) {
        if let tempUser = AppInstance.applicationInstance.user
        {
            var queryString = "?email=" + tempUser.email!
            queryString = queryString + "&password=" + tempUser.password!
            queryString = queryString + "&name=" + tempUser.name!
            commMgr.GET(API.API_USER_REGISTER, queryString: queryString, sync: false, completionHandler: { (success, response) -> Void in
                if(success) {
                    var tempUser : User?
                    tempUser <-- response
                    AppInstance.applicationInstance.user = tempUser!
                    if tempUser?.message == nil {
                        AppInstance.applicationInstance.userLoggedIn = true
                        Helper.SaveUserObjectToFile(tempUser!)
                        completionHandler(success: true,errorMessage: nil)
                    }
                    else {
                        completionHandler(success: false,errorMessage: response)
                    }
                }
            })
        }
    }
    
    func signOut(index:Int) {
        AppInstance.applicationInstance.userLoggedIn = false
        Helper.DeleteUserObject()
        AppInstance.applicationInstance.user = nil
        
        let uDefaults=NSUserDefaults.standardUserDefaults()
        if let id = NSBundle.mainBundle().bundleIdentifier {
            uDefaults.removePersistentDomainForName(id)
        }
    }
    
    func getResponseDictionary(responseData:NSData) -> NSDictionary? {
        do {
            if let responseDictionary: NSDictionary = try NSJSONSerialization.JSONObjectWithData(responseData, options: NSJSONReadingOptions.MutableLeaves) as? NSDictionary
            {
                return responseDictionary
            }
        } catch let error as NSError {
            Helper.printLog(error.localizedDescription)
        }
        
        return nil
    }
    
    
    
    func downloadImage(filename:String)
    {
        let imageURL: NSURL = NSURL(string: API.BASE_URL + API.UPLOAD_FOLDER + filename)!
        if let imageData = NSData(contentsOfURL: imageURL) {
            let image:UIImage = UIImage(data: imageData)!
            Helper.SaveImageToFile(image, filename: filename)
        }
    }

    
}
