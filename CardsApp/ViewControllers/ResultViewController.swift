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
    
    var wrongAnswers: [String: String] = [:]
    
    //@IBOutlet var tableview: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true

        resultLabel.text = "Вы ответили на \(knowWords) из \(wordsCount)"
        //setupTableView()
        //tableview.alwaysBounceVertical = false
    }
    
    @IBAction func backTapped(_ sender: Any) {
        performSegue(withIdentifier: "backToTest", sender: self)
    }
    
}

//extension ResultViewController: UITableViewDelegate,  UITableViewDataSource {
    
//    func setupTableView() {
//            tableview.delegate = self
//            tableview.dataSource = self
//
//        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
//
//            view.addSubview(tableview)
//        }
//
//        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            // 1
//            return wrongAnswers.count
//        }
//
//        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            // 2
//            let cell = tableview.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
//            cell.backgroundColor = UIColor.white
//            var content = cell.defaultContentConfiguration()
//
//            let index = wrongAnswers.index(wrongAnswers.startIndex, offsetBy: indexPath.row)
//            let word = wrongAnswers[index]
//
//            content.text = "\(word.key) - \(word.value)"
//
//            cell.contentConfiguration = content
//            return cell
//        }
    
//}
