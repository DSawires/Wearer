//
//  WeatherManager.swift
//  Wearer
//
//  Created by David Sawires on 8/7/22.
//

import Foundation

import CoreLocation
protocol WeatherManagerDelegate {
    func didUpdateWeather(_ WeatherManager: weatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}
struct weatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=1c5223abf0898c6c9867de21b92b2926&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func getWeather(_ cityName: String) {
        let urlstring = "\(weatherURL)&q=\(cityName)"
        performRequest(urlstring)
    }
    
    func getLocationWeather(_ lati: CLLocationDegrees, _ lon: CLLocationDegrees) {
        let urlstring = "\(weatherURL)&lat=\(lati)&lon=\(lon)"
        performRequest(urlstring)
    }
    
    func performRequest(_ urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {(data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let tem = decodedData.main.temp
            let tempmax = decodedData.main.temp_max
            let tempmin = decodedData.main.temp_min
            let desc = decodedData.weather[0].description
            
            return WeatherModel(weatherID: id, cityName: name, description: desc, temp: tem, temp_max: tempmax, temp_min: tempmin)
        } catch {
            print(error)
            return nil
        }
    }
}
