//
//  ImageRecipeEndpointTests.swift
//  SpoonacularAppTests
//
//  Created by Natalia Goyes on 25/03/23.
//

import XCTest
@testable import SpoonacularApp
/*
final class ImageRecipeEndpointTests: XCTestCase {

    private var sut: ImageRecipeEndpoint!
    private var mockURLDecomposer: MockURLDecomposer!
    var expectation: XCTestExpectation!

    struct Constant {
        static let givenURL = "https://spoonacular.com/recipeImages/716426-312x231.jpg"
        static let expectedHost = "spoonacular.com"
        static let expectedPath = "/recipeImages/716426-312x231.jpg"
        static let successfulURLReturned = URL(string:                 "https://spoonacular.com/recipeImages/716426-312x231.jpg?apiKey=\(Constants.apiKey)")!
    }

    override func setUp() {
        mockURLDecomposer = MockURLDecomposer()
        super.setUp()
    }

    override func tearDown() {
        mockURLDecomposer = nil
        sut = nil
        super.tearDown()
    }
    
    
    func testImageRecipeEndpoint_WhenGetURLisCalled_GivenURL_ReturnShouldBeEqualToResult(){
        //arrange
        let validInputParameter = Constant.givenURL
        
        //act
        expectation = expectation(description: "ImageRecipeEndpoint URL expectation")
        mockURLDecomposer.caseSuccess = true
        mockURLDecomposer.expectedHost = Constant.expectedHost
        mockURLDecomposer.expectedPath = Constant.expectedPath
        
        //assert
        do {
            sut = try ImageRecipeEndpoint(imagePath: validInputParameter, decomposer: mockURLDecomposer)
            let url = try sut.getURL()
            XCTAssertEqual(url, Constant.successfulURLReturned, "The returned URL should have been the same as the expected")
            expectation.fulfill()
        } catch {
            XCTFail()
        }
        
        self.wait(for: [expectation], timeout: 1)
    }
    
    
    func testImageRecipeEndpoint_WhenGetURLisCalled_GivenURL_ShouldThrowError(){
        //arrange
        let validInputParameter = Constant.givenURL
        
        //act
        expectation = expectation(description: "ImageRecipeEndpoint URL expectation")
        mockURLDecomposer.caseSuccess = false
        
        //assert
        do {
            sut = try ImageRecipeEndpoint(imagePath: validInputParameter, decomposer: mockURLDecomposer)
            let _ = try sut.getURL()
            XCTFail()
        } catch {
            XCTAssertEqual(error as! EndpointError, EndpointError.invalidURL, "The error returned should have been the same as the expected")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 1)
    }
}
*/
