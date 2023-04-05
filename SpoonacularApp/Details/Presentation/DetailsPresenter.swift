//
//  DetailsPresenter.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 30/03/23.
//

import Foundation

protocol DetailsPresenterProtocol: AnyObject {
    func setController(_ viewController: DetailsViewControllerProtocol?)
    func processRecipeWasReceived(from receivedRecipe: RecipeToDisplay)
}

class DetailsPresenter {
    
    weak var controller: DetailsViewControllerProtocol?
    
    private let getDetailsUseCase: GetDetailsRecipeUseCaseProtocol
    
    init(getDetailsUseCase: GetDetailsRecipeUseCaseProtocol) {
        self.getDetailsUseCase = getDetailsUseCase
    }
        
    func getDetailsFromRecipe(from receivedRecipe: RecipeToDisplay) {
        getDetailsUseCase.getRecipesToDisplay(search: receivedRecipe.id) { [weak self] details, error in
            guard let self = self else {
                return
            }
            if error != nil {
                self.controller?.alertDownloadingDetailsFailed()
            }
            if let details = details {
                self.processDetails(details)
            }
        }
    }
    
    func processDetails(_ details: DetailedRecipe) {
        controller?.fillInRecipeDetails(with: details)
    }
    
    func fillInViewBasicDetails(from recipe: RecipeToDisplay) {
        controller?.fillInBasicData(with: recipe)
    }
}

extension DetailsPresenter: DetailsPresenterProtocol {
    
    func setController(_ viewController: DetailsViewControllerProtocol?) {
        self.controller = viewController
    }
    
    func processRecipeWasReceived(from receivedRecipe: RecipeToDisplay) {
        fillInViewBasicDetails(from: receivedRecipe)
        getDetailsFromRecipe(from: receivedRecipe)
    }
    
}
