//
//  FavoriteRecipeToObject.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 30/03/23.
//

import Foundation

protocol FavoriteRecipeToObjectProtocol: AnyObject {
    func convert(_ input: FavoriteRecipe) -> FavoriteRecipeObject
}

class FavoriteRecipeToObject {
    func convert(_ input: FavoriteRecipe) -> FavoriteRecipeObject {
        let favoriteRecipeObject = FavoriteRecipeObject()
        favoriteRecipeObject.id = input.id
        favoriteRecipeObject.title = input.title
        favoriteRecipeObject.image = input.image
        return favoriteRecipeObject
    }
}
