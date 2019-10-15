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

class ListCollectionViewController: UICollectionViewController, NoteView {
     
    
 
    @IBAction func openMenu() {
        print("Toggle Side Menu")
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
    }
    
    var notes = [NoteInfo]()
    {
        didSet {
            collectionView.reloadData()
            
        }
    }
    
     var noteListPresenter : ListViewPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        //notes = NoteCoreDataHelper.retrieveNotes()
        //collectionView.reloadData()
    //   noteListPresenter = ListViewPresenterImpl(view: self)
      //  noteListPresenter?.initUI()
    }
    
    func getListOfNotes(listOfNotes: [NoteInfo]) {
        self.notes = listOfNotes
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        noteListPresenter = ListViewPresenterImpl(view: self)
        noteListPresenter?.initUI()
   }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "noteCell", for: indexPath) as! NoteCollectionViewCell
        let note : NoteInfo = notes[indexPath.item]
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
            let note = notes[indexPath.item]
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
        let temp = notes.remove(at: sourceIndexPath.item)
        notes.insert(temp, at: destinationIndexPath.item)
    
        }
    }

