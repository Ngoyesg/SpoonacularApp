//
//  DetailedRecipeViewController.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 30/03/23.
//

import UIKit

protocol DetailsViewControllerProtocol: AnyObject {
    
}

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var vegetarianImageView: UIImageView!
    @IBOutlet weak var veganImageView: UIImageView!
    @IBOutlet weak var glutenFreeImageView: UIImageView!
    @IBOutlet weak var dairyFreeImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
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
