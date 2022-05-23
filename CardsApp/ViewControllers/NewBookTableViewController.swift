//
//  NewBookTableViewController.swift
//  CardsApp
//
//  Created by Julia Romanenko on 23.05.2022.
//

import UIKit

class NewBookTableViewController: UITableViewController {
    
    @IBOutlet var newBookImage: UIImageView!
    
    @IBOutlet var newNameTextField: UITextField!
    @IBOutlet var newAuthorTextField: UITextField!
    @IBOutlet var newDescriptionTextField: UITextField!
    
    @IBOutlet var saveButton: UIBarButtonItem!
    
    var book = Book(name: "", author: "", description: "", image: UIImage(named: ""), isFavorite: false)
    var imageChance = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSaveButtonState()
    }
    
    @IBAction func checkText(_ sender: UITextField) {
        setSaveButtonState()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "save" else { return }
        
        let name = newNameTextField.text ?? ""
        let author = newAuthorTextField.text ?? ""
        let description = newDescriptionTextField.text ?? ""
        var image = newBookImage.image
        image = UIImage(named: "image")
        
        book = Book(name: name, author: author, description: description, image: image, isFavorite: book.isFavorite)
    }
}

extension NewBookTableViewController {
    private func setSaveButtonState() {
        
        let name = newNameTextField.text ?? ""
        let author = newAuthorTextField.text ?? ""
        let description = newDescriptionTextField.text ?? ""
        
        saveButton.isEnabled = !name.isEmpty && !author.isEmpty && !description.isEmpty
    }
}


