//
//  WeatherModel.swift
//  Clima
//
//  Created by Javier Heisecke  Echeverria on 12/29/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let id : Int
    let cityName : String
    let temperature : Double
    
    var tempString : String {
        return String(format: "%.1f", temperature)
    }
    
    func getConditionIcon(icon: Int) -> String {
        switch icon {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        default:
            return "cloud"
        }
    }
}
