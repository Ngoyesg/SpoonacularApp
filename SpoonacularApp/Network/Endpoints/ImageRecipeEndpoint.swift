//
//  ImageRecipeEndpoint.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 23/03/23.
//

import Foundation

class ImageRecipeEndpoint: BaseEndpoint {
   
    init(imagePath: String) throws {
        if let urlDecomposed = try? URLDecomposer.extract(from: imagePath) {
            super.init(path: urlDecomposed.path, contentType: .image ,host: urlDecomposed.host)
        } else {
            throw EndpointError.invalidURL
        }
    }
    
}
