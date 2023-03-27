//
//  ImageRecipeEndpoint.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 23/03/23.
//

import Foundation

class ImageRecipeEndpoint: BaseEndpoint {

    let decomposer: URLDecomposerProtocol?
    
    init(imagePath: String, decomposer: URLDecomposerProtocol) throws {
        
        self.decomposer = decomposer
        
        if let urlDecomposed = try? decomposer.extract(from: imagePath) {
            super.init(host: urlDecomposed.host, path: urlDecomposed.path)
        } else {
            throw EndpointError.invalidURL
        }
    }
    
}
