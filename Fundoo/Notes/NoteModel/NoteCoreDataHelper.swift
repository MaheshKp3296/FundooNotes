//
//  CoreDataHelper.swift
//  Fundoo
//
//  Created by User on 05/10/19.
//  Copyright © 2019 BridgeLabz. All rights reserved.
//

import UIKit
import CoreData
protocol NoteModel {
    func newNote() -> Note
    func saveNote()
    func delete(note: NoteInfo)
    func retrieveNotes() -> [Note]
    func addNotes(note: NoteInfo)
    func updateNote(noteInfo : NoteInfo)
    func getListOfNotes() -> [NoteInfo]
}

class NoteManager: NoteModel {
    
    private let persistentContainer : NSPersistentContainer = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        
        return appDelegate.persistentContainer
    }()
    
    private lazy var context: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    func newNote() -> Note {
        let note = NSEntityDescription.insertNewObject(forEntityName: "Note", into: context) as! Note
        
        return note
    }
    
    func saveNote() {
        do {
            try context.save()
        } catch let error {
            print("Could not save \(error.localizedDescription)")
        }
    }
    
    func delete(note: NoteInfo) {
        // context.delete(note)
        
        saveNote()
    }
    
    func retrieveNotes() -> [Note] {
        //
        do {
            let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
            let results = try context.fetch(fetchRequest)
            //   listOfNotes = results as! [NoteInfo]
            return results
        } catch let error {
            print("Could not fetch \(error.localizedDescription)")
            
            return []
        }
    }
    
    func addNotes(note : NoteInfo) {
        let newNote = self.newNote()
        newNote.setValue(note.noteTitle, forKey: "noteTitle")
        newNote.setValue(note.noteDescription, forKey: "noteDescription")
        saveNote()
    }
    
    func updateNote(noteInfo: NoteInfo){
        print(noteInfo.noteId!)
        
        if let idUrl = URL.init(string: noteInfo.noteId!) {
            let objectModel =  persistentContainer.managedObjectModel
            let coordinator = NSPersistentStoreCoordinator(managedObjectModel: objectModel)
            let managedObjectID = coordinator.managedObjectID(forURIRepresentation: idUrl)
            if let note = getById(id: managedObjectID!) {
                note.noteTitle = noteInfo.noteTitle
                note.noteDescription = noteInfo.noteDescription
            }
            saveNote()
        }
    }
    
    func getListOfNotes() -> [NoteInfo] {
        var listOfNotes = [NoteInfo]()
        let results = retrieveNotes()
        
        for result in results {
            let noteTitle = result.noteTitle
            let noteDescription = result.noteDescription
            var noteDetails = NoteInfo.init(noteTitle: noteTitle!, noteDescription: noteDescription!)
            noteDetails.noteId = result.objectID.uriRepresentation().absoluteString
            listOfNotes.append(noteDetails)
        }
        print(listOfNotes)
        
        return listOfNotes
    }
    
    func getById(id: NSManagedObjectID) -> Note? {
        return context.object(with: id) as? Note
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
