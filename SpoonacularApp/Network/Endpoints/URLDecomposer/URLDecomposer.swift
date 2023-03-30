//
//  URLDecomposer.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 26/03/23.
//

import Foundation

protocol URLDecomposerProtocol: AnyObject {
    static func extract(from urlString: String) throws -> DecomposedURL
}

class URLDecomposer: URLDecomposerProtocol {
   
    static func extract(from urlString: String) throws -> DecomposedURL {
        let shared = URLComponents()
        let url = URL(string: urlString)
        let components = shared.url(relativeTo: url)
        let host = components?.host
        let path = components?.path
        
        guard let host = host, let path = path else {
            throw EndpointError.invalidURL
        }
        return DecomposedURL(host: host, path: path)
    }
}

