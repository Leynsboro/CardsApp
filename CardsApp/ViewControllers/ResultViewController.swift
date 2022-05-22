//
//  ResultViewController.swift
//  CardsApp
//
//  Created by Илья Гусаров on 23.05.2022.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet var resultLabel: UILabel!
    
    var knowWords: Int = 0
    var wordsCount: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        resultLabel.text = "Вы ответили на \(knowWords) из \(wordsCount)"
    }
    
    @IBAction func backTapped(_ sender: Any) {
        performSegue(withIdentifier: "unwindToTest", sender: self)
    }
    
}
