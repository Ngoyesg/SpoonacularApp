//
//  RecipesPresenter.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 30/03/23.
//

import Foundation

protocol RecipesPresenterProtocol: AnyObject {
    func setController(_ viewController: RecipesViewControllerProtocol?)
}

class RecipesPresenter {
    
    weak var controller: RecipesViewControllerProtocol?
    
    var filteringUseCase: FilteringUseCaseProtocol
    var recipesRetrieverUseCase: RecipesRetrieverUseCaseProtocol
    var saveFavoriteUseCase: SaveFavoriteUseCaseProtocol
    var deleteFavoriteUseCase: DeleteFavoriteUseCase
    
    var headDownloadedElements = 0
    var isFetchingData: Bool = false
    var recipesToDisplay: [RecipeWithImageModel] = []

    
    init(filteringUseCase: FilteringUseCaseProtocol, recipesRetrieverUseCase: RecipesRetrieverUseCaseProtocol, saveFavoriteUseCase: SaveFavoriteUseCaseProtocol, deleteFavoriteUseCase: DeleteFavoriteUseCase) {
        self.filteringUseCase = filteringUseCase
        self.recipesRetrieverUseCase = recipesRetrieverUseCase
        self.saveFavoriteUseCase = saveFavoriteUseCase
        self.deleteFavoriteUseCase = deleteFavoriteUseCase
    }
    
}

extension RecipesPresenter: RecipesPresenterProtocol {
    
    func setController(_ viewController: RecipesViewControllerProtocol?) {
        self.controller = viewController
    }
    
    func restartFetchingHistory() {
       headDownloadedElements = 0
       recipesToDisplay = []
    }
    
    func processDownloadFailed(){
     // controller alert failure
    }
    
    func updateHeadDownloadedElements(information: AllRecipesModel){
        if let number = information.number {
            headDownloadedElements = number
        } else {
            let totalResults =  information.recipes?.count ?? 0
            let newHead = headDownloadedElements + totalResults
        }
    }
    
    func updateRecipesToDisplay(recipes: [RecipeWithImageModel]) {
        recipesToDisplay += recipes
    }
    
    
    func processDownloadSucceded(information: AllRecipesModel, recipes: [RecipeWithImageModel]) {
        updateHeadDownloadedElements(information: information)
        updateRecipesToDisplay(recipes: recipes)
       

        // controller reload table
    }
    
    func processSavingStatus(status: DBManagerResultStatus){
        // controller alert saving status
    }
    
    func processDeletingStatus(status: DBManagerResultStatus){
        // controller alert deleting status
    }
    
    
    func getUnfilteredRecipes() {
        isFetchingData = true
        
        recipesRetrieverUseCase.getRecipesToDisplay(from: headDownloadedElements, to: headDownloadedElements + Constants.recipesPerDownload) { [weak self] allInfo, recipesToDisplay, error in
            guard let self = self else {
                self?.isFetchingData = false
                self?.processDownloadFailed()
                return
            }
            
            if error != nil {
                self.isFetchingData = false
                self.processDownloadFailed()
                return
            }
            
            if let allInfo = allInfo, let recipesToDisplay = recipesToDisplay {
                self.isFetchingData = false
                self.processDownloadSucceded(information: allInfo, recipes: recipesToDisplay)
                return
            }
        }
    }
    
    func getFilteredRecipes(search keyword: String) {
        
        isFetchingData = true
        restartFetchingHistory()
        
        filteringUseCase.getRecipesToDisplay(search: keyword) { [weak self] allInfo, recipesToDisplay, error in
            guard let self = self else {
                self?.isFetchingData = false
                self?.processDownloadFailed()
                return
            }
            
            if error != nil {
                self.isFetchingData = false
                self.processDownloadFailed()
                return
            }
            
            if let allInfo = allInfo, let recipesToDisplay = recipesToDisplay {
                self.isFetchingData = false
                self.processDownloadSucceded(information: allInfo, recipes: recipesToDisplay)
                return
            }
        }
    }
    
    func saveFavorite(recipe: RecipeWithImageModel){
        saveFavoriteUseCase.save(recipe) { [weak self] success, error in
            guard let self = self else {
                self?.processSavingStatus(status: .failure)
                return
            }
            
            if error != nil {
                self.processSavingStatus(status: .failure)
                return
            }
            
            self.processSavingStatus(status: .success)
        }
    }
    
    func deleteFavoriteRecipe(recipe: RecipeWithImageModel){
        deleteFavoriteUseCase.delete(recipe) { [weak self] success, error in
            guard let self = self else {
                self?.processSavingStatus(status: .failure)
                return
            }
            
            if error != nil {
                self.processSavingStatus(status: .failure)
                return
            }
            
            self.processSavingStatus(status: .success)
        }
    }

}
