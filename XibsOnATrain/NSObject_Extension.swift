//
//  NSObject_Extension.swift
//
//  Created by Matthew Garden on 2016-05-01.
//  Copyright © 2016 Savagely Optimized. All rights reserved.
//

import Foundation

extension NSObject {
    class func pluginDidLoad(bundle: NSBundle) {
        let appName = NSBundle.mainBundle().infoDictionary?["CFBundleName"] as? NSString
        if appName == "Xcode" {
        	if sharedPlugin == nil {
        		sharedPlugin = XibsOnATrain(bundle: bundle)
        	}
        }
    }
}