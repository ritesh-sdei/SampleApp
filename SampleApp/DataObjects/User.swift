//
//  User.swift
//  TestSwift
//
//  Created by Gurdev Singh on 12/23/14.
//  Copyright (c) 2014 Gurdev Singh. All rights reserved.
//

import UIKit



public class User : NSObject,NSCoding,Deserializable {
    
    var email:String?
    var name:String?
    var username:String?
    var _id:String?
    var age:Int?
    var password:String?
    var accessToken:String?
    var message:String?
    var socialmedia_id:String?
    override init()
    {
        email=nil
        name=nil
        username=nil
        _id=nil
        password=nil
        accessToken = nil
    }
    
    required public init(coder aDecoder: NSCoder) {
        self.email = aDecoder.decodeObjectForKey("email")  as? String
        self._id = aDecoder.decodeObjectForKey("_id") as? String
        self.username = aDecoder.decodeObjectForKey("username") as? String
        self.name = aDecoder.decodeObjectForKey("name") as? String
        self.accessToken=aDecoder.decodeObjectForKey("accessToken") as? String
        self.password = aDecoder.decodeObjectForKey("password") as? String
    }
    
    public func encodeWithCoder(_aCoder: NSCoder) {
        _aCoder.encodeObject(self.email, forKey: "email")
        _aCoder.encodeObject(self._id, forKey: "_id")
        _aCoder.encodeObject(self.username, forKey: "username")
        _aCoder.encodeObject(self.name, forKey: "name")
        _aCoder.encodeObject(self.password, forKey: "password")
    }
    
    func toDictionary() -> NSMutableDictionary {
        let dict:NSMutableDictionary = NSMutableDictionary()
        dict.setValue(self.email!, forKey: "email")
        dict.setValue(self._id!, forKey: "_id")
        dict.setValue(self.username!, forKey: "username")
        dict.setValue(self.name!, forKey: "name")
        dict.setValue(self.password!, forKey: "password")

        return dict
    }
    
    
    required public init(data: [String: AnyObject]) {
        email <-- data["email"]
        username <-- data["username"]
        name <-- data["name"]
        _id <-- data["_id"]
    }
}
