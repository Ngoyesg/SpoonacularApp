//
//  FilteredRecipeEndpoint.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 23/03/23.
//

import Foundation

class FilteredRecipeEndpoint: BaseEndpoint {
    
    struct Constants {

        struct Keys {
            static let path = "/food/products/search"
            static let queryKey = "query"
        }
        
    }
        
    init(search keywords: String){
        let queryItem =  URLQueryItem(name: Constants.Keys.queryKey, value: keywords.escaped())
        super.init(path: Constants.Keys.path, queryItems: [queryItem], httpMethod: .get)
    }
    
}