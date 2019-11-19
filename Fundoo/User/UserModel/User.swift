//
//  User.swift
//  Fundoo
//
//  Created by User on 12/10/19.
//  Copyright © 2019 BridgeLabz. All rights reserved.
//

import Foundation

struct UserInfo {
    var name : String
    var email : String
    var password : String
}

struct UserDetails : Codable{
    var firstName = "Chacha"
    var lastName = "Choudary"
    var password : String
    var phoneNumber : String?
    var imageUrl : String?
    var role = "user"
    var service = "basic"
    var createdDate = "2018-10-10T05:14:44.485Z"
    var modifiedDate = "2018-10-10T05:14:44.485Z"
    var address : String?
    var realm : String?
    var username : String
    var email : String
    var emailVerified : Bool?
    var id : String?

    init(username : String, email: String, password: String){
        self.username = username
        self.email = email
        self.password = password
    }
}



