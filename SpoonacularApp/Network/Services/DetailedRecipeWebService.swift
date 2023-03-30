//
//  DetailedRecipeWebService.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 29/03/23.
//

import Foundation

class DetailedRecipeWebService: WebService<DetailedRecipeAPI, DetailedRecipeEndpoint> {
    
    let converter: DetailedRecipeAPIToModelMapProtocol
    
    init(converter: DetailedRecipeAPIToModelMapProtocol) {
        self.converter = converter
    }
    
    func getDetails(for id: Int, with nutrition: Bool, completion: @escaping (DetailedRecipeModel?, WebServiceError?)-> Void) {
        
        guard let endpoint = try? DetailedRecipeEndpoint(recipeID: id, includeNutrition: nutrition) else {
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
