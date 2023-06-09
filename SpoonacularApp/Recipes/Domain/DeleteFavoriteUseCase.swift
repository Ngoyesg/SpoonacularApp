//
//  DeleteFavoriteUseCase.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 30/03/23.
//

import Foundation

protocol DeleteFavoriteUseCaseProtocol: AnyObject {
    func delete(_ recipeWithImageData: RecipeToDisplay, completion: @escaping((DBManagerResultStatus?, DBManagerError?) -> Void))
    func deleteAll(completion: @escaping((DBManagerResultStatus?, DBManagerError?) -> Void)) 
}

class DeleteFavoriteUseCase {
    
    private let dbManagerDeleteService: DBDeleteManagerProtocol

    init(dbManagerDeleteService: DBDeleteManagerProtocol) {
        self.dbManagerDeleteService = dbManagerDeleteService
    }
    
    func mapRecipeToFavorite(_ recipe: RecipeToDisplay) -> FavoriteRecipe {
        FavoriteRecipe(id: recipe.id, title: recipe.title ?? "", image: recipe.image)
    }
    
}

extension DeleteFavoriteUseCase: DeleteFavoriteUseCaseProtocol {
 
    func delete(_ recipeWithImageData: RecipeToDisplay, completion: @escaping((DBManagerResultStatus?, DBManagerError?) -> Void)) {
        
        let favoriteRecipe = mapRecipeToFavorite(recipeWithImageData)
        
        do {
            try dbManagerDeleteService.delete(recipe: favoriteRecipe)
            completion(.success, nil)
        } catch {
            completion(.failure, .unableToAddObject)
        }
    }
    
    func deleteAll(completion: @escaping((DBManagerResultStatus?, DBManagerError?) -> Void)) {
        
        do {
            try dbManagerDeleteService.deleteAll()
            completion(.success, nil)
        } catch {
            completion(.failure, .unableToAddObject)
        }
    }
        
}
