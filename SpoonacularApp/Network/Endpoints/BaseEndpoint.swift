//
//  BaseEndpoint.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 23/03/23.
//

import Foundation
import Alamofire

enum ContentType {
    case json, image
}

class BaseEndpoint {
    
    private var scheme: String = "https"
    private var host: String
    private var path: String
    private var queryItems: [URLQueryItem]
    private var httpMethod: HTTPMethod
    private let authKey = URLQueryItem(name: "apiKey", value: Constants.apiKey)
    private let contentType: ContentType
    
    init(path: String, contentType: ContentType, host: String = "api.spoonacular.com", queryItems: [URLQueryItem] = [], httpMethod: HTTPMethod = .get) {
        self.host = host
        self.path = path
        self.queryItems = [authKey]
        self.queryItems += queryItems
        self.httpMethod = httpMethod
        self.contentType = contentType
    }
    
    func getURL() throws -> URL {
        var components = URLComponents()
        components.scheme = self.scheme
        components.host = self.host
        components.path = self.path
        components.queryItems = self.queryItems
        
        guard let url = components.url else {
            throw EndpointError.invalidURL
        }
        return url
    }
    
    func getHTTPMethod() -> HTTPMethod {
        httpMethod
    }
    
    func getHeaders() -> HTTPHeaders {
        switch contentType {
        case .image:
            return ContentTypeHeaders.image
        case .json:
            return ContentTypeHeaders.json
        }
    }
}
