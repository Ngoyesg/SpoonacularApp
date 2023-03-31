//
//  RecipesViewController.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 30/03/23.
//

import UIKit

protocol RecipesViewControllerProtocol: AnyObject {
    
}

class RecipesViewController: UIViewController {
        
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterRecipeTextField: UITextField!
    @IBOutlet weak var searchRecipeButton: UIButton!
    
    var presenter: RecipesPresenterProtocol?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
//        presenter = RecipesPresenterBuilder().build()
//        presenter?.setController(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.presenter?.requestInitialRecipes()
    }
    
    
    @IBAction func onSearchRecipeButtonTapped(){
//        self.presenter?.procesOnSearchTapped(for: filterRecipeTextField.text)
    }

    
    
}

extension RecipesViewController: RecipesViewControllerProtocol {
    
}

extension RecipesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func reloadTable(){
        tableView.reloadData()
    }
    
    
}
