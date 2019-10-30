//
//  SideMenuController.swift
//  Fundoo
//
//  Created by User on 03/10/19.
//  Copyright © 2019 BridgeLabz. All rights reserved.
//

import UIKit

class SideMenuController: UITableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case SideMenuIndex.NotesPageIndex.rawValue :
            NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name("SideMenuView"), object: nil, userInfo: ["value": SideMenuIndex.NotesPageIndex.rawValue])
            
        case SideMenuIndex.ReminderNotesIndex.rawValue :
            NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name("SideMenuView"), object: nil, userInfo: ["value": SideMenuIndex.ReminderNotesIndex.rawValue])
            
        case SideMenuIndex.ImpNotesIndex.rawValue :
            NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name("SideMenuView"), object: nil, userInfo: ["value": SideMenuIndex.ImpNotesIndex.rawValue])
            
        case SideMenuIndex.ArchivePageIndex.rawValue :
            NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name("SideMenuView"), object: nil, userInfo: ["value": SideMenuIndex.ArchivePageIndex.rawValue])
            
        case SideMenuIndex.LogOutPageIndex.rawValue :
            UserDefaults.standard.removeObject(forKey: "email")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "LoginVcId") as UIViewController
            present(viewController, animated: true, completion: nil)
            
        default:
            print("error")
        }
        
    }
    
    enum SideMenuIndex : Int {
        case NotesPageIndex = 1
        case ReminderNotesIndex = 2
        case ImpNotesIndex = 3
        case ArchivePageIndex = 4
        case LogOutPageIndex = 6
    }
}
