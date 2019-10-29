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
               image = UIImage(named: "outline_star_border_black_24dp.png")
            }
            noteImpButton.image = image
        }
    }
    var noteArchive : Bool!{
        didSet{
            archiveUnarchiveBtn.title = ""
            archiveUnarchiveBtn.image = nil
            
            if noteArchive {
                archiveUnarchiveBtn!.setBackgroundImage(UIImage(named: "unarchive.png"), for: .normal, barMetrics: .default)
            }
            else {
                archiveUnarchiveBtn!.setBackgroundImage(UIImage(named: "archive.png"), for: .normal, barMetrics: .default)
                
            }
        }
    }
    var notePresenter : NoteDetailPresenter?
    
    func fillDetailView(note : NoteInfo) {
        self.note = note
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteDescriptionField.delegate = self
        notePresenter = NoteDetailPresenterImpl(view: self)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(changeColor),
                                               name: NSNotification.Name("ChangeColor"),
                                               object: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initMode()
    }
    
    private func initMode(){
        if let note = note {
            initEditMode(note: note)
        }
        else {
            initCreateMode()
        }
    }
    
    private func initEditMode(note : NoteInfo){
        noteTitleField.text = note.noteTitle
        noteDescriptionField.text = note.noteDescription
        noteColor = note.noteColor
        noteArchive = note.noteArchive
        noteImp = note.noteImp
       // noteDate = note.noteReminder
        setColor(note.noteColor)
        
        
    }
    private func initCreateMode(){
        noteTitleField.text = ""
        noteDescriptionField.text = textViewPlaceHolder
        noteDescriptionField.textColor = .lightGray
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch value {
        case 0:
            noteColor = "#666666"
        case 1:
            noteColor = "#FFFFFF"
        case 2:
            noteColor = "#99CC66"
        case 3:
            noteColor = "#FFFF00"
        case 4:
            noteColor = "#6699FF"
        case 5:
            noteColor = "#FF66CC"
            
        default:
            print("error")
        }
        
        
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case "save" where note != nil:
            note?.noteTitle = noteTitleField.text ??  ""
            note?.noteDescription = noteDescriptionField.text ?? ""
            note?.noteColor = noteColor ?? ""
            note?.noteReminder = noteDate
          //  print("note is archived \(String(describing: note?.noteArchive))")
            notePresenter?.updateNote(noteInfo : note!)
           if noteDate != nil{
             scheduleNotification()
            }


            
        case "save" where note == nil:
            if noteTitleField.text == "" || noteDescriptionField.text == "" {
                return
            }
            else {
                
                print("Color value = \(value ?? 0)")
                let noteDetails = NoteInfo.init(notePosition: (notePresenter?.getMaxPositon())! + 1, noteTitle: noteTitleField.text ?? "" , noteDescription: noteDescriptionField.text ?? "", noteColor: noteColor ?? "#FFFFFF", noteArchive: noteArchive ?? false, noteImp: noteImp, noteReminder: noteDate )
                notePresenter?.createNote(noteInfo: noteDetails)
               if noteDate != nil{
                  scheduleNotification()
            }
                
            }
            
        case "delete" where note != nil:
            notePresenter?.deleteNote(noteInfo: note!)
            
        case "archive" where note != nil:
            noteArchive = note?.noteArchive
            if !noteArchive{
                note?.noteArchive = true
                notePresenter?.archiveNote(noteinfo: note!)
            }
            else {
                note?.noteArchive = false
                notePresenter?.archiveNote(noteinfo: note!)
            }
//        
        case "NoteToReminderSegue" :
            let reminderVC = segue.destination as? NotificationViewController
            reminderVC!.completionBlock = {[weak self] date in
                print(date)
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
        switch value!{
        case 0 : setColor("#666666")
            
        case 1 : setColor("#FFFFFF")
            
        case 2 : setColor("#99CC66")
            
        case 3 : setColor("#FFFF00")
            
        case 4 : setColor("#6699FF")
            
        case 5 : setColor("#FF66CC")
            
        default:
            print("error")
        }
        
    }
    
    func setColor(_ hexColorString : String){
        let viewColor = UIColor(hex: hexColorString)
        self.view.backgroundColor = viewColor
        noteTitleField.backgroundColor = viewColor
        noteDescriptionField.backgroundColor = viewColor
        
    }
    
    @IBAction func impNotes(_ sender: Any) {
        // MARK: create note problem
//        noteImp = note?.noteImp ??
        
       
//        if !noteImp {
//            note?.noteImp = true
//            notePresenter?.updateNote(noteInfo: note!)
//        }
//        else{
//            note?.noteImp = false
//            notePresenter?.updateNote(noteInfo: note!)
//        }
        noteImp = !noteImp
        
        if note != nil {
        note?.noteImp = noteImp
        notePresenter?.updateNote(noteInfo: note!)
        }
        
    }
    
    
    
}

























extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xFF0000) >> 16) / 255.0
                    g = CGFloat((hexNumber & 0x00FF00) >> 8)  / 255.0
                    b = CGFloat(hexNumber & 0x0000FF) / 255.0
                    a = 1.0
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
    
    
    
    
    
    
}











//666666
//FFFFFF
//99CC66
//FFFF00
//6699FF
//FF66CC
//red   = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
//green = CGFloat((hexValue & 0x00FF00) >> 8)  / 255.0
//blue  = CGFloat(hexValue & 0x0000FF) / 255.0
