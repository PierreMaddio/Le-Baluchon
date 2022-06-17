//
//  TranslateViewController.swift
//  Le Baluchon
//
//  Created by Pierre on 09/06/2022.
//

import UIKit

class TranslateViewController: UIViewController {

    @IBOutlet weak var textToTranslate: UITextField!
    @IBOutlet weak var translatedText: UILabel!
    
    private let translation = translateService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    private func fetchDataForTranslation(text: UITextField) {
        let textToTranslateString = self.textToTranslate.text!
        self.translation.getTranslation(target: "en", q: textToTranslateString) { data in
            if let translationResult = data?.data?.translations?[0].translatedText {
                DispatchQueue.main.async {
                    self.translatedText.text = translationResult
                }
            }
        }failureCompletion: {
            print("failureCompletion \(#function)")
        }
    }
    
    @IBAction func tappedTranslateButton(_ sender: UIButton) {
        fetchDataForTranslation(text: textToTranslate)
    }
    

}
