//
//  GetRecipesWebService.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 29/03/23.
//

import Foundation

protocol GetRecipesWebServiceProtocol {
    func getAllRecipes(from offset: Int, to number: Int, completion: @escaping (AllRecipesModel?, WebServiceError?)-> Void)
}

class GetRecipesWebService: WebService<AllRecipesAPI, AllRecipesEndpoint>, GetRecipesWebServiceProtocol {
    
    let converter: AllRecipesAPIToModelMapProtocol
    
    init(converter: AllRecipesAPIToModelMapProtocol) {
        self.converter = converter
        super.init(responseDecoder: AnyResponseDecoder<AllRecipesAPI>())
    }
    
    func getAllRecipes(from offset: Int, to number: Int, completion: @escaping (AllRecipesModel?, WebServiceError?)-> Void){
        
        guard let endpoint = try? AllRecipesEndpoint(offset: offset, number: number) else {
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
