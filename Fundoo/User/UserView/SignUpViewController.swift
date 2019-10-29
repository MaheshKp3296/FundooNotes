//
//  SignUpViewController.swift
//  Fundoo
//
//  Created by User on 24/09/19.
//  Copyright © 2019 BridgeLabz. All rights reserved.
//

import UIKit
import CoreData

//@available(iOS 13.0, *)
class SignUpViewController: UIViewController, SignUpView {
   
    var failureMsg = ""
    var successMsg = ""
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var nameText: UITextField!
    
    @IBOutlet var emailText: UITextField!
    
    @IBOutlet var passwordText: UITextField!
    
    @IBOutlet var confirmPasswordText: UITextField!
    
    var presenter : SignUpPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = SignUpPresenterImpl(view: self)
    //    scrollView.contentSize=CGSize(width: self.view.frame.width, height: self.view.frame.height+100)
    }
    
    func onSuccess(message: String) {
        self.successMsg = message
    }
    
    func onFailure(message: String) {
        self.failureMsg = message
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        if areFieldsEmpty() {
            displayAlertMessage(title: "Alert", message: "All fields are required")
            return
        }
       
        if !presenter!.isValidUser(nameText.text!) {
            print("name check")
            displayAlertMessage(title: "Alert", message: failureMsg)
            return
        }
        if !presenter!.isPasswordValid(passwordText.text!) {
            print("pswd check")
            displayAlertMessage(title: "Alert", message: failureMsg)
        }
        if arePasswordsMatching() {
            displayAlertMessage(title: "Alert", message: "Passwords do not match")
            return
        }
        if !presenter!.isValidEmail(emailText.text!) {
            
            print("mail check")
            displayAlertMessage(title: "Alert", message: failureMsg)
        }
        
        doAddUser()
    }
    
    private func areFieldsEmpty() -> Bool {
        return (nameText.text!.isEmpty || emailText.text!.isEmpty || passwordText.text!.isEmpty)
    }
    
    private func arePasswordsMatching() -> Bool {
        return (passwordText!.text != confirmPasswordText!.text)
    }
    
    func displayAlertMessage(title: String, message: String) {
        let alertController1 = UIAlertController (title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController1.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController1, animated: true, completion: nil)
    }
    
    private func doAddUser() {
        let user = UserInfo(name: nameText.text!,email: emailText.text!,password: passwordText.text!)
        presenter?.registerUser(user: user)
        let myAlert = UIAlertController (title: "Congrats!", message: successMsg, preferredStyle: UIAlertController.Style.alert)
        let okAction  = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { action in
            self.dismiss(animated: true, completion: nil) }
        myAlert.addAction(okAction)
        self.present(myAlert, animated: true, completion: nil)
    }
}



