//
//  FilteredRecipesWebService.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 29/03/23.
//

import Foundation

class FilteredRecipesWebService: WebService<FilteredRecipesAPI, FilteredRecipesEndpoint> {
    
    let converter: FilteredRecipesAPIToModelMapProtocol
    
    init(converter: FilteredRecipesAPIToModelMapProtocol) {
        self.converter = converter
    }
    
    func getFilteredRecipes(for keyword: String, completion: @escaping (FilteredRecipesModel?, WebServiceError?)-> Void) {
        
        guard let endpoint = try? FilteredRecipesEndpoint(search: keyword) else {
            fatalError()
        }
        
        makeRequest(endpoint: endpoint) { [weak self] results, error in
            
            guard let self = self else {
                completion(nil, .unexpectedError)
                return
            }
            
            if let results = results {
                let transformedData = self.converter.convert(results)
                completion(transformedData, nil)
                return
            }
            
            if error != nil {
                completion(nil, .unexpectedError)
                return
            }
        }
    }
}
