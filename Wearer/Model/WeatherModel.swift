//
//  WeatherModel.swift
//  Wearer
//
//  Created by David Sawires on 8/7/22.
//

import Foundation

struct WeatherModel {
    let weatherID: Int
    let cityName: String
    let description: String
    let temp: Double
    let temp_max: Double
    let temp_min: Double
    
    var tempString: String {
        return String(format:"%.0f", temp)
    }
    var tempMinString: String {
        return String(format:"%.0f", temp_min)
    }
    var tempMaxString: String {
        return String(format:"%.0f", temp_max)
    }
    var condition: String {
        switch weatherID {
        case 200...232:
            return "cloud.bolt"
        case 800:
            return "sun.max"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 700...781:
            return "cloud.fog"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}
