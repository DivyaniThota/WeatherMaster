//
//  ViewController.swift
//  WeatherMaster
//
//  Created by DIVYANI PRASAD THOTA on 25/01/24.
//

import UIKit
import CoreLocation

class ClimateViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    
    @IBOutlet weak var stateLabel: UILabel!
    
    @IBOutlet weak var googleTextField: UITextField!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {        
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherManager.delegate = self
        googleTextField.delegate = self
        
    }

    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
}

//MARK: - UITextFieldDelegate

extension ClimateViewController: UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
        googleTextField.endEditing(true)
        print(googleTextField.text!)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        print(textField.text!)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something here..."
            return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = googleTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        googleTextField.text = ""
    }
    
}

//MARK: - WeatherManagerDelegate

extension ClimateViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, climate: WeatherModel){
        DispatchQueue.main.async {
            self.temperatureLabel.text = climate.temperatureString
            self.conditionImageView.image = UIImage(systemName: climate.conditionName)
            self.stateLabel.text = climate.cityName
            
        }
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

 //MARK: - CLLocationManagerDelegate

extension ClimateViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            print(lat)
            print(lon)
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

