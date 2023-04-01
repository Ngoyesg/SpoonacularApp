//
//  RecipesToRecipesWithImages.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 30/03/23.
//

import Foundation

protocol RecipesToRecipesWithImagesProtocol: AnyObject {
    func mapWithImageData(from recipe: Recipe, and thumbnail: Data?) -> RecipeWithImageModel
}

class RecipesToRecipesWithImages: RecipesToRecipesWithImagesProtocol {
    
    func mapWithImageData(from recipe: Recipe, and thumbnail: Data?) -> RecipeWithImageModel {
        RecipeWithImageModel(id: recipe.id, title: recipe.title, image: thumbnail)
    }
    
}
