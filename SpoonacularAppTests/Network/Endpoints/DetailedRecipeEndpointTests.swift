//
//  DetailedRecipeEndpointTests.swift
//  SpoonacularAppTests
//
//  Created by Natalia Goyes on 26/03/23.
//

import XCTest
@testable import SpoonacularApp

final class DetailedRecipeEndpointTests: XCTestCase {

    private var sut: DetailedRecipeEndpoint!
    var expectation: XCTestExpectation!
    
    struct Constant {
        static let idToTest = 716429
        static let invalidIDToTest = -idToTest
        static let includeNutritionMock = false
        static let successfulURLReturned = URL(string:                 "https://api.spoonacular.com/recipes/\(Constant.idToTest)/information?apiKey=\(Constants.apiKey)&includeNutrition=\(String(describing: includeNutritionMock))")!
    }

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    
    func testDetailedRecipeEndpoint_WhenGetURLisCalled_GivenValidID_ReturnShouldBeEqualToResult(){
        //arrange
        let validInputParameters = (id: Constant.idToTest, includeNutrition: Constant.includeNutritionMock)
        
        //act
        expectation = expectation(description: "DetailedRecipeEndpoint URL expectation")
        
        //assert
        do {
            sut = try DetailedRecipeEndpoint(recipeID: validInputParameters.id, includeNutrition: validInputParameters.includeNutrition)
            let url = try sut.getURL()
            XCTAssertEqual(url, Constant.successfulURLReturned, "The returned URL should have been the same as the expected")
            expectation.fulfill()
        } catch {
            XCTFail()
        }
        
        self.wait(for: [expectation], timeout: 1)
    }
    
    func testDetailedRecipeEndpoint_WhenGetURLisCalled_GivenInvalidID_ShouldThrowError(){
        //arrange
        let invalidInputParameters = (id: Constant.invalidIDToTest, includeNutrition: Constant.includeNutritionMock)
        
        //act
        expectation = expectation(description: "DetailedRecipeEndpoint URL expectation")
        
        //assert
        do {
            sut = try DetailedRecipeEndpoint(recipeID: invalidInputParameters.id, includeNutrition: invalidInputParameters.includeNutrition)
            let _ = try sut.getURL()
            XCTFail()
        } catch let error {
            XCTAssertEqual(error as! EndpointError, EndpointError.invalidSearchID, "The error returned should have been the same as the expected")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 1)
    }
}
