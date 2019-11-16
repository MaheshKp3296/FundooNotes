//
//  NoteInfo.swift
//  Fundoo
//
//  Created by User on 12/10/19.
//  Copyright © 2019 BridgeLabz. All rights reserved.
//

import Foundation

struct NoteInfo {
    var noteId : String?
    var notePosition : Int
    var noteTitle : String
    var noteDescription: String
    var noteColor: String
    var noteArchive: Bool
    var noteImp: Bool
    var noteReminder: Date?
    
    init(notePosition: Int, noteTitle : String, noteDescription : String, noteColor: String, noteArchive: Bool, noteImp: Bool, noteReminder : Date?) {
        self.notePosition = notePosition
        self.noteTitle = noteTitle
        self.noteDescription = noteDescription
        self.noteColor = noteColor
        self.noteArchive = noteArchive
        self.noteImp = noteImp
        self.noteReminder = noteReminder
    }
}

struct NoteInfoApi : Codable{

        var  title: String
        var  description: String
        var  isPined: Bool
        var  isArchived: Bool
        var  isDeleted: Bool?
        var  reminder: [String]?
        var  createdDate: String = "2019-11-08T10:22:48.725Z"
        var  modifiedDate: String = "2019-11-08T10:22:48.725Z"
        var  color: String
        var  label: [String]?
        var  imageUrl: String?
        var  linkUrl: String?
        var  collaborators: [String]?
        var  id: String?
        var  userId: String?
        var  collaberator: [String]?
        var  noteCheckLists: [String]?
        var  noteLabels: [String]?
        var  user : [UserDetails]?
        var  questionAndAnswerNotes: [String]?

    init(title : String, description: String, isPined: Bool, isArchived: Bool, color : String ){
        self.title = title
        self.description = description
        self.isPined = isPined
        self.isArchived = isArchived
        self.color = color
    }
}
