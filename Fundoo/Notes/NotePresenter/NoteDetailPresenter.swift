//
//  NoteDetailPresenter.swift
//  Fundoo
//
//  Created by User on 09/10/19.
//  Copyright © 2019 BridgeLabz. All rights reserved.
//

import Foundation

protocol NoteDetailPresenter {
    func updateNote(noteInfo : NoteInfo)
    func createNote(noteInfo : NoteInfo)
    func deleteNote(noteInfo : NoteInfo)
}

@available(iOS 13.0, *)
class NoteDetailPresenterImpl: NoteDetailPresenter  {
    
    var noteModel : NoteModel!
    private var view : NoteDetailView
    
    init(view : NoteDetailView) {
        self.view = view
    }
    
    func createNote(noteInfo : NoteInfo){
        noteModel = NoteManager()
         noteModel.addNotes(note: noteInfo)
        
    }
    
    func updateNote(noteInfo: NoteInfo){
        noteModel = NoteManager()
        noteModel.updateNote( noteInfo: noteInfo)
    }
    
    func deleteNote(noteInfo : NoteInfo){
        noteModel = NoteManager()
        noteModel.delete(noteInfo: noteInfo)
    }
    
 
    
}
