//
//  RecipesRetrieverUseCase.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 30/03/23.
//

import Foundation

protocol RecipesRetrieverUseCaseStepProtocol: AnyObject {
    func getRecipesToDisplay(from offset: Int, to number: Int, completion: @escaping (AllRecipesModel?, [RecipeWithImageModel]?, WebServiceError?) -> Void)
}

class RecipesRetrieverUseCaseStep {
    
    private let recipesRetrieverService: GetRecipesWebServiceProtocol
    private let imagesRetrieverService: GetRecipesWithImageWebServiceProtocol

    init(recipesRetrieverService: GetRecipesWebServiceProtocol, imagesRetrieverService: GetRecipesWithImageWebServiceProtocol) {
        self.recipesRetrieverService = recipesRetrieverService
        self.imagesRetrieverService = imagesRetrieverService
    }
    
}

extension RecipesRetrieverUseCaseStep: RecipesRetrieverUseCaseStepProtocol {
    
    func getRecipesToDisplay(from offset: Int, to number: Int, completion: @escaping (AllRecipesModel?, [RecipeWithImageModel]?, WebServiceError?) -> Void) {
        
        recipesRetrieverService.getAllRecipes(from: offset, to: number) {  [weak self] allrecipes, error in
            
            guard let self = self else {
                return
            }
            
            if error != nil {
                completion(nil, nil, .unexpectedError)
            }
            
            if let allrecipes = allrecipes {
                self.imagesRetrieverService.getRecipesWithThumbnails(from: allrecipes, completion: completion)
            }
        }
    }
}
