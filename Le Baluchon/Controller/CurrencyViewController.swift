//
//  CurrencyViewController.swift
//  Le Baluchon
//
//  Created by Pierre on 08/06/2022.
//

import UIKit

class CurrencyViewController: UIViewController {
    
    @IBOutlet weak var amountToConvertLabel: UITextField!
    @IBOutlet weak var convertedValueLabel: UILabel!
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    private let currency = CurrencyService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainStackView.center = loader.center
    }
    
    @IBAction func tappedConvertButton(_ sender: UIButton) {
        fetchDataOfConversion(amount: amountToConvertLabel)
    }
    
    private func fetchDataOfConversion(amount: UITextField) {
        let amountString = self.amountToConvertLabel.text!
        self.currency.getConversion(to: "USD", from: "EUR", amount: amountString) { data in
            if let conversionResult = data?.result {
                DispatchQueue.main.async {
                    self.convertedValueLabel.text = String(conversionResult) + "$"
                }
            }
        }
    }
    

}
