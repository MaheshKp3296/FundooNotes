//
//  CoreDataHelper.swift
//  Fundoo
//
//  Created by User on 05/10/19.
//  Copyright © 2019 BridgeLabz. All rights reserved.
//

import UIKit
import CoreData

struct CoreDataHelper {
    static let context: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        
        let persistentContainer = appDelegate.persistentContainer
        let context = persistentContainer.viewContext
        
        return context
    }()

    static func newNote() -> Note {
        let note = NSEntityDescription.insertNewObject(forEntityName: "Note", into: context) as! Note
        
        return note
    }
    
    static func saveNote() {
        do {
            try context.save()
        } catch let error {
            print("Could not save \(error.localizedDescription)")
        }
    }
    
    static func delete(note: Note) {
        context.delete(note)
        
        saveNote()
    }
    
    static func retrieveNotes() -> [Note] {
        do {
            let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
            let results = try context.fetch(fetchRequest)
            
            return results
        } catch let error {
            print("Could not fetch \(error.localizedDescription)")
            
            return []
        }
    }
    

}


/*
 
 MVVM
 
 Model
 
 
 Presenter
 
 
 View
 ====================================
 
 
 view - 1 presenter   <=======     UI Logic

 presenter - 1 view , 1 model  <========= Unit Testing   ---- Business Logic

 model - no reference  <========= Unit Testing   ------- Data Logic
 
 
 Unit Testing
 
 LogInTest {
 
 func whenUserCreated_Then_UserShouldExit() {
     model.signUp(Data)
     model.checkIfUserExits(Data)
 }
 
 
 }
 
View - viewmodel  --> on Data Change
 
ViewModel --> model   ----> exposes data to View through observable data
 
model --> alone
 
 
 Model :
 -------
 
 same Model -> Observable(Data)
 
  logIn from Server ---- www.facebook.com
 
 
 Response(
 Data,
 Status,
 Error
 )
 
 LOADING,   ----> ProgressBar
 SUCCESS,  ----> LogIn Screen
 FAILURE  ----> Failure Screen
 
 
 model -> FacebookAuthManager    ----> logIn(userName , password) -> {Data logic} Observable<Response>   -> LOADING
 
 viewModel -> LogInViewModel   -> model -----> logInWithUsername(userName, password)  -> {Business Logic}  fbManager.logIn(userName, password)

 view -> LogInViewController : LogInView  -> ViewModel  ---->
 
 @IBOutlet func onLogInBtnPressed(_ sender: Any?) {
 viewModel.logInWithUserName(userTextField.text, passwdTextField.text).onDataChange( [weak self] Response ->
 if Response.status == .LOADING  {
    showProgressBar()
 } else if Response.status == .SUCCESS {
    showSuccessMessage()
 } else if Response.status == .FAILURE {
   showErrorMessage()
 }
 
 )
 
 }
 
 */
