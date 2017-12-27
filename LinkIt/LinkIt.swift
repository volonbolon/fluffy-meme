//
//  LinkIt.swift
//  LinkIt
//
//  Created by Ariel Rodriguez on 27/12/2017.
//  Copyright © 2017 Ariel Rodriguez. All rights reserved.
//

import Cocoa

class LinkIt: NSObject {
    var item: NSStatusItem!

    func loadSystemBar() {
        let systemStatusBar = NSStatusBar.system
        self.item = systemStatusBar.statusItem(withLength: NSStatusItem.variableLength)
        let imageName = NSImage.Name(rawValue: "link")
        self.item.image = NSImage(named: imageName)

        let linkitAction = #selector(LinkIt.linkIt)
        let menu = NSMenu()

        let linkitTitle = NSLocalizedString("Link It!", comment: "Link It!")
        let linkitMenuItem = NSMenuItem(title: linkitTitle, action: linkitAction, keyEquivalent: "")
        linkitMenuItem.target = self
        menu.addItem(linkitMenuItem)

        let quitTitle = NSLocalizedString("Quit", comment: "Quit")
        let quitAction = #selector(LinkIt.quit)
        let quitMenuItem = NSMenuItem(title: quitTitle, action: quitAction, keyEquivalent: "")
        quitMenuItem.target = self
        menu.addItem(quitMenuItem)

        self.item.menu = menu
    }

    @objc func linkIt() {
        let pasteboard = NSPasteboard.general
        let utf8Type = NSPasteboard.PasteboardType(rawValue: "public.utf8-plain-text")
        let htmlType = NSPasteboard.PasteboardType(rawValue: "public.html")
        if let items = pasteboard.pasteboardItems {
            for item in items {
                for type in item.types where type == utf8Type {
                    if let urlString = item.string(forType: type) {
                        pasteboard.clearContents()
                        var urlWithScheme = urlString
                        if !(urlString.hasPrefix("http://") || urlString.hasPrefix("https://")) {
                            urlWithScheme = "http://" + urlString
                        }

                        let hrefString = "<a href=\"\(urlWithScheme)\">\(urlString)</a>"
                        pasteboard.setString(hrefString, forType: htmlType)
                        pasteboard.setString(urlString, forType: utf8Type)
                    }
                }
            }
        }
    }

    @objc func quit() {
        NSApplication.shared.terminate(self)
    }
}
