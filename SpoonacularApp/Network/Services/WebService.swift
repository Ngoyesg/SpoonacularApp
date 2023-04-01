//
//  WebService.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 23/03/23.
//

import Alamofire
import Foundation

struct ContentTypeHeaders {
    static let json: HTTPHeaders = HTTPHeaders(arrayLiteral: HTTPHeader(name: "content-type", value: "application/json"))
    static let image: HTTPHeaders = HTTPHeaders(arrayLiteral: HTTPHeader(name: "content-type", value: "multipart/form-data"))
}

enum WebServiceError: Error {
    case unableToFetchData, buildingEndpointFailed, unexpectedResponseFormat, emptyResponse, unexpectedError
}

class WebService<ReturnType: Decodable, Endpoint: BaseEndpoint> {
    
    private let manager: Session
        
    init(manager: Session = Session.default) {
        self.manager = manager
    }
    
    func makeRequest(endpoint: Endpoint, completion: @escaping (ReturnType?, WebServiceError?)-> Void) {
        guard let url = try? endpoint.getURL() else {
            completion(nil, .buildingEndpointFailed)
            return
        }
        
        manager.request(url, method: endpoint.getHTTPMethod(), parameters: nil, encoding: URLEncoding.default, headers: endpoint.getHeaders(), interceptor: nil).response {
            
            response in
            
            switch response.result {
            case .success(let data):
                guard let data = data else {
                    DispatchQueue.main.async {
                        completion(nil, .emptyResponse)
                    }
                    return
                }
                
                guard let result = try? JSONDecoder().decode(ReturnType.self, from: data) else {
                    DispatchQueue.main.async {
                        completion(nil, .unexpectedResponseFormat)
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    completion(result, nil)
                }
            case .failure(_):
                DispatchQueue.main.async {
                    completion(nil, .unexpectedError)
                }
            }
        }
    }
    
    func makeRequestForImage(endpoint: Endpoint, completion: @escaping (Data?, WebServiceError?)-> Void) {
        
        guard let url = try? endpoint.getURL() else {
            completion(nil, .buildingEndpointFailed)
            return
        }
        
        manager.request(url, method: endpoint.getHTTPMethod(), parameters: nil, encoding: URLEncoding.default, headers: endpoint.getHeaders(), interceptor: nil).response {
            
            response in
            
            switch response.result {
            case .success(let data):
                guard let data = data else {
                    DispatchQueue.main.async {
                        completion(nil, .emptyResponse)
                    }
                    return
                }
                DispatchQueue.main.async {
                    completion(data, nil)
                }
            case .failure(_):
                DispatchQueue.main.async {
                    completion(nil, .unexpectedError)
                }
            }
        }
        
    }
    
}
