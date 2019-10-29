//
//  BottomMenuTableViewController.swift
//  Fundoo
//
//  Created by User on 22/10/19.
//  Copyright © 2019 BridgeLabz. All rights reserved.
//

import UIKit

class BottomMenuTableViewController: UITableViewController  {
   
    
    var colorArray = [#colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1), #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1), #colorLiteral(red: 0.6585915685, green: 0.8257755637, blue: 0.4744312167, alpha: 1), #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1), #colorLiteral(red: 0.470497191, green: 0.675825417, blue: 1, alpha: 1), #colorLiteral(red: 1, green: 0.5100005269, blue: 0.8374838829, alpha: 1)]
    
    @IBOutlet var colorCollectionView: UICollectionView!
    var color : UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = .clear
        colorCollectionView.backgroundColor = .clear
    }
     func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
          // Change the color of all cells
       
   
}
}
extension BottomMenuTableViewController : UICollectionViewDelegate, UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           colorArray.count
       }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = colorCollectionView.dequeueReusableCell(withReuseIdentifier: "ColorCollectionViewCell", for: indexPath) as! ColorCollectionViewCell
        
        cell.colourView.backgroundColor = colorArray[indexPath.row]
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 1
        
        return cell
    }
    
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        NotificationCenter.default.post(name: NSNotification.Name("ChangeColor"), object: nil, userInfo: ["value" : indexPath.item] )
        setColor(indexPath.item)
        color = colorArray[indexPath.item]
      }
    
    func setColor(_ indexPath: Int ){
        view.backgroundColor = colorArray[indexPath]
        let cell = UITableViewCell()
        cell.contentView.backgroundColor = colorArray[indexPath]
        cell.backgroundColor = colorArray[indexPath]
        //cell.backgroundColor = UIColor.greenColor()
        
    }
    
   
    
}
    

