//
//  DetailsPresenterBuilder.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 30/03/23.
//

import Foundation

class DetailsPresenterBuilder {
    
    private func getProductionDetailsUseCase()-> GetDetailsRecipeUseCase {
        
        let mapperModelToDetailedRecipe = MapDetailedRecipe()
        
        let converter = DetailedRecipeAPIToModelMap()
        
        let detailedRecipesRetrieverService = DetailedRecipeWebService(converter: converter)
        
        return GetDetailsRecipeUseCase(detailedRecipesRetrieverService: detailedRecipesRetrieverService, mapperModelToDetailedRecipe: mapperModelToDetailedRecipe)
    }
    
    private func getDevelopmentDetailsUseCase() -> FakeGetDetailsRecipeUseCase {
        
        return FakeGetDetailsRecipeUseCase()
    }
    
    func getDetailsUseCase() -> GetDetailsRecipeUseCaseProtocol {
        #if DEBUG
            return getDevelopmentDetailsUseCase()
        #else
            return getProductionDetailsUseCase()
        #endif
    }
    
    func build() -> DetailsPresenter {
        
        let getDetailsUseCase = getDetailsUseCase()
        
        return DetailsPresenter(getDetailsUseCase: getDetailsUseCase)
        
    }
    
}
