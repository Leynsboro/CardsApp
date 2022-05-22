//
//  Card.swift
//  CardsApp
//
//  Created by Илья Гусаров on 22.05.2022.
//

import Foundation

struct Card {
    let originalWord: String
    let translatedWord: String
    let originalImage: String
    
    var translated: String {
        "\(originalWord) (\(translatedWord)"
    }
    
    static func getCards() -> [Card] {
        
        var listOfCards: [Card] = []
        
        let words = DataManager.share.words
        
        for (key, value) in words {
            listOfCards.append(
                Card(
                    originalWord: key,
                    translatedWord: value,
                    originalImage: key)
            )
        }
        
        return listOfCards
    }
}
