//
//  RecipesViewController.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 30/03/23.
//

import UIKit

protocol RecipesViewControllerProtocol: AnyObject {
    func alertProcessStatus(for process: RecipesUseCase, status: RecipesUseCaseStatus)
    func reloadTable()
    func startSpinner()
    func stopSpinner()
    func setIDToSend(with id: Int)
    func goToRecipeDetailsController()
}

class RecipesViewController: UIViewController {
        
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterRecipeTextField: UITextField!
    @IBOutlet weak var searchRecipeButton: UIButton!
    @IBOutlet private weak var spinner: UIActivityIndicatorView!
    
    var presenter: RecipesPresenterProtocol?
    var idToSend: Int?

    struct Constant {
        static let tableViewCellIdentifier = "RecipeCell"
        static let segueToRecipeDetails = "ToRecipeDetails"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        presenter = RecipesPresenterBuilder().build()
        presenter?.setController(self)
        self.presenter?.fetchAllRecipes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.presenter?.fetchAllRecipes()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.presenter?.restartFetchingHistory()
    }
    
    @IBAction func onSearchRecipeButtonTapped(){
        self.presenter?.procesOnSearchFilteredRecipeTapped(with: filterRecipeTextField.text)
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailsViewControllerProtocol, let idToSend = idToSend {
            destination.receive(id: idToSend)
        }
    }
}

extension RecipesViewController: RecipesViewControllerProtocol {
    
    func alertProcessStatus(for process: RecipesUseCase, status: RecipesUseCaseStatus) {
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
    
    func setIDToSend(with id: Int) {
        self.idToSend = id
    }
    
    func goToRecipeDetailsController() {
        performSegue(withIdentifier: Constant.segueToRecipeDetails, sender: self)
    }
}

extension RecipesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func reloadTable(){
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.getTotalOfRecipes() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.tableViewCellIdentifier, for: indexPath) as! RecipeCellProtocol
                
        let recipe = presenter?.getRecipeForRow(at: indexPath.row)
        
//        var content = cell.defaultContentConfiguration()
//
//        content.text = recipe?.title
//        content.textProperties.numberOfLines = 0
//
//        content.secondaryText = (recipe?.isFavorite ?? false ) ? "􀊵" : nil
//
//        if let image = recipe?.image {
//            content.image = UIImage(data: image)
//        } else {
//            content.image = UIImage(systemName: "questionmark.square")
//        }
//
//        cell.contentConfiguration = content
        cell.setTitle(recipe?.title)
        cell.setImage(recipe?.image)
        cell.toggleFavoriteStatus(to: recipe?.isFavorite ?? false)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.recipeWasSelected(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let addToFavorites = UIContextualAction(style: .normal, title: "Favorite") { [weak self] (action, view, completionHandler) in
            guard let self = self else {
                return
            }
            self.presenter?.handleAddToFavorites(at: indexPath.row)
            completionHandler(true)
        }
        
        addToFavorites.image = UIImage(systemName: "star.fill")
        addToFavorites.backgroundColor = .systemYellow
        
        let deleteFromFavorites = UIContextualAction(style: .destructive, title: "RemoveFavorite") { [weak self] (action, view, completionHandler) in
            guard let self = self else {
                return
            }
            self.presenter?.handleDeleteFromFavorites(at: indexPath.row)
            completionHandler(true)
        }
        deleteFromFavorites.image = UIImage(systemName: "star.slash")
        
        let configuration = UISwipeActionsConfiguration(actions: [addToFavorites, deleteFromFavorites])

        return configuration
    }
    
}
