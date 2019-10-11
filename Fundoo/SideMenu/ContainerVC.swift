//
//  ContainerVC.swift
//  Fundoo
//
//  Created by User on 03/10/19.
//  Copyright © 2019 BridgeLabz. All rights reserved.
//

import UIKit

class ContainerVC: UIViewController {
    
    @IBOutlet weak var sideMenuConstraint : NSLayoutConstraint!
    var isSideMenuOpen : Bool! {
        didSet {
            if isSideMenuOpen {
                sideMenuConstraint.constant = 0
            } else {
                sideMenuConstraint.constant = -240
            }
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isSideMenuOpen = false
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(toggleSideMenu),
                                               name: NSNotification.Name("ToggleSideMenu"),
                                               object: nil)
    }
    
    @objc func toggleSideMenu() {
        isSideMenuOpen = !isSideMenuOpen
    }
}
