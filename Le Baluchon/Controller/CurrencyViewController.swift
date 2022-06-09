//
//  CurrencyViewController.swift
//  Le Baluchon
//
//  Created by Pierre on 08/06/2022.
//

import UIKit

class CurrencyViewController: UIViewController {
    private let currency = CurrencyService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    @IBAction func tappedConvertButton(_ sender: UIButton) {
        currency.getCurrency(from: "USD", to: "EUR", amount: 25)
    }
    

}
