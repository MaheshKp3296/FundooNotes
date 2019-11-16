//
//  NoteDetailPresenter.swift
//  Fundoo
//
//  Created by User on 09/10/19.
//  Copyright © 2019 BridgeLabz. All rights reserved.
//

import Foundation

protocol NoteDetailPresenter {
    func updateNote(noteInfo : NoteInfoApi)
    func createNote(noteInfo : NoteInfoApi)
    func deleteNote(noteInfo : NoteInfoApi)
  //  func getMaxPositon()
    func archiveNote(noteinfo : NoteInfoApi)
}


class NoteDetailPresenterImpl: NoteDetailPresenter  {
    
    var noteModel : RESTNoteModel!
    private var view : NoteDetailView
    
    init(view : NoteDetailView) {
        self.view = view
    }
    
    func createNote(noteInfo : NoteInfoApi){
        noteModel = NoteNetworkManagar()
         noteModel.addNotes(note: noteInfo)
    }
    
    func updateNote(noteInfo: NoteInfoApi){
        noteModel = NoteNetworkManagar()
        noteModel.updateNote( noteInfo: noteInfo)
    }
    
    func deleteNote(noteInfo : NoteInfoApi){
        noteModel = NoteNetworkManagar()
        noteModel.delete(noteInfo: noteInfo)
    }
    
//    func getMaxPositon() {
//        noteModel = FireBaseNoteManager()
//        noteModel.readListOfNotes { (noteList, error) in
//            for note in noteList!{
//              var max = 0
//                if note.position > max{
//                    max = Int(note.position)
//                }
//                self.view.getMaxPosition(notePosition: max)
//            }
//
//        }
//    }
    
    func archiveNote(noteinfo : NoteInfoApi){
        noteModel = NoteNetworkManagar()
        noteModel.updateNote(noteInfo: noteinfo)
        
    }
 
    
}
