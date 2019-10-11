//
//  NoteCollectionViewCell.swift
//  Fundoo
//
//  Created by User on 09/10/19.
//  Copyright © 2019 BridgeLabz. All rights reserved.
//

import UIKit

class NoteCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var decriptionLabel: UILabel!
    
    func configureCell(note : Note) {
        self.titleLabel.text = note.noteTitle
        self.decriptionLabel.text = note.noteDescription
    }
    
}
