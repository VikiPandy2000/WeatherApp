//
//  ViewController.swift
//  WeatherApp
//
//  Created by Nagaraj, Vignesh (Cognizant) on 01/01/24.
//

import UIKit
import CoreLocation
class ViewController: UIViewController,CLLocationManagerDelegate,UICollectionViewDelegate,UICollectionViewDataSource{
    
    //MARK: - Properties
    
    @IBOutlet weak var uiimage: UIImageView!
    
    @IBOutlet weak var CityName: UILabel!
    
    @IBOutlet weak var lowtemp: UILabel!
    
    @IBOutlet weak var HighTemp: UILabel!
    
    @IBOutlet weak var Stususlbl: UILabel!
    
    @IBOutlet weak var Datelbl: UILabel!
    
    @IBOutlet weak var tempCollectionView: UICollectionView!
    
    @IBOutlet weak var temp: UILabel!
    


    var weatherData = [List]()
    var locationManager = CLLocationManager()
    var currentLocation : CLLocation?
    var weatherViewModel = SearchWeatherViewModel()
    
    
    var lattitide :  Double?
    var longititude : Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tempCollectionView.dataSource = self
        tempCollectionView.delegate = self
        setupLocation()
    }
    
    //MARK: - Api call
    
    func fetchWeatherData(){
        weatherViewModel.fetchWeatherData(lat: lattitide!, long: longititude!, completionHandler: {
            
            (data) in
            var previousday = ""
//            Filter the day to dispaly the weather data
            for i in 0...30 {
                let currentday = AppUtils.fromDtToformatedDate(dt:Double(data.list[i].dt) , foramt : "EEEE, MMM d, yyyy" )
                if currentday != previousday {
                    self.weatherData.append(data.list[i])
                }
            previousday = currentday
                
//        Display the datas while fetching to model
            DispatchQueue.main.async { [self] in
                self.temp.text = AppUtils.ConvertKivToC(temperature :data.list[0].main.temp)
                self.CityName.text = data.city.name
                self.Datelbl.text = AppUtils.fromDtToformatedDate(dt:Double(data.list[0].dt) , foramt : "EEEE, MMM d, yyyy" )
                self.lowtemp.text = "\(AppUtils.ConvertKivToC(temperature : Double(data.list[0].main.tempMin)))↓"
                self.HighTemp.text = "\(AppUtils.ConvertKivToC(temperature : Double(data.list[0].main.tempMax)))↑"
                self.uiimage.image = AppUtils.getWeatherStatusImg( status: data.list[0].weather[0].main.rawValue )
                self.Stususlbl.text = data.list[0].weather[0].weatherDescription
                self.tempCollectionView.reloadData()
                }
            }
         }
    )
}

 
    func setupLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    //MARK: - Location
    
//     Access the current location using lattitude and longitude
 
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        guard let location = locations.first else {
                return
            }
    
        locationManager.stopUpdatingLocation()
        lattitide = location.coordinate.latitude
        longititude = location.coordinate.longitude
        fetchWeatherData()
    }
    
    //MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = tempCollectionView.dequeueReusableCell(withReuseIdentifier:"tempCell", for: indexPath) as! TempCollectionViewCell
        cell.setCell(temp:AppUtils.ConvertKivToC(temperature: weatherData[indexPath.row].main.temp),
                     img: AppUtils.getWeatherStatusImg(status: weatherData[indexPath.row].weather[0].main.rawValue),
                     day : AppUtils.fromDtToformatedDate(dt: Double(weatherData[indexPath.row].dt), foramt: "EEEE"),
                     month :AppUtils.fromDtToformatedDate(dt: Double(weatherData[indexPath.row].dt), foramt: "MMM d"))
        return cell
    }


}

