//
//  LoginViewController.swift
//  Fundoo
//
//  Created by User on 25/09/19.
//  Copyright © 2019 BridgeLabz. All rights reserved.
//

import UIKit
import CoreData
class LoginViewController: UIViewController {
    
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func loginAction(_ sender: Any) {
        // view
        let emailString = emailField.text
        let passwordString = passwordField.text
        
        // model
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.predicate = NSPredicate(format: "email == %@", emailString!)
        do {
            let result = try context.fetch(request)
            if result.count > 0 {
                let email = (result[0] as AnyObject).value(forKey: "email") as! String
                let password = (result[0] as AnyObject).value(forKey: "password") as! String
                
                if emailString == email && passwordString == password {
                    let storyboard = UIStoryboard(name: "SignIn", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "ContainerVCID") as UIViewController
                    present(vc, animated: true, completion: nil)
                }
                else if emailString == email || passwordString == password {
                    let alertController1 = UIAlertController(title: "Alert", message: "Invalid email or password", preferredStyle: UIAlertController.Style.alert)
                    alertController1.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alertController1, animated: true, completion: nil)
                }
            }
            else {
                let alertController1 = UIAlertController(title: "Alert", message: "Invalid email or password", preferredStyle: UIAlertController.Style.alert)
                alertController1.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alertController1, animated: true, completion: nil)
            }
        }
        catch {
            
        }
    }
    
    
}
