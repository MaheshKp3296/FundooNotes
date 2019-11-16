//
//  NoteViewProtocol.swift
//  Fundoo
//
//  Created by User on 12/10/19.
//  Copyright © 2019 BridgeLabz. All rights reserved.
//

import Foundation

protocol NoteView {
    func getListOfArchivedNotes(listOfNotes: [NoteInfoApi])
    func getOriginalListOfNotes(listOfNotes: [NoteInfoApi])
    func getListOfImpNotes(listOfNotes: [NoteInfoApi])
    func getListOfReminderNotes(listOfNotes: [NoteInfoApi])
}
