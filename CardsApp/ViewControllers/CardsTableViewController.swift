//
//  CardsTableViewController.swift
//  CardsApp
//
//  Created by Nasim Nozirov on 27.05.2022.
//

import UIKit

class CardsTableViewController: UITableViewController {

    var cardsList: [Card] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = Color.darkBlue
        tabBarController?.tabBar.barTintColor = Color.darkBlue
        
        tableView.rowHeight = 80
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return cardsList.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wordCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let card = cardsList[indexPath.row]

        content.text = card.originalWord
        content.textProperties.font = UIFont(
            name: Font.fontName,
            size: Font.sizeForTextInTableView) ?? UIFont()
        content.textProperties.color = Color.lightGray
        
        cell.contentConfiguration = content
        
        cell.selectionStyle = .none
        
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navVC = segue.destination as? UINavigationController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        
        if let cardVC = navVC.topViewController as? CardViewController {
            cardVC.cards = cardsList[indexPath.row]
            cardVC.delegate = self
        }
    }
}

extension CardsTableViewController: CardViewControllerDelegate {
    func getNextCard(_ current: Card) -> Card {
        let cardsWithoutCurrent = cardsList.filter {$0.uuid != current.uuid}
        return cardsWithoutCurrent[Int.random(in: 0..<cardsWithoutCurrent.count)]
    }
}
