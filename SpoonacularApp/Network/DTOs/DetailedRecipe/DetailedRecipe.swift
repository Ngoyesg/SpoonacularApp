//
//  DetailedRecipe.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 29/03/23.
//

import Foundation

struct DetailedRecipe {
    var vegetarian               : Bool?                  = nil
    var vegan                    : Bool?                  = nil
    var glutenFree               : Bool?                  = nil
    var dairyFree                : Bool?                  = nil
    var preparationMinutes       : Int?                   = nil
    var cookingMinutes           : Int?                   = nil
    var id                       : Int?                   = nil
    var title                    : String?                = nil
    var readyInMinutes           : Int?                   = nil
    var servings                 : Int?                   = nil
    var sourceUrl                : String?                = nil
    var image                    : String?                = nil
    var nutrition                : Nutrition?             = Nutrition()
    var instructions             : String?                = nil
}
