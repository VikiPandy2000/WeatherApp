//
//  TempCollectionViewCell.swift
//  WeatherApp
//
//  Created by Nagaraj, Vignesh (Cognizant) on 03/01/24.
//

import UIKit

class TempCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    @IBOutlet weak var temp: UILabel!
    
    @IBOutlet weak var img: UIImageView!
 
    @IBOutlet weak var daylbl: UILabel!
    
    @IBOutlet weak var monthlbl: UILabel!
    
    //MARK: - Data MappingFunction
    
    func setCell(temp:String , img : UIImage , day : String , month :String  ){
        self.temp.text = temp
        self.img.image = img
        self.daylbl.text = day
        self.monthlbl.text = month

   }
}
