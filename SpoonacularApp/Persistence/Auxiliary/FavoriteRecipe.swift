//
//  FavoriteRecipe.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 28/03/23.
//

import Foundation
import RealmSwift

struct FavoriteRecipe {
    var id        : Int?    = nil
    var title     : String? = nil
    var image     : String? = nil
}

extension FavoriteRecipe: Persistable {
    typealias ManagedObject = FavoriteRecipeObject
    
    public init(managedObject: FavoriteRecipeObject) {
        id = managedObject.id
        title = managedObject.title
        image = managedObject.image
    }
    
    public func managedObject() -> FavoriteRecipeObject {
        let favoriteRecipeObject = FavoriteRecipeObject()
        favoriteRecipeObject.id = id
        favoriteRecipeObject.title = title
        favoriteRecipeObject.image = image
        return favoriteRecipeObject
    }
}
