//
//  AllRecipesEndpoint.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 23/03/23.
//

import Foundation

class AllRecipesEndpoint: BaseEndpoint {
    
    struct Constants {
        static let allRecipesPath = "/recipes/complexSearch"
      
        struct Keys {
            static let offsetKey = "offset"
            static let maximumNumberKey = "number"
        }
    }
    
    init(offset: Int, number: Int) throws {
        
        guard offset >= 0, number >= 0 else {
            throw EndpointError.invalidSearchBoundaries
        }
        
        let offset = URLQueryItem(name: Constants.Keys.offsetKey, value: String(offset))
        let maxNumber = URLQueryItem(name: Constants.Keys.maximumNumberKey, value: String(number))
        let queryItems = [offset, maxNumber]
        super.init(path: Constants.allRecipesPath, contentType: .json, queryItems: queryItems)
    }
    
}
