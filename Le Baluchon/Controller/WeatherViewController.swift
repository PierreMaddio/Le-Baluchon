//
//  WeatherViewController.swift
//  Le Baluchon
//
//  Created by Pierre on 08/06/2022.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var destinationCityNameLabel: UILabel!
    @IBOutlet weak var destinationTemperatureLabel: UILabel!
    @IBOutlet weak var destinationDescriptionLabel: UILabel!
    
    @IBOutlet weak var originCityNameLabel: UILabel!
    @IBOutlet weak var originTemperatureLabel: UILabel!
    @IBOutlet weak var originDescriptionLabel: UILabel!
    
    private let weather = WeatherService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func tappedWeatherButton(_ sender: UIButton) {
        weather.getWeather(lat: 40.7127281, lon: -74.0060152) { data in
            if let name = data.name, let temperature = data.main?.temp {
                DispatchQueue.main.async {
                    self.destinationCityNameLabel.text = name
                    self.destinationTemperatureLabel.text = String(temperature)
                }
            }
        } failureCompletion: {
            print("failureCompletion \(#function)")
        }
    }
    
    func kelvinsToCelsius(temperature: Double) -> String {
        let conversion = temperature - 273.15
        let aroundConversion = conversion
        let stringConversion = String(aroundConversion)
        return stringConversion
    }
    
    
}
