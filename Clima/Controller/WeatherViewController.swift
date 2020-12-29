//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchBar: UITextField!
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        weatherManager.delegate = self
    }

    @IBAction func doSearch(_ sender: Any) {
        if let name = searchBar.text {
            weatherManager.fetchWeather(city: name)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(searchBar.text!)
        searchBar.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchBar.text = ""
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func didUpdateWeather(weatherData: WeatherModel) {
        temperatureLabel.text = weatherData.tempString
        cityLabel.text = weatherData.cityName
    }
    
    func didFail(_ error: Error) {
        print(error)
    }
}

