//
//  MapDetailedRecipe.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 2/04/23.
//

import Foundation

protocol MapDetailedRecipeProtocol: AnyObject {
    func convert(_ input: DetailedRecipeModel) -> DetailedRecipe
}

class MapDetailedRecipe: MapDetailedRecipeProtocol {
    func convert(_ input: DetailedRecipeModel) -> DetailedRecipe {
        DetailedRecipe(vegetarian: input.vegetarian, vegan: input.vegan, glutenFree: input.glutenFree, dairyFree: input.dairyFree, preparationMinutes: input.preparationMinutes, cookingMinutes: input.cookingMinutes, id: input.id, title: input.title, readyInMinutes: input.readyInMinutes, servings: input.servings, sourceUrl: input.sourceUrl, nutrition: input.nutrition, instructions: input.instructions)
    }
}
