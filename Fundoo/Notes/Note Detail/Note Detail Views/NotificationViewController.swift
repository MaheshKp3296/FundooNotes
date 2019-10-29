//
//  NotificationViewController.swift
//  Fundoo
//
//  Created by User on 29/10/19.
//  Copyright © 2019 BridgeLabz. All rights reserved.
//

import UIKit
import UserNotifications

typealias setDate  = (_ dateInfo : Date) -> ()
class NotificationViewController: UIViewController {
    
    @IBOutlet weak var dateAndTimePicker: UIDatePicker!
    var completionBlock : setDate?

    override func viewDidLoad() {
        super.viewDidLoad()
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted{
                print("permission granted")
            }
            else{
                print("denied")
            }
        }
    }
    
    @IBAction func addReminder(_ sender: Any) {
        let date = dateAndTimePicker.date
        completionBlock?(date)
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func backButton(_ sender: Any) {
       dismiss(animated: true, completion: nil)
    }
    

}
