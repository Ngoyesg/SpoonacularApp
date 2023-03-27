//
//  MockURLDecomposerProtocol.swift
//  SpoonacularAppTests
//
//  Created by Natalia Goyes on 26/03/23.
//

import Foundation
@testable import SpoonacularApp

class MockURLDecomposer: URLDecomposerProtocol {
  
    var caseSuccess: Bool = false
    var expectedHost: String = "default"
    var expectedPath: String = "default"
    
    func extract(from urlString: String) throws -> SpoonacularApp.DecomposedURL {
        if caseSuccess {
            return DecomposedURL(host: expectedHost, path: expectedPath)
        } else {
            throw EndpointError.invalidURL
        }
    }
}
