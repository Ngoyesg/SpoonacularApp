//
//  DetailedRecipeModel.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 28/03/23.
//

import Foundation

class DetailedRecipeModel {
    
    let webResponse: DetailedRecipeAPI
    
    init(webResponse: DetailedRecipeAPI) {
        self.webResponse = webResponse
    }
    
    var nutrition: Nutrition? {
        webResponse.nutrition?.nutritionToObject
    }
    
    var vegetarian: Bool? {
        webResponse.vegetarian
    }
    
    var vegan: Bool? {
        webResponse.vegan
    }
    
    var glutenFree: Bool? {
        webResponse.glutenFree
    }
    
    var dairyFree: Bool? {
        webResponse.dairyFree
    }
    
    var preparationMinutes: Int? {
        webResponse.preparationMinutes
    }
    
    var cookingMinutes: Int? {
        webResponse.cookingMinutes
    }
    
    var id: Int? {
        webResponse.id
    }
    
    var title: String? {
        webResponse.title
    }
    
    var readyInMinutes: Int? {
        webResponse.readyInMinutes
    }
    
    var servings: Int? {
        webResponse.servings
    }
    
    var sourceUrl: String? {
        webResponse.sourceUrl
    }
    
    var image: String? {
        webResponse.image
    }
    
    var instructions: String? {
        webResponse.instructions
    }
    
    
}


