//
//  ImageWebService.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 29/03/23.
//

import Foundation

class ImageWebService {
    
    let webService: WebService
    let endpointBuilder: ImageRecipeEndpoint
    
    init(webService: WebService, endpointBuilder: ImageRecipeEndpoint) {
        self.webService = webService
        self.endpointBuilder = endpointBuilder
    }
    
    func getAllRecipes(completionHandler: @escaping (Data?, WebServiceError?)-> Void) {
        
        guard let url = try? endpointBuilder.getURL() else {
            completionHandler(nil, WebServiceError.buildingEndpointFailed)
            return
        }
    
        let imageResource = Resource<Data>(url: url, httpMethod: .get, httpHeaders: ContentTypeHeaders.json) { data in
            let imageResource = try? JSONDecoder().decode(Data.self, from: data)
            return imageResource
        }
        
        webService.load(resource: imageResource) { result in
            if let result = result {
                completionHandler(result, nil)
            }
        }
        
    }
}
