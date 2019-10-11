//
//  UserCoreDataHelper.swift
//  Fundoo
//
//  Created by User on 11/10/19.
//  Copyright © 2019 BridgeLabz. All rights reserved.
//

import UIKit
import CoreData

protocol UserModel {
    func newUser() -> User
    func saveUser()
    func delete(user: User)
    func retrieveUsers() -> [User]
    func addUser(_ userName : String, _ email: String, password : String )
}

class UserManager : UserModel {
    let context: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        
        let persistentContainer = appDelegate.persistentContainer
        let context = persistentContainer.viewContext
        
        return context
    }()
    
    func newUser() -> User {
        let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as! User
        
        return user
    }
    
    func saveUser() {
        do {
            try context.save()
        }
        catch let error {
            print("Could not save \(error.localizedDescription)")
        }
    }
    
    func delete(user: User) {
        context.delete(user)
        
        saveUser()
    }
    
    func retrieveUsers() -> [User] {
        do {
            let fetchRequest = NSFetchRequest<User>(entityName: "User")
            let results = try context.fetch(fetchRequest)
            
            return results
        }
        catch let error {
            print("Could not fetch \(error.localizedDescription)")
            
            return []
        }
    }
    
    func addUser(_ userName : String, _ email: String, password : String ) {
        let newUser = self.newUser()
        newUser.setValue(userName, forKey: "name")
        newUser.setValue(email, forKey: "email")
        newUser.setValue(password, forKey: "password")
        saveUser()
    }
    
    
}