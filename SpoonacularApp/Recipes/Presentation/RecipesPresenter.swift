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
    
    private let fetchRecipesUseCase: FetchRecipesUseCaseProtocol
    private let dbFacade: DBFacadeProtocol
    
    var offset = 0
    var limitNumber = 25
    var recipesToDisplay: [RecipeToDisplay] = []
    
    init(fetchRecipesUseCase: FetchRecipesUseCaseProtocol, dbFacade: DBFacadeProtocol) {
        self.fetchRecipesUseCase = fetchRecipesUseCase
        self.dbFacade = dbFacade
    }
            
    func updateData(information: AllRecipesModel, recipes: [RecipeToDisplay]){
        offset = information.number ?? offset + (information.totalResults ?? 0)
        recipesToDisplay =  recipes
    }
    
    func getAllRecipes(){
        fetchRecipesUseCase.getRecipes(from: offset, to: limitNumber, search: "") { [weak self] generalInfo, recipes in
            guard let self = self else {
                return
            }
            self.processRecipesResponse(generalInfo: generalInfo, recipes: recipes)
        }
    }
    
    func processRecipesResponse(generalInfo: AllRecipesModel?, recipes: [RecipeToDisplay]?) {
        guard let recipes = recipes, let generalInfo = generalInfo else {
            self.controller?.stopSpinner()
            self.controller?.alertProcessStatus(for: .downloading, status: .failure)
            return
        }
        self.updateData(information: generalInfo, recipes: recipes)
        self.controller?.stopSpinner()
        self.controller?.reloadTable()
    }
    
    func getFilteredRecipes(search keyword: String) {
        fetchRecipesUseCase.getRecipes(from: offset, to: limitNumber, search: keyword) { [weak self] generalInfo, recipes in
            guard let self = self else {
                return
            }
            self.processRecipesResponse(generalInfo: generalInfo, recipes: recipes)
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
        let recipeToSend = recipesToDisplay[row]
        controller?.setRecipeToSend(with: recipeToSend)
        controller?.goToRecipeDetailsController()
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
    
    func handleAddToFavorites(at index: Int) {
        let favoriteRecipe = recipesToDisplay[index]
        dbFacade.saveFavorite(recipe: favoriteRecipe) { [weak self] status in
            guard let self = self else {
                return
            }
            if (status == .success) {
                self.recipesToDisplay[index].updateRecipeFavoriteStatus(status: true)
                self.controller?.reloadRow(at: index)
            }
            self.processModifyingFavoriteStatus(status: status)
        }
    }
    
    func handleDeleteFromFavorites(at index: Int) {
        let favoriteRecipe = recipesToDisplay[index]
        dbFacade.deleteFavoriteRecipe(recipe: favoriteRecipe) { [weak self] status in
            guard let self = self else {
                return
            }
            if (status == .success) {
                self.recipesToDisplay[index].updateRecipeFavoriteStatus(status: false)
                self.controller?.reloadRow(at: index)
            }
            self.processModifyingFavoriteStatus(status: status)
        }
    }
}
