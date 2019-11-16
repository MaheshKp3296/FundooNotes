//
//  ListViewPresenter.swift
//  Fundoo
//
//  Created by User on 12/10/19.
//  Copyright © 2019 BridgeLabz. All rights reserved.
//

import Foundation
protocol NoteListViewPresenter {
    func getOriginalListOfNotes()
    func getImpNotes()
    func getArchivedNotes()
    func getReminderNotes()
    //  func moveNotes(_ sourcePosition: Int, _ destinationPosition: Int)
    
}

class NoteListViewPresenterImpl: NoteListViewPresenter {
    let tag = "NoteListViewPresenter"
    var noteListModel : RESTNoteModel!
    var view : NoteView
    
    init(view : NoteView){
        self.view = view
    }
    
   func getOriginalListOfNotes() {
       noteListModel = NoteNetworkManagar()
        var noteList = [NoteInfoApi]()
//        noteListModel.readListOfNotes { (listOfNotes, err) in
//            for list in listOfNotes!{
//                if list.noteArchive == false && list.noteImp == false {
//                    noteList.append(list)
//                }
//            }
//            AppUtil.showLog(tag: self.tag, message: "\(noteList)")
//            self.view.getOriginalListOfNotes(listOfNotes: noteList)
//        }
    }
    
    func getArchivedNotes() {
        var noteList = [NoteInfoApi]()
//        noteListModel = FireBaseNoteManager()
//        noteListModel.readListOfNotes { (listOfNotes, err) in
//            for list in listOfNotes!{
//                if list.noteArchive == true {
//                    noteList.append(list)
//                }
//            }
//            AppUtil.showLog(tag: self.tag, message: "\(noteList)")
//            self.view.getListOfArchivedNotes(listOfNotes: noteList)
//        }
    }
    
    func getImpNotes() {
        var noteList = [NoteInfoApi]()
//        noteListModel = FireBaseNoteManager()
//        noteListModel.readListOfNotes { (listOfNotes, err) in
//            for list in listOfNotes!{
//                if list.noteImp == true {
//                    noteList.append(list)
//                }
//            }
//            AppUtil.showLog(tag: self.tag, message: "\(noteList)")
//            self.view.getListOfImpNotes(listOfNotes: noteList)
//        }
    }
    
    func getReminderNotes(){
        var noteList = [NoteInfo]()
//        noteListModel = FireBaseNoteManager()
//        noteListModel.readListOfNotes { (listOfNotes, err) in
//            for list in listOfNotes!{
//                if list.noteReminder != nil {
//                    noteList.append(list)
//                }
//            }
//            AppUtil.showLog(tag: self.tag, message: "\(noteList)")
//            self.view.getListOfReminderNotes(listOfNotes: noteList)
//
//        }
    }
    
    //    func moveNotes(_ sourcePosition: Int, _ destinationPosition: Int) {
       //        print(sourcePosition)
       //        noteListModel = FireBaseNoteManager()
       //        var destination = destinationPosition
       //        var source = sourcePosition
       //        var noteLists = noteListModel.getListOfNotes()
       //        noteLists.sort{$0.notePosition < $1.notePosition}
       //        if source > destination {
       //
       //            noteLists[source-1].notePosition = noteLists[destination-1].notePosition
       //            noteListModel.updateNote(noteInfo: noteLists[source-1])
       //            while destination <= source-1 {
       //                noteLists[destination-1].notePosition = destination + 1
       //                noteListModel.updateNote(noteInfo: noteLists[destination-1])
       //                destination = destination + 1
       //            }
       //
       //        }
       //        else {
       //            noteLists[source-1].notePosition = noteLists[destination-1].notePosition
       //            noteListModel.updateNote(noteInfo: noteLists[source-1])
       //            while source <= destination-1 {
       //                noteLists[source].notePosition = source - 1
       //                noteListModel.updateNote(noteInfo: noteLists[source])
       //                source = source + 1
       //            }
       //        }
       //    }
       
}
