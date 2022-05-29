//
//  ViewController.swift
//  CardsApp
//
//  Created by Nozirov Nas on 20.05.2022.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    private let cardsList = Card.getCards()
    private let booksList = Book.getBooks()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let tabBarController = segue.destination as? UITabBarController else { return }
        guard let viewControllers = tabBarController.viewControllers else { return }
        
        for viewController in viewControllers {
            if let navVC = viewController as? UINavigationController {
                if let cardsVC = navVC.topViewController as? CardsTableViewController {
                    cardsVC.cardsList = cardsList
                } else if let booksVC = navVC.topViewController as? BooksListViewController {
                    booksVC.booksList = booksList
                }
            }
        }
    }
}

