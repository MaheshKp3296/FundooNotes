//
//  FirebaseNoteDataHelper.swift
//  Fundoo
//
//  Created by User on 14/11/19.
//  Copyright © 2019 BridgeLabz. All rights reserved.
//

import Foundation
import Firebase

class FireBaseNoteManager : FirebaseNoteModel {
    
    let fireStoreDatabase = Firestore.firestore()
    
    func addNotes(note : NoteInfo) {
        let noteDocument = ["noteTitle":note.noteTitle,
                            "noteDescription":note.noteDescription,
                            "notePosition":note.notePosition,
                            "noteColor":note.noteColor,
                            "noteArchive":note.noteArchive,
                            "noteImp":note.noteImp,
                            "noteReminder":note.noteReminder as Any]
            as [String : Any]
        
        fireStoreDatabase.collection("Note").addDocument(data: noteDocument)
    }
    
    typealias ResponseData = [NoteInfo]
    typealias ResponseError = Error
    
    func readListOfNotes(completion : @escaping (ResponseData?,ResponseError?)-> Void) {
        var listOfNotes = [NoteInfo]()
        
        fireStoreDatabase.collection("Note").addSnapshotListener { (result, err) in
            if err != nil {
                completion(nil,err)
                print("error fetching data")
            }
            else
            {
                for document in result!.documents {
                    guard let noteTitle = document.data()["noteTitle"] as? String else {
                        print("noteTitle is emp")
                        return
                    }
                    guard  let noteDescription = document.data()["noteDescription"] as? String else {
                        return
                    }
                    guard let notePosition = document.data()["notePosition"] as? Int else {
                        return
                    }
                    guard let noteColor = document.data()["noteColor"] as? String else {
                        return
                    }
                    guard let noteArchive = document.data()["noteArchive"] as? Bool else {
                        return
                    }
                    guard let noteImp = document.data()["noteImp"] as? Bool else {
                        return
                    }
                    let noteReminder = document.data()["noteReminder"] as? Timestamp
                    
                    var NoteDetails = NoteInfo.init(notePosition: notePosition, noteTitle: noteTitle, noteDescription: noteDescription, noteColor: noteColor, noteArchive: noteArchive, noteImp: noteImp, noteReminder: noteReminder?.dateValue())
                    NoteDetails.noteId = document.documentID
                    listOfNotes.append(NoteDetails)
                }
                completion(listOfNotes,nil)
            }
        }
    }
    
    func updateNote(noteInfo: NoteInfo) {
        let noteDocument = ["noteTitle":noteInfo.noteTitle,
                            "noteDescription":noteInfo.noteDescription,
                            "notePosition":noteInfo.notePosition,
                            "noteColor":noteInfo.noteColor,
                            "noteArchive":noteInfo.noteArchive,
                            "noteImp":noteInfo.noteImp,
                            "noteReminder":noteInfo.noteReminder as Any]
            as [String : Any]
        
        fireStoreDatabase.collection("Note").getDocuments { (result, error) in
            if error != nil{
                print("error fetching data")
            }
            else
            {
                for document in result!.documents{
                    if document.documentID == noteInfo.noteId {
                        self.fireStoreDatabase.collection("Note").document(document.documentID).updateData(noteDocument)
                    }
                }
            }
        }
    }
    
    func delete(noteInfo: NoteInfo){
        fireStoreDatabase.collection("Note").getDocuments { (result, error) in
            if error != nil {
                print("error fetching data")
            }
            else
            {
                for document in result!.documents{
                    if document.documentID == noteInfo.noteId {
                        self.fireStoreDatabase.collection("Note").document(document.documentID).delete()
                    }
                    
                }
            }
        }
    }
}
