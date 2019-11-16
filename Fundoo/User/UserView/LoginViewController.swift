//
//  LoginViewController.swift
//  Fundoo
//
//  Created by User on 25/09/19.
//  Copyright © 2019 BridgeLabz. All rights reserved.
//

import UIKit
import CoreData
import GoogleSignIn
import FacebookLogin
import FirebaseAuth
import Firebase

class LoginViewController: UIViewController, LoginView, GIDSignInDelegate, LoginButtonDelegate {
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet var noteImage: UIImageView!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    var presenter : LogInPresenter?
    var message = ""
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    @IBOutlet weak var faceBookLogin: FBLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        signInButton.style =  GIDSignInButtonStyle.wide
        
        faceBookLogin.delegate = self
        faceBookLogin.permissions = ["email"]
        
        presenter = LogInPresenterImpl(view: self)
        presenter?.showMessage()
        
        bottomLine(emailField)
        bottomLine(passwordField)
        
        loginButton.layer.cornerRadius = 10
    }
    
    func onFailure(message: String) {
        //self.message = message
    }
    
    @IBAction func loginAction(_ sender: Any) {
        if areFieldsEmpty() {
            displayAlertMessage(title: "Alert", message: "Fill all fields")
        }
      
        loginUsingAPI(emailField.text!, passwordField.text!) { (data, error) in
            guard let data = data else {
                return
            }
            if data["id"] != nil {
                    self.doLogin(self.emailField.text!)
                }
            else {
                self.displayAlertMessage(title: "Alert", message: "Invalid email or password field" )
            }
            
        }
       
    }
    
    private func areFieldsEmpty() -> Bool {
        return (emailField.text!.isEmpty) || (passwordField.text!.isEmpty)
    }
    
    func doLogin(_ email : String) {
        DispatchQueue.main.async {
        UserDefaults.standard.set(email, forKey: "email")
        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let vc =  storyboard.instantiateViewController(withIdentifier: "DashboardVC") as! DashboardVC
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.window?.rootViewController = vc
        }
    }
    
    func displayAlertMessage(title: String, message: String) {
        DispatchQueue.main.async {
        let alertController1 = UIAlertController (title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController1.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController1, animated: true, completion: nil)
        }
        
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            doLogin(emailField.text!)
        }
    }
    
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
        }
        
        if let result = result {
            if result.isCancelled {
                print("Facebook Login Cancelled")
                return
            }
            else {
                if result.grantedPermissions.contains("email"){
                    doLogin(emailField.text!)
                }
            }
        }
        else {
            return
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("")
    }
    
    func bottomLine(_ field : UITextField){
        let bottomLIne = CALayer()
        bottomLIne.frame = CGRect(x: 0.0, y: field.frame.height - 1, width: field.frame.width, height: 1.0)
        bottomLIne.backgroundColor = UIColor.white.cgColor
        field.borderStyle = UITextField.BorderStyle.none
        field.layer.addSublayer(bottomLIne)
    }
    
    typealias  ResponseData = [String : Any]
    typealias ResponseError = String
    
    func loginUsingAPI(_ userEmail : String, _ userPassword: String, completion : @escaping (ResponseData?, ResponseError?) -> Void){
        
        let userDetails = UserDetails( username: "abc", email:emailField.text!, password: passwordField.text!)
        guard let url  = URL(string: "http://fundoonotes.incubation.bridgelabz.com/api/user/login") else { return }
        var request = URLRequest(url : url)
        request.httpMethod = "POST"
        
        do {
            let httpBody = try JSONEncoder().encode(userDetails)
             request.httpBody =  httpBody
        }
        catch {}
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            print(response!)
            if let error = error {
                completion(nil, error.localizedDescription)
            }
            if let response = response
            {
                print(response)
             do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                completion(json, nil)
                print(json)
            } catch {
                print("error")
            }
        }
    })
     task.resume()
        
    }

    
    
}

extension UITextField {
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}


//  let validUser = presenter?.checkUser(emailField.text!, passwordField.text!)
//        if validUser! {
//            UserDefaults.standard.set(emailField.text!, forKey: "email")
//            let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
//            let vc =  storyboard.instantiateViewController(withIdentifier: "DashboardVC") as! DashboardVC
//            present(vc, animated: true, completion: nil)
//        }
//        else {
//            displayAlertMessage(title: "Alert", message: message)
//        }



//Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!) { (result, error) in
//           if error == nil{
//               self.doLogin((Auth.auth().currentUser?.email)!)
//           }
//           else {
//               self.displayAlertMessage(title: "Alert", message: error!.localizedDescription)
//           }
//       }
