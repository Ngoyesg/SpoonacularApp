//
//  FavoritesViewController.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 30/03/23.
//

import UIKit

protocol FavoritesViewControllerProtocol: AnyObject {
    func alertProcessStatus(for process: FavoritesUseCases, status: FavoritesUseCasesStatus)
    func reloadTable()
    func reloadRow(at index: Int)
    func startSpinner()
    func stopSpinner()
}

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet private weak var spinner: UIActivityIndicatorView!
    
    
    var presenter: FavoritesPresenterProtocol?
    var idToSend: Int?
    
    struct Constant {
        static let tableViewCellIdentifier = "RecipeCell"
        static let segueToRecipeDetails = "ToRecipeDetails"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        presenter = FavoritesPresenterBuilder().build()
        presenter?.setController(self)
        self.presenter?.listAllRecipes()
    }
    
    
    @IBAction func onDeleteAllButtonTapped(_ sender: Any) {
        alertDeletion()
    }
    
    func alertDeletion() {
        let alert = UIAlertController(title: "Warning", message: "Are you sure you want to remove all favorites?", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            self.presenter?.handleDeleteAll()
        }
        alert.addAction(deleteAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }
    
    
}

extension FavoritesViewController: FavoritesViewControllerProtocol {
    func reloadRow(at index: Int) {
        tableView.performBatchUpdates {
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        }
    }
    
    func alertProcessStatus(for process: FavoritesUseCases, status: FavoritesUseCasesStatus) {
        let message = "\(process.rawValue) \(status.rawValue.lowercased())"
        let alert = UIAlertController(title: status.rawValue, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
    func startSpinner(){
        spinner.isHidden = false
        spinner.startAnimating()
    }
    
    func stopSpinner(){
        spinner.isHidden = true
        spinner.stopAnimating()
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func reloadTable(){
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.getTotalOfRecipes() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.tableViewCellIdentifier, for: indexPath) as! RecipeCellProtocol
        
        if let recipe = presenter?.getRecipeForRow(at: indexPath.row) {
            cell.setTitle(recipe.title)
            cell.setImage(recipe.image)
            cell.toggleFavoriteStatus(to: recipe.isFavorite)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
               
        let deleteFromFavorites = UIContextualAction(style: .destructive, title: "RemoveFavorite") { [weak self] (action, view, completionHandler) in
            guard let self = self else {
                return
            }
            self.presenter?.handleDeleteFromFavorites(at: indexPath.row)
            completionHandler(true)
        }
        deleteFromFavorites.image = UIImage(systemName: "star.slash")
        
        return UISwipeActionsConfiguration(actions: [deleteFromFavorites])
    }
}
