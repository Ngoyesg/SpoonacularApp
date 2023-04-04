//
//  GetRecipesWebServiceTests.swift
//  SpoonacularAppTests
//
//  Created by Natalia Goyes on 2/04/23.
//

import XCTest
@testable import SpoonacularApp

final class GetRecipesWebServiceTests: XCTestCase {

    private var sut: GetRecipesWebService!
    private var converter: AllRecipesAPIToModelMapProtocol!
    var expectation: XCTestExpectation!
    
    override func setUp() {
        super.setUp()
        converter = AllRecipesAPIToModelMapMock()
        sut = GetRecipesWebService(converter: converter)
    }
    
    override func tearDown() {
        sut = nil
        converter = nil
        super.tearDown()
    }
    
    //func testGetRecipesWebService_WhenGetAllRecipesIsCalled_Given
    
    

}
