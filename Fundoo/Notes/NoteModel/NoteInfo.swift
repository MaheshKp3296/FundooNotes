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
    var noteTitle : String
    var noteDescription: String
    
    init(noteTitle : String, noteDescription : String) {
        self.noteTitle = noteTitle
        self.noteDescription = noteDescription
    }
}
