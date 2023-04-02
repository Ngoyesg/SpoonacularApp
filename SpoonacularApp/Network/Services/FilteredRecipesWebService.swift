//
//  FilteredRecipesWebService.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 29/03/23.
//

import Foundation

protocol FilteredRecipesWebServiceProtocol {
    func getFilteredRecipes(for keyword: String, completion: @escaping (AllRecipesModel?, WebServiceError?)-> Void)
}

class FilteredRecipesWebService: WebService<FilteredRecipesAPI, FilteredRecipesEndpoint>, FilteredRecipesWebServiceProtocol {
    
    let converter: FilteredRecipesAPIToModelMapProtocol
    
    init(converter: FilteredRecipesAPIToModelMapProtocol) {
        self.converter = converter
        super.init(responseDecoder: AnyResponseDecoder<FilteredRecipesAPI>())
    }
    
    func getFilteredRecipes(for keyword: String, completion: @escaping (AllRecipesModel?, WebServiceError?)-> Void) {
        
        guard let endpoint = try? FilteredRecipesEndpoint(search: keyword) else {
            completion(nil, .buildingEndpointFailed)
            return
        }
        
        makeRequest(endpoint: endpoint) { [weak self] results, error in
            
            guard let self = self else {
                completion(nil, .unexpectedError)
                return
            }
            
            if error != nil {
                completion(nil, .unexpectedError)
                return
            }
            
            if let results = results {
                let transformedData = self.converter.convert(results)
                completion(transformedData, nil)
                return
            }
        }
    }
}
