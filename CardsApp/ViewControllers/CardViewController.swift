//
//  CardViewController.swift
//  CardsApp
//
//  Created by Nasim Nozirov on 27.05.2022.
//

import UIKit

class CardViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var englishWordLabel: UILabel!
    @IBOutlet var russianwordLabel: UILabel!
    
    var cards: Card!
    
    var card: [String: String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        russianwordLabel.isHidden = true
        englishWordLabel.text = cards.originalWord
        imageView.image = UIImage(named: cards.originalImage)
        }
    

   
    @IBAction func translation() {
        russianwordLabel.isHidden = false
        russianwordLabel.text = cards.translatedWord
    }
    
    @IBAction func save() {
       
        card.updateValue(cards.originalWord, forKey: cards.translatedWord)
        
    }
    
    @IBAction func noSave() {
        
    }
    
}
