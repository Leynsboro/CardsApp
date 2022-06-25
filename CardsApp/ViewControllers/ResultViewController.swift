//
//  ResultViewController.swift
//  CardsApp
//
//  Created by Илья Гусаров on 23.05.2022.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet var resultLabel: UILabel!
    
    var correctWords: Int = 0
    var wordsCount: Int = 0
    
    var wrongAnswers: [String: String] = [:]
    
    @IBOutlet var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        resultLabel.text = "Вы ответили на \(correctWords) из \(wordsCount)"
        setupTableView()
        tableview.alwaysBounceVertical = false
    }
    
    @IBAction func backTapped(_ sender: Any) {
        performSegue(withIdentifier: "backToTest", sender: self)
    }
    
}

extension ResultViewController: UITableViewDelegate,  UITableViewDataSource {
    
    private func setupTableView() {
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        wrongAnswers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "wrongWord", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        let index = wrongAnswers.index(wrongAnswers.startIndex, offsetBy: indexPath.row)
        let word = wrongAnswers[index]
        
        content.text = "\(word.key) - \(word.value)"
        content.textProperties.font = UIFont(
            name: Font.fontName,
            size: Font.sizeForTextInTableView) ?? UIFont()
        content.textProperties.color = Color.lightGray
        
        cell.contentConfiguration = content
        return cell
    }
}
