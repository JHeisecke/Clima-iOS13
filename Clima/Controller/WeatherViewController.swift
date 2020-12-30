//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchBar: UITextField!
    
    var weatherManager = WeatherManager()
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        locationManager.delegate = self
        searchBar.delegate = self
        weatherManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }

    @IBAction func updateToCurrentLocation(_ sender: Any) {
        locationManager.requestLocation()
    }
}

//MARK: - UITextFieldDelegate

extension WeatherViewController : UITextFieldDelegate {
 
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
}

//MARK: - WeatherManagerDelegate


extension WeatherViewController : WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weatherData: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weatherData.tempString
            self.cityLabel.text = weatherData.cityName
            self.conditionImageView.image = UIImage(systemName: weatherData.conditionName)
        }
    }
    
    func didFail(_ error: Error) {
        print(error)
    }
}

//MARK: - WeatherManagerDelegate


extension WeatherViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            weatherManager.fetchWeather(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    
}
