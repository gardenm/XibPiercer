//
//  XibsOnATrain.swift
//
//  Created by Matthew Garden on 2016-05-01.
//  Copyright © 2016 Savagely Optimized. All rights reserved.
//

import AppKit

var sharedPlugin: XibsOnATrain?

class XibsOnATrain: NSObject {

    var bundle: NSBundle
    lazy var center = NSNotificationCenter.defaultCenter()

    init(bundle: NSBundle) {
        self.bundle = bundle

        super.init()
        
        center.addObserver(self, selector: #selector(self.handleNotification(_:)), name: nil, object: nil)
    }

    deinit {
        removeObserver()
    }

    func removeObserver() {
        center.removeObserver(self)
    }
    
    var timer: NSTimer?
    
    func handleNotification(notification: NSNotification) {
        print("name: \(notification.name)")
        if notification.name == "IDEEditorContextWillOpenNavigableItemNotification" ||
            notification.name == "NSApplicationDidFinishLaunchingNotification" {
            
            timer?.invalidate()
            timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: #selector(self.shake(_:)), userInfo: nil, repeats: true)
        }
    }
    
    func shake(timer: NSTimer) {
        let lowerValue: Int = -20
        
        let range: UInt32 = 40
        let xOffset: CGFloat = CGFloat(arc4random_uniform(range)) + CGFloat(lowerValue)
        let yOffset: CGFloat = CGFloat(arc4random_uniform(range)) + CGFloat(lowerValue)

        if let window = NSApplication.sharedApplication().mainWindow {
            var origin = window.frame.origin
            origin.x += xOffset
            origin.y += yOffset
            
            window.setFrameOrigin(origin)
        }
    }
}

