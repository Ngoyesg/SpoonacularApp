//
//  DetailedRecipe.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 29/03/23.
//

import Foundation

struct DetailedRecipe {
    var vegetarian: Bool?
    var vegan: Bool?
    var glutenFree: Bool?
    var dairyFree: Bool?
    var preparationMinutes: Int?
    var cookingMinutes: Int?
    var id: Int?
    var title: String?
    var readyInMinutes: Int?
    var servings: Int?
    var sourceUrl: String?
    var image: String?
    var nutrition: Nutrition?
    var instructions: String?
}
