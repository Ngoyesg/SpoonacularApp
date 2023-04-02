//
//  DBSubsystem.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 1/04/23.
//

import Foundation

protocol DBFacadeProtocol: AnyObject {
    func saveFavorite(recipe: RecipeToDisplay, completion: @escaping (DBManagerResultStatus) -> Void)
    func deleteFavoriteRecipe(recipe: RecipeToDisplay, completion: @escaping (DBManagerResultStatus) -> Void)
}

class DBFacade {
    
    private let saveFavoriteUseCase: SaveFavoriteUseCaseProtocol
    private let deleteFavoriteUseCase: DeleteFavoriteUseCase
    
    init(saveFavoriteUseCase: SaveFavoriteUseCaseProtocol, deleteFavoriteUseCase: DeleteFavoriteUseCase) {
        self.saveFavoriteUseCase = saveFavoriteUseCase
        self.deleteFavoriteUseCase = deleteFavoriteUseCase
    }
    
}
    
extension DBFacade: DBFacadeProtocol {
    
    func saveFavorite(recipe: RecipeToDisplay, completion: @escaping (DBManagerResultStatus) -> Void){
        saveFavoriteUseCase.save(recipe) { success, error in
            if error != nil {
                completion(.failure)
                return
            }
            completion(.success)
        }
    }
    
    func deleteFavoriteRecipe(recipe: RecipeToDisplay, completion: @escaping (DBManagerResultStatus) -> Void){
        deleteFavoriteUseCase.delete(recipe) { success, error in
            if error != nil {
                completion(.failure)
                return
            }
            completion(.success)
        }
    }
}
