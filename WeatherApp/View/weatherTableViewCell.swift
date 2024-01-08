//
//  weatherTableViewCell.swift
//  WeatherApp
//
//  Created by Nagaraj, Vignesh (Cognizant) on 04/01/24.
//

import UIKit

class weatherTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var Description: UILabel!
    
    @IBOutlet weak var weatherIcon: UIImageView!
    
    @IBOutlet weak var maxtemp: UILabel!
    
    @IBOutlet weak var mintemp: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Data MappingFunction
    func connectCell (date:String,descrip:String,weathericon:UIImage,maxtemp:String,mintemp:String){
        self.dateLabel.text = date
        self.Description.text = descrip
        self.weatherIcon.image = weathericon
        self.maxtemp.text = maxtemp
        self.mintemp.text = mintemp
    }

}
