//
//  BaseEndpointTests.swift
//  SpoonacularAppTests
//
//  Created by Natalia Goyes on 26/03/23.
//

import XCTest
@testable import SpoonacularApp

final class BaseEndpointTests: XCTestCase {
    
    private var sut: BaseEndpoint!
    var expectation: XCTestExpectation!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    struct Constant {
        static let expectedHost = "api.spoonacular.com"
        static let expectedPath = "/recipes/complexSearch"
        static let invalidHost = "   "
        static let invalidPath = "   "
        static let successfulURLReturned = URL(string: "https://api.spoonacular.com/recipes/complexSearch?apiKey=\(Constants.apiKey)")
    }
    
    func testBaseEndpoint_WhenGetURLisCalled_GivenValidHostAndPath_ReturnShouldBeEqualToResult(){
        //arrange
        sut = BaseEndpoint(host: Constant.expectedHost, path: Constant.expectedPath)
        
        //act
        expectation = expectation(description: "BaseEndpoint URL expectation")
                    
        //assert
        do {
            let url = try sut.getURL()
            XCTAssertEqual(url, Constant.successfulURLReturned, "The returned URL should have been the same as the expected")
            expectation.fulfill()
        } catch {
            XCTFail()
        }
        
        self.wait(for: [expectation], timeout: 1)
    }
    
    func testBaseEndpoint_WhenGetURLisCalled_GivenValidHostAndPath_ShouldThrowError(){
        //arrange
        sut = BaseEndpoint(host: Constant.invalidHost, path: Constant.invalidPath)

        //act
        expectation = expectation(description: "AllRecipesEndpoint URL expectation")

        //assert
        do {
            let _ = try sut.getURL()
            XCTFail()
        } catch let error {
            XCTAssertEqual(error as! EndpointError, EndpointError.invalidURL, "The error returned should have been the same as the expected")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 1)
    }

}
