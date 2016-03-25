
import Foundation

let FB = Facebook()

class Facebook {
    
    
    func doFBLogin(completionHandler:(success:Bool,fbUserObject:AnyObject?)-> Void) {
        
        let permissions: [AnyObject] = ["public_profile", "email"]
        
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
    
        fbLoginManager.logInWithReadPermissions(permissions) { (result, error) -> Void in
            
            if (error == nil){
                
                let fbloginresult : FBSDKLoginManagerLoginResult = result
                
                if(fbloginresult.grantedPermissions.contains("email"))
                {
                    FB.getUserInfo({ (success, fbUserObject) -> Void in

                        if(success) {
                            
                        completionHandler(success: true, fbUserObject: result)
                            
                        }
                        else {
                            
                             completionHandler(success: false, fbUserObject: nil)
                        }
                    })
                    
                }
            }
        }

    }
    
    func getUserInfo(completionHandler:(success:Bool,fbUserObject:AnyObject?)-> Void)
    {
       
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id,name,first_name,last_name,email"])
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
                completionHandler(success: false, fbUserObject: nil)
            }
            else
            {
                print("fetched user: \(result)")
                let userName : NSString = result.valueForKey("name") as! NSString
                print("User Name is: \(userName)")
                let userEmail : NSString = result.valueForKey("email") as! NSString
                print("User Email is: \(userEmail)")
                
                completionHandler(success: true, fbUserObject: result)
            }
        }) // completion block ends for getting user details from FB
        
    }
    
    func handleDidBecomeActive(){
         FBSDKAppEvents.activateApp()
    }
    
}
