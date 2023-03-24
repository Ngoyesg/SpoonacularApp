//
//  WebService.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 23/03/23.
//

import Alamofire
import Foundation


struct Resource<T> {
    let url: URL
    var httpMethod: HTTPMethod
    var httpHeaders: HTTPHeaders
    let parse: (Data) -> T?
}

final class WebService {
    
    func load<T>(resource: Resource<T>, completion: @escaping (T?)-> ()) {
        
        AF.request(resource.url, method: resource.httpMethod, parameters: nil, encoding: URLEncoding.default, headers: resource.httpHeaders, interceptor: nil).response {
            
            response in
            
            switch response.result {
            case .success(let data):
                DispatchQueue.main.async {
                    completion(resource.parse(data!))
                }
            case .failure(_):
                completion(nil)
            }
            
        }
    }
}
