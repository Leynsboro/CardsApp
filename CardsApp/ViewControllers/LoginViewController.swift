//
//  ViewController.swift
//  CardsApp
//
//  Created by Илья Гусаров on 20.05.2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet var startButton: UIButton!
    @IBOutlet var developersButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startButton.layer.cornerRadius = Radius.radiusButton
        developersButton.layer.cornerRadius = Radius.radiusButton
        
    }
}

