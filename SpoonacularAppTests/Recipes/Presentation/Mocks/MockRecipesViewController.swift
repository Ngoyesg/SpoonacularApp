//
//  MockRecipesViewController.swift
//  SpoonacularAppTests
//
//  Created by Natalia Goyes on 12/04/23.
//

import Foundation
import XCTest
@testable import SpoonacularApp

class MockRecipesViewController: RecipesViewControllerProtocol {
    
    var recipeSetExpectation: XCTestExpectation?
    var segueTriggeredExpectation: XCTestExpectation?
    var rowReloadedExpectation: XCTestExpectation?
    var alertTriggeredExpectation: XCTestExpectation?
    var spinnerStartedExpectation: XCTestExpectation?
    var spinnerStoppedExpectation: XCTestExpectation?
    var reloadTableExpectation: XCTestExpectation?
         
    func alertProcessStatus(for process: SpoonacularApp.RecipesUseCase, status: SpoonacularApp.RecipesUseCaseStatus) {
        alertTriggeredExpectation?.fulfill()
    }
    
    func reloadTable() {
        reloadTableExpectation?.fulfill()
    }
    
    func reloadRow(at index: Int) {
        rowReloadedExpectation?.fulfill()
    }
    
    func startSpinner() {
        spinnerStartedExpectation?.fulfill()
    }
    
    func stopSpinner() {
       spinnerStoppedExpectation?.fulfill()
    }
    
    func setRecipeToSend(with recipe: SpoonacularApp.RecipeToDisplay) {
        recipeSetExpectation?.fulfill()
    }
    
    func goToRecipeDetailsController() {
        segueTriggeredExpectation?.fulfill()
    }
    
    
}
