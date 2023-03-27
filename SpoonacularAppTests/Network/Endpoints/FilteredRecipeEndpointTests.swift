//
//  FilteredRecipeEndpointTests.swift
//  SpoonacularAppTests
//
//  Created by Natalia Goyes on 25/03/23.
//

import XCTest
@testable import SpoonacularApp

final class FilteredRecipeEndpointTests: XCTestCase {
    
    private var sut: FilteredRecipeEndpoint!
    var expectation: XCTestExpectation!
    
    struct Constant {
        static let validSearch = "pasta with pesto"
        static let encodedValidSearch = "pasta%20with%20pesto"
        static let invalidSearch = ""
        static let successfulURLReturned = URL(string:                 "https://api.spoonacular.com/food/products/search?apiKey=\(Constants.apiKey)&query=\(encodedValidSearch)")!
    }

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testFilteredRecipeEndpoint_WhenGetURLisCalled_GivenValidSearch_ReturnShouldBeEqualToResult(){
        //arrange

        //act
        expectation = expectation(description: "FilteredRecipeEndpoint URL expectation")
        
        //assert
        do {
            sut = try FilteredRecipeEndpoint(search: Constant.validSearch)
            let url = try sut.getURL()
            expectation.fulfill()
            XCTAssertEqual(url, Constant.successfulURLReturned, "The returned URL should have been the same as the expected")
        } catch {
            XCTFail()
        }
        self.wait(for: [expectation], timeout: 1)
    }
    
    func testFilteredRecipeEndpoint_WhenGetURLisCalled_GivenInvalidSearch_ShouldThrowError(){
        //arrange

        //act
        expectation = expectation(description: "FilteredRecipeEndpoint URL expectation")
        
        //assert
        do {
            sut = try FilteredRecipeEndpoint(search: Constant.invalidSearch)
            let _ = try sut.getURL()
            XCTFail()
        } catch let error{
            expectation.fulfill()
            XCTAssertEqual(error as! EndpointError, EndpointError.emptySearch, "The error returned should have been the same as the expected")
        }
        
        self.wait(for: [expectation], timeout: 1)
    }

}
