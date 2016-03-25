//
//  TestExtension.swift
//  Quealth
//
//  Created by Gurdev Singh on 03/01/16.
//  Copyright © 2016 Gurdev Singh. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    
    override public var description: String {
        let id = identifier ?? ""
        return "id: \(id), constant: \(constant)" //you may print whatever you want here
    }
}
