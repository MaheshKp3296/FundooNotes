//
//  ListCollectionViewController.swift
//  Fundoo
//
//  Created by User on 09/10/19.
//  Copyright © 2019 BridgeLabz. All rights reserved.
//

import UIKit
import CoreData
import FirebaseAuth
import Firebase
//private let reuseIdentifier = "Cell"


class NoteListCollectionViewController: UICollectionViewController, NoteView {
    
    var noteListToDisplay = [NoteInfoApi]()
    {
        didSet {
            collectionView.reloadData()
        }
    }
    var searchedListOfNotes = [NoteInfoApi]()

    fileprivate func isLoggedIn() -> Bool{
        return UserDefaults.standard.bool(forKey: "isLoggedIn")
    }
    
    @IBOutlet var displayView: UISegmentedControl!
    
    var searchActive = false {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var noteListPresenter : NoteListViewPresenter?
    var displayType = CollectionViewDisplay.Grid {
        didSet{
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       //  print(Auth.auth().currentUser?.email as Any)
       // FirebaseApp.configure()
        createSearchBar()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(sideMenuViews),
                                               name: NSNotification.Name("SideMenuView"),
                                               object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        noteListPresenter = NoteListViewPresenterImpl(view: self)
        noteListPresenter?.getOriginalListOfNotes()
        searchedListOfNotes = noteListToDisplay
        
    }

    func getListOfArchivedNotes(listOfNotes: [NoteInfoApi]) {
           self.noteListToDisplay = listOfNotes
       }
    
    func getOriginalListOfNotes(listOfNotes: [NoteInfoApi]) {
          self.noteListToDisplay = listOfNotes
    }
    
    func getListOfImpNotes(listOfNotes: [NoteInfoApi]) {
        self.noteListToDisplay = listOfNotes
    }
    
    func getListOfReminderNotes(listOfNotes: [NoteInfoApi]) {
        self.noteListToDisplay = listOfNotes
    }
    
       
    
    @IBAction func gridListBtn(_ sender: Any) {
        switch displayView.selectedSegmentIndex {
        case 0 : displayType = .Grid
            
        case 1 : displayType = .List
            
        default:
            break
        }
    }
    
    @IBAction func openMenu() {
        print("Toggle Side Menu")
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if searchActive == true {
            return searchedListOfNotes.count
        }
        else {
            return noteListToDisplay.count
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "noteCell", for: indexPath) as! NoteCollectionViewCell
        var note : NoteInfoApi!
        if searchActive == true {
            note = searchedListOfNotes[indexPath.row]
        }
        else {
            note = noteListToDisplay[indexPath.row]
        }
        
        cell.configureCell(note : note)
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 10
        return cell
    }
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case "displayNoteSegue":
            print("note cell tapped")
            guard let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }
            var note : NoteInfoApi!
            if searchActive == true {
                note = searchedListOfNotes[indexPath.item]
            }
            else {
                note = noteListToDisplay[indexPath.item]
            }
            
            let destination = segue.destination as! NotesDetailViewController
            destination.note = note
            
        case "addNoteSegue":
            print("create note bar button item tapped")
            
        default:
            print("unexpected segue identifier")
        }
    }
    
    func collectionView(collectionView: UICollectionView, canMoveItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let temp = noteListToDisplay.remove(at: sourceIndexPath.item)
        noteListToDisplay.insert(temp, at: destinationIndexPath.item)
      //  noteListPresenter?.moveNotes(sourceIndexPath.item + 1,destinationIndexPath.item + 1)
    }
    
    @objc func sideMenuViews(_ notification: NSNotification){
        let value = notification.userInfo?["value"] as? Int
        switch value {
        case 1:
            noteListPresenter?.getOriginalListOfNotes()
            
        case 2:
            noteListPresenter?.getReminderNotes()
            
        case 3:
            noteListPresenter?.getImpNotes()
            
        case 4:
            noteListPresenter?.getArchivedNotes()
            
        default:
            print("error")
        }
    }
    
}


extension NoteListCollectionViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath ) -> CGSize {
        
        if displayType == .Grid
        {
            return CGSize(width: (self.view.frame.width)/2 - 5, height: (self.view.frame.width)/2 - 5)
        }
        else {
            return CGSize(width: self.view.frame.width, height: (self.view.frame.width)/2 - 5)
        }
        
    }
}

extension NoteListCollectionViewController : UISearchBarDelegate {
    
    func createSearchBar() {
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = false
        searchBar.placeholder = "Search Notes.."
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            searchedListOfNotes = noteListToDisplay
            collectionView.reloadData()
            return
        }
        
        searchedListOfNotes = noteListToDisplay.filter({NoteInfo -> Bool in guard let text = searchBar.text?.lowercased() else
        { return false }
            return NoteInfo.title.lowercased().contains(text) || NoteInfo.description.lowercased().contains(text)
        })
        
        if searchedListOfNotes.count == 0 {
            searchActive = false
        }
        else {
            searchActive = true
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        searchBar.text = ""
    }
    
    enum CollectionViewDisplay : String {
        case Grid = "Grid"
        case List = "List"
    }
    
}
