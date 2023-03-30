//
//  GetRecipesWebService.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 29/03/23.
//

import Foundation

class GetRecipesWebService: WebService<AllRecipesAPI, AllRecipesEndpoint> {
    
    let converter: AllRecipesAPIToModelMapProtocol
    
    init(converter: AllRecipesAPIToModelMapProtocol) {
        self.converter = converter
    }
    
    
    func getAllRecipes(from offset: Int, to number: Int, completion: @escaping (AllRecipesModel?, WebServiceError?)-> Void){
        
        guard let endpoint = try? AllRecipesEndpoint(offset: offset, number: number) else {
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
