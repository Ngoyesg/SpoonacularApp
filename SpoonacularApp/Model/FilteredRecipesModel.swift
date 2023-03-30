//
//  FilteredRecipes.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 28/03/23.
//

import Foundation

class FilteredRecipesModel {
    
    let webResponse: FilteredRecipesAPI
    
    init(webResponse: FilteredRecipesAPI) {
        self.webResponse = webResponse
    }
    
    var type: String? {
        webResponse.type
    }
    
    var recipes: [Recipe]? {
        webResponse.resultstoObject
    }
    
    var offset: Int? {
        webResponse.offset
    }
    
    var number: Int? {
        webResponse.number
    }
    
    var totalProducts: Int? {
        webResponse.totalProducts
    }
    
}


