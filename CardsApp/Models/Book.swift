//
//  Book.swift
//  CardsApp
//
//  Created by Илья Гусаров on 22.05.2022.
//

import Foundation

struct Book {
    let name: String
    let description: String
    
    static func getBooks() -> [Book] {
        var listOfBooks: [Book] = []
        
        let books = DataManager.share.books
        
        for (key, value) in books {
            listOfBooks.append(Book(name: key, description: value))
        }
        
        return listOfBooks
        
    }
}
