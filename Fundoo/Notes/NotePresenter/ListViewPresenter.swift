//
//  ListViewPresenter.swift
//  Fundoo
//
//  Created by User on 12/10/19.
//  Copyright © 2019 BridgeLabz. All rights reserved.
//

import Foundation
protocol ListViewPresenter {
    func initUI()
}

@available(iOS 13.0, *)
class ListViewPresenterImpl: ListViewPresenter {
    
    var model : NoteModel?
    var view : NoteView
    
    init(view : NoteView){
        self.view = view
    }
    
    
    func initUI() {
        model = NoteManager()
        let noteList = model?.getListOfNotes()
        view.getListOfNotes(listOfNotes: noteList!)
    }
    
}
