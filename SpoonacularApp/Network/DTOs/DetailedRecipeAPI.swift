//
//  DetailedRecipeAPI.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 28/03/23.
//

import Foundation

struct DetailedRecipeAPI: Codable {
    
    var vegetarian               : Bool?                  = nil
    var vegan                    : Bool?                  = nil
    var glutenFree               : Bool?                  = nil
    var dairyFree                : Bool?                  = nil
    var veryHealthy              : Bool?                  = nil
    var cheap                    : Bool?                  = nil
    var veryPopular              : Bool?                  = nil
    var sustainable              : Bool?                  = nil
    var lowFodmap                : Bool?                  = nil
    var weightWatcherSmartPoints : Int?                   = nil
    var gaps                     : String?                = nil
    var preparationMinutes       : Int?                   = nil
    var cookingMinutes           : Int?                   = nil
    var aggregateLikes           : Int?                   = nil
    var healthScore              : Int?                   = nil
    var creditsText              : String?                = nil
    var license                  : String?                = nil
    var sourceName               : String?                = nil
    var pricePerServing          : Double?                = nil
    var extendedIngredients      : [ExtendedIngredientsAPI]? = []
    var id                       : Int?                   = nil
    var title                    : String?                = nil
    var readyInMinutes           : Int?                   = nil
    var servings                 : Int?                   = nil
    var sourceUrl                : String?                = nil
    var image                    : String?                = nil
    var imageType                : String?                = nil
    var nutrition                : NutritionAPI?             = NutritionAPI()
    var summary                  : String?                = nil
    var cuisines                 : [String]?              = []
    var dishTypes                : [String]?              = []
    var diets                    : [String]?              = []
    var occasions                : [String]?              = []
    var winePairing              : WinePairingAPI?           = WinePairingAPI()
    var instructions             : String?                = nil
    var analyzedInstructions     : [String]?              = []
    var originalId               : String?                = nil
    var spoonacularSourceUrl     : String?                = nil
    
    enum CodingKeys: String, CodingKey {
        
        case vegetarian               = "vegetarian"
        case vegan                    = "vegan"
        case glutenFree               = "glutenFree"
        case dairyFree                = "dairyFree"
        case veryHealthy              = "veryHealthy"
        case cheap                    = "cheap"
        case veryPopular              = "veryPopular"
        case sustainable              = "sustainable"
        case lowFodmap                = "lowFodmap"
        case weightWatcherSmartPoints = "weightWatcherSmartPoints"
        case gaps                     = "gaps"
        case preparationMinutes       = "preparationMinutes"
        case cookingMinutes           = "cookingMinutes"
        case aggregateLikes           = "aggregateLikes"
        case healthScore              = "healthScore"
        case creditsText              = "creditsText"
        case license                  = "license"
        case sourceName               = "sourceName"
        case pricePerServing          = "pricePerServing"
        case extendedIngredients      = "extendedIngredients"
        case id                       = "id"
        case title                    = "title"
        case readyInMinutes           = "readyInMinutes"
        case servings                 = "servings"
        case sourceUrl                = "sourceUrl"
        case image                    = "image"
        case imageType                = "imageType"
        case nutrition                = "nutrition"
        case summary                  = "summary"
        case cuisines                 = "cuisines"
        case dishTypes                = "dishTypes"
        case diets                    = "diets"
        case occasions                = "occasions"
        case winePairing              = "winePairing"
        case instructions             = "instructions"
        case analyzedInstructions     = "analyzedInstructions"
        case originalId               = "originalId"
        case spoonacularSourceUrl     = "spoonacularSourceUrl"
        
    }
    
    
}

extension DetailedRecipeAPI {
    
    private func toDTO(_ apiData: [RecipesAPI]) -> [Recipe] {
        apiData.map { eachRecipe in
            eachRecipe.toObject
        }
    }
    
    var toDTO: DetailedRecipe {
        DetailedRecipe(vegetarian: self.vegetarian, vegan: self.vegan, glutenFree: self.glutenFree, dairyFree: self.vegetarian, preparationMinutes: self.preparationMinutes, cookingMinutes: self.cookingMinutes, id: self.id, title: self.title, readyInMinutes: self.readyInMinutes, servings: self.servings, sourceUrl: self.sourceUrl, image: self.image, nutrition: self.nutrition?.nutritionToObject, instructions: self.instructions)
    }
}
