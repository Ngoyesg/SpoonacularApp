//
//  DBGetManager.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 1/04/23.
//

import Foundation

protocol DBGetManagerProtocol: AnyObject {
    func getById(id: Int) throws -> FavoriteRecipe
}

class DBGetManager: DBManager, DBGetManagerProtocol {
    
    let converter: FavoriteRecipeFromObjectProtocol
    init(converter: FavoriteRecipeFromObjectProtocol) {
        self.converter = converter
    }
    
    func getById(id: Int) throws -> FavoriteRecipe {
        do {
            guard let object = realm.objects(FavoriteRecipeObject.self).filter("id = %d", id).first else {
                throw DBManagerError.objectNotFound
            }
            let recipe = converter.convert(object)
            return recipe
        } catch {
            throw DBManagerError.unableToDeleteObject
        }
    }
}
