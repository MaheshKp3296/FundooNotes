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
    var presenter : LogInPresenter?
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = LogInPresenterImpl()
    }
    
    
    @IBAction func loginAction(_ sender: Any) {
        let emailString = emailField.text
        let passwordString = passwordField.text
        let validUser = presenter?.checkUser(emailString!, passwordString!)
        
        if (emailString?.isEmpty)! || (passwordString?.isEmpty)! {
            displayAlertMessage(title: "Alert", message: "Fill  all fields")
        }
        
        if validUser! {
            let storyboard = UIStoryboard(name: "SignIn", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ContainerVCID") as UIViewController
            present(vc, animated: true, completion: nil)
            
        }
        else {
            displayAlertMessage(title: "Alert", message: "Invalid email or password")
        }
    }
    
    func displayAlertMessage(title: String, message: String) {
        let alertController1 = UIAlertController (title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController1.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController1, animated: true, completion: nil)
    }
    
}
