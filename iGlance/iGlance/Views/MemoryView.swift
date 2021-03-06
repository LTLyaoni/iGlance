//
//  MemoryView.swift
//  iGlance
//
//  Created by Dominik on 27.10.18.
//  Copyright © 2018 iGlance Corp. All rights reserved.
//

import Cocoa

class MemoryView: NSViewController {
    
    // define the color values for the memory icon
    var colRedMem: CGFloat = 0
    var colBlueMem: CGFloat = 0
    var colGreenMem: CGFloat = 0
    var colAlphaMem: CGFloat = 0
    
    // define the outlet and the action of the checkbox which displays the memory usage icon
    @IBOutlet weak var cbMemUtil: NSButton! {
        didSet {
            cbMemUtil.state = AppDelegate.UserSettings.userWantsMemUsage ? NSButton.StateValue.on : NSButton.StateValue.off
        }
    }
    @IBAction func cbMemUtil_clicked(_ sender: NSButton) {
        let checked = (cbMemUtil.state == NSButton.StateValue.on)
        AppDelegate.UserSettings.userWantsMemUsage = checked
        AppDelegate.sItemMemUsage.isVisible = checked
        UserDefaults.standard.set(checked, forKey: "userWantsMemUsage")
        checked ? MyStatusItems.insertItem(item: MyStatusItems.StatusItems.memUtil) : MyStatusItems.removeItem(item: MyStatusItems.StatusItems.memUtil)
    }
    
    // define the outlet and the action of the checkbox which enables and disables the border of the memory icon
    @IBOutlet weak var cbMemBorder: NSButton! {
        didSet {
            cbMemBorder.state = AppDelegate.UserSettings.userWantsMemBorder ? NSButton.StateValue.on : NSButton.StateValue.off
        }
    }
    @IBAction func cbMemBorder_clicked(_ sender: NSButton) {
        AppDelegate.UserSettings.userWantsMemBorder = (cbMemBorder.state == NSButton.StateValue.on)
        UserDefaults.standard.set((cbMemBorder.state == NSButton.StateValue.on), forKey: "userWantsMemBorder")
    }
    
    
    // define the outlet and the action of the color well to change the color of the memory icon
    @IBOutlet weak var cpMemUtil: NSColorWell! {
        didSet {
            cpMemUtil.color = AppDelegate.UserSettings.memColor
            AppDelegate.UserSettings.memColor.getRed(&colRedMem, green: &colGreenMem, blue: &colBlueMem, alpha: &colAlphaMem)
        }
    }
    @IBAction func cpMem_clicked(_ sender: NSColorWell) {
        AppDelegate.UserSettings.memColor = sender.color
        sender.color.usingColorSpace(NSColorSpace.genericRGB)?.getRed(&colRedMem, green: &colGreenMem, blue: &colBlueMem, alpha: &colAlphaMem)
        UserDefaults.standard.set(CGFloat(round(colRedMem * 10000)/10000), forKey: "colRedMem")
        UserDefaults.standard.set(CGFloat(round(colGreenMem * 10000)/10000), forKey: "colGreenMem")
        UserDefaults.standard.set(CGFloat(round(colBlueMem * 10000)/10000), forKey: "colBlueMem")
        UserDefaults.standard.set(CGFloat(round(colAlphaMem * 10000)/10000), forKey: "colAlphaMem")
    }
}
