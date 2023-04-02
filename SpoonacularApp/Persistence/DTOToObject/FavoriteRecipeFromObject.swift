//
//  FavoriteRecipeFromObject.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 1/04/23.
//

import Foundation

protocol FavoriteRecipeFromObjectProtocol: AnyObject {
    func convert(_ input: FavoriteRecipeObject) -> FavoriteRecipe
}

class FavoriteRecipeFromObject: FavoriteRecipeFromObjectProtocol {
    func convert(_ input: FavoriteRecipeObject) -> FavoriteRecipe {
        FavoriteRecipe(id: input.id, title: input.title, image: input.image) 
    }
}
