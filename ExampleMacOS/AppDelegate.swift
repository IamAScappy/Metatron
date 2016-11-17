//
//  AppDelegate.swift
//  Metatron Example (macOS)
//
//  Created by Almaz Ibragimov on 26.08.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import Cocoa

import Metatron

@NSApplicationMain class AppDelegate: NSObject, NSApplicationDelegate {

	// MARK: Instance Methods

    func applicationDidFinishLaunching(_ aNotification: Notification) {
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}
