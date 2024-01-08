//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Nagaraj, Vignesh (Cognizant) on 04/01/24.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
 
    //MARK: - Properties
    
    @IBOutlet weak var searchtxt: UITextField!
    
    @IBOutlet weak var weatherConditionIcon: UIImageView!
    
    @IBOutlet weak var tempLabel: UILabel!
    
    @IBOutlet weak var mintemp: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var currentemp: UILabel!

    @IBOutlet weak var hightemp: UILabel!
    
    @IBOutlet weak var datelbl: UILabel!
    
    @IBOutlet weak var citylbl: UILabel!
    
    @IBOutlet weak var tableview: UITableView!
    
    var weatherForecastList = [List]()
    var weatherDataModel = SearchWeatherViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
    // Do any additional setup after loading the view.
        searchtxt.delegate = self
        tableview.delegate = self
        tableview.dataSource = self
        
    }
   
    //MARK: - Api call search button

    @IBAction func searchbtn(_ sender: UIButton) {
        searchtxt.endEditing(true)
        guard let cityName = searchtxt.text else{
            return
        }
        weatherDataModel.fetchingWeatherCity(City: cityName) { result in
            
        var previousDay = ""
       
            for i in 0...30 {
           
                let currentDay = AppUtils.fromDtToformatedDate(dt: Double(result.list[i].dt), foramt: "EEEE, MMM d, yyyy")
                if currentDay != previousDay  {
                    self.weatherForecastList.append( result.list[i])
                }
                previousDay = currentDay
             
                DispatchQueue.main.async { [self] in
                    self.tempLabel.text = AppUtils.ConvertKivToC(temperature: result.list[0].main.temp)
                    self.citylbl.text = result.city.name
                    self.dateLabel.text = AppUtils.fromDtToformatedDate(dt: Double(result.list[0].dt), foramt: "EEEE, MMM d, yyyy")
                    self.currentemp.text = AppUtils.ConvertKivToC(temperature: result.list[0].main.temp)
                    self.mintemp.text = AppUtils.ConvertKivToC(temperature: result.list[0].main.tempMin)
                    self.hightemp.text = AppUtils.ConvertKivToC(temperature: result.list[0].main.tempMax)
                    self.weatherConditionIcon.image = AppUtils.getWeatherStatusImg(status: result.list[0].weather[0].main.rawValue)
                    self.tableview.reloadData()
                    searchtxt.text = ""
                }
            }
        }
    }
    
    //MARK: - UITextfield Function
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchtxt.text != ""{
            clearWeatherData()
            return true
        }else {
            searchtxt.placeholder = "Please type cityName"
            return false
        }
    }
    
    func clearWeatherData() {
        weatherForecastList.removeAll()
        self.tableview.reloadData()
    }
    
  //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherForecastList.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherForecastCell", for: indexPath) as! weatherTableViewCell
        let weatherData = self.weatherForecastList[(indexPath as NSIndexPath).row]
        
        cell.connectCell(date: AppUtils.fromDtToformatedDate(dt: Double(weatherData.dt), foramt: "MMM d"),
                         descrip: weatherData.weather[0].weatherDescription,
                         weathericon: AppUtils.getWeatherStatusImg(status: weatherData.weather[0].main.rawValue),
                         maxtemp: AppUtils.ConvertKivToC(temperature: Double(weatherData.main.tempMax)),
                         mintemp: AppUtils.ConvertKivToC(temperature: Double(weatherData.main.tempMin)))
        return cell
    }
    
}
