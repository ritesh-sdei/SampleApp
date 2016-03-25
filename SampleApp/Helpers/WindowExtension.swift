//
//  WindowExtension.swift
//  Quealth
//
//  Created by Gurdev Singh on 05/01/16.
//  Copyright © 2016 Gurdev Singh. All rights reserved.
//

import UIKit


public extension UIWindow {
    
    func capture() -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(self.frame.size, self.opaque, 0.0)
        
        self.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
}