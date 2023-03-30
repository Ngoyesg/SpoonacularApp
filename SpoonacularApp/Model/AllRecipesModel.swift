//
//  AllRecipesModel.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 28/03/23.
//

import Foundation

class AllRecipesModel {
    
    let webResponse: AllRecipesAPI
    
    init(webResponse: AllRecipesAPI) {
        self.webResponse = webResponse
    }
    
    var recipes: [Recipe]? {
        return webResponse.resultstoObject
    }
    
    var offset: Int? {
        webResponse.offset
    }
    
    var number: Int? {
        webResponse.number
    }
    
    var totalResults: Int? {
        webResponse.totalResults
    }
    
}
