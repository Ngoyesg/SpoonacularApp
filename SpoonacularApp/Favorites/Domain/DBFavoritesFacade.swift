//
//  DBFavoritesFacade.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 1/04/23.
//

import Foundation

protocol DBFavoritesFacadeProtocol: AnyObject {
    func listAll(completion: @escaping(([RecipeToDisplay]?, DBManagerError?) -> Void))
    func delete(_ recipeWithImageData: RecipeToDisplay, completion: @escaping((DBManagerResultStatus?, DBManagerError?) -> Void))
    func deleteAll(completion: @escaping((DBManagerResultStatus?, DBManagerError?) -> Void))
}

class DBFavoritesFacade {
    
    private let listFavoriteUseCase: ListFavoritesUseCaseProtocol
    private let deleteFavoriteUseCase: DeleteFavoriteUseCase
    
    init(listFavoriteUseCase: ListFavoritesUseCaseProtocol, deleteFavoriteUseCase: DeleteFavoriteUseCase) {
        self.listFavoriteUseCase = listFavoriteUseCase
        self.deleteFavoriteUseCase = deleteFavoriteUseCase
    }
    
}
    
extension DBFavoritesFacade: DBFavoritesFacadeProtocol {
    
    
    func listAll(completion: @escaping (([RecipeToDisplay]?, DBManagerError?) -> Void)) {
        listFavoriteUseCase.listAll { recipes, error in
            if error != nil {
                completion(nil, .unableToDeleteObject)
                return
            }
            completion(recipes, nil)
        }
    }
    
    
    func delete(_ recipeWithImageData: RecipeToDisplay, completion: @escaping ((DBManagerResultStatus?, DBManagerError?) -> Void)) {
        deleteFavoriteUseCase.delete(recipeWithImageData) { success, error in
            if error != nil {
                completion(.failure, .unableToDeleteObject)
                return
            }
            completion(.success, nil)
        }
    }
    
    func deleteAll(completion: @escaping ((DBManagerResultStatus?, DBManagerError?) -> Void)) {
        deleteFavoriteUseCase.deleteAll { success, error in
            if error != nil {
                completion(.failure, .unableToDeleteObject)
                return
            }
            completion(.success, nil)
        }
    }
    
}
