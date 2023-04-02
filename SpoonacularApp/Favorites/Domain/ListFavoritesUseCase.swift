//
//  ListFavoritesUseCase.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 1/04/23.
//

import Foundation

protocol ListFavoritesUseCaseProtocol: AnyObject {
    func listAll(completion: @escaping(([RecipeToDisplay]) -> Void))
}

class ListFavoritesUseCase {
    
    private let dbManagerListService: DBListManagerProtocol
    
    init(dbManagerListService: DBListManagerProtocol) {
        self.dbManagerListService = dbManagerListService
    }
    
    func mapFavoriteToRecipe(_ favorite: FavoriteRecipe) -> RecipeToDisplay {
        RecipeToDisplay(id: favorite.id, title: favorite.title, image: favorite.image, isFavorite: true)
    }
    
}
 
extension ListFavoritesUseCase: ListFavoritesUseCaseProtocol{
    
    func listAll(completion: @escaping(([RecipeToDisplay]) -> Void)) {
        let favorites = dbManagerListService.getAll()
        let recipes = favorites.map { favorite in
            mapFavoriteToRecipe(favorite)
        }
        completion(recipes)
    }
    
}
