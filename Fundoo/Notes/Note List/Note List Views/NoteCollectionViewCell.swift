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
    @IBOutlet weak var dateLabel: UILabel?
    @IBOutlet weak var remImage: UIImageView!
    
    func configureCell(note : NoteInfoApi) {
        self.backgroundColor = Helper.hexStringToUIColor(note.color)
        self.titleLabel.text = note.title
        self.decriptionLabel.text = note.description
//        if note.reminder != nil {
//            let noteDateText = convertDateIntoString(dateString: note.reminder!)
//            dateLabel?.text = noteDateText
//            remImage.image = UIImage(named: "fundooRem.png")
//        }
//        else
//        {
            dateLabel?.text = ""
            remImage.image = nil
      //  }
    }
    
    func convertDateIntoString(dateString : Date) -> String {

        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "MMM dd, hh:mm:ss "

        let dateObj = dateFormatter.string(from: dateString as Date)

        return dateObj

    }
    
}
