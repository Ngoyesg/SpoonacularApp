//
//  RecipesPresenter.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 30/03/23.
//

import Foundation

protocol RecipesPresenterProtocol: AnyObject {
    func setController(_ viewController: RecipesViewControllerProtocol?)
    func getTotalOfRecipes() -> Int
    func getRecipeForRow(at row: Int) -> RecipeToDisplay
    func recipeWasSelected(at row: Int)
    func handleAddToFavorites(at index: Int)
    func handleDeleteFromFavorites(at index: Int)
    func procesOnSearchFilteredRecipeTapped(with keywords: String?)
    func fetchAllRecipes()
    func restartFetchingHistory()
}

class RecipesPresenter {
    
    weak var controller: RecipesViewControllerProtocol?
    var webServiceFacade: WebServicesFacadeProtocol
    var dbFacade: DBFacadeProtocol
    
    var offset = 0
    var limitNumber = 25
    var recipesToDisplay: [RecipeToDisplay] = []
    
    private let dispatchQueue = DispatchQueue(label: "Serial tasks")
    private let semaphore = DispatchSemaphore(value: 1)
        
    init(webServiceFacade: WebServicesFacadeProtocol, dbFacade: DBFacadeProtocol) {
        self.webServiceFacade = webServiceFacade
        self.dbFacade = dbFacade
    }
    
        
    func updateData(information: AllRecipesModel, recipes: [RecipeToDisplay]){
        offset = information.number ?? offset + (information.totalResults ?? 0)
        recipesToDisplay =  recipes
    }
    
    func getAllRecipes(){
        webServiceFacade.getUnfilteredRecipes(from: offset, to: limitNumber) { [weak self] generalInfo, recipes in
            guard let self = self else {
                self?.controller?.stopSpinner()
                self?.controller?.alertProcessStatus(for: .downloading, status: .failure)
                return
            }
            if let generalInfo = generalInfo, let recipes = recipes {
                self.updateData(information: generalInfo, recipes: recipes)
                self.controller?.stopSpinner()
                self.controller?.reloadTable()
            } else {
                self.controller?.stopSpinner()
                self.controller?.alertProcessStatus(for: .downloading, status: .failure)
            }
            
        }
    }
    
    func getFilteredRecipes(search keyword: String) {
        webServiceFacade.getFilteredRecipes(search: keyword) { [weak self] generalInfo, recipes in
            guard let self = self else {
                self?.controller?.stopSpinner()
                self?.controller?.alertProcessStatus(for: .downloading, status: .failure)
                return
            }
            if let generalInfo = generalInfo, let recipes = recipes {
                self.updateData(information: generalInfo, recipes: recipes)
                self.controller?.stopSpinner()
                self.controller?.reloadTable()
            } else {
                self.controller?.stopSpinner()
                self.controller?.alertProcessStatus(for: .downloading, status: .failure)
            }
        }
    }
    
    func saveFavorite(recipe: RecipeToDisplay){
        dbFacade.saveFavorite(recipe: recipe) { [weak self] status in
            guard let self = self else {
                self?.processModifyingFavoriteStatus(status: .failure)
                return
            }
            self.processModifyingFavoriteStatus(status: status)
        }
    }
    
    func deleteFavoriteRecipe(recipe: RecipeToDisplay){
        dbFacade.deleteFavoriteRecipe(recipe: recipe) { [weak self] status in
            guard let self = self else {
                self?.processModifyingFavoriteStatus(status: .failure)
                return
            }
            self.processModifyingFavoriteStatus(status: status)
        }
    }
    
    func processModifyingFavoriteStatus(status: DBManagerResultStatus){
        if let status = RecipesUseCaseStatus(rawValue: status.rawValue) {
            DispatchQueue.main.async {
                self.controller?.alertProcessStatus(for: .modifying, status: status)
            }
        }
    }
    
}

extension RecipesPresenter: RecipesPresenterProtocol {
    
    func setController(_ viewController: RecipesViewControllerProtocol?) {
        self.controller = viewController
    }
    
    func getTotalOfRecipes() -> Int {
        recipesToDisplay.count
    }
    
    func getRecipeForRow(at row: Int) -> RecipeToDisplay {
        recipesToDisplay[row]
    }
    
    func recipeWasSelected(at row: Int) {
        if let recipeToSend = recipesToDisplay[row].id {
            controller?.setIDToSend(with: recipeToSend)
            controller?.goToRecipeDetailsController()
        }
    }
    
    func handleAddToFavorites(at index: Int) {
        let favoriteRecipe = recipesToDisplay[index]
        saveFavorite(recipe: favoriteRecipe)
        recipesToDisplay[index].updateRecipeFavoriteStatus(status: true)
        controller?.reloadTable()
    }
    
    func handleDeleteFromFavorites(at index: Int) {
        let favoriteRecipe = recipesToDisplay[index]
        deleteFavoriteRecipe(recipe: favoriteRecipe)
        recipesToDisplay[index].updateRecipeFavoriteStatus(status: false)
    }
    
    func restartFetchingHistory() {
        offset = 0
        limitNumber = 25
        recipesToDisplay = []
    }
    
    
    func procesOnSearchFilteredRecipeTapped(with keywords: String?) {
        controller?.startSpinner()
        restartFetchingHistory()
        getFilteredRecipes(search: keywords ?? "")
    }
    
    func fetchAllRecipes() {
        controller?.startSpinner()
        getAllRecipes()
    }
}
