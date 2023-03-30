//
//  DetailedRecipeWebService.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 29/03/23.
//

import Foundation

class DetailedRecipeWebService {
    
    let webService: WebService
    let endpointBuilder: DetailedRecipeEndpoint
    
    init(webService: WebService, endpointBuilder: DetailedRecipeEndpoint) {
        self.webService = webService
        self.endpointBuilder = endpointBuilder
    }
    
    func getAllRecipes(completionHandler: @escaping (DetailedRecipeModel?, WebServiceError?)-> Void) {
        
        guard let url = try? endpointBuilder.getURL() else {
            completionHandler(nil, WebServiceError.buildingEndpointFailed)
            return
        }
    
        let detailedRecipeResource = Resource<DetailedRecipeAPI>(url: url, httpMethod: .get, httpHeaders: ContentTypeHeaders.json) { data in
            let detailedRecipeResource = try? JSONDecoder().decode(DetailedRecipeAPI.self, from: data)
            return detailedRecipeResource
        }
        
        webService.load(resource: detailedRecipeResource) { result in
            if let result = result {
                let viewModel = DetailedRecipeModel(webResponse: result)
                completionHandler(viewModel, nil)
            }
        }
        
    }
}
