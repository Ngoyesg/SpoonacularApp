//
//  ImageWebService.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 29/03/23.
//

import Foundation

class ImageWebService: WebService<Data, ImageRecipeEndpoint> {
    
    
    
    func getImage(for imageURL: String, completion: @escaping (Data?, WebServiceError?)-> Void) {
        
        guard let endpoint = try? ImageRecipeEndpoint(imagePath: imageURL) else {
            fatalError()
        }
        
        makeRequest(endpoint: endpoint) { [weak self] results, error in
            
            guard let self = self else {
                completion(nil, .unexpectedError)
                return
            }
            
            if let results = results {
                completion(results, nil)
                return
            }
            
            if error != nil {
                completion(nil, .unexpectedError)
                return
            }
        }
    }
}
