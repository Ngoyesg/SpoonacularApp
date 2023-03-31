//
//  DBGetManager.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 29/03/23.
//

import Foundation

protocol DBGetManagerProtocol: AnyObject {
    func getAll() throws -> [FavoriteRecipe]
}

class DBGetManager: DBManager, DBGetManagerProtocol {
    
    func getAll() throws -> [FavoriteRecipe] {
        let results = realm.objects(FavoriteRecipeObject.self).toArray(ofType: FavoriteRecipe.self)
        if results.count == 0 {
            throw DBManagerError.unableToRetriveData
        }
        return results
    }
}
 
