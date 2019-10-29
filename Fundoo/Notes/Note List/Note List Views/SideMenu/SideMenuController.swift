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
        
        if indexPath.row == SideMenuIndex.NotesPageIndex.rawValue {
            NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
             NotificationCenter.default.post(name: NSNotification.Name("SideMenuView"), object: nil, userInfo: ["value": indexPath.row])
        }
        
        if indexPath.row == SideMenuIndex.ArchivePageIndex.rawValue {
            NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name("SideMenuView"), object: nil, userInfo: ["value": indexPath.row])
        }
        
        if indexPath.row == SideMenuIndex.ReminderNotesIndex.rawValue {
            NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name("SideMenuView"), object: nil, userInfo: ["value": indexPath.row])
        }
        
        if indexPath.row == SideMenuIndex.LogOutPageIndex.rawValue {
            UserDefaults.standard.removeObject(forKey: "email")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "LoginVcId") as UIViewController
            present(vc, animated: true, completion: nil)
        }
    }
    
}

enum SideMenuIndex : Int {
    case NotesPageIndex = 1
    case ReminderNotesIndex = 2
    case ArchivePageIndex = 4
    case LogOutPageIndex = 6
}
