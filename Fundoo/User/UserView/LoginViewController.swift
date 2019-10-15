//
//  LoginViewController.swift
//  Fundoo
//
//  Created by User on 25/09/19.
//  Copyright © 2019 BridgeLabz. All rights reserved.
//

import UIKit
import CoreData
class LoginViewController: UIViewController, LoginView {
    
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    var presenter : LogInPresenter?
    var message = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = LogInPresenterImpl(view: self)
        presenter?.showMessage()
    }
    
    func onFailure(message: String) {
        self.message = message
    }
    
    @IBAction func loginAction(_ sender: Any) {
        let validUser = presenter?.checkUser(emailField.text!, passwordField.text!)
        
        if areFieldsEmpty() {
            displayAlertMessage(title: "Alert", message: "Fill all fields")
        }
        
        if validUser! {
            doLogin()
        }
        else {
            displayAlertMessage(title: "Alert", message: message)
        }
    }
    
    private func areFieldsEmpty() -> Bool{
        return (emailField.text!.isEmpty) || (passwordField.text!.isEmpty)
    }
    
    func doLogin(){
        let storyboard = UIStoryboard(name: "SignIn", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ContainerVCID") as UIViewController
        present(vc, animated: true, completion: nil)
    }
    
    func displayAlertMessage(title: String, message: String) {
        let alertController1 = UIAlertController (title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController1.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController1, animated: true, completion: nil)
    }
    
}
