//
//  RecipesPresenterTests.swift
//  SpoonacularAppTests
//
//  Created by Natalia Goyes on 12/04/23.
//

import XCTest
@testable import SpoonacularApp

final class RecipesPresenterTests: XCTestCase {

    var mockController: MockRecipesViewController!
    var mockDBFacade: MockDBFacade!
    var fakeFetchRecipesUseCase: FakeFetchRecipesUseCase!
    var sut: RecipesPresenter!
    
    override func setUp()  {
        super.setUp()
        mockController = MockRecipesViewController()
        mockDBFacade = MockDBFacade()
        fakeFetchRecipesUseCase = FakeFetchRecipesUseCase()
        sut = RecipesPresenter(fetchRecipesUseCase: fakeFetchRecipesUseCase, dbFacade: mockDBFacade)
    }
    
    override func tearDown()  {
        sut = nil
        fakeFetchRecipesUseCase = nil
        mockDBFacade = nil
        mockController = nil
        super.tearDown()
    }
    
    func testRecipesPresenter_WhenSetControllerIsCalled_GivenAValidController_ControllerShouldNotBeNil(){
        //arrange
        mockController = MockRecipesViewController()
        
        //act
        sut.setController(mockController)
        
        //assert
        XCTAssertNotNil(sut.controller, "Controller should have not been nil")
    }
    
    
    func testRecipesPresenter_WhenGetTotalOfRecipesIsCalled_GivenFetchAllRecipesWasCalled_TotalShouldEqualExpected() {
        //arrange
        sut.setController(mockController)
        sut.fetchAllRecipes()
        let expectedTotal = fakeFetchRecipesUseCase.fakeRecipes.count
        
        //act
        let totalRecipes = sut.getTotalOfRecipes()

        //assert
        XCTAssertEqual(totalRecipes, expectedTotal , "Total recipes should have been equal")
    }
    
    func testRecipesPresenter_WhenGetRecipeForRowIsCalled_GivenFetchAllRecipesWasCalled_ShouldReturnRecipe() {
        //arrange
        sut.fetchAllRecipes()
        let anyValidRow = 0
        
        //act
        let recipeToDisplay = sut.getRecipeForRow(at: anyValidRow)

        //assert
        
        XCTAssertNotNil(recipeToDisplay, "Result should not have been nil")
    }
    
    func testRecipesPresenter_WhenGetRecipeWasSelected_GivenAValidRow_ControllerShouldSaveDataAndPerformSegue(){
        //arrange
        sut.setController(mockController)
        
        sut.fetchAllRecipes()
        
        let recipeSetExpectation = expectation(description: "Expected the setRecipeToSend() method to be called")
        mockController.recipeSetExpectation = recipeSetExpectation

        let segueTriggeredExpectation = expectation(description: "Expected the goToRecipeDetailsController() method to be called")
        mockController.segueTriggeredExpectation = segueTriggeredExpectation
        
        let anyValidRow = 0

        //act
        sut.recipeWasSelected(at: anyValidRow)
        
        //assert
        self.wait(for: [recipeSetExpectation, segueTriggeredExpectation], timeout: 5)
    }
    
    func testRecipesPresenter_WhenHandleAddToFavoritesisCalled_GivenASuccessfulSaving_FavoriteStatusShouldBeTrueControllerRowReloadedAndAlertDisplayed() {
        //arrange
        sut.setController(mockController)
        
        sut.fetchAllRecipes()
        
        self.mockDBFacade.successfulSave = true
        
        let rowReloadedExpectation = expectation(description: "Expected the reloadRow(at index: Int) method to be called")
        mockController.rowReloadedExpectation = rowReloadedExpectation
        
        let alertTriggeredExpectation = expectation(description: "Expected the alertProcessStatus(for process: RecipesUseCase, status: RecipesUseCaseStatus) method to be called")
        mockController.alertTriggeredExpectation = alertTriggeredExpectation
        
        let anyValidRecipeIndex = 0
        
        //act
        sut.handleAddToFavorites(at: anyValidRecipeIndex)
        
        //assert
        let recipeFavoriteStatus = sut.recipesToDisplay[anyValidRecipeIndex].isFavorite
        
        XCTAssertTrue(recipeFavoriteStatus, "Recipe status should have been true after being added to favorites")
        
        self.wait(for: [rowReloadedExpectation, alertTriggeredExpectation], timeout: 5)
        
    }
    
    func testRecipesPresenter_WhenHandleDeleteFromFavoritesisCalled_GivenASuccessfulDeletion_FavoriteStatusShouldBeFalseControllerRowReloadedAndAlertDisplayed() {
        //arrange
        sut.setController(mockController)
        
        sut.fetchAllRecipes()
        
        self.mockDBFacade.successfulDelete = true
        
        let rowReloadedExpectation = expectation(description: "Expected the reloadRow(at index: Int) method to be called")
        mockController.rowReloadedExpectation = rowReloadedExpectation
        
        let alertTriggeredExpectation = expectation(description: "Expected the alertProcessStatus(for process: RecipesUseCase, status: RecipesUseCaseStatus) method to be called")
        mockController.alertTriggeredExpectation = alertTriggeredExpectation
        
        let anyValidRecipeIndex = 0
        
        //act
        sut.handleDeleteFromFavorites(at: anyValidRecipeIndex)
        
        //assert
        let recipeFavoriteStatus = sut.recipesToDisplay[anyValidRecipeIndex].isFavorite
        
        XCTAssertFalse(recipeFavoriteStatus, "Recipe status should have been false after being deleted from favorites")
        
        self.wait(for: [rowReloadedExpectation, alertTriggeredExpectation], timeout: 5)
    }
    
    func testRecipesPresenter_WhenFetchAllRecipesisCalled_GivenASuccessfulCase_RecipesShouldNotBeEmptyControllerShouldStartAndStopSpinnerAndReloadTable() {
        //arrange
        sut.setController(mockController)
        
        fakeFetchRecipesUseCase.successFetch = true
        
        let spinnerStartedExpectation = expectation(description: "Expected the startSpinner() method to be called")
        mockController.spinnerStartedExpectation = spinnerStartedExpectation

        let spinnerStoppedExpectation = expectation(description: "Expected the stopSpinner()  method to be called")
        mockController.spinnerStoppedExpectation = spinnerStoppedExpectation
       
        let reloadTableExpectation = expectation(description: "Expected the reloadTable() method to be called")
        mockController.reloadTableExpectation = reloadTableExpectation
        
        //act
        sut.fetchAllRecipes()
        
        //assert
        XCTAssertTrue(sut.recipesToDisplay.count >= 1, "Recipes should have not been nil")
                
        self.wait(for: [spinnerStartedExpectation, spinnerStoppedExpectation, reloadTableExpectation], timeout: 5)
    }
    
    func testRecipesPresenter_WhenFetchAllRecipesisCalled_GivenAFailedCase_RecipesShouldBeEmptyControllerShouldStartAndStopSpinnerAndThrowAlert() {
        //arrange
        sut.setController(mockController)
        
        fakeFetchRecipesUseCase.successFetch = false
        
        let spinnerStartedExpectation = expectation(description: "Expected the startSpinner() method to be called")
        mockController.spinnerStartedExpectation = spinnerStartedExpectation

        let spinnerStoppedExpectation = expectation(description: "Expected the stopSpinner()  method to be called")
        mockController.spinnerStoppedExpectation = spinnerStoppedExpectation
       
        let alertTriggeredExpectation = expectation(description: "Expected the alertProcessStatus(for process: RecipesUseCase, status: RecipesUseCaseStatus) method to be called")
        mockController.alertTriggeredExpectation = alertTriggeredExpectation
        
        //act
        sut.fetchAllRecipes()
        
        //assert
        XCTAssertEqual(sut.recipesToDisplay, [], "Recipes should have been empty")
        
        self.wait(for: [spinnerStartedExpectation, spinnerStoppedExpectation, alertTriggeredExpectation], timeout: 5)
    }
        
    func testRecipesPresenter_WhenRestartFetchingHistoryisCalled_GivenDataWasPreviouslyFilled_RecipesShouldBeEmpty(){
        //arrange
        sut.setController(mockController)
        sut.fetchAllRecipes()
        
        //act
        sut.restartFetchingHistory()
        
        //assert
        XCTAssertEqual(sut.recipesToDisplay, [], "Recipes should have been empty")
    }
    
    func testRecipesPresenter_WhenProcesOnSearchFilteredRecipeTappedisCalled_GivenASuccessfulCase_RecipesShouldNotBeEmptyControllerShouldStartAndStopSpinnerAndReloadTable(){
        //arrange
        sut.setController(mockController)
        
        fakeFetchRecipesUseCase.successFetch = true
        
        let spinnerStartedExpectation = expectation(description: "Expected the startSpinner() method to be called")
        mockController.spinnerStartedExpectation = spinnerStartedExpectation

        let spinnerStoppedExpectation = expectation(description: "Expected the stopSpinner()  method to be called")
        mockController.spinnerStoppedExpectation = spinnerStoppedExpectation
       
        let reloadTableExpectation = expectation(description: "Expected the reloadTable() method to be called")
        mockController.reloadTableExpectation = reloadTableExpectation
        
        let anyValidKeyword = "pasta with pesto"
        
        //act
        sut.procesOnSearchFilteredRecipeTapped(with: anyValidKeyword)
        
        //assert
        XCTAssertTrue(sut.recipesToDisplay.count >= 1, "Recipes should have not been nil")
                
        self.wait(for: [spinnerStartedExpectation, spinnerStoppedExpectation, reloadTableExpectation], timeout: 5)
    }

    func testRecipesPresenter_WhenProcesOnSearchFilteredRecipeTappedisCalled_GivenAFailedCase_RecipesShouldBeEmptyControllerShouldStartAndStopSpinnerAndThrowAlert() {
        //arrange
        sut.setController(mockController)
        
        fakeFetchRecipesUseCase.successFetch = false
        
        let spinnerStartedExpectation = expectation(description: "Expected the startSpinner() method to be called")
        mockController.spinnerStartedExpectation = spinnerStartedExpectation

        let spinnerStoppedExpectation = expectation(description: "Expected the stopSpinner()  method to be called")
        mockController.spinnerStoppedExpectation = spinnerStoppedExpectation
       
        let alertTriggeredExpectation = expectation(description: "Expected the alertProcessStatus(for process: RecipesUseCase, status: RecipesUseCaseStatus) method to be called")
        mockController.alertTriggeredExpectation = alertTriggeredExpectation
        
        let anyValidKeyword = "pasta with pesto"
        
        //act
        sut.procesOnSearchFilteredRecipeTapped(with: anyValidKeyword)
        
        //assert
        XCTAssertEqual(sut.recipesToDisplay, [], "Recipes should have been empty")
        
        self.wait(for: [spinnerStartedExpectation, spinnerStoppedExpectation, alertTriggeredExpectation], timeout: 5)
    }
    
}
