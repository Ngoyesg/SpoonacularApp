//
//  DBDeleteManager.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 29/03/23.
//

import Foundation

protocol DBDeleteManagerProtocol: AnyObject {
    func delete(recipe: FavoriteRecipe) throws
    func deleteAll() throws
}

class DBDeleteManager: DBManager, DBDeleteManagerProtocol {
    
    let converter: FavoriteRecipeToObjectProtocol
    
    init(converter: FavoriteRecipeToObjectProtocol) {
        self.converter = converter
    }
    
    func delete(recipe: FavoriteRecipe) throws {
        do {
            try realm.write{
                let object = converter.convert(recipe)
                let objectToDelete = realm.objects(FavoriteRecipeObject.self).filter("id = %@", object.id).first!
                realm.delete(objectToDelete)
            }
        } catch {
            throw DBManagerError.unableToDeleteObject
        }
    }
    
    func deleteAll() throws {
        do {
            try realm.write{
                realm.deleteAll()
            }
        } catch {
            throw DBManagerError.unableToDeleteData
        }
    }
}
