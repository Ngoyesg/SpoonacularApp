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
    var extendedIngredients      : [ExtendedIngredients]? = []
    var id                       : Int?                   = nil
    var title                    : String?                = nil
    var readyInMinutes           : Int?                   = nil
    var servings                 : Int?                   = nil
    var sourceUrl                : String?                = nil
    var image                    : String?                = nil
    var imageType                : String?                = nil
    var nutrition                : Nutrition?             = Nutrition()
    var summary                  : String?                = nil
    var cuisines                 : [String]?              = []
    var dishTypes                : [String]?              = []
    var diets                    : [String]?              = []
    var occasions                : [String]?              = []
    var winePairing              : WinePairing?           = WinePairing()
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
    
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        vegetarian               = try values.decodeIfPresent(Bool.self                  , forKey: .vegetarian               )
        vegan                    = try values.decodeIfPresent(Bool.self                  , forKey: .vegan                    )
        glutenFree               = try values.decodeIfPresent(Bool.self                  , forKey: .glutenFree               )
        dairyFree                = try values.decodeIfPresent(Bool.self                  , forKey: .dairyFree                )
        veryHealthy              = try values.decodeIfPresent(Bool.self                  , forKey: .veryHealthy              )
        cheap                    = try values.decodeIfPresent(Bool.self                  , forKey: .cheap                    )
        veryPopular              = try values.decodeIfPresent(Bool.self                  , forKey: .veryPopular              )
        sustainable              = try values.decodeIfPresent(Bool.self                  , forKey: .sustainable              )
        lowFodmap                = try values.decodeIfPresent(Bool.self                  , forKey: .lowFodmap                )
        weightWatcherSmartPoints = try values.decodeIfPresent(Int.self                   , forKey: .weightWatcherSmartPoints )
        gaps                     = try values.decodeIfPresent(String.self                , forKey: .gaps                     )
        preparationMinutes       = try values.decodeIfPresent(Int.self                   , forKey: .preparationMinutes       )
        cookingMinutes           = try values.decodeIfPresent(Int.self                   , forKey: .cookingMinutes           )
        aggregateLikes           = try values.decodeIfPresent(Int.self                   , forKey: .aggregateLikes           )
        healthScore              = try values.decodeIfPresent(Int.self                   , forKey: .healthScore              )
        creditsText              = try values.decodeIfPresent(String.self                , forKey: .creditsText              )
        license                  = try values.decodeIfPresent(String.self                , forKey: .license                  )
        sourceName               = try values.decodeIfPresent(String.self                , forKey: .sourceName               )
        pricePerServing          = try values.decodeIfPresent(Double.self                , forKey: .pricePerServing          )
        extendedIngredients      = try values.decodeIfPresent([ExtendedIngredients].self , forKey: .extendedIngredients      )
        id                       = try values.decodeIfPresent(Int.self                   , forKey: .id                       )
        title                    = try values.decodeIfPresent(String.self                , forKey: .title                    )
        readyInMinutes           = try values.decodeIfPresent(Int.self                   , forKey: .readyInMinutes           )
        servings                 = try values.decodeIfPresent(Int.self                   , forKey: .servings                 )
        sourceUrl                = try values.decodeIfPresent(String.self                , forKey: .sourceUrl                )
        image                    = try values.decodeIfPresent(String.self                , forKey: .image                    )
        imageType                = try values.decodeIfPresent(String.self                , forKey: .imageType                )
        nutrition                = try values.decodeIfPresent(Nutrition.self             , forKey: .nutrition                )
        summary                  = try values.decodeIfPresent(String.self                , forKey: .summary                  )
        cuisines                 = try values.decodeIfPresent([String].self              , forKey: .cuisines                 )
        dishTypes                = try values.decodeIfPresent([String].self              , forKey: .dishTypes                )
        diets                    = try values.decodeIfPresent([String].self              , forKey: .diets                    )
        occasions                = try values.decodeIfPresent([String].self              , forKey: .occasions                )
        winePairing              = try values.decodeIfPresent(WinePairing.self           , forKey: .winePairing              )
        instructions             = try values.decodeIfPresent(String.self                , forKey: .instructions             )
        analyzedInstructions     = try values.decodeIfPresent([String].self              , forKey: .analyzedInstructions     )
        originalId               = try values.decodeIfPresent(String.self                , forKey: .originalId               )
        spoonacularSourceUrl     = try values.decodeIfPresent(String.self                , forKey: .spoonacularSourceUrl     )
        
    }
    
    init() {
        
    }
    
}
