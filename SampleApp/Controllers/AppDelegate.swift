//
//  AppDelegate.swift
//  QScore
//
//  Created by Gurdev Singh on 12/10/14.
//  Copyright (c) 2014 Gurdev Singh. All rights reserved.
//

import UIKit
import TwitterKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    lazy var passcodeLockPresenter: PasscodeLockPresenter = {
        
        let configuration = PasscodeLockConfiguration()
        let presenter = PasscodeLockPresenter(mainWindow: self.window, configuration: configuration)
        
        return presenter
    }()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        //Enable Toolbar on Keyboard
        IQKeyboardManager.sharedManager().enable = true
        
        //Twitter API Key
        Twitter.sharedInstance().startWithConsumerKey(STRINGVALUES.TWITTER_CONSUMER_KEY, consumerSecret: STRINGVALUES.TWITTER_CONSUMER_SECRET)
        
        
        //Crashlytics API Key
       //Fabric.with([Crashlytics.startWithAPIKey(STRINGVALUES.CRASHALYTICS_API_KEY),Twitter.sharedInstance()])
        
        let settings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
        UIApplication.sharedApplication().registerForRemoteNotifications()
        
        application.applicationIconBadgeNumber = 0
        
        //present lock screen if enabled
        passcodeLockPresenter.presentPasscodeLock()

        // add menu icon for left menu slider
        self.addMenuSlider()
        
        self.window!.makeKeyAndVisible()
        return true
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {

        let characterSet: NSCharacterSet = NSCharacterSet( charactersInString: "<>" )
        
        let deviceTokenString: String = ( deviceToken.description as NSString )
            .stringByTrimmingCharactersInSet( characterSet )
            .stringByReplacingOccurrencesOfString( " ", withString: "" ) as String
        AppInstance.applicationInstance.device_id = deviceTokenString
        
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        Helper.printLog("Couldn't register: \(error)")
    }

    func application(application: UIApplication,
        openURL url: NSURL,
        sourceApplication: String?,
        annotation: AnyObject) -> Bool {
            

            return FBSDKApplicationDelegate.sharedInstance().application(
                application,
                openURL: url,
                sourceApplication: sourceApplication,
                annotation: annotation)
    }
    
    //MARK: Add Menu Slider
    func addMenuSlider()
    {
        if (!SlideNavigationController.sharedInstance().isMenuAdded)
        {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let sideViewController = storyboard.instantiateViewControllerWithIdentifier("leftMenuViewController")as! LeftMenuVC
            SlideNavigationController.sharedInstance().leftMenu = sideViewController
            SlideNavigationController.sharedInstance().menuRevealAnimationDuration = 0.18
            
           let imgMenu: UIImage = UIImage(named:"icon-menuSup")!
            
            // Creating a custom bar button for right menu
           let button = UIButton(type: UIButtonType.Custom)
               button.frame = CGRectMake(0, 0, imgMenu.size.width, imgMenu.size.height)
               button.setImage(imgMenu, forState: UIControlState.Normal)
            
               button.addTarget(SlideNavigationController.sharedInstance(), action: "toggleLeftMenu", forControlEvents: UIControlEvents.TouchUpInside)
            let leftButton: UIBarButtonItem = UIBarButtonItem(customView:button)
            
            SlideNavigationController.sharedInstance().leftBarButtonItem = leftButton
            
            SlideNavigationController.sharedInstance().isMenuAdded = true
            
        }
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
       
        //present lock screen
        passcodeLockPresenter.presentPasscodeLock()
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        FBSDKAppEvents.activateApp()
        
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:

    }
    
    func didFinishedWithError(errorMessage: String) {
        Helper.printLog("Error")
    }
    
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        Helper.printLog("Remove notification received \(userInfo)",override: true)
//        NSNotificationCenter.defaultCenter().postNotificationName("RemotePush", object: 0, userInfo: userInfo)
    }
}

