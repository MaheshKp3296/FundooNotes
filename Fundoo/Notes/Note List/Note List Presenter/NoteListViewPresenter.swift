//
//  ListViewPresenter.swift
//  Fundoo
//
//  Created by User on 12/10/19.
//  Copyright © 2019 BridgeLabz. All rights reserved.
//

import Foundation
protocol NoteListViewPresenter {
    func initUI()
    func moveNotes(_ sourcePosition: Int, _ destinationPosition: Int)
    func getImpNotes() -> [NoteInfo]
    func getArchivedNotes() -> [NoteInfo]
    func getRemindedNotes() -> [NoteInfo]
}

//@available(iOS 13.0, *)
class NoteListViewPresenterImpl: NoteListViewPresenter {
    
    var noteListModel : NoteModel!
    var view : NoteView
    
    init(view : NoteView){
        self.view = view
    }
    
    func moveNotes(_ sourcePosition: Int, _ destinationPosition: Int) {
        print(sourcePosition)
        noteListModel = NoteManager()
        var destination = destinationPosition
        var source = sourcePosition
        var noteLists = noteListModel.getListOfNotes()
        noteLists.sort{$0.notePosition < $1.notePosition}
        if source > destination {
            
            noteLists[source-1].notePosition = noteLists[destination-1].notePosition
            noteListModel.updateNote(noteInfo: noteLists[source-1])
            while destination <= source-1 {
                noteLists[destination-1].notePosition = destination + 1
                noteListModel.updateNote(noteInfo: noteLists[destination-1])
                destination = destination + 1
            }
            initUI()
        }
        else {
            noteLists[source-1].notePosition = noteLists[destination-1].notePosition
            noteListModel.updateNote(noteInfo: noteLists[source-1])
            while source <= destination-1 {
                noteLists[source].notePosition = source - 1
                noteListModel.updateNote(noteInfo: noteLists[source])
                source = source + 1
            }
            initUI()
            
            }
    }
    
    func getArchivedNotes() -> [NoteInfo]{
        var listOfNotes = [NoteInfo]()
        noteListModel = NoteManager()
        let noteList = noteListModel.getListOfNotes()
        for notes in noteList{
            if notes.noteArchive == true{
                listOfNotes.append(notes)
            }
        }
        return listOfNotes
    }
    
    func getImpNotes() -> [NoteInfo]{
        var listOfNotes = [NoteInfo]()
        noteListModel = NoteManager()
        let noteList = noteListModel.getListOfNotes()
        for notes in noteList{
            if notes.noteImp == true {
                listOfNotes.append(notes)
            }
        }
        return listOfNotes
    }
    
    func initUI() {
        noteListModel = NoteManager()
        var noteList = [NoteInfo]()
        let noteLists = noteListModel.getListOfNotes()
        for list in noteLists{
            if list.noteArchive == false && list.noteImp == false{
                noteList.append(list)
            }
        }
        view.getListOfNotes(listOfNotes: noteList)
    }
    
    func getRemindedNotes() -> [NoteInfo]{
        var listOfNotes = [NoteInfo]()
        noteListModel = NoteManager()
        let noteList = noteListModel.getListOfNotes()
        for notes in noteList{
            if notes.noteReminder != nil {
                listOfNotes.append(notes)
            }
        }
        return listOfNotes
    }
}
