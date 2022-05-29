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
        navigationItem.leftBarButtonItem = editButtonItem
        tableView.rowHeight = 100
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return cards.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wordCell", for: indexPath)
        var contend = cell.defaultContentConfiguration()
        let card = cards[indexPath.row]

        contend.text = card.originalWord
        contend.image = UIImage(named: card.originalImage)
//        contend.imageProperties.cornerRadius = tableView.rowHeight / 2
        cell.contentConfiguration = contend
        return cell
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            guard let cardVC = segue.destination as? CardViewController else { return }
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
