//
//  AppDelegate.swift
//  LinkIt
//
//  Created by Ariel Rodriguez on 26/12/2017.
//  Copyright © 2017 Ariel Rodriguez. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var linkIt = LinkIt()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        self.linkIt.loadSystemBar()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}
