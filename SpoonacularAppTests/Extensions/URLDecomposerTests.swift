//
//  URLDecomposerTests.swift
//  SpoonacularAppTests
//
//  Created by Natalia Goyes on 26/03/23.
//

import XCTest
@testable import SpoonacularApp
/*
final class URLDecomposerTests: XCTestCase {
    
    private var sut: URLDecomposer!
    var expectation: XCTestExpectation!

    struct Constant {
        static let invalidURL = ""
        static let validURLString = "https://spoonacular.com/recipeImages/716426-312x231.jpg"
        static let expectedHost = "spoonacular.com"
        static let expectedPath = "/recipeImages/716426-312x231.jpg"
        static let expectedResult = DecomposedURL(host: expectedHost, path: expectedPath)
    }

    override func setUp() {
        sut = URLDecomposer()
        super.setUp()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    
    func testURLDecomposer_WhenExtractisCalled_GivenValidURLString_ReturnShouldBeEqualToResult(){
        //arrange
        let validURLString = Constant.validURLString
        
        //act
        expectation = expectation(description: "URLDecomposer URL expectation")
        
        //assert
        do {
            let result = try sut.extract(from: validURLString)
            XCTAssertEqual(result, Constant.expectedResult, "The returned URL should have been the same as the expected")
            expectation.fulfill()
        } catch {
            XCTFail()
        }
        
        self.wait(for: [expectation], timeout: 1)
    }
    

    func testURLDecomposer_WhenExtractisCalled_GivenInvalidURL_ShouldThrowError(){
        //arrange
        let invalidInputParameter = Constant.invalidURL

        //act
        expectation = expectation(description: "URLDecomposer URL expectation")

        //assert
        do {
            let _ = try sut.extract(from: invalidInputParameter)
            XCTFail()
        } catch {
            XCTAssertEqual(error as! EndpointError, EndpointError.invalidURL, "The error returned should have been the same as the expected")
            expectation.fulfill()
        }

        self.wait(for: [expectation], timeout: 1)
    }

}
*/
