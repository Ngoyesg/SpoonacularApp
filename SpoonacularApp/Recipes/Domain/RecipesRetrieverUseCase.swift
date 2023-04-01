//
//  RecipesRetrieverUseCase.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 30/03/23.
//

import Foundation

protocol RecipesRetrieverUseCaseProtocol: AnyObject {
    func getRecipesToDisplay(from offset: Int, to number: Int, completion: @escaping (AllRecipesModel?, [RecipeWithImageModel]?, WebServiceError?) -> Void)
}

class RecipesRetrieverUseCase {
    
    private let recipesRetrieverService: GetRecipesWebServiceProtocol
    private let imagesRetrieverService: GetRecipesWithImageWebServiceProtocol

    init(recipesRetrieverService: GetRecipesWebServiceProtocol, imagesRetrieverService: GetRecipesWithImageWebServiceProtocol) {
        self.recipesRetrieverService = recipesRetrieverService
        self.imagesRetrieverService = imagesRetrieverService
    }
    
}

extension RecipesRetrieverUseCase: RecipesRetrieverUseCaseProtocol {
    
    func getRecipesToDisplay(from offset: Int, to number: Int, completion: @escaping (AllRecipesModel?, [RecipeWithImageModel]?, WebServiceError?) -> Void) {
        
        recipesRetrieverService.getAllRecipes(from: offset, to: number) {  [weak self] allrecipes, error in
            
            guard let self = self else {
                completion(nil, nil, .unexpectedError)
                return
            }
            
            if error != nil {
                completion(nil, nil, .unexpectedError)
                return
            }
            
            if let allrecipes = allrecipes {
                self.imagesRetrieverService.getRecipesWithThumbnails(from: allrecipes, completion: completion)
               return
            }
        }
    }
}
