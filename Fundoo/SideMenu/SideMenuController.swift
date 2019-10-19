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
        
        if indexPath.row == 1 {
            NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
        }
        
        if indexPath.row == 6 {
            UserDefaults.standard.removeObject(forKey: "email")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "LoginVcId") as UIViewController
            present(vc, animated: true, completion: nil)
        }
    }
    
}
