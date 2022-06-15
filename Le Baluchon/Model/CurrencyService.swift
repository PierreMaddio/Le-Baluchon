//
//  CurrencyService.swift
//  Le Baluchon
//
//  Created by Pierre on 08/06/2022.
//

import Foundation

class CurrencyService {
    static let currencyAPIKey = "CNQSfz5lOVWIo5wZmGu5TdL5zfD6QlHb"
    
    func getCurrency(from: String, to: String, amount: String,successCompletion: @escaping (Currency) -> Void, failureCompletion: @escaping () -> Void) {
        
        let url = "https://api.apilayer.com/fixer/convert?to=\(to)&from=\(from)&amount=\(amount)&apikey=\(Self.currencyAPIKey)"
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
            if let httpResponse = response as? HTTPURLResponse {
                                let decoder = JSONDecoder()
                                guard httpResponse.statusCode == 200, let response = try? decoder.decode(Currency.self, from: data) else {
                                    // Failed
                                    failureCompletion()
                                    return
                                }
                                // success
                                successCompletion(response)
                            }
        }
        task.resume()
    }
    
}
