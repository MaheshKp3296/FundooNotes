//
//  NoteModelProtocol.swift
//  Fundoo
//
//  Created by User on 14/11/19.
//  Copyright © 2019 BridgeLabz. All rights reserved.
//

import Foundation

protocol CoreDataNoteModel {
    func newNote() -> Note
    func saveNote()
    func delete(noteInfo: NoteInfo)
    func retrieveNotes() -> [Note]
    func addNotes(note: NoteInfo)
    func updateNote(noteInfo : NoteInfo)
    func getListOfNotes() -> [NoteInfo]
}

protocol  FirebaseNoteModel {
    func addNotes(note : NoteInfo)
    func updateNote(noteInfo: NoteInfo)
    func delete(noteInfo: NoteInfo)
    func readListOfNotes(completion : @escaping ([NoteInfo]?,Error?)-> Void)
}

protocol RESTNoteModel{
    func addNotes(note : NoteInfoApi)
    func updateNote(noteInfo: NoteInfoApi)
    func delete(noteInfo: NoteInfoApi)
    func readListOfNotes(completion : @escaping ([NoteInfoApi]?,Error?)-> Void)
   func getPostString(params:[String:Any]) -> String
    
}
