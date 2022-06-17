//
//  TranslateService.swift
//  Le Baluchon
//
//  Created by Pierre on 16/06/2022.
//

import Foundation

class translateService {
    static let translationAPIKey = ""
    
    func getTranslation(target: String, q: String, successCompletion: @escaping (Translation?) -> (Void), failureCompletion: @escaping () -> Void) {
        let urlPathStr = "https://translation.googleapis.com/language/translate/v2?target=\(target)&key=\(Self.translationAPIKey)&q=\(q)"
        if let url = URL(string: urlPathStr) {
            var requestURL = URLRequest(url: url)
            requestURL.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: requestURL) { data, response, error in
                // Parsing du data CurrencyExchange
                if let httpResponse = response as? HTTPURLResponse {
                    let decoder = JSONDecoder()
                    guard let data = data, httpResponse.statusCode == 200, let response = try? decoder.decode(Translation.self, from: data) else {
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
