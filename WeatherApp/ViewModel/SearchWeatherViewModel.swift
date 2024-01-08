//
//  SearchWeatherViewModel.swift
//  WeatherApp
//
//  Created by Nagaraj, Vignesh (Cognizant) on 04/01/24.
//

import Foundation
class SearchWeatherViewModel {
    
    //MARK: - Location Api

    func fetchWeatherData(lat:Double,long:Double, completionHandler : @escaping (Welcome)->Void )  {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(long)&appid=553626bed26b25f56af0d6fa3890d1c5")
        else{

            return
        }
        print(url)
        findingData(url: url, completionHandler: completionHandler)
    }
    
    //MARK: - City Api

    func fetchingWeatherCity(City:String,completion:@escaping(Welcome) ->Void) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=\(City)&exclude=minutely&appid=bc889d2079abcecedd0fcf849f572e12")
        else{
            
            return
        }
      print(url)
     findingData(url: url, completionHandler: completion)
    
    }
    
    //MARK: - Api Call Function

    func findingData(url:URL?,completionHandler:@escaping(Welcome)->Void) {
                       guard let url = url else {
                                    return
                                }
                       let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                           
                           if let error = error {
                                print("error in url session")
                               print(error)
                               return
                           }
                                                  guard let httpResponse = response as? HTTPURLResponse,
                               (200...299).contains(httpResponse.statusCode)
                               else {
                                                      
                                // Show the URL and response status code in the debug console
                                                      
                                   if let httpResponse = response as? HTTPURLResponse {
                                       print("URL: \(httpResponse.url!.path )\nStatus code: \(httpResponse.statusCode)")
                                   }
                                   return
                           }
                               if let data = data {
                               // Create and configure a JSON decoder
                               let decoder = JSONDecoder()

                               do {
                                   let result = try decoder.decode(Welcome.self, from: data)
                                   
                                   // Diagnostic
                                   
                                print("result in url session")
                                   print(result)
                                   
                                   // Save the data (in memory)
                                   
                                completionHandler(result)
                                   
                                   // Then reload the table view; must be done this way
                               }
                               catch {
                                    print("error exception in url session")
                                print(error)
                               }
                           }
                       }
        
                    // Now that "task" has been fully defined, execute it...
                       task.resume()
                  
            }
    
    
    
    
    
    
    
}
