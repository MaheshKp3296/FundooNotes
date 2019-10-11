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
    func logIn(_ userName: String, _ email: String, _ password: String)
}


class SignUpPresenterImpl: SignUpPresenter {
    
    var userModel : UserModel?
    
    func isValidUser(_ user:String) -> Bool {
        let RegEx = "\\A\\w{3,18}\\z" 
        let Test = NSPredicate(format:"SELF MATCHES %@", RegEx)
        return Test.evaluate(with: user)
    }
    
    func isPasswordValid(_ password : String) -> Bool {
        let  passwordRegex = "(?=.*[A-Z])(?=.*[0-9])(?=.*[$@$#!%*?&])(?=.*[a-z]).{6,16}"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: password)
    }
    
    func isValidEmail(_ email:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    func logIn(_ userName: String, _ email: String, _ password: String) {
        userModel = UserManager()
        userModel!.addUser(userName, email, password: password)
    }
    
    
}
