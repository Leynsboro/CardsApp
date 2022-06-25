//
//  Book.swift
//  CardsApp
//
//  Created by Илья Гусаров on 22.05.2022.
//

import Foundation
import UIKit

struct Book {
    let name: String
    let author: String
    let description: String
    let image: UIImage?
    var isFavorite: Bool
    
    static func getBooks() -> [Book] {
        var listOfBooks: [Book] = []
        
        let books = DataManager.share.books
        
        for (key, value) in books {
            listOfBooks.append(Book(name: key,
                                    author: value["author"] ?? "",
                                    description: value["description"] ?? "",
                                    image: UIImage(named: key),
                                    isFavorite: false
                                   ))
        }
        
        return listOfBooks
        
    }
}
