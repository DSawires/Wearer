//
//  ViewController.swift
//  Wearer
//
//  Created by David Sawires on 8/7/22.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var wearLabel: UILabel!
    
    var WeatherManager = weatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.requestLocation()
        
        WeatherManager.delegate = self
        searchTextField.delegate = self
    }
    @IBAction func locationButton(_ sender: UIButton) {
        locationManager.requestLocation()
    }
}

//MARK: -UITextFieldDelegate

extension ViewController: UITextFieldDelegate {
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Empty city"
            return false
            
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchTextField.text {
            WeatherManager.getWeather(city)
        }
        
        searchTextField.text = ""
    }
    
}
 
//MARK: -WeatherManagerDelegate

extension ViewController: WeatherManagerDelegate{
    func didUpdateWeather(_ WeatherManager: weatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.tempString
            self.cityLabel.text = weather.cityName
            self.conditionImageView.image = UIImage(systemName: weather.condition)
            self.descriptionLabel.text = weather.tempDescription
            self.wearLabel.text = weather.wearDescription
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: -CLLocationManagerDelegate

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let lon = location?.coordinate.longitude
        let lat = location?.coordinate.latitude
        WeatherManager.getLocationWeather(lat!, lon!)
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
