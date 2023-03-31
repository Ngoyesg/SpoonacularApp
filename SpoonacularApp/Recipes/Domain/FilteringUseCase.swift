//
//  FilteringUseCase.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 30/03/23.
//

import Foundation

protocol FilteringUseCaseProtocol: AnyObject {
    func getRecipesToDisplay(search keywords: String, completion: @escaping (AllRecipesModel?, [RecipeWithImageModel]?, WebServiceError?) -> Void)
}

class FilteringUseCase {
    
    private let filteredRecipesRetrieverService: FilteredRecipesWebServiceProtocol
    private let imagesRetrieverService: GetRecipesWithImageWebServiceProtocol

    init(filteredRecipesRetrieverService: FilteredRecipesWebServiceProtocol, imagesRetrieverService: GetRecipesWithImageWebServiceProtocol) {
        self.filteredRecipesRetrieverService = filteredRecipesRetrieverService
        self.imagesRetrieverService = imagesRetrieverService
    }
}

extension FilteringUseCase: FilteringUseCaseProtocol {
    func getRecipesToDisplay(search keywords: String, completion: @escaping (AllRecipesModel?, [RecipeWithImageModel]?, WebServiceError?) -> Void) {
        
        filteredRecipesRetrieverService.getFilteredRecipes(for: keywords) { [weak self] allrecipes, error in
            
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
