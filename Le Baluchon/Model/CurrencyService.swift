//
//  CurrencyService.swift
//  Le Baluchon
//
//  Created by Pierre on 08/06/2022.
//

import Foundation

class CurrencyService {
    func getCurrency(from: String, to: String, amount: Int) {
        let semaphore = DispatchSemaphore (value: 0)

        let url = "https://api.apilayer.com/fixer/convert?to=\(to)&from=\(from)&amount=\(amount)"
        var request = URLRequest(url: URL(string: url)!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        request.addValue("YFQJZ2987TVMTULWQ6ouobwPSknWfxLm", forHTTPHeaderField: "apikey")

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
