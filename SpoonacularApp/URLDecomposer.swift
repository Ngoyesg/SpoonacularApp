//
//  URLDecomposer.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 26/03/23.
//

import Foundation

protocol URLDecomposerProtocol: AnyObject {
    func extract(from urlString: String) throws -> DecomposedURL
}

class URLDecomposer {
    let shared = URLComponents()
}

extension URLDecomposer: URLDecomposerProtocol {
    
    func extract(from urlString: String) throws -> DecomposedURL {
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
