//
//  BooksListViewController.swift
//  CardsApp
//
//  Created by Julia Romanenko on 23.05.2022.
//

import UIKit

class BooksListViewController: UITableViewController {
    
    var booksList = Book.getBooks()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80
        
        navigationController?.navigationBar.barTintColor = Color.darkBlue
        tabBarController?.tabBar.barTintColor = Color.darkBlue
        
        navigationItem.leftBarButtonItem = self.editButtonItem
        navigationItem.leftBarButtonItem?.image = UIImage(systemName: "wrench.and.screwdriver.fill")
        navigationItem.leftBarButtonItem?.tintColor = UIColor(red: 237/255, green: 124/255, blue: 104/255, alpha: 1)
    }
    
    @IBAction func unwindsegue(segue: UIStoryboardSegue) {
        guard segue.identifier == "save" else { return }
        
        guard let newBookVC = segue.source as? NewBookTableViewController else { return }
        let book = newBookVC.book
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            booksList[selectedIndexPath.row] = book
            tableView.reloadRows(at: [selectedIndexPath], with: .fade)
        } else {
            let newIndexPath = IndexPath(row: booksList.count, section: 0)
            booksList.append(book)
            tableView.insertRows(at: [newIndexPath], with: .fade)
        }
    }
    
// MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let book = booksList[indexPath.row]
        
        guard let navVC = segue.destination as? UINavigationController else { return }
        
        if let detailsVC = navVC.topViewController as? DetailsBookViewController {
            detailsVC.book = book
        }
    }
}

// MARK: - Table view DataSource and Delegate
extension BooksListViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        booksList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "booksCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        let book = booksList[indexPath.row]
        
        content.text = book.name
        content.textProperties.font = UIFont(name: Font.fontName, size: Font.sizeForTextInTableView) ?? UIFont()
        content.textProperties.color = Color.lightGray
        
        content.secondaryText = book.author
        content.secondaryTextProperties.font = UIFont(name: Font.fontName, size: Font.sizeForSecondaryTextInTableView) ?? UIFont()
        content.secondaryTextProperties.color = Color.gray
        
        content.image = book.image
        content.imageProperties.cornerRadius = 5
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            booksList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = booksList[sourceIndexPath.row]
        
        booksList.remove(at: sourceIndexPath.row)
        booksList.insert(item, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favourite = createFavouriteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [favourite])
    }
}

// MARK: - Private funcs
extension BooksListViewController {
    private func createFavouriteAction(at indexPath: IndexPath) -> UIContextualAction {
        var book = booksList[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "Favourite") { (action, view, completion) in
            book.isFavorite = !book.isFavorite
            self.booksList[indexPath.row] = book
            completion(true)
        }
        
        action.backgroundColor = book.isFavorite ? UIColor(red: 184/255, green: 207/255, blue: 158/255, alpha: 1) : .systemGray
        action.image = book.isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        
        return action
    }
}
