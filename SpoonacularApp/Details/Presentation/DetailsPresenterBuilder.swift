//
//  DetailsPresenterBuilder.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 30/03/23.
//

import Foundation

class DetailsPresenterBuilder {
    
    func build() -> DetailsPresenter {
        
        let mapperModelToDetailedRecipe = MapDetailedRecipe()
        
        let converter = DetailedRecipeAPIToModelMap()
        
        let detailedRecipesRetrieverService = DetailedRecipeWebService(converter: converter)
        
        let getDetailsUseCase = GetDetailsRecipeUseCaseStep(detailedRecipesRetrieverService: detailedRecipesRetrieverService, mapperModelToDetailedRecipe: mapperModelToDetailedRecipe)
        
        return DetailsPresenter(getDetailsUseCase: getDetailsUseCase)
        
    }
    
}
