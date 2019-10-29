//
//  UserPresenter.swift
//  Fundoo
//
//  Created by User on 11/10/19.
//  Copyright © 2019 BridgeLabz. All rights reserved.
//

import Foundation

protocol SignUpPresenter {
    func isValidUser(_ user:String) -> Bool
    func isPasswordValid(_ password : String) -> Bool
    func isValidEmail(_ email:String) -> Bool
    func registerUser(user : UserInfo)
}


//@available(iOS 13.0, *)
class SignUpPresenterImpl: SignUpPresenter {
    
    var userModel : UserModel?
    var view : SignUpView
    init(view : SignUpView) {
        self.view = view
    }
    
    func isValidUser(_ user:String) -> Bool {
        let RegEx = "\\A\\w{3,18}\\z" 
        let Test = NSPredicate(format:"SELF MATCHES %@", RegEx)
        if !(Test.evaluate(with: user)){
            view.onFailure(message: "Enter Valid Username")
        }
        return Test.evaluate(with: user)
    }
    
    func isPasswordValid(_ password : String) -> Bool {
        let  passwordRegex = "(?=.*[A-Z])(?=.*[0-9])(?=.*[$@$#!%*?&])(?=.*[a-z]).{6,16}"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        if !(passwordTest.evaluate(with: password)){
            view.onFailure(message: "Password must contain atleast 6 characters, including UpperCase,LowerCase,number and a special symbol")
        }
        return passwordTest.evaluate(with: password)
    }
    
    func isValidEmail(_ email:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if !(emailTest.evaluate(with: email)){
            view.onFailure(message: "Enter valid email")
        }
        return emailTest.evaluate(with: email)
    }
    
    func registerUser(user : UserInfo) {
    
        userModel = UserManager()
        userModel!.addUser(user : user)
        view.onSuccess(message: "Successfully registered")
    }
    
    
}

