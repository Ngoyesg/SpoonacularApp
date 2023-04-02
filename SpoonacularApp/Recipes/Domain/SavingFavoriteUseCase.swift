//
//  SavingFavoriteUseCase.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 30/03/23.
//

import Foundation

protocol SaveFavoriteUseCaseProtocol: AnyObject {
    func save(_ recipeWithImageData: RecipeToDisplay, completion: @escaping((DBManagerResultStatus?, DBManagerError?) -> Void))
}

class SaveFavoriteUseCase {
    
    private let dbManagerAddService: DBAddManagerProtocol

    init(dbManagerAddService: DBAddManagerProtocol) {
        self.dbManagerAddService = dbManagerAddService
    }
    
    func mapRecipeToFavorite(_ recipe: RecipeToDisplay) -> FavoriteRecipe {
        FavoriteRecipe(id: recipe.id, title: recipe.title ?? "", image: recipe.image)
    }
    
}

extension SaveFavoriteUseCase: SaveFavoriteUseCaseProtocol {
 
    func save(_ recipeWithImageData: RecipeToDisplay, completion: @escaping((DBManagerResultStatus?, DBManagerError?) -> Void)) {
        
        let favoriteRecipe = mapRecipeToFavorite(recipeWithImageData)
        
        do {
            try dbManagerAddService.add(recipe: favoriteRecipe)
            completion(.success, nil)
        } catch {
            completion(.failure, .unableToAddObject)
        }
    }
    
}
