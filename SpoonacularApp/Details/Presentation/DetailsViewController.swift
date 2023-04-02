//
//  DetailedRecipeViewController.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 30/03/23.
//

import UIKit
import WebKit

protocol DetailsViewControllerProtocol: AnyObject {
    func receive(recipe: RecipeToDisplay)
    func alertDownloadingDetailsFailed()
    func fillInBasicData(with recipe: RecipeToDisplay)
    func fillInRecipeDetails(with details: DetailedRecipe)
}

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var recipeTitleLabel: UILabel!
    
    @IBOutlet weak var recipeImageView: UIImageView!
    
    @IBOutlet weak var isVeganLabel: UIStackView!
    
    @IBOutlet weak var isVegetarianLabel: UIStackView!
    
    @IBOutlet weak var isLactoseFreeLabel: UIStackView!
    
    @IBOutlet weak var isGlutenFreeLabel: UIStackView!
    
    @IBOutlet weak var instructions: WKWebView!
    
    var recipeReceived: RecipeToDisplay?
    var presenter: DetailsPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = DetailsPresenterBuilder().build()
        presenter?.setController(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let recipeReceived = recipeReceived {
            presenter?.processRecipeWasReceived(from: recipeReceived)
        }
    }
    
    func setTitle(with title: String?) {
        self.recipeTitleLabel.text = title ?? "No title found"
    }
    
    func setRecipeImage(with data: Data?) {
        if let data = data {
            self.recipeImageView.image = UIImage(data: data)
        } else {
            self.recipeImageView.image = UIImage(systemName: "questionmark.square")
        }
    }
    
    func isVegan(status: Bool) {
        isVeganLabel.isHidden = !status
    }
    func isVegetarian(status: Bool) {
        isVegetarianLabel.isHidden = !status
    }
    func isLactoseFree(status: Bool) {
        isLactoseFreeLabel.isHidden = !status
    }
    func isGlutenFree(status: Bool) {
        isGlutenFreeLabel.isHidden = !status
    }
    func setInstructions(with instructions: String) {
        let headerString = "<head><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></head>"
        self.instructions.loadHTMLString(headerString + instructions, baseURL: nil)
    }
    
}

extension DetailsViewController: DetailsViewControllerProtocol {
 
    func receive(recipe: RecipeToDisplay) {
        recipeReceived = recipe
    }
    
    func fillInBasicData(with recipe: RecipeToDisplay) {
        setTitle(with: recipe.title)
        setRecipeImage(with: recipe.image)
    }
    
    func fillInRecipeDetails(with details: DetailedRecipe) {
        isVegan(status: details.vegan ?? false)
        isVegetarian(status: details.vegetarian ?? false)
        isLactoseFree(status: details.dairyFree ?? false)
        isGlutenFree(status: details.glutenFree ?? false)
        setInstructions(with: details.instructions ?? "No instructions")
    }
    
    func alertDownloadingDetailsFailed() {
        let alert = UIAlertController(title: "Error", message: "Downloading details failed", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }

}
