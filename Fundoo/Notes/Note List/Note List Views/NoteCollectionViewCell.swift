//
//  NoteCollectionViewCell.swift
//  Fundoo
//
//  Created by User on 09/10/19.
//  Copyright © 2019 BridgeLabz. All rights reserved.
//

import UIKit

class NoteCollectionViewCell: UICollectionViewCell {
    
//    override var reuseIdentifier: String? = "noteCell"
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var decriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel?
    
    func configureCell(note : NoteInfo) {
        self.backgroundColor = UIColor(hex: note.noteColor)
        self.titleLabel.text = note.noteTitle
//       let formatter = DateFormatter()
//       formatter.dateFormat = "yyyy-MM-dd hh:mm:ss +zzz"
//
//        self.dateLabel?.text = formatter.string(from: note.noteReminder)
        self.decriptionLabel.text = note.noteDescription
    }
    
    func convertDateIntoString(dateString : Date) -> String {

        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss +zzz"

        let dateObj = dateFormatter.string(from: dateString as Date)

        return dateObj

    }
    
}
