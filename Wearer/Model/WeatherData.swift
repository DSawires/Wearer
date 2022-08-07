//
//  WeatherData.swift
//  Wearer
//
//  Created by David Sawires on 8/7/22.
//

import Foundation


struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
    let temp_max: Double
    let temp_min: Double
}

struct Weather: Decodable {
    let description: String
    let id: Int
}
