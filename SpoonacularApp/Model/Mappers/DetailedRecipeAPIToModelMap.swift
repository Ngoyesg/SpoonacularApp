//
//  DetailedRecipeAPIToModelMap.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 30/03/23.
//

import Foundation

protocol DetailedRecipeAPIToModelMapProtocol: AnyObject {
    func convert(_ input: DetailedRecipeAPI) -> DetailedRecipeModel
}

class DetailedRecipeAPIToModelMap: DetailedRecipeAPIToModelMapProtocol {
    func convert(_ input: DetailedRecipeAPI) -> DetailedRecipeModel {
        DetailedRecipeModel(nutrition: input.nutrition?.nutritionToObject, vegetarian: input.vegetarian, vegan: input.vegan, glutenFree: input.glutenFree, dairyFree: input.dairyFree, preparationMinutes: input.preparationMinutes, cookingMinutes: input.cookingMinutes, id: input.id, title: input.title, sourceUrl: input.sourceUrl, instructions: input.instructions)
    }
}
