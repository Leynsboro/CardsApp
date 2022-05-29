//
//  CardViewController.swift
//  CardsApp
//
//  Created by Nasim Nozirov on 27.05.2022.
//

import UIKit

protocol CardViewControllerDelegate: AnyObject {
    func getNextCard(_ current: Card) -> Card
}

class CardViewController: UIViewController {
    
    weak var delegate: CardViewControllerDelegate?
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var englishWordLabel: UILabel!
    @IBOutlet var russianwordLabel: UILabel!
    
    var cards: Card!
    
    var card: [String: String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        russianwordLabel.isHidden = true
        setupUI(with: cards)
        }
    

   
    @IBAction func translation() {
        russianwordLabel.isHidden = false
        russianwordLabel.text = cards.translatedWord
    }
    
    @IBAction func save() {
        card.updateValue(cards.originalWord, forKey: cards.translatedWord)
        
        englishWordLabel.text = cards.originalImage
        russianwordLabel.text = cards.translatedWord
        imageView.image = UIImage(named: cards.originalImage)
        cards = delegate?.getNextCard(cards)
        russianwordLabel.isHidden = true
        
    }
    
    @IBAction func noSave() {
        
        card.updateValue(cards.originalWord, forKey: cards.translatedWord)
        englishWordLabel.text = cards.originalImage
        russianwordLabel.text = cards.translatedWord
        imageView.image = UIImage(named: cards.originalImage)
        cards = delegate?.getNextCard(cards)
        
    }
    
    private func setupUI(with card: Card) {
        englishWordLabel.text = cards.originalWord
        russianwordLabel.text = cards.translatedWord
        imageView.image = UIImage(named: cards.originalImage)
    }
    
}
