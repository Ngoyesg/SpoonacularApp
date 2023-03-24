//
//  AllRecipesEndpoint.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 23/03/23.
//

import Foundation

class AllRecipesSearch: BaseEndpoint {
    
    struct Constants {
        static let allRecipesPath = "/recipes/complexSearch"
    }
    
    init(){
        super.init(path: Constants.allRecipesPath, httpMethod: .get)
    }
    
}
