//
//  AppDelegate.swift
//  Vanity Mirror
//
//  Created by Sam Parsons on 6/28/20.
//  Copyright © 2020 Sam Parsons. All rights reserved.
//

import Cocoa
import SwiftUI
import HotKey
import AVFoundation

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var popover: NSPopover!
    
    var statusBarItem: NSStatusItem!
    
//    private let session = AVCaptureSession()
    
    // toggles camera pane
    @objc func togglePopover(_ sender: AnyObject?) {
         if let button = self.statusBarItem.button {
              if self.popover.isShown {
                   self.popover.performClose(sender)
              } else {
                   self.popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
              }
         }
    }
    
    private var hotKey: HotKey? {
        didSet {
            guard let hotKey = hotKey else {
                print("HotKey not available")
                return
            }
            
            hotKey.keyDownHandler = { [weak self] in
                self?.togglePopover(self)
            }
        }
    }


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // register the hotkey
        register(self)
        
        // Create the SwiftUI view that provides the window contents.
        let contentView = ViewController()

        // Create the popover
        let popover = NSPopover()
        popover.contentSize = NSSize(width: 640, height: 480)
        popover.behavior = .transient
        popover.contentViewController = contentView
        self.popover = popover
        
        self.statusBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
        if let button = self.statusBarItem.button {
             button.image = NSImage(named:NSImage.Name("StatusBarButtonImage"))
             button.action = #selector(togglePopover(_:))
        }
    }
    

    func applicationWillTerminate(_ aNotification: Notification) {
        // unregister hotkey
        unregister(self)
    }
    
    @IBAction func unregister(_ sender: Any?) {
        hotKey = nil
    }

    @IBAction func register(_ sender: Any?) {
        hotKey = HotKey(keyCombo: KeyCombo(key: .v, modifiers: [.command, .option]))
    }

}

