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
    @IBOutlet var russianWordLabel: UILabel!
    
    var cards: Card!
    
    var card: [String: String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .font: UIFont(name: Font.fontName, size: Font.sizeForLargeTitle) ?? UIFont(),
            .foregroundColor: Color.blue
        ]
        
        russianWordLabel.isHidden = true
        setupUI(with: cards)
    }
    
    @IBAction func translation() {
        russianWordLabel.isHidden = false
        russianWordLabel.text = cards.translatedWord
    }
    
    @IBAction func save() {
        card.updateValue(cards.originalWord, forKey: cards.translatedWord)
        cards = delegate?.getNextCard(cards)
        
        englishWordLabel.text = cards.originalImage
        russianWordLabel.text = cards.translatedWord
        
        imageView.image = UIImage(named: cards.originalImage)
        
        russianWordLabel.isHidden = true
        KnowCards.cards = card
    }
    
    @IBAction func noSave() {
        englishWordLabel.text = cards.originalImage
        russianWordLabel.text = cards.translatedWord
        cards = delegate?.getNextCard(cards)
        
        imageView.image = UIImage(named: cards.originalImage)
        
        russianWordLabel.isHidden = true
    }
    
    private func setupUI(with card: Card) {
        englishWordLabel.text = cards.originalWord
        russianWordLabel.text = cards.translatedWord
        imageView.image = UIImage(named: cards.originalImage)
    }
    
}

struct KnowCards {
    static var cards: [String:String] = [:]
}
