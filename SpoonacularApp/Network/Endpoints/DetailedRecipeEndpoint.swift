//
//  DetailedRecipeEndpoint.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 23/03/23.
//

import Foundation

class DetailedRecipeEndpoint: BaseEndpoint {
    
    struct Constants {
        
        struct Keys {
            static let includeNutrition = "includeNutrition"
        }
        
    }
    
    init(recipeID: Int, includeNutrition: Bool = false) throws {
        
        guard recipeID >= 0 else {
            throw EndpointError.invalidSearchID
        }
        
        let path = "/recipes/\(recipeID)/information"
        let queryItem = URLQueryItem(name: Constants.Keys.includeNutrition, value: String(includeNutrition))
        super.init(path: path, contentType: .json, queryItems: [queryItem], httpMethod: .get)
    }
    
}
