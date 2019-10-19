//
//  ListCollectionViewController.swift
//  Fundoo
//
//  Created by User on 09/10/19.
//  Copyright © 2019 BridgeLabz. All rights reserved.
//

import UIKit
import CoreData
private let reuseIdentifier = "Cell"

@available(iOS 13.0, *)
class ListCollectionViewController: UICollectionViewController, NoteView {
    
    fileprivate func isLoggedIn() -> Bool{
        return UserDefaults.standard.bool(forKey: "isLoggedIn")
    }
    
    @IBOutlet var gridListView: UISegmentedControl!
    
    var listOfNotes = [NoteInfo]()
    {
        didSet {
            collectionView.reloadData()
            
        }
    }
    var isSearching = false {
        didSet{
            collectionView.reloadData()
        }
        
    }
    
    var currentListOfNotes = [NoteInfo]()
    var noteListPresenter : ListViewPresenter?
    var strTemp = "grid"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        createSearchBar()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        noteListPresenter = ListViewPresenterImpl(view: self)
        noteListPresenter?.initUI()
        currentListOfNotes = listOfNotes
    }
    
    func getListOfNotes(listOfNotes: [NoteInfo]) {
        self.listOfNotes = listOfNotes
        
    }
    
    
    @IBAction func gridListBtn(_ sender: Any) {
        switch gridListView.selectedSegmentIndex {
        case 0 : strTemp = "grid"
        collectionView.reloadData()
            
        case 1 : strTemp = "list"
        collectionView.reloadData()
            
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
        
        if isSearching == true{
            return currentListOfNotes.count
        }
        else{
            return listOfNotes.count
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "noteCell", for: indexPath) as! NoteCollectionViewCell
        var note : NoteInfo!
        // let note : NoteInfo = listOfNotes[indexPath.item]
        if isSearching == true {
            note = currentListOfNotes[indexPath.row]
        }
        else {
            note = listOfNotes[indexPath.row]
        }
        
        cell.configureCell(note : note)
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 4
        return cell
    }
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        // notes = NoteManager.retrieveNotes()
        //  notes = (noteListPresenter?.retrieveNotes())!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case "displayNote":
            print("note cell tapped")
            guard let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }
            var note : NoteInfo!
            if isSearching == true {
                note = currentListOfNotes[indexPath.item]
            }
            else {
                note = listOfNotes[indexPath.item]
            }
            
            let destination = segue.destination as! NotesDetailViewController
            destination.note = note
            
        case "addNote":
            print("create note bar button item tapped")
            
        default:
            print("unexpected segue identifier")
        }
    }
    
    func collectionView(collectionView: UICollectionView, canMoveItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let temp = listOfNotes.remove(at: sourceIndexPath.item)
        listOfNotes.insert(temp, at: destinationIndexPath.item)
        
    }
}


@available(iOS 13.0, *)
extension ListCollectionViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath ) -> CGSize {
        
        if strTemp == "grid"
        {
            return CGSize(width: self.view.frame.width/2-5, height: self.view.frame.width/2-5)
        }
        else {
            return CGSize(width: self.view.frame.width, height: self.view.frame.width/2-5)
        }
        
    }
}


@available(iOS 13.0, *)
extension ListCollectionViewController : UISearchBarDelegate {
    
    func createSearchBar() {
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = false
        searchBar.placeholder = "Search Notes.."
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            currentListOfNotes = listOfNotes
            collectionView.reloadData()
            return
        }
        
        currentListOfNotes = listOfNotes.filter({NoteInfo -> Bool in guard let text = searchBar.text?.lowercased() else
            { return false }
            return NoteInfo.noteTitle.lowercased().contains(text) || NoteInfo.noteDescription.lowercased().contains(text)
        })
        
        if currentListOfNotes.count == 0 {
            isSearching = false
        }
        else {
            isSearching = true
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
    }
}
