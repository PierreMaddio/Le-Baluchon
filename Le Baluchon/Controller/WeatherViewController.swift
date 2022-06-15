//
//  WeatherViewController.swift
//  Le Baluchon
//
//  Created by Pierre on 08/06/2022.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var destinationCityNameLabel: UILabel!
    @IBOutlet weak var destinationTemperatureLabel: UILabel!
    @IBOutlet weak var destinationDescriptionLabel: UILabel!
    
    @IBOutlet weak var originCityNameLabel: UILabel!
    @IBOutlet weak var originTemperatureLabel: UILabel!
    @IBOutlet weak var originDescriptionLabel: UILabel!
    
    private let weather = WeatherService()
    
    var viewWillAppearForFirstTime: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if viewWillAppearForFirstTime {
            fetchDataNewYork()
            fetchDataParis()
            viewWillAppearForFirstTime = false
        }
    }
    
    private func fetchDataNewYork() {
        let coordinateNewYork = CLLocationCoordinate2D(latitude: 40.7127281, longitude: -74.0060152)
        
        fetchDataForCity(with: coordinateNewYork, for: true)
        
    }
    
    private func fetchDataParis() {
        let coordinateParis = CLLocationCoordinate2D(latitude: 48.8534100, longitude: 2.3488000)
        fetchDataForCity(with: coordinateParis, for: false)
        
    }
    
    private func fetchDataForCity(with coordinates: CLLocationCoordinate2D, for destinationView: Bool) {
        weather.getWeather(lat: coordinates.latitude, lon: coordinates.longitude) { data in
            if let name = data.name, let temperature = data.main?.temp, let desc = data.weather?.description {
                DispatchQueue.main.async {
                    if destinationView == true {
                        self.destinationCityNameLabel.text = name
                        self.destinationTemperatureLabel.text = String(format: "%.0f", self.kelvinsToCelsius(temperature: temperature)) + "°"
                        self.destinationDescriptionLabel.text = String(desc)
                    } else {
                        self.originCityNameLabel.text = name
                        self.originTemperatureLabel.text = String(format: "%.0f", self.kelvinsToCelsius(temperature: temperature)) + "°"
                        self.originDescriptionLabel.text = String(desc)
                    }
                }
            }
        } failureCompletion: {
            print("failureCompletion \(#function)")
            
        }
    }
    
    
    @IBAction func tappedWeatherButton(_ sender: UIButton) {
        fetchDataNewYork()
        fetchDataParis()
    }
    
    private func kelvinsToCelsius(temperature: Double) -> Double {
        let conversion = temperature - 273.15
        let aroundConversion = conversion.rounded()
        return aroundConversion
    }
    
    
}
