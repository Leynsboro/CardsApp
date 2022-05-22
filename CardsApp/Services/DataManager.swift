//
//  DataManager.swift
//  CardsApp
//
//  Created by Илья Гусаров on 20.05.2022.
//

import Foundation

class DataManager {
    
    static var share = DataManager()
    
    let words = ["cat": "кошка", "dog": "собака", "eye": "глаз", "leg": "нога", "tea": "чай", "cake": "торт", "laptop": "ноутбук", "apple": "яблоко", "snake": "змея", "milk": "молоко"]
    
    let books = [
        "1984": "New Russia",
        "Chapollino": "Jopa govno",
        "kniga": "ee nado chitat'"
    ]
    
    
    init() {}
}
