//
//  BottomMenuTableViewController.swift
//  Fundoo
//
//  Created by User on 22/10/19.
//  Copyright © 2019 BridgeLabz. All rights reserved.
//

import UIKit

class BottomMenuTableViewController: UITableViewController  {
    
    
    var colorArray = [#colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1), #colorLiteral(red: 0.9333333333, green: 0.5450980392, blue: 0.5098039216, alpha: 1), #colorLiteral(red: 0.968627451, green: 0.737254902, blue: 0.2, alpha: 1), #colorLiteral(red: 1, green: 0.9568627451, blue: 0.462745098, alpha: 1), #colorLiteral(red: 0.7921568627, green: 0.968627451, blue: 0.5647058824, alpha: 1), #colorLiteral(red: 0.6470588235, green: 0.9803921569, blue: 0.9215686275, alpha: 1), #colorLiteral(red: 0.8, green: 0.9411764706, blue: 0.9725490196, alpha: 1), #colorLiteral(red: 0.6862745098, green: 0.8, blue: 0.9803921569, alpha: 1), #colorLiteral(red: 0.8431372549, green: 0.6862745098, blue: 0.9843137255, alpha: 1), #colorLiteral(red: 0.9607843137, green: 0.8078431373, blue: 0.9098039216, alpha: 1)]
    
    @IBOutlet var colorCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = .clear
        colorCollectionView.backgroundColor = .clear
        applyShadowOnView(tableView)
    }
}

extension BottomMenuTableViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        colorArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = colorCollectionView.dequeueReusableCell(withReuseIdentifier: "ColorCollectionViewCell", for: indexPath) as! ColorCollectionViewCell
        
        cell.colourView.backgroundColor = colorArray[indexPath.row]
        cell.layer.cornerRadius = 25
        cell.layer.borderWidth = 0.5
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: NSNotification.Name("ChangeColor"), object: nil, userInfo: ["value" : indexPath.item])
    }
    
    func applyShadowOnView(_ view: UIView) {
        
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = CGSize(width: 1.5, height: 3)
        view.layer.masksToBounds = false
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 2
        view.layer.rasterizationScale = UIScreen.main.scale
        view.layer.shouldRasterize = true
    }
    
}


// FFFFFF white
// EE8B82 red
// F7BC33 orange
// FFF476 yellow
// CAF790 green
// A5FAEB teal
// CCF0F8 blue
// AFCCFA dark blue
// D7AFFB purple
// F5CEE8  pink

