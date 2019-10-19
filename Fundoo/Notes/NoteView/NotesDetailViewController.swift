//
//  NotesDetailViewController.swift
//  Fundoo
//
//  Created by User on 04/10/19.
//  Copyright © 2019 BridgeLabz. All rights reserved.
//
import UIKit
import CoreData

@available(iOS 13.0, *)
class NotesDetailViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UINavigationControllerDelegate, NoteDetailView {
    @IBOutlet var noteTitleField: UITextField!
    @IBOutlet var noteDescriptionField: UITextView!
     @IBOutlet weak var colorMenuConstraint : NSLayoutConstraint!
    
    var textViewPlaceHolder = "Note..."
    var note : NoteInfo?
    
   var notePresenter : NoteDetailPresenter?
    override func viewDidLoad() {
        super.viewDidLoad()
        noteDescriptionField.delegate = self
        notePresenter = NoteDetailPresenterImpl(view: self)
    }
    
    func fillDetailView(note : Note) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let note = note {
            noteTitleField.text = note.noteTitle
            noteDescriptionField.text = note.noteDescription
        }
        else {
            noteTitleField.text = ""
            noteDescriptionField.text = textViewPlaceHolder
            noteDescriptionField.textColor = .lightGray
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case "save" where note != nil:
           note?.noteTitle = noteTitleField.text ??  ""
           note?.noteDescription = noteDescriptionField.text ?? ""
           notePresenter?.updateNote(noteInfo : note!)
           // NoteCoreDataHelper.saveNote()
            
        case "save" where note == nil:
            if noteTitleField.text == "" || noteDescriptionField.text == "" {
                return
            }
            else {
            let noteDetails = NoteInfo.init(noteTitle: noteTitleField.text ?? "" , noteDescription: noteDescriptionField.text ?? "" )
            notePresenter?.createNote(noteInfo: noteDetails)
            
            }
            
        case "delete" where note != nil:
            notePresenter?.deleteNote(noteInfo: note!)
            
        default:
            print("unexpected segue identifier")
        }
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        textView.textColor = .black
        if(textView.text == textViewPlaceHolder) {
            textView.text = ""
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if(textView.text == "") {
            textView.text = textViewPlaceHolder
            textView.textColor = .lightGray
        }
    }
    
//    var isBottomMenuOpen : Bool! {
//        didSet {
//            if isBottomMenuOpen {
//                colorMenuConstraint.constant = 0
//            } else {
//                colorMenuConstraint.constant = 256
//                
//            }
//            UIView.animate(withDuration: 0.3) {
//                self.view.layoutIfNeeded()
//            }
//        }
//    }
//    
//    @objc func toggleBottomMenu() {
//        isBottomMenuOpen = !isBottomMenuOpen
//    }
//    
//    @IBAction func colorMenu(_ sender: UIBarButtonItem) {
//        NotificationCenter.default.post(name: NSNotification.Name("ToggleBottomMenu"), object: nil)
//    }
    
}

