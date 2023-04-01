//
//  WebServicesFacade.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 1/04/23.
//

import Foundation

protocol WebServicesFacadeProtocol: AnyObject {
    func getUnfilteredRecipes(from offset: Int, to number: Int, completion: @escaping (AllRecipesModel?, [RecipeToDisplay]?) -> Void)
    func getFilteredRecipes(search keyword: String, completion: @escaping (AllRecipesModel?, [RecipeToDisplay]?) -> Void)
}

class WebServicesFacade {
    
    var filteringUseCase: FilteringUseCaseProtocol
    var recipesRetrieverUseCase: RecipesRetrieverUseCaseProtocol
    var mapperRecipesToDisplay: MapRecipeToDisplayProtocol

    init(filteringUseCase: FilteringUseCaseProtocol, recipesRetrieverUseCase: RecipesRetrieverUseCaseProtocol, mapperRecipesToDisplay: MapRecipeToDisplayProtocol) {
        self.filteringUseCase = filteringUseCase
        self.recipesRetrieverUseCase = recipesRetrieverUseCase
        self.mapperRecipesToDisplay = mapperRecipesToDisplay
    }
    
    func mapResultsToDisplay(from model: [RecipeWithImageModel]) -> [RecipeToDisplay] {
        model.map { result in
            mapperRecipesToDisplay.convert(result)
        }
    }
    
}

extension WebServicesFacade: WebServicesFacadeProtocol {
    
    func getUnfilteredRecipes(from offset: Int, to number: Int, completion: @escaping (AllRecipesModel?, [RecipeToDisplay]?) -> Void) {
        
        recipesRetrieverUseCase.getRecipesToDisplay(from: offset, to: number) { [weak self] allInfo, recipesResults, error in
            guard let self = self else {
                completion(nil, nil)
                return
            }
            
            if error != nil {
                completion(nil, nil)
            }
            
            if let allInfo = allInfo, let recipesResults = recipesResults {
                let transformed = self.mapResultsToDisplay(from: recipesResults)
                completion(allInfo, transformed)
            }
        }
    }
    
    func getFilteredRecipes(search keyword: String, completion: @escaping (AllRecipesModel?, [RecipeToDisplay]?) -> Void) {
        
        filteringUseCase.getRecipesToDisplay(search: keyword) { [weak self] allInfo, recipesResults, error in
            guard let self = self else {
                completion(nil, nil)
                return
            }
            
            if error != nil {
                completion(nil, nil)
            }
            
            if let allInfo = allInfo, let recipesResults = recipesResults {
                let transformed = self.mapResultsToDisplay(from: recipesResults)
                completion(allInfo, transformed)
            }
        }
    }
    
}
