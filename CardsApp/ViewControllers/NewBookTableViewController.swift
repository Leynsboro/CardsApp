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
    var imageChange = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = Color.darkBlue
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .font: UIFont(name: Font.fontName, size: Font.sizeForLargeTitle) ?? UIFont(),
            .foregroundColor: Color.blue
        ]
        
        newNameTextField.delegate = self
        newAuthorTextField.delegate = self
        newDescriptionTextField.delegate = self
        
        newNameTextField.returnKeyType = .next
        newAuthorTextField.returnKeyType = .next
        newDescriptionTextField.returnKeyType = .done
        
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
        let image = imageChange ? newBookImage.image : UIImage(named: "book")
        
        book = Book(name: name, author: author, description: description, image: image, isFavorite: book.isFavorite)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            createAlertSheet()
        } else {
            view.endEditing(true)
        }
    }
}

extension NewBookTableViewController {
    private func setSaveButtonState() {
        
        let name = newNameTextField.text ?? ""
        let author = newAuthorTextField.text ?? ""
        let description = newDescriptionTextField.text ?? ""
        
        saveButton.isEnabled = !name.isEmpty && !author.isEmpty && !description.isEmpty
    }
    
    private func createAlertSheet() {
        let camera = UIImage(systemName: "camera")
        let photo = UIImage(systemName: "photo")
        
        let alertSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
            self.choseImagePicker(source: .camera)
        }
        cameraAction.setValue(camera, forKey: "image")
        
        let photoAction = UIAlertAction(title: "Photo", style: .default) { _ in
            self.choseImagePicker(source: .photoLibrary)
        }
        photoAction.setValue(photo, forKey: "image")
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertSheet.addAction(cameraAction)
        alertSheet.addAction(photoAction)
        alertSheet.addAction(cancelAction)
        
        present(alertSheet, animated: true)
    }
}

extension NewBookTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private func choseImagePicker(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        newBookImage.image = info[.editedImage] as? UIImage
        newBookImage.contentMode = .scaleAspectFill
        newBookImage.clipsToBounds = true
        
        imageChange = true
        dismiss(animated: true)
    }
}

extension NewBookTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == newNameTextField {
            newAuthorTextField.becomeFirstResponder()
        } else if textField == newAuthorTextField {
            newDescriptionTextField.becomeFirstResponder()
        } else {
            newDescriptionTextField.resignFirstResponder()
        }
        
        return true
    }
}
