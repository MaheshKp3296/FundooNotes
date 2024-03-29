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
    func addUser(user : UserInfo)
}

//@available(iOS 13.0, *)
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
        let user = NSEntityDescription.insertNewObject(forEntityName: UserEntity.EntityName.rawValue, into: context) as! User
        
        return user
    }
    
    func saveUser() {
        do {
            try context.save()
        }
        catch let error {
            print(error.localizedDescription)
        }
    }
    
    func delete(user: User) {
        context.delete(user)
        saveUser()
    }
    
    func retrieveUsers() -> [User] {
        do {
            let fetchRequest = NSFetchRequest<User>(entityName: UserEntity.EntityName.rawValue)
            let results = try context.fetch(fetchRequest)
            
            return results
        }
        catch let error {
            print(error.localizedDescription)
            
            return []
        }
    }
    
    func addUser(user : UserInfo) {
        let newUser = self.newUser()
        newUser.setValue(user.name, forKey: UserEntity.Name.rawValue)
        newUser.setValue(user.email, forKey: UserEntity.email.rawValue)
        newUser.setValue(user.password, forKey: UserEntity.password.rawValue)
        saveUser()
    }
}

typealias Completion = ((Bool) -> Void)

protocol UserModel1 {
    func addUser(user : User)
    func updateUser(user : User)
    func deleteUser(user : User)
    func deleteUser(id : String)
    func getListOfUsers() -> [User]
}
