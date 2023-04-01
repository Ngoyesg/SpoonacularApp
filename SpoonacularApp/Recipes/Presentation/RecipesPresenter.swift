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
    func loadMore()
}

class RecipesPresenter {
    
    weak var controller: RecipesViewControllerProtocol?
    
    var filteringUseCase: FilteringUseCaseProtocol
    var recipesRetrieverUseCase: RecipesRetrieverUseCaseProtocol
    var saveFavoriteUseCase: SaveFavoriteUseCaseProtocol
    var deleteFavoriteUseCase: DeleteFavoriteUseCase
    var mapperRecipesToDisplay: MapRecipeToDisplayProtocol
    
    var headDownloadedElements = 0
    var isFetchingAllData: Bool = false
    var lastKeywordSearched: String?
    var recipesToDisplay: [RecipeToDisplay] = []

    
    init(filteringUseCase: FilteringUseCaseProtocol, recipesRetrieverUseCase: RecipesRetrieverUseCaseProtocol, saveFavoriteUseCase: SaveFavoriteUseCaseProtocol, deleteFavoriteUseCase: DeleteFavoriteUseCase, mapperRecipesToDisplay: MapRecipeToDisplayProtocol) {
        self.filteringUseCase = filteringUseCase
        self.recipesRetrieverUseCase = recipesRetrieverUseCase
        self.saveFavoriteUseCase = saveFavoriteUseCase
        self.deleteFavoriteUseCase = deleteFavoriteUseCase
        self.mapperRecipesToDisplay = mapperRecipesToDisplay
    }
 
    
    func getUnfilteredRecipes() {
        isFetchingAllData = true

        recipesRetrieverUseCase.getRecipesToDisplay(from: headDownloadedElements, to: headDownloadedElements + Constants.recipesPerDownload) { [weak self] allInfo, recipesToDisplay, error in
            guard let self = self else {
                self?.processDownloadFailed()
                return
            }

            if error != nil {
                self.processDownloadFailed()
                return
            }

            if let allInfo = allInfo, let recipesToDisplay = recipesToDisplay {
                self.processDownloadSucceded(information: allInfo, recipes: recipesToDisplay)
                return
            }
        }
    }

    func getFilteredRecipes(search keyword: String) {
        
        isFetchingAllData = false
        lastKeywordSearched = keyword
        
        filteringUseCase.getRecipesToDisplay(search: keyword) { [weak self] allInfo, recipesToDisplay, error in
            guard let self = self else {
                self?.processDownloadFailed()
                return
            }
            
            if error != nil {
                self.processDownloadFailed()
                return
            }
            
            if let allInfo = allInfo, let recipesToDisplay = recipesToDisplay {
                self.processDownloadSucceded(information: allInfo, recipes: recipesToDisplay)
                return
            }
        }
    }
    
    func saveFavorite(recipe: RecipeToDisplay){
        saveFavoriteUseCase.save(recipe) { [weak self] success, error in
            guard let self = self else {
                self?.processModifyingFavoriteStatus(status: .failure)
                return
            }
            
            if error != nil {
                self.processModifyingFavoriteStatus(status: .failure)
                return
            }
            
            self.processModifyingFavoriteStatus(status: .success)
        }
    }
    
    func deleteFavoriteRecipe(recipe: RecipeToDisplay){
        deleteFavoriteUseCase.delete(recipe) { [weak self] success, error in
            guard let self = self else {
                self?.processModifyingFavoriteStatus(status: .failure)
                return
            }
            
            if error != nil {
                self.processModifyingFavoriteStatus(status: .failure)
                return
            }
            
            self.processModifyingFavoriteStatus(status: .success)
        }
    }
    
    func restartFetchingHistory() {
       headDownloadedElements = 0
       recipesToDisplay = []
    }
        
    func updateHeadDownloadedElements(information: AllRecipesModel){
        if let number = information.number {
            headDownloadedElements = number
        } else {
            let totalResults =  information.recipes?.count ?? 0
            headDownloadedElements += totalResults
        }
    }
    
    func updateRecipesToDisplay(recipes: [RecipeWithImageModel]) {
        let transformed = recipes.map { mapperRecipesToDisplay.convert($0)}
        recipesToDisplay += transformed
    }
    
    
    func processDownloadFailed(){
        DispatchQueue.main.async {
            self.controller?.stopSpinner()
            self.controller?.alertProcessStatus(for: .downloading, status: .failure)
        }
    }
    
    func processDownloadSucceded(information: AllRecipesModel, recipes: [RecipeWithImageModel]) {
        DispatchQueue.main.async {
            self.updateHeadDownloadedElements(information: information)
            self.updateRecipesToDisplay(recipes: recipes)
            self.controller?.stopSpinner()
            self.controller?.reloadTable()
        }
    }
    
    func processModifyingFavoriteStatus(status: DBManagerResultStatus){
        if let status = RecipesUseCaseStatus(rawValue: status.rawValue) {
            DispatchQueue.main.async {
                self.controller?.alertProcessStatus(for: .modifying, status: status)
            }
        }
    }
    
    
    func clearDataAndReloadTable(){
        restartFetchingHistory()
        controller?.reloadTable()
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
        recipesToDisplay[index].updateRecipeFavoriteStatus(status: true)

    }
    
    func procesOnSearchFilteredRecipeTapped(with keywords: String?) {
        DispatchQueue.main.async {
            self.clearDataAndReloadTable()
            self.controller?.startSpinner()
        }
        
        if let keywords = keywords {
            getFilteredRecipes(search: keywords)
        }
    }
    
    func fetchAllRecipes() {
        controller?.startSpinner()
        //getUnfilteredRecipes()
    }
    
    func loadMore() {
        if isFetchingAllData {
            //getUnfilteredRecipes()
        } else if let lastKeyword = lastKeywordSearched {
            getFilteredRecipes(search: lastKeyword)
        }
    }
    
}
