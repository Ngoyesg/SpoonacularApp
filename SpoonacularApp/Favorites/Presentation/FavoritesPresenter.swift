//
//  FavoritesPresenter.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 30/03/23.
//

import Foundation

protocol FavoritesPresenterProtocol: AnyObject {
    func setController(_ viewController: FavoritesViewControllerProtocol?)
    func listAllRecipes()
    func getTotalOfRecipes() -> Int
    func getRecipeForRow(at row: Int) -> RecipeToDisplay
    func handleDeleteFromFavorites(at index: Int)
    func handleDeleteAll() 
}

class FavoritesPresenter {
    
    weak var controller: FavoritesViewControllerProtocol?
    
    private let dbFavoritesFacade: DBFavoritesFacadeProtocol
    
    init(dbFavoritesFacade: DBFavoritesFacadeProtocol) {
        self.dbFavoritesFacade = dbFavoritesFacade
    }
    
    var recipesToDisplay: [RecipeToDisplay] = []
    
    func processRecipesResponse(useCase: FavoritesUseCases, recipes: [RecipeToDisplay]) {
        self.controller?.stopSpinner()
        self.updateData(recipes: recipes)
        self.controller?.reloadTable()
        
        if (recipes.isEmpty) {
            controller?.enableEmptyState()
        } else {
            controller?.disableEmptyState()    
        }
    }
    
    func updateData(recipes: [RecipeToDisplay]){
        recipesToDisplay =  recipes
    }
    
    func processModifyingFavoriteStatus(useCase: FavoritesUseCases, status: DBManagerResultStatus){
        if let status = FavoritesUseCasesStatus(rawValue: status.rawValue) {
            DispatchQueue.main.async {
                self.controller?.alertProcessStatus(for: useCase, status: status)
            }
        }
    }
    
}

extension FavoritesPresenter: FavoritesPresenterProtocol {
    
    func setController(_ viewController: FavoritesViewControllerProtocol?) {
        self.controller = viewController
    }
    
    func getTotalOfRecipes() -> Int {
        recipesToDisplay.count
    }
    
    func getRecipeForRow(at row: Int) -> RecipeToDisplay {
        recipesToDisplay[row]
    }
    
    func listAllRecipes(){
        controller?.startSpinner()
        dbFavoritesFacade.listAll(completion: { [weak self] recipes in
            guard let self = self else {
                return
            }
            self.processRecipesResponse(useCase: .fetching, recipes: recipes)
        })
    }
    
    func handleDeleteFromFavorites(at index: Int) {
        let favoriteRecipe = recipesToDisplay[index]
        dbFavoritesFacade.delete(favoriteRecipe){ [weak self] status, error in
            guard let self = self else {
                return
            }
            if (status == .success) {
                self.recipesToDisplay.remove(at: index)
                self.controller?.removeRow(at: index)
            }
            self.processModifyingFavoriteStatus(useCase: .deleteOne, status: status ?? .failure)
        }
    }
    
    func handleDeleteAll() {
        dbFavoritesFacade.deleteAll { [weak self]  status, error in
            guard let self = self else {
                return
            }
            if (status == .success) {
                self.recipesToDisplay = []
                self.controller?.reloadTable()
            }
            self.processModifyingFavoriteStatus(useCase: .deleteAll, status: status ?? .failure)
        }
    }
    
    
    
}
