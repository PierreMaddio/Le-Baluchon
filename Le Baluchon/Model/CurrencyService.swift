//
//  CurrencyService.swift
//  Le Baluchon
//
//  Created by Pierre on 08/06/2022.
//

import Foundation

class CurrencyService {
    static let currencyAPIKey = "CNQSfz5lOVWIo5wZmGu5TdL5zfD6QlHb"
    
    func getConversion(to: String, from: String, amount: String, completion: @escaping (Currency?) -> (Void) ) {
        let urlPathStr = "https://api.apilayer.com/fixer/convert?to=\(to)&from=\(from)&amount=\(amount)&apikey=\(Self.currencyAPIKey)"
        if let url = URL(string: urlPathStr) {
            var requestURL = URLRequest(url: url)
            requestURL.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: requestURL) { data, response, error in
                // Parsing du data CurrencyExchange
                if let httpResponse = response as? HTTPURLResponse {
                    let decoder = JSONDecoder()
                    guard let data = data, httpResponse.statusCode == 200, let response = try? decoder.decode(Currency.self, from: data) else {
                        // Failed
                        completion(nil)
                        return
                    }
                    // success
                    completion(response)
                }
            }
            task.resume()
        }
    }
    
}
