//
//  DetailedRecipe.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 28/03/23.
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
    var nutrition                : Calories?             = Calories()
    var instructions             : String?                = nil
}

struct Calories {
    
    var composition : CaloricBreakdown? = CaloricBreakdown()
    
    enum CodingKeys: String, CodingKey {
        case composition = "caloricBreakdown"
    }
}

struct CaloricBreakdown {

  var percentProtein : Double? = nil
  var percentFat     : Double? = nil
  var percentCarbs   : Double? = nil

}



