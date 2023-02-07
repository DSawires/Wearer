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
    var tempDescription: String {
        return String(description)
    }
    var wearDescription: String {
        var S = String()
        if (temp >= 27) {
            S += "Wear a short sleeve and Shorts"
        } else if (temp >= 20) {
            S += "Wear a Short Sleeve and Pants"
        } else if (temp >= 10) {
            S += "Wear a Long Sleeve and Pants"
        } else {
            S += "Wear a Long Sleeve, Pants and don't forget your Jacket and Beanie"
        }
        switch weatherID {
            case 200...232:
                S += ", it's going to rain"
            case 300...321:
                S += ", it's going to drizzle"
            case 500...531:
                S += ", it's going to rain"
            default:
                S
        }
        S += "!"
        return S
    }
    var condition: String {
        switch weatherID {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 700...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud"
        default:
            return "cloud"
        }
    }
}
