//
//  DBAddManager.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 29/03/23.
//

import Foundation

protocol DBAddManagerProtocol: AnyObject {
    func add(recipe: FavoriteRecipe) throws
}

class DBAddManager: DBManager, DBAddManagerProtocol{
    
    let converter: FavoriteRecipeToObjectProtocol
    
    init(converter: FavoriteRecipeToObjectProtocol) {
        self.converter = converter
    }
    
    func add(recipe: FavoriteRecipe) throws{
        do {
            try realm.write{
                let object = converter.convert(recipe)
                realm.add(object)
            }
        } catch {
            throw DBManagerError.unableToAddObject
        }
    }
}
