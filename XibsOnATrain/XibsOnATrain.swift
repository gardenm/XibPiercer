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
        center.addObserver(self, selector: #selector(self.createMenuItems), name: NSApplicationDidFinishLaunchingNotification, object: nil)
    }

    deinit {
        removeObserver()
    }

    func removeObserver() {
        center.removeObserver(self)
    }

    func createMenuItems() {
        removeObserver()

        guard let mainMenu = NSApp.mainMenu else { return }
        guard let item = mainMenu.itemWithTitle("Edit") else { return }
        guard let submenu = item.submenu else { return }

        let actionMenuItem = NSMenuItem(title:"Do Action", action:#selector(self.doMenuAction), keyEquivalent:"")
        actionMenuItem.target = self

        submenu.addItem(NSMenuItem.separatorItem())
        submenu.addItem(actionMenuItem)
    }

    func doMenuAction() {
        let error = NSError(domain: "Hello World!", code:42, userInfo:nil)
        NSAlert(error: error).runModal()
    }
}

