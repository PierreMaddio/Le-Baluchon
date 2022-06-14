//
//  WeatherService.swift
//  Le Baluchon
//
//  Created by Pierre on 08/06/2022.
//

import Foundation

class WeatherService {
    static let weatherAPIKey = "074b276c5f07fc244358b814afab7bbf"
    
//    func getWeather(lat: Double, lon: Double, successCompletion: @escaping (Data) -> Void, failureCompletion: @escaping () -> Void) {
//        let semaphore = DispatchSemaphore (value: 0)
//        
//        let url = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(Self.weatherAPIKey)"
//        var request = URLRequest(url: URL(string: url)!, timeoutInterval: 15)
//        request.httpMethod = HTTPMethod.get.rawValue
//        
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard error == nil else {
//                failureCompletion()
//                return
//            }
//            guard
//                let data = data,
//                !data.isEmpty
//            else {
//                failureCompletion()
//                print(String(describing: error))
//                return
//            }
//            //print(String(data: data, encoding: .utf8)!)
//            successCompletion(data)
//            semaphore.signal()
//        }
//        task.resume()
//        semaphore.wait()
//    }
    
    func getWeather(lat: Double, lon: Double, successCompletion: @escaping (Weather) -> Void, failureCompletion: @escaping () -> Void) {
        let semaphore = DispatchSemaphore (value: 0)
        
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(Self.weatherAPIKey)"
        var request = URLRequest(url: URL(string: url)!, timeoutInterval: 15)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                failureCompletion()
                return
            }
            guard
                let data = data,
                !data.isEmpty
            else {
                failureCompletion()
                print(String(describing: error))
                return
            }
            //print(String(data: data, encoding: .utf8)!)
            if let httpResponse = response as? HTTPURLResponse {
                                let decoder = JSONDecoder()
                                guard httpResponse.statusCode == 200, let response = try? decoder.decode(Weather.self, from: data) else {
                                    // Failed
                                    failureCompletion()
                                    return
                                }
                                // success
                                successCompletion(response)
                            }
            semaphore.signal()
        }
        task.resume()
        semaphore.wait()
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}
