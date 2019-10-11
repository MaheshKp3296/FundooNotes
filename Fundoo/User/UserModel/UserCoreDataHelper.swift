//
//  UserCoreDataHelper.swift
//  Fundoo
//
//  Created by User on 11/10/19.
//  Copyright © 2019 BridgeLabz. All rights reserved.
//

import UIKit
import CoreData

class UserCoreDataHelper {
    static let context: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        
        let persistentContainer = appDelegate.persistentContainer
        let context = persistentContainer.viewContext
        
        return context
    }()
    
    static func newUser() -> User {
        let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as! User
        
        return user
    }
    
    static func saveUser() {
        do {
            try context.save()
        } catch let error {
            print("Could not save \(error.localizedDescription)")
        }
    }
    
    static func delete(user: User) {
        context.delete(user)
        
        saveUser()
    }
    
    static func retrieveUsers() -> [User] {
        do {
            let fetchRequest = NSFetchRequest<User>(entityName: "User")
            let results = try context.fetch(fetchRequest)
            
            return results
        } catch let error {
            print("Could not fetch \(error.localizedDescription)")
            
            return []
        }
    }
    
    
}
