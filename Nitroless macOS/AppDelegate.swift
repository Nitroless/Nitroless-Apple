//
//  AppDelegate.swift
//  Nitroless
//
//  Created by Paras KCD on 2022-10-08.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var popover = NSPopover.init()
    var statusBar: StatusBarController?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        NSAppleEventManager.shared().setEventHandler(self, andSelector: #selector(self.handleGetURL(event:reply:)), forEventClass: UInt32(kInternetEventClass), andEventID: UInt32(kAEGetURL) )
        
        // Create the SwiftUI view that provides the contents
        let contentView = ContentView()
        NSApp.setActivationPolicy(NSApplication.ActivationPolicy.accessory)

        // Set the SwiftUI's ContentView to the Popover's ContentViewController
        popover.contentViewController = MainViewController()
        popover.contentSize = NSSize(width: 512, height: 512)
        popover.contentViewController?.view = NSHostingView(rootView: contentView)
        
        // Create the Status Bar Item with the Popover
        statusBar = StatusBarController.init(popover)
    }
    
    @objc func handleGetURL(event: NSAppleEventDescriptor, reply:NSAppleEventDescriptor) {
        NSApp.setActivationPolicy(NSApplication.ActivationPolicy.accessory)
        if let urlString = event.paramDescriptor(forKeyword: keyDirectObject)?.stringValue {
            guard let url = URL(string: urlString) else { return }
            
            AppKitEvents.shared.receivedUrl = url
            print("Received and stored URL in AppKitEvents class")
        }
    }
    
    func popMenubarView() {
        guard let statusBar = statusBar else { return }
        statusBar.hidePopover(nil)
    }
    
    func showMenubarView() {
        guard let statusBar = statusBar else { return }
        statusBar.showPopover(nil)
    }
}

class AppKitEvents: ObservableObject {
    static let shared = AppKitEvents()
    
    @Published var receivedUrl: URL? = nil
}
