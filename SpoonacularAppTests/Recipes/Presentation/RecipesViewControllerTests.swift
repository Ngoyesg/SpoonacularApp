//
//  RecipesViewControllerTests.swift
//  SpoonacularAppTests
//
//  Created by Natalia Goyes on 5/04/23.
//

import XCTest
@testable import SpoonacularApp

final class RecipesViewControllerTests: XCTestCase {

    var storyboard: UIStoryboard!
    var sut: RecipesViewController!
    var navigationController: UINavigationController!
    
    override func setUpWithError() throws {
        storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "RecipesViewController") as? RecipesViewController
        sut.loadViewIfNeeded()
        navigationController = UINavigationController(rootViewController: sut)
    }
    
    override  func tearDown() {
        storyboard = nil
        sut = nil
        navigationController = nil
        super.tearDown()
    }
    
    
    func testRecipesViewController_WhenCreated_HasFilterRecipeTextFieldAndTableViewEmpty() throws {
        
        //assert
        let filterRecipeTextField = try XCTUnwrap(sut.filterRecipeTextField, "The filterRecipeTextField is not connected to an IBOutlet")
        let tableView = try XCTUnwrap(sut.tableView, "The tableView is not connected to an IBOutlet")
        
        XCTAssertEqual(filterRecipeTextField.text, "", "The filterRecipeTextField should have been empty when viewController initially loaded")
        XCTAssertTrue(tableView.visibleCells.isEmpty, "The tableView should have been empty when viewController initially loaded")

    }

    func testRecipesViewController_WhenCreated_HasSignupButtonAndAction() throws {

        // Arrange

        let searchButton: UIButton = try XCTUnwrap(sut.searchRecipeButton, "The searchRecipeButton does not have a referencing outlet")

        // Act

        let searchButtonActions = try XCTUnwrap(searchButton.actions(forTarget: sut, forControlEvent: .touchUpInside), "The searchButton has no actions assigned to it")

        // Assert

        XCTAssertEqual(searchButtonActions.count, 1, "The number of actions of the searchRecipeButton should have been 1")

        XCTAssertEqual(searchButtonActions.first, "onSearchRecipeButtonTapped", "There is no method onSearchRecipeButtonTapped in the searchRecipeButton actions")

    }
    
    func testRecipesViewController_WhenViewDidAppearAndRecipeCellIsTapped_DetailsViewControllerIsPushed() {

        let spyNavigationController = SpyNavigationController(rootViewController: sut)

        sut.viewDidAppear(true)
        
        sut.tableView(sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 1))
        
        guard let _ = spyNavigationController.pushedViewController as? DetailsViewController else {
            XCTFail()
            return
        }
    }
    

}
