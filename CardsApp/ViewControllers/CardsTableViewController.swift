//
//  CardsTableViewController.swift
//  CardsApp
//
//  Created by Nasim Nozirov on 27.05.2022.
//

import UIKit

class CardsTableViewController: UITableViewController {

    
   var cards = Card.getCards()
//    var cards: [Card] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 80
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return cards.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wordCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let card = cards[indexPath.row]

        content.text = card.originalWord
        content.textProperties.font = UIFont(name: Font.fontName, size: Font.sizeForTextInTableView) ?? UIFont()
        content.textProperties.color = Color.lightGray
        
        cell.contentConfiguration = content
        return cell
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navVC = segue.destination as? UINavigationController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        
        if let cardVC = navVC.topViewController as? CardViewController {
            cardVC.cards = cards[indexPath.row]
            cardVC.delegate = self
        }
    }
}

extension CardsTableViewController: CardViewControllerDelegate {
    func getNextCard(_ current: Card) -> Card {
        let cardsWithoutCurrent = cards.filter {$0.uuid != current.uuid}
        return cardsWithoutCurrent[Int.random(in: 0..<cardsWithoutCurrent.count)]
    }
}
