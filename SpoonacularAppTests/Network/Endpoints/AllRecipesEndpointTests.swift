//
//  AllRecipesEndpointTests.swift
//  SpoonacularAppTests
//
//  Created by Natalia Goyes on 25/03/23.
//

import XCTest
@testable import SpoonacularApp

final class AllRecipesEndpointTests: XCTestCase {

    private var sut: AllRecipesEndpoint!
    var expectation: XCTestExpectation!
    
    struct Constant {
        static let validOffset = 0
        static let validNumber = 5
        static let invalidOffset = -validOffset
        static let invalidNumber = -validNumber
        static let successfulURLReturned = URL(string: "https://api.spoonacular.com/recipes/complexSearch?apiKey=\(Constants.apiKey)&offset=\(validOffset)&number=\(validNumber)")
    }

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testAllRecipesEndpoint_WhenGetURLisCalled_GivenValidBoundaries_ReturnShouldBeEqualToResult(){
        //arrange
        let validBoundaries = (offset: Constant.validOffset, number: Constant.validNumber)
        
        //act
        expectation = expectation(description: "AllRecipesEndpoint URL expectation")
                    
        //assert
        do {
            sut = try AllRecipesEndpoint(offset: validBoundaries.offset, number: validBoundaries.number)
            let url = try sut.getURL()
            XCTAssertEqual(url, Constant.successfulURLReturned, "The returned URL should have been the same as the expected")
            expectation.fulfill()
        } catch {
            XCTFail()
        }
        
        self.wait(for: [expectation], timeout: 1)
    }
    
    func testAllRecipesEndpoint_WhenGetURLisCalled_GivenInvalidBoundaries_ShouldThrowError(){
        //arrange
        let invalidBoundaries = (offset: Constant.invalidOffset, number: Constant.invalidNumber)

        //act
        expectation = expectation(description: "AllRecipesEndpoint URL expectation")

        //assert
        do {
            sut = try AllRecipesEndpoint(offset: invalidBoundaries.offset, number: invalidBoundaries.number)
            let _ = try sut.getURL()
            XCTFail()
        } catch let error {
            XCTAssertEqual(error as! EndpointError, EndpointError.invalidSearchBoundaries, "The error returned should have been the same as the expected")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 1)
    }

}
