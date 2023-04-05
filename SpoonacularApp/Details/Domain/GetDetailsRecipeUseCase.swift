//
//  GetDetailsRecipeUseCase.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 2/04/23.
//

import Foundation

protocol GetDetailsRecipeUseCaseProtocol {
    func getRecipesToDisplay(search id: Int, completion: @escaping (DetailedRecipe?, WebServiceError?) -> Void)
}

class GetDetailsRecipeUseCase {
    
    private let detailedRecipesRetrieverService: DetailedRecipeWebServiceProtocol
    private let mapperModelToDetailedRecipe: MapDetailedRecipeProtocol

    init(detailedRecipesRetrieverService: DetailedRecipeWebServiceProtocol, mapperModelToDetailedRecipe: MapDetailedRecipeProtocol) {
        self.detailedRecipesRetrieverService = detailedRecipesRetrieverService
        self.mapperModelToDetailedRecipe = mapperModelToDetailedRecipe
    }
}

extension GetDetailsRecipeUseCase: GetDetailsRecipeUseCaseProtocol {
    func getRecipesToDisplay(search id: Int, completion: @escaping (DetailedRecipe?, WebServiceError?) -> Void) {
        
        detailedRecipesRetrieverService.getDetails(for: id, with: true) { [weak self] detailedRecipe, error in
            
            guard let self = self else {
                return
            }
            
            if error != nil {
                completion(nil, .unexpectedError)
                return
            }
            
            if let detailedRecipe = detailedRecipe {
                let transformed = self.mapperModelToDetailedRecipe.convert(detailedRecipe)
                completion(transformed, nil)
                return
            }
        }
    }
}
