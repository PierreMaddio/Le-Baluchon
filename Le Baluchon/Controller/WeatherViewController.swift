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
        weather.getWeather(lat: 37.39, lon: -122.08) { data in
            print(String(data: data, encoding: .utf8) ?? "" as Any)
        } failureCompletion: {
            print("failureCompletion \(#function)")
        }

    }
    


}
