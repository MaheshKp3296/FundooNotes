//
//  SignUpViewController.swift
//  Fundoo
//
//  Created by User on 24/09/19.
//  Copyright © 2019 BridgeLabz. All rights reserved.
//

import UIKit
import CoreData
import FirebaseAuth
import Firebase

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
        
        if arePasswordsMatching() {
            displayAlertMessage(title: "Alert", message: "Passwords do not match")
            return
        }
        
        
        doSignUp()
        dismissView()
        
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
    
    private func dismissView() {
        //  let user = UserInfo(name: nameText.text!,email: emailText.text!,password: passwordText.text!)
        //  presenter?.registerUser(user: user)
        let myAlert = UIAlertController (title: "Registration Successful", message: "Please Login", preferredStyle: UIAlertController.Style.alert)
        let okAction  = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { action in
            self.dismiss(animated: true, completion: nil) }
        myAlert.addAction(okAction)
        self.present(myAlert, animated: true, completion: nil)
    }
    
    func doSignUp(){
        
        let userDetails = UserDetails.init(username: nameText.text!, email: emailText.text!, password: passwordText.text!)
        guard let url  = URL(string: "http://fundoonotes.incubation.bridgelabz.com/api/user/userSignUp") else { return }
        var request = URLRequest(url : url)
        request.httpMethod = "POST"
        
        do {
            let httpBody = try JSONEncoder().encode(userDetails)
             request.httpBody =  httpBody
        }
        catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            print(response!)
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                print(json)
            } catch {
                print("error")
            }
        })

        task.resume()
        
    }
    
    
    
    
}


//typealias error = Error
//signUp(emailText.text!, passwordText.text!, completion: { [weak self] error in
//    if error != nil {
//        self!.displayAlertMessage(title: "Alert", message: error!.localizedDescription)
//    }
//    else{
//        self!.doAddUser()
//    }
//})
//
//func signUp(_ email :String,_ password: String, completion : @escaping (error?)-> Void ){
//    Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
//        if error != nil{
//            completion(error)
//        }
//        else{
//            let firestoreDatabase = Firestore.firestore()
//            let uid = result!.user.uid
//            let document =  ["username":self.nameText.text!,"email":self.emailText.text!, "userId": uid]
//
//            firestoreDatabase.collection("user").document(uid).setData(document) {
//                guard let error = $0 else { return }
//                print(error)
//            }
//            completion(nil)
//        }
//    }
//
//}











//        if !presenter!.isPasswordValid(passwordText.text!) {
//            print("pswd check")
//            displayAlertMessage(title: "Alert", message: failureMsg)
//        }
//
//        if !presenter!.isValidEmail(emailText.text!) {
//
//            print("mail check")
//            displayAlertMessage(title: "Alert", message: failureMsg)
//        }
//
//        doAddUser()
