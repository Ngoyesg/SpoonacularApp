//
//  FilteredRecipesWebService.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 29/03/23.
//

import Foundation

class FilteredRecipesWebService {
    
    let webService: WebService
    let endpointBuilder: FilteredRecipesEndpoint
    
    init(webService: WebService, endpointBuilder: FilteredRecipesEndpoint) {
        self.webService = webService
        self.endpointBuilder = endpointBuilder
    }
    
    func getAllRecipes(completionHandler: @escaping (FilteredRecipesModel?, WebServiceError?)-> Void) {
        
        guard let url = try? endpointBuilder.getURL() else {
            completionHandler(nil, WebServiceError.buildingEndpointFailed)
            return
        }
    
        let filteredRecipesResource = Resource<FilteredRecipesAPI>(url: url, httpMethod: .get, httpHeaders: ContentTypeHeaders.json) { data in
            let filteredRecipesResource = try? JSONDecoder().decode(FilteredRecipesAPI.self, from: data)
            return filteredRecipesResource
        }
        
        webService.load(resource: filteredRecipesResource) { result in
            if let result = result {
                let viewModel = FilteredRecipesModel(webResponse: result)
                completionHandler(viewModel, nil)
            }
        }
        
    }
}
