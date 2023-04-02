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
    case unableToFetchData, buildingEndpointFailed, unexpectedResponseFormat, emptyResponse, unexpectedError, exceededNumberOfAPIKeyCalls
}

protocol APIResponseDecodable {
    func decode(data: Data) -> Any?
}

class AnyResponseDecoder<ReturnType: Decodable>: APIResponseDecodable {
    private let jsonDecoder = JSONDecoder()
    
    func decode(data: Data) -> Any? {
        do {
            return try jsonDecoder.decode(ReturnType.self, from: data)
        } catch {
            let error = error as! NSError
            print(error.userInfo)
            return nil
        }
    }
}

class ImageDecoder: APIResponseDecodable {
    func decode(data: Data) -> Any? {
        data
    }
}

class WebService<ReturnType: Decodable, Endpoint: BaseEndpoint> {
    
    private let manager: Session
    private let responseDecoder: APIResponseDecodable
    
    init(responseDecoder: APIResponseDecodable, manager: Session = Session.default) {
        self.manager = manager
        self.responseDecoder = responseDecoder
    }
    
    func makeRequest(endpoint: Endpoint, completion: @escaping (ReturnType?, WebServiceError?)-> Void) {
        guard let url = try? endpoint.getURL() else {
            completion(nil, .buildingEndpointFailed)
            return
        }
        
        manager.request(url, method: endpoint.getHTTPMethod(), parameters: nil, encoding: URLEncoding.default, headers: endpoint.getHeaders(), interceptor: nil).response { response in
            
            switch response.result {
            case .success(let data):
                guard let data = data else {
                    DispatchQueue.main.async {
                        completion(nil, .emptyResponse)
                    }
                    return
                }
                
                guard let result = self.responseDecoder.decode(data: data) as? ReturnType else {
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
}
