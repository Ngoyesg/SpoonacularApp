//
//  FilteredRecipesEndpoint.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 23/03/23.
//

import Foundation

class FilteredRecipesEndpoint: BaseEndpoint {
    
    struct Constants {

        struct Keys {
            static let path = "/food/products/search"
            static let queryKey = "query"
        }
        
    }
        
    init(search keywords: String) throws {
        guard keywords != "" else {
            throw EndpointError.emptySearch
        }
        let queryItem =  URLQueryItem(name: Constants.Keys.queryKey, value: String(describing: keywords))
        super.init(path: Constants.Keys.path, contentType: .json, queryItems: [queryItem], httpMethod: .get)
    }
    
}
