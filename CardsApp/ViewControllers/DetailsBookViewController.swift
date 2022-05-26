//
//  DetailsBookViewController.swift
//  CardsApp
//
//  Created by Julia Romanenko on 23.05.2022.
//

import UIKit

class DetailsBookViewController: UIViewController {
    
    @IBOutlet var bookImage: UIImageView!
    
    @IBOutlet var nameBookLable: UILabel!
    @IBOutlet var descriptionBookLable: UILabel!
    
    var book: Book!

    override func viewDidLoad() {
        super.viewDidLoad()
        settingBackItemColor()

        tabBarController?.tabBar.backgroundColor = Color.darkBlue
        
        bookImage.image = book.image
        nameBookLable.text = book.name
        descriptionBookLable.text = book.description
    }
    
    private func settingBackItemColor() {
        let backButton = UIBarButtonItem()
        backButton.title = "Назад"
        backButton.tintColor = Color.red
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

}
