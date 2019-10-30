//
//  NotesDetailViewController.swift
//  Fundoo
//
//  Created by User on 04/10/19.
//  Copyright © 2019 BridgeLabz. All rights reserved.
//
import UIKit
import CoreData
import UserNotifications

class NotesDetailViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UINavigationControllerDelegate, NoteDetailView {
    @IBOutlet weak var bottomContainerView: UIView!
    @IBOutlet var bottomMenuConstraint: NSLayoutConstraint!
    @IBOutlet var noteTitleField: UITextField!
    @IBOutlet var noteDescriptionField: UITextView!
    @IBOutlet var noteImpButton: UIBarButtonItem!
    @IBOutlet var archiveUnarchiveBtn: UIBarButtonItem!
    var noteColor : String?
    var value : Int!
    var noteDate : Date?
    var textViewPlaceHolder = "Note..."
    var note : NoteInfo?
    var noteImp : Bool = false {
        didSet{
            let image : UIImage!
            if noteImp {
                image = UIImage(named: "impNote.png")
            }
            else {
                image = UIImage(named: "outlineStarBorderBlack1.png")
            }
            noteImpButton.image = image
        }
    }
    var noteArchive : Bool = false {
        didSet {
            let image : UIImage!
            if noteArchive {
                image = UIImage(named: "unarchive.png")
            }
            else {
                image = UIImage(named: "archive.png")
            }
            archiveUnarchiveBtn.image = image
        }
    }
    
    var notePresenter : NoteDetailPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteDescriptionField.delegate = self
        notePresenter = NoteDetailPresenterImpl(view: self)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(changeColor),
                                               name: NSNotification.Name("ChangeColor"),
                                               object: nil)
        applyShadowOnView(bottomContainerView)
        initMode()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func fillDetailView(note : NoteInfo) {
        self.note = note
    }
    
    private func initMode() {
        if let note = note {
            initEditMode(note: note)
        }
        else {
            initCreateMode()
        }
    }
    
    private func initEditMode(note : NoteInfo) {
        noteTitleField.text = note.noteTitle
        noteDescriptionField.text = note.noteDescription
        noteColor = note.noteColor
        noteArchive = note.noteArchive
        noteImp = note.noteImp
        setColor(note.noteColor)
    }
    
    private func initCreateMode() {
        noteTitleField.text = ""
        noteDescriptionField.text = textViewPlaceHolder
        noteDescriptionField.textColor = .lightGray
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case "saveNoteSegue" where note != nil:
            note?.noteTitle = noteTitleField.text ??  ""
            note?.noteDescription = noteDescriptionField.text ?? ""
            note?.noteColor = noteColor ?? ""
            note?.noteReminder = noteDate
            notePresenter?.updateNote(noteInfo : note!)
            if noteDate != nil{
                scheduleNotification()
            }
            
        case "saveNoteSegue" where note == nil:
            if noteTitleField.text == "" || noteDescriptionField.text == "" {
                return
            }
            else {
                print("Color value = \(value ?? 0)")
                let noteDetails = NoteInfo.init(notePosition: (notePresenter?.getMaxPositon())! + 1, noteTitle: noteTitleField.text ?? "" , noteDescription: noteDescriptionField.text ?? "", noteColor: noteColor ?? "#FFFFFF", noteArchive: noteArchive , noteImp: noteImp, noteReminder: noteDate )
                notePresenter?.createNote(noteInfo: noteDetails)
                if noteDate != nil {
                    scheduleNotification()
                }
                
            }
            
        case "deleteNoteSegue" where note != nil:
            notePresenter?.deleteNote(noteInfo: note!)
            
        case "archiveNoteSegue" where note != nil:
            noteArchive = !noteArchive
            note?.noteArchive = noteArchive
            notePresenter?.updateNote(noteInfo: note!)
    
        case "setReminderSegue" :
            let reminderVC = segue.destination as? NotificationViewController
            reminderVC!.completionBlock = {[weak self] date in
            self?.noteDate = date
            }
            
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
    
    var bottomMenu = false
    
    @IBAction func onClickBottomMenu(_ sender: UIBarButtonItem) {
        if bottomMenu {
            bottomMenu = false
            bottomMenuConstraint.constant = 220
        }
        else {
            bottomMenu = true
            bottomMenuConstraint.constant = 0
            
        }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func scheduleNotification() {
        let notificationCenter = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = noteTitleField.text!
        content.body = noteDescriptionField.text!
        content.sound = UNNotificationSound.default
        content.badge = 1
        let dateComponent = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second,], from: noteDate!)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
    }
    
    @objc func changeColor(_ notification : NSNotification) {
        value = notification.userInfo?["value"] as? Int
        switch value {
        case 0:
            noteColor = "#FFFFFF"
            setColor(noteColor!)
        case 1:
            noteColor = "#EE8B82"
            setColor(noteColor!)
        case 2:
            noteColor = "#F7BC33"
            setColor(noteColor!)
        case 3:
            noteColor = "#FFF476"
            setColor(noteColor!)
        case 4:
            noteColor = "#CAF790"
            setColor(noteColor!)
        case 5:
            noteColor = "#A5FAEB"
            setColor(noteColor!)
        case 6:
            noteColor = "#CCF0F8"
            setColor(noteColor!)
        case 7:
            noteColor = "#AFCCFA"
            setColor(noteColor!)
        case 8:
            noteColor = "#D7AFFB"
            setColor(noteColor!)
        case 9:
            noteColor = "#F5CEE8"
            setColor(noteColor!)
        default:
            print("error")
        }
        
    }
    
    func setColor(_ hexColorString : String){
        let viewColor : UIColor = Helper.hexStringToUIColor(hexColorString)
        self.view.backgroundColor = viewColor
        noteTitleField.backgroundColor = viewColor
        noteDescriptionField.backgroundColor = viewColor
    }
    
    @IBAction func impNotes(_ sender: Any) {
        noteImp = !noteImp
        if note != nil {
            note?.noteImp = noteImp
            notePresenter?.updateNote(noteInfo: note!)
        }
        
    }
    
    func applyShadowOnView(_ view: UIView) {
            view.layer.shadowColor = UIColor.black.cgColor
            view.layer.shadowOffset = CGSize(width: 1.5, height: 3)
            view.layer.masksToBounds = false
            view.layer.shadowOpacity = 0.6
            view.layer.shadowRadius = 3
            view.layer.rasterizationScale = UIScreen.main.scale
            view.layer.shouldRasterize = true
        }
}


/**
 viewcontroller -> taking values from view

 presenter -> note <- 
 
 */
