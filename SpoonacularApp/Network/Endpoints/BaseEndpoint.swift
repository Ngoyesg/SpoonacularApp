//
//  BaseEndpoint.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 23/03/23.
//

import Foundation
import Alamofire

class BaseEndpoint {
    
    private var scheme: String = "https"
    private var host: String = "api.spoonacular.com"
    private var path: String
    private var queryItems: [URLQueryItem]
    private var httpMethod: HTTPMethod = .get
    private let authKey = URLQueryItem(name: "apiKey", value: Constants.apiKey)
    
    init(path: String, queryItems: [URLQueryItem] = [], httpMethod: HTTPMethod) {
        self.path = path
        self.queryItems = queryItems
        self.httpMethod = httpMethod
        self.queryItems.append(authKey)
    }
    
    init(with url: String) {
        let components = URLComponents()
        let urlToDecompose = URL(string: url)
        self.path = components.url(relativeTo: urlToDecompose)!.path
        self.queryItems = [authKey]
        self.httpMethod = .get
    }
        
    func getURL() -> URL? {
        var components = URLComponents()
        components.scheme = self.scheme
        components.host = self.host
        components.path = self.path
        components.queryItems = self.queryItems
        return components.url
    }
}
