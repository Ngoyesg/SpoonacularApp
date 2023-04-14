//
//  WebServiceTests.swift
//  SpoonacularAppTests
//
//  Created by Natalia Goyes on 26/03/23.
//

import XCTest
@testable import SpoonacularApp
@testable import Alamofire

struct MockResponse: Codable, Equatable {
    let mockProperty: String
}

/*
final class WebServiceTests: XCTestCase {
    
    private var sut: WebService!
    
    var requestExpectation: XCTestExpectation!
    
    struct Constant {
        static let mockURL = URL(string: "https://api.example.com/mockResource")!
    }
    
    override func setUp() {
        super.setUp()
        
        let mockSession: Session = {
            let configuration = URLSessionConfiguration.af.default
            configuration.protocolClasses = [MockURLProtocol.self] + (configuration.protocolClasses ?? [])
            return Session(configuration: configuration)
        }()
        
        sut = WebService(manager: mockSession)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testWebService_WhenLoadIsCalled_GivenAValidResource_ShouldReturnMockedResponse() {
        
        // arrange
        MockURLProtocol.error = nil
        let mockedData = MockResponse(mockProperty: "this is a default value")
        MockURLProtocol.stubResponseData = try! JSONEncoder().encode(mockedData)
        
        let header = HTTPHeader(name: "content-type", value: "application/json")
        let headers = HTTPHeaders(arrayLiteral: header)
        let mockResource = Resource<MockResponse>(url: Constant.mockURL, httpMethod: .get, httpHeaders: headers) { data in
            let mockResource = try? JSONDecoder().decode(MockResponse.self, from: data)
            return mockResource
        }
        
        requestExpectation = XCTestExpectation(description: "Performs a request")
        
        
        // act
        sut.load(resource: mockResource) { result in
            XCTAssertEqual(result, mockedData)
            self.requestExpectation.fulfill()
        }
        
        // assert
        self.wait(for: [requestExpectation], timeout: 3)
    }    
}
*/
