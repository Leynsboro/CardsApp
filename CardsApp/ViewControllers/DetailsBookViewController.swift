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
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .font: UIFont(
                name: Font.fontName,
                size: Font.sizeForLargeTitle) ?? UIFont(),
            .foregroundColor: Color.blue
        ]
        
        bookImage.image = book.image
        nameBookLable.text = book.name
        descriptionBookLable.text = book.description
    }
}
