//
//  DBListManager.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 29/03/23.
//

import Foundation

protocol DBListManagerProtocol: AnyObject {
    func getAll() -> [FavoriteRecipe]
}

class DBListManager: DBManager, DBListManagerProtocol {
    
    let converter = FavoriteRecipeFromObject()
    
    func getAll() -> [FavoriteRecipe] {
        let realmObjects = realm.objects(FavoriteRecipeObject.self)
        let results = realmObjects.toArray()
        return results.map {
            converter.convert($0)
        }
    }
}
 
