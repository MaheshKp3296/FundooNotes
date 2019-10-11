//
//  SignUpViewController.swift
//  Fundoo
//
//  Created by User on 24/09/19.
//  Copyright © 2019 BridgeLabz. All rights reserved.
//

import UIKit
import CoreData

class SignUpViewController: UIViewController {
    
    @IBOutlet var nameText: UITextField!
    
    @IBOutlet var emailText: UITextField!
    
    @IBOutlet var passwordText: UITextField!
    
    @IBOutlet var confirmPasswordText: UITextField!
    
    var presenter : SignUpPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = SignUpPresenterImpl()
        
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        
        if (nameText.text!.isEmpty || emailText.text!.isEmpty || passwordText.text!.isEmpty) {
            displayAlertMessage(title: "Alert", message: "All fields are required")
            return
        }
        
        if (passwordText!.text != confirmPasswordText!.text) {
            displayAlertMessage(title: "Alert", message: "Passwords do not match")
            return
        }
        
        if presenter!.isValidUser(nameText.text!) {
            if presenter!.isPasswordValid(passwordText.text!) {
                if presenter!.isValidEmail(emailText.text!) {
                    presenter!.logIn(nameText.text!, emailText.text!, passwordText.text!)
                    let myAlert = UIAlertController (title: "Valid ", message: "Sucess ", preferredStyle: UIAlertController.Style.alert)
                    let okAction  = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { action in
                        self.dismiss(animated: true, completion: nil) }
                    myAlert.addAction(okAction)
                    self.present(myAlert, animated: true, completion: nil)
                    
                }
                else {
                    print("mail check")
                    displayAlertMessage(title: "Fill email id", message: "Enter valid email")
                }
            }
            else {
                print("pswd check")
                displayAlertMessage(title: "Fill the password", message: "Password must contain atleast 6 characters, including UpperCase,LowerCase,number and a special symbol ")
            }
        }
        else {
            print("name check")
            displayAlertMessage(title: "Fill the name", message: "Enter valid username")
        }
    }
    
    func displayAlertMessage(title: String, message: String) {
        let alertController1 = UIAlertController (title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController1.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController1, animated: true, completion: nil)
    }
    
}



