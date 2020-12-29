//
//  WeatherManager.swift
//  Clima
//
//  Created by Javier Heisecke  Echeverria on 12/28/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager : WeatherManager, weatherData : WeatherModel)
    func didFail(_ error: Error)
}

struct WeatherManager {
    let endpoint = "https://api.openweathermap.org/data/2.5/weather?appid=c1c629ce92b820735f8d5852caa84afd"
    var delegate: WeatherManagerDelegate?
    func fetchWeather(city: String) {
        let url = "\(endpoint)&q=\(city)"
        performRequest(with: url)
    }
    
    func performRequest(with url: String) {
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
                if(error != nil) {
                    self.delegate?.didFail(error!)
                }
                
                if let responseData = data {
                    self.parseJSON(weatherData: responseData)
                }
            })

            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            
            let weather = WeatherModel(id: decodedData.weather[0].id, cityName: decodedData.name, temperature: decodedData.main.temp)
            self.delegate?.didUpdateWeather(self, weatherData: weather)
        } catch {
            self.delegate?.didFail(error)
        }
    }
}
