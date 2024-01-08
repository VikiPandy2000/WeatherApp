//
//  Constant.swift
//  WeatherApp
//
//  Created by Nagaraj, Vignesh (Cognizant) on 04/01/24.
//

import Foundation
import UIKit

public class AppUtils {
    //MARK: - Temperature
    
   public static func ConvertKivToC(temperature : Double)->String {
       return  "\(String(format: "%.0f", temperature - 273.15))°"
    }
    
    //MARK: - ImageIcon
    
   public static func getWeatherStatusImg(status : String )->UIImage {
       
        switch status {
        case "Clouds":
            return UIImage(systemName: "cloud.fill")!
        case "Rain":
            return  UIImage(systemName: "cloud.rain.fill")!
        case "Clear":
            return UIImage(systemName: "sun.max")!
        case "Snow":
            return UIImage(systemName: "cloud.snow.fill")!
        default:
            return UIImage(systemName: "cloud.snow.fill")!
        }
     
     }
    
    //MARK: - Date Function
    
 public static func fromDtToformatedDate(dt: Double, foramt : String ) -> String {
        
          let date = Date(timeIntervalSince1970: dt)
        let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = foramt
          return dateFormatter.string(from: date)
      }

}
