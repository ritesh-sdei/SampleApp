 //
//  CommunicationManager.swift
//  TestSwift
//
//  Created by Gurdev Singh on 12/15/14.
//  Copyright (c) 2014 Gurdev Singh. All rights reserved.
//


import Foundation


class CommunicationManager: NSObject {
    
    func POST(api:NSString,jsonString:NSString,completionHandler:(success:Bool,response:String) -> Void) {
        
        let screenName = api.stringByReplacingOccurrencesOfString(API.BASE_URL, withString: "")
        Helper.TrackAPICall(screenName)
        
        let url: NSURL = NSURL(string: api as String)!
        let jsonData:NSData = jsonString.dataUsingEncoding(NSASCIIStringEncoding)!
        let postLength:NSString = String( jsonData.length )
        let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.timeoutInterval = 60
        request.HTTPBody=jsonData
        request.HTTPShouldHandleCookies=false
        request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        if let user = AppInstance.applicationInstance.user {
            if let token = user.accessToken {
                Helper.printLog("Token available & set")
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }
        }
        
        
        let response: AutoreleasingUnsafeMutablePointer<NSURLResponse?>=nil
        do {
            let data: NSData = try NSURLConnection.sendSynchronousRequest(request, returningResponse: response)
            if let responseString = NSString(data: data, encoding: NSUTF8StringEncoding) {
                completionHandler(success: true, response: responseString as String)
            }
        }catch let error as NSError{
            Helper.printLog(error.localizedDescription)
            completionHandler(success: false, response: "Error in post")
        }

    }
    
    func GET(var api:NSString,queryString:NSString,sync:Bool, completionHandler:(success:Bool,response:String) -> Void) {
        let screenName = api.stringByReplacingOccurrencesOfString(API.BASE_URL, withString: "")
        Helper.TrackAPICall(screenName)
        
        api = (api as String) + queryString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        let url: NSURL? = NSURL(string: api as String)
        
        if((url) != nil) {
            Helper.printLog("REQUEST_URL= \(url)")
            let request: NSMutableURLRequest = NSMutableURLRequest(URL: url!)
            request.HTTPMethod = "GET"
            request.timeoutInterval = 30
            request.HTTPShouldHandleCookies=false
            if let user = AppInstance.applicationInstance.user {
                if let token = user.accessToken {
                    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                }
            }
            if(sync==false) {
                let queue:NSOperationQueue = NSOperationQueue()
                
                NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler:{ (response: NSURLResponse?, responseData: NSData?, error: NSError?) -> Void in
                    
                    if let data = responseData {
                        if let responseString = NSString(data: data, encoding: NSUTF8StringEncoding) {
                            
                            completionHandler(success:true,response:responseString as String)
                        }
                        else {
                            Helper.printLog("Error: CommMgr:GET=\(error)")
                            completionHandler(success:false,response:"")
                        }
                    }
                    else {
                        Helper.printLog("Error in GET \(error)")
                        completionHandler(success:false,response:"")
                    }
                })
            }
            else {

                let response: AutoreleasingUnsafeMutablePointer<NSURLResponse?>=nil

                do {
                    let data: NSData = try NSURLConnection.sendSynchronousRequest(request, returningResponse: response)
                    if let responseString = NSString(data: data, encoding: NSUTF8StringEncoding) {
                        
                        completionHandler(success:true,response:responseString as String)
                    }
                    else {
                        completionHandler(success:false,response:"")
                    }
                }catch let error as NSError{
                    // Handling error
                    Helper.printLog("Error in API \(url)" + error.localizedDescription)
                    completionHandler(success:false,response:"")
                }
                
            }
        }
    }
    
    
}
