//
//  GetRecipesWebService.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 29/03/23.
//

import Foundation

class GetRecipesWebService {
    
    let webService: WebService
    let endpointBuilder: AllRecipesEndpoint
    
    init(webService: WebService, endpointBuilder: AllRecipesEndpoint) {
        self.webService = webService
        self.endpointBuilder = endpointBuilder
    }
    
    func getAllRecipes(completionHandler: @escaping (AllRecipesModel?, WebServiceError?)-> Void) {
        
        guard let url = try? endpointBuilder.getURL() else {
            completionHandler(nil, WebServiceError.buildingEndpointFailed)
            return
        }
    
        let allRecipesResource = Resource<AllRecipesAPI>(url: url, httpMethod: .get, httpHeaders: ContentTypeHeaders.json) { data in
            let allRecipesResource = try? JSONDecoder().decode(AllRecipesAPI.self, from: data)
            return allRecipesResource
        }
        
        webService.load(resource: allRecipesResource) { result in
            if let result = result {
                let viewModel = AllRecipesModel(webResponse: result)
                completionHandler(viewModel, nil)
            }
        }
        
    }
}
