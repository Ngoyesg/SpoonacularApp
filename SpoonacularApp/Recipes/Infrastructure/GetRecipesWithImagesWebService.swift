//
//  GetRecipeWithImageWebService.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 30/03/23.
//

import Foundation

protocol GetRecipesWithImageWebServiceProtocol: AnyObject {
    func getRecipesWithThumbnails(from recipes: AllRecipesModel, completion: @escaping (AllRecipesModel?, [RecipeWithImageModel]?, WebServiceError?) -> Void)
}

class GetRecipesWithImagesWebService {
    
    private let getRecipesService: GetRecipesWebServiceProtocol
    private let getImageService: ImageWebServiceProtocol
    private let mapperFromRecipeService: RecipesToRecipesWithImagesProtocol
    
    private var recipesToReturn : [RecipeWithImageModel] = []
    private let dispatchGroup = DispatchGroup()
    private let dispatchQueue = DispatchQueue(label: "RecipesWithImagesQueue")
    
    init(getRecipesService: GetRecipesWebServiceProtocol, getImageService: ImageWebServiceProtocol, mapperFromRecipeService: RecipesToRecipesWithImagesProtocol) {
        self.getRecipesService = getRecipesService
        self.getImageService = getImageService
        self.mapperFromRecipeService = mapperFromRecipeService
    }
    
}

extension GetRecipesWithImagesWebService: GetRecipesWithImageWebServiceProtocol {
    
    func getRecipesWithThumbnails(from recipes: AllRecipesModel, completion: @escaping (AllRecipesModel?, [RecipeWithImageModel]?, WebServiceError?) -> Void) {
                
        recipes.recipes?.forEach { recipe in
            guard let imageURL = recipe.image else {
                completion(nil, nil, .unexpectedError)
                return
            }
            
            self.dispatchQueue.async {
                self.dispatchGroup.enter()
            
                self.getImageService.getImage(for: imageURL) { [weak self] imageData, error in
                    guard let self = self else {
                        return
                    }
                    
                    if error != nil {
                        let recipeWithImage = self.mapperFromRecipeService.mapWithImageData(from: recipe, and: nil)
                        self.recipesToReturn.append(recipeWithImage)
                        self.dispatchGroup.leave()
                    } else if let image = imageData {
                        let recipeWithImage = self.mapperFromRecipeService.mapWithImageData(from: recipe, and: image)
                        self.recipesToReturn.append(recipeWithImage)
                        self.dispatchGroup.leave()
                    }
                }
            }
        }
        
        dispatchGroup.notify(queue: dispatchQueue) {
            
            DispatchQueue.main.async {
                completion(recipes, self.recipesToReturn, nil)
            }
            
        }
    }
}
