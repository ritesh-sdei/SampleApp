//
//  Application.swift
//  TestSwift
//
//  Created by Gurdev Singh on 12/25/14.
//  Copyright (c) 2014 Gurdev Singh. All rights reserved.
//

import UIKit

private let _applicationInstance = AppInstance()


class AppInstance: NSObject {
    class var applicationInstance : AppInstance {
        
        return _applicationInstance
        
    }
    var user:User?
    var facebookId = ""
    var device_id = ""
    var GLOBAL_CONNECTION:CONNECTIONMODE.enBuildConnection = CONNECTIONMODE.enBuildConnection.Dev
    var tokenExpired = false
    var VERBOSE_MODE = false
    var userLoggedIn = false
}
