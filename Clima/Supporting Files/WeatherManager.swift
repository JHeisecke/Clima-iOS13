//
//  WeatherManager.swift
//  Clima
//
//  Created by Javier Heisecke  Echeverria on 12/28/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let endpoint = "http://api.openweathermap.org/data/2.5/weather?appid=c1c629ce92b820735f8d5852caa84afd"
    
    func fetchWeather(city: String) {
        let url = "\(endpoint)&q=\(city)"
    }
}
