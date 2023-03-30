//
//  DetailedRecipeModel.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 28/03/23.
//

import Foundation


struct DetailedRecipeModel {
    
    var nutrition: Nutrition?
    
    var vegetarian: Bool?
    
    var vegan: Bool?
    
    var glutenFree: Bool?
    
    var dairyFree: Bool?
    
    var preparationMinutes: Int?
    
    var cookingMinutes: Int?
    
    var id: Int?
        
    var title: String?
    
    var sourceUrl: String?
    
    var image: String?
    
    var instructions: String?
    
}
