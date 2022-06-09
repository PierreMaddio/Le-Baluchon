//
//  WeatherService.swift
//  Le Baluchon
//
//  Created by Pierre on 08/06/2022.
//

import Foundation

class WeatherService {
    func getWeather(lat: Double, lon: Double, apikey: String) {
        let semaphore = DispatchSemaphore (value: 0)

        let url = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(apikey)"
        var request = URLRequest(url: URL(string: url)!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
          print(String(data: data, encoding: .utf8)!)
          semaphore.signal()
        }

        task.resume()
        semaphore.wait()

    }
}
