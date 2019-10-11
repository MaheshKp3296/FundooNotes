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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        if isValidInput(Input: nameText.text!) {
            if isPasswordValid(passwordText.text!) {
                if isValidEmail(testStr: emailText.text!) {
                    
                    let appDelegate : AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
                    let context : NSManagedObjectContext = appDelegate.persistentContainer.viewContext
                    let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as NSManagedObject
                    newUser.setValue(nameText.text, forKey: "name")
                    newUser.setValue(passwordText.text, forKey: "password")
                    newUser.setValue(emailText.text, forKey: "email")
                    do {
                        try context.save()
                    } catch {
                        print(" ")
                    }
                    print(newUser)
                    print("Object Saved.")
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
    
    func isValidInput(Input:String) -> Bool {
        let RegEx = "\\A\\w{3,18}\\z"  //  \\[A-Za-z]{3, 18}
        let Test = NSPredicate(format:"SELF MATCHES %@", RegEx)
        return Test.evaluate(with: Input)
    }
    
    func isPasswordValid(_ password : String) -> Bool {
        let  passwordRegex = "(?=.*[A-Z])(?=.*[0-9])(?=.*[$@$#!%*?&])(?=.*[a-z]).{6,16}"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: password)
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func displayAlertMessage(title: String, message: String) {
        let alertController1 = UIAlertController (title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController1.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController1, animated: true, completion: nil)
    }
    
}



