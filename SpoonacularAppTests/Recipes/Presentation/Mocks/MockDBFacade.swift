//
//  MockDBFacade.swift
//  SpoonacularAppTests
//
//  Created by Natalia Goyes on 12/04/23.
//

import Foundation
@testable import SpoonacularApp

class MockDBFacade: DBFacadeProtocol {
    
    var successfulSave: Bool = false
    var successfulDelete: Bool = false
    
    func saveFavorite(recipe: SpoonacularApp.RecipeToDisplay, completion: @escaping (SpoonacularApp.DBManagerResultStatus) -> Void) {
        if successfulSave {
            completion(.success)
        } else {
            completion(.failure)
        }
    }
    
    func deleteFavoriteRecipe(recipe: SpoonacularApp.RecipeToDisplay, completion: @escaping (SpoonacularApp.DBManagerResultStatus) -> Void) {
        if successfulDelete {
            completion(.success)
        } else {
            completion(.failure)
        }
    }
    
    
   
}
