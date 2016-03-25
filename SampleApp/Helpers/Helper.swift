
//
//  Helper.swift
//  TestSwift
//
//  Created by Gurdev Singh on 12/30/14.
//  Copyright (c) 2014 Gurdev Singh. All rights reserved.
//

import UIKit

class Helper: NSObject {

    
    class func SaveUserObjectToFile(user:User) {
        let fileSaved = NSKeyedArchiver.archiveRootObject(user, toFile: GetFilePath("User.plist"))
        Helper.printLog(fileSaved)
    }
    
    class func ReadUserObjectFromFile() -> User? {
        if let user = NSKeyedUnarchiver.unarchiveObjectWithFile(GetFilePath("User.plist")) as? User {
            return user
        }
        return nil
    }
    
    class func getDocumentsURL() -> NSURL {
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        return documentsURL
    }
    
    class func GetFilePath(fileName:String) -> String {
        let fileURL = getDocumentsURL().URLByAppendingPathComponent(fileName)
        return fileURL.path!
    }
    
    class func FileExists(fileName:String) -> Bool {
        return NSFileManager.defaultManager().fileExistsAtPath(GetFilePath(fileName))
    }
    
    class func DeleteUserObject() {
        DeleteAllFiles()
    }
    
    class func DeleteAllFiles() {
        let fileManager:NSFileManager=NSFileManager()
        do {
            
            let folderPathURL = fileManager.URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask)[0]
            if let directoryURLs = try? fileManager.contentsOfDirectoryAtURL(folderPathURL, includingPropertiesForKeys: nil, options: NSDirectoryEnumerationOptions.SkipsHiddenFiles) {
                let listOfFiles = try? directoryURLs.filter { $0.pathExtension == "plist" }.map { $0.lastPathComponent! }
                if let files = listOfFiles {
                    for file in files {
                        try fileManager.removeItemAtPath(GetFilePath(file))
                    }
                }
            }
        }catch let error as NSError{
            Helper.printLog(error.localizedDescription)
        }
    }
    
    class func SaveImageToFile(imageData:UIImage,filename:String) {
        let saved = UIImagePNGRepresentation(imageData)!.writeToFile(GetFilePath(filename), atomically: true)
        if saved==true {
                Helper.printLog("image data saved.")
        }
    }
    
    class func GetPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true) as! [String]
        return paths.first!
    }
    
    
    class func convertText(inputText: String) -> NSAttributedString {
        var html = inputText
        while let range = html.rangeOfString("\n") {
            html.replaceRange(range, with: "<br />")
        }
        
        html = "<span style=\"font-family: Helvetica; font-size:12pt;\">" + html + "</span>"
        
        let data = html.dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: true)!
        do {
            let attrStr = try NSAttributedString(data: data, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
            return attrStr
        } catch let error as NSError {
            Helper.printLog(error.localizedDescription)
        }
        
        return NSAttributedString(string: "")
    }
    
    class func getTintedImage(backgroundImage:UIImage,transparentImage:UIImage,tintColor:UIColor,rect:CGRect) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        let context:CGContextRef  = UIGraphicsGetCurrentContext()!
        let ivTemp:UIImageView=UIImageView(image: transparentImage.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate))
        ivTemp.tintColor=tintColor
        ivTemp.frame.size.height=rect.size.height
        ivTemp.frame.size.width=rect.size.width
        let bInfo:UIButton=UIButton(type: UIButtonType.Custom)
        bInfo.setImage(backgroundImage, forState: UIControlState.Normal)
        bInfo.frame.size.height=rect.size.height
        bInfo.frame.size.width=rect.size.width
        ivTemp.addSubview(bInfo)
        
        ivTemp.layer.renderInContext(context)
        let tintedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return tintedImage
    }
    
    class func TrackScreenName(screenString:String) {
//        let tracker = GAI.sharedInstance().defaultTracker
//        tracker.set(kGAIScreenName, value: screenString)
//        
//        let builder = GAIDictionaryBuilder.createScreenView()
//        let build = builder.build()
//        tracker.send(build as! [NSObject:AnyObject])
    }
    
    class func TrackAPICall(apiString:String) {
//        let tracker = GAI.sharedInstance().defaultTracker
//        tracker.set(kGAIEvent, value: apiString)
//
//        let builder = GAIDictionaryBuilder.createEventWithCategory(apiString, action: "API", label: apiString, value: 1)
//        let build = builder.build()
//        tracker.send(build as! [NSObject:AnyObject])
    }
    
    class func getDeviceModel() -> DEVICES.enDeviceFamily
    {
        var screenHeight: CGFloat!
        screenHeight = UIScreen .mainScreen().bounds.size.height
        if screenHeight > 480 && screenHeight < 667 { //iphone5 family
            return DEVICES.enDeviceFamily.iPhone5Family
        }
        else if  screenHeight > 480 && screenHeight < 736 { //iPhone6
            return DEVICES.enDeviceFamily.iPhone6
        }
        else if ( screenHeight > 480 ) { // iPhone6Plus
            return DEVICES.enDeviceFamily.iPhone6Plus
        }
        return DEVICES.enDeviceFamily.iPhone5Family
    }
    

    class func convertObjectToJson(object:NSObject) -> String {
        
        do {
            let jsonData = try NSJSONSerialization.dataWithJSONObject(object, options: NSJSONWritingOptions.PrettyPrinted)
            if let result = NSString(data: jsonData, encoding: NSUTF8StringEncoding) {
                return result as String
            }
        } catch let error as NSError {
            Helper.printLog(error.localizedDescription)
        
        }
        
        return ""
    }
    
    class func getMainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    class func roundToPlaces(value:Double, places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return round(value * divisor) / divisor
    }
    
    class func printLog(logValue:AnyObject?,override:Bool=false) {
        if(AppInstance.applicationInstance.VERBOSE_MODE || override) {
            print(logValue)
        }
    }
}
