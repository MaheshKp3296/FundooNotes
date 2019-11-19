//
//  NoteInfo.swift
//  Fundoo
//
//  Created by User on 12/10/19.
//  Copyright © 2019 BridgeLabz. All rights reserved.
//

import Foundation

struct NoteApi: Codable {
    let data : NoteListResponseDetails
}

struct NoteListResponseDetails : Codable {
    var success : Bool
    var message : String
    var data : [NoteInfoApi]?
}


struct NoteInfoApi : Codable {
        
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
        var  questionAndAnswerNotes: [String]?
        var  user : UserNoteInfo?
        var asDictionary : [String:Any] {
          let mirror = Mirror(reflecting: self)
          let dict = Dictionary(uniqueKeysWithValues: mirror.children.lazy.map({ (label:String?,value:Any) -> (String,Any)? in
            guard label != nil else { return nil }
            return (label!,value)
          }).compactMap{ $0 })
          return dict
        }
      

    init(title : String, description: String, isPined: Bool, isArchived: Bool, color : String ){
        self.title = title
        self.description = description
        self.isPined = isPined
        self.isArchived = isArchived
        self.color = color
    }
}

struct UserNoteInfo : Codable{
    var firstName : String?
    var lastName : String?
    var role : String?
    var service : String?
    var createdDate : String?
    var modifiedDate : String?
    var address : String?
    var username : String?
    var email : String?
    var emailVerified : Bool?
    var id : String?

}








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
