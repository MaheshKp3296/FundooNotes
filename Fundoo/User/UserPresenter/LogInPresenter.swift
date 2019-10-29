//
//  LogInPresenter.swift
//  Fundoo
//
//  Created by User on 11/10/19.
//  Copyright © 2019 BridgeLabz. All rights reserved.
//

import Foundation

protocol LogInPresenter {
    func checkUser(_ email : String , _ password : String) -> Bool
    func showMessage()
}

//@available(iOS 13.0, *)
class LogInPresenterImpl : LogInPresenter {
    var retrieveModel : UserModel?
    var view :  LoginView
    
    init(view : LoginView){
        self.view = view
    }
    
    
    func checkUser(_ email : String , _ password : String) -> Bool {
        retrieveModel = UserManager()
        var check = false
        let userList = retrieveModel?.retrieveUsers()
        for users in userList! {
            if users.email == email && users.password == password {
                check = true
            }
            else {
                check = false
            }
        }
        return check
    }
    
    func showMessage(){
        view.onFailure(message: "Invalid password or email")
    }
    
}
