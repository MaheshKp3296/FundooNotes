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
