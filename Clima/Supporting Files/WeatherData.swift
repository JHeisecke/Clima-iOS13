//
//  WeatherData.swift
//  Clima
//
//  Created by Javier Heisecke  Echeverria on 12/29/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData : Codable {
    let name : String
    let weather : [Weather]
    let main : Main
}

struct Main : Codable {
    let temp : Double
    let feels_like : String
    let temp_min : String
    let temp_max : String
}

struct Weather : Codable {
    let id : Int
    let main : String
    let description : String
}
