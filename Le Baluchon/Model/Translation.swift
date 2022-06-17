//
//  Translation.swift
//  Le Baluchon
//
//  Created by Pierre on 16/06/2022.
//

import Foundation

// MARK: - Translation
struct Translation: Codable {
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let translations: [TranslationElement]?
}

// MARK: - TranslationElement
struct TranslationElement: Codable {
    let translatedText, detectedSourceLanguage: String?
}
