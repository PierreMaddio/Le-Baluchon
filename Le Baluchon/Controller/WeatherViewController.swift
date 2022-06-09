//
//  WeatherViewController.swift
//  Le Baluchon
//
//  Created by Pierre on 08/06/2022.
//

import UIKit

class WeatherViewController: UIViewController {
    private let weather = WeatherService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func tappedWeatherButton(_ sender: UIButton) {
        weather.getWeather(lat: 37.39, lon: -122.08, apikey: "074b276c5f07fc244358b814afab7bbf")
    }
    


}
