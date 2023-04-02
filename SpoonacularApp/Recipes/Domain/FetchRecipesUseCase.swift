//
//  FetchRecipesUseCase.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 1/04/23.
//

import Foundation

protocol FetchRecipesUseCaseProtocol {
    func getRecipes(from offset: Int, to number: Int, search keyword: String, completion: @escaping (AllRecipesModel?, [RecipeToDisplay]?) -> Void)
}

class FetchRecipesUseCase: FetchRecipesUseCaseProtocol {
    
    private let filteringUseCaseStep: FilteringUseCaseStepProtocol
    private let recipesRetrieverUseCaseStep: RecipesRetrieverUseCaseStepProtocol
    private let mapperRecipesToDisplay: MapRecipeToDisplayProtocol
    private let getLocalRecipeUseCase: GetLocalRecipeUseCaseStepProtocol
    
    init(filteringUseCase: FilteringUseCaseStepProtocol, recipesRetrieverUseCase: RecipesRetrieverUseCaseStepProtocol, mapperRecipesToDisplay: MapRecipeToDisplayProtocol, getLocalRecipeUseCase: GetLocalRecipeUseCaseStepProtocol) {
        self.filteringUseCaseStep = filteringUseCase
        self.recipesRetrieverUseCaseStep = recipesRetrieverUseCase
        self.mapperRecipesToDisplay = mapperRecipesToDisplay
        self.getLocalRecipeUseCase = getLocalRecipeUseCase
    }
    
    func getRecipes(from offset: Int, to number: Int, search keyword: String, completion: @escaping (AllRecipesModel?, [RecipeToDisplay]?) -> Void) {
        
        if (keyword.isEmpty) {
            getUnfilteredRecipes(from: offset, to: number) { [weak self] allInfo, recipesResults, error in
                guard let self = self else {
                    completion(nil, nil)
                    return
                }
                self.processResponse(allInfo: allInfo, recipesResults: recipesResults, error: error, completion: completion)
            }
        } else {
            getFilteredRecipes(search: keyword) { [weak self] allInfo, recipesResults, error in
                guard let self = self else {
                    completion(nil, nil)
                    return
                }
                self.processResponse(allInfo: allInfo, recipesResults: recipesResults, error: error, completion: completion)
            }
        }
    }
    
    func getUnfilteredRecipes(from offset: Int, to number: Int, completion: @escaping (AllRecipesModel?, [RecipeWithImageModel]?, WebServiceError?) -> Void) {
        recipesRetrieverUseCaseStep.getRecipesToDisplay(from: offset, to: number) { allInfo, recipesResults, error in
            completion(allInfo, recipesResults, error)
        }
    }
    
    func getFilteredRecipes(search keyword: String, completion: @escaping (AllRecipesModel?, [RecipeWithImageModel]?, WebServiceError?) -> Void) {
        
        filteringUseCaseStep.getRecipesToDisplay(search: keyword) { allInfo, recipesResults, error in
            completion(allInfo, recipesResults, error)
        }
    }
    
    func processResponse(allInfo: AllRecipesModel?, recipesResults: [RecipeWithImageModel]?, error: WebServiceError?, completion: @escaping (AllRecipesModel?, [RecipeToDisplay]?) -> Void) {
        if error != nil {
            completion(nil, nil)
        }
        
        if let allInfo = allInfo, let recipesResults = recipesResults {
            let transformed = recipesResults.map { result in
                mapperRecipesToDisplay.convert(result) { recipeId in
                    let localRecipe = getLocalRecipeUseCase.getLocalRecipe(by: recipeId)
                    return localRecipe != nil
                }
            }
            completion(allInfo, transformed)
        }
    }
}
