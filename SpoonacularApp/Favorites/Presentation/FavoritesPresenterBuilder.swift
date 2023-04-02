//
//  FavoritesPresenterBuilder.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 30/03/23.
//

import Foundation

class FavoritesPresenterBuilder {
    
    func build() -> FavoritesPresenter {
        
        let dbManagerListService = DBListManager()
        
        let listFavoriteUseCase = ListFavoritesUseCase(dbManagerListService: dbManagerListService)
        
        let converter = FavoriteRecipeToObject()
        
        let dbManagerDeleteService = DBDeleteManager(converter: converter)
        
        let deleteFavoriteUseCase = DeleteFavoriteUseCase(dbManagerDeleteService: dbManagerDeleteService)
        
        let dbFavoritesFacade = DBFavoritesFacade(listFavoriteUseCase: listFavoriteUseCase, deleteFavoriteUseCase: deleteFavoriteUseCase)
        
        return FavoritesPresenter(dbFavoritesFacade: dbFavoritesFacade)
    }
    
}
