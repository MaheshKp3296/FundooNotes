//
//  NotesDetailViewController.swift
//  Fundoo
//
//  Created by User on 04/10/19.
//  Copyright © 2019 BridgeLabz. All rights reserved.
//
import UIKit
import CoreData

class NotesDetailViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UINavigationControllerDelegate {
    @IBOutlet var noteTitleField: UITextField!
    @IBOutlet var noteDescriptionField: UITextView!
    var textViewPlaceHolder = "Note..."
    var note : Note?
    override func viewDidLoad() {
        super.viewDidLoad()
        noteDescriptionField.delegate = self
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
            note?.noteTitle = noteTitleField.text ?? ""
            note?.noteDescription = noteDescriptionField.text ?? ""
            NoteCoreDataHelper.saveNote()
            
        case "save" where note == nil:
            if noteTitleField.text == "" || noteDescriptionField.text == "" {
                
            }
            else {
                let note = NoteCoreDataHelper.newNote()
                note.noteTitle = noteTitleField.text ?? ""
                note.noteDescription = noteDescriptionField.text ?? ""
                NoteCoreDataHelper.saveNote()
            }
        case "cancel":
            print("cancel bar button item tapped")
            
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
}

