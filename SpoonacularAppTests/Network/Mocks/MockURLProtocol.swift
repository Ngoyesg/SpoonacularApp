//
//  MockURLProtocol.swift
//  SpoonacularAppTests
//
//  Created by Natalia Goyes on 26/03/23.
//

import Foundation

class MockURLProtocol: URLProtocol {
    
    private(set) var activeTask: URLSessionTask?
    
    static var stubResponseData: Data?
    
    static var error: Error?
        
    private lazy var session: URLSession = {
        let configuration: URLSessionConfiguration = URLSessionConfiguration.ephemeral
        return URLSession(configuration: configuration)
    }()

    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override class func requestIsCacheEquivalent(_ a: URLRequest, to b: URLRequest) -> Bool {
          return false
    }
    
    override func startLoading() {
        
        activeTask = session.dataTask(with: request.urlRequest!)
        activeTask?.cancel()
        
        if let loadingError = MockURLProtocol.error {
            let error = NSError(domain: "testingError", code: -99, userInfo: [NSLocalizedDescriptionKey: loadingError.localizedDescription])
            self.client?.urlProtocol(self, didFailWithError: error)
        } else {
            self.client?.urlProtocol(self, didLoad: MockURLProtocol.stubResponseData ?? Data())
        }
        self.client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {
        activeTask?.cancel()
    }
    
}
