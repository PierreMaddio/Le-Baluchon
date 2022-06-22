//
//  WeatherService.swift
//  Le Baluchon
//
//  Created by Pierre on 08/06/2022.
//

import Foundation

enum WeatherServiceError: Error {
    case noInternetConnection
    case timeout
    case cancel
    case wrongUrl
    case anyError
}

class WeatherService {
    static let weatherAPIKey = "074b276c5f07fc244358b814afab7bbf"
    
    var task: URLSessionDataTask?
    
    func getWeather(lat: Double,
                    lon: Double,
                    completion: @escaping (Result<Weather, WeatherServiceError>) -> Void) {
        
        let urlPathStr = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(Self.weatherAPIKey)"
        
        guard let url = URL(string: urlPathStr) else {
            completion(.failure(.wrongUrl))
            return
        }
        
        var requestURL = URLRequest(url: url)
        requestURL.httpMethod = "GET"
        task?.cancel()
        task = URLSession.shared.dataTask(with: requestURL) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(.failure(.anyError))
                }
                return
            }
            let decoder = JSONDecoder()
            guard
                let data = data,
                httpResponse.statusCode == 200,
                let response = try? decoder.decode(Weather.self, from: data)
            else {
                DispatchQueue.main.async {
                    completion(.failure(.anyError))
                }
                return
            }
            DispatchQueue.main.async {
                completion(.success(response))
            }
        }
        task?.resume()
    }
    
    func getWeather(lat: Double, lon: Double, successCompletion: @escaping (Weather?) -> (Void), failureCompletion: @escaping () -> Void) {
        let urlPathStr = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(Self.weatherAPIKey)"
        if let url = URL(string: urlPathStr) {
            var requestURL = URLRequest(url: url)
            requestURL.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: requestURL) { data, response, error in
                if let httpResponse = response as? HTTPURLResponse {
                    let decoder = JSONDecoder()
                    guard let data = data, httpResponse.statusCode == 200, let response = try? decoder.decode(Weather.self, from: data) else {
                        // Failed
                        successCompletion(nil)
                        return
                    }
                    // success
                    successCompletion(response)
                }
            }
            task.resume()
        }
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}
