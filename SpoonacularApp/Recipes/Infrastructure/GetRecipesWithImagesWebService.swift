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
    
    private var getRecipesService: GetRecipesWebServiceProtocol
    private var getImageService: ImageWebServiceProtocol
    private var mapperFromRecipeService: RecipesToRecipesWithImagesProtocol
    
    private var recipesToReturn : [RecipeWithImageModel] = []
    private let dispatchGroup = DispatchGroup()
    private let dispatchQueue = DispatchQueue(label: "RecipesWithImagesQueue")
    private var error: Bool = false
    
    init(getRecipesService: GetRecipesWebServiceProtocol, getImageService: ImageWebServiceProtocol, mapperFromRecipeService: RecipesToRecipesWithImagesProtocol) {
        self.getRecipesService = getRecipesService
        self.getImageService = getImageService
        self.mapperFromRecipeService = mapperFromRecipeService
    }
    
}

extension GetRecipesWithImagesWebService: GetRecipesWithImageWebServiceProtocol {
    
    func getRecipesWithThumbnails(from recipes: AllRecipesModel, completion: @escaping (AllRecipesModel?, [RecipeWithImageModel]?, WebServiceError?) -> Void) {
        
        error = false
        
        recipes.recipes?.forEach { recipe in
            self.dispatchQueue.async {
                self.dispatchGroup.enter()
                guard let imageURL = recipe.image else {
                    completion(nil, nil, .unexpectedError)
                    self.dispatchGroup.leave()
                    return
                }
                self.getImageService.getImage(for: imageURL) { [weak self] imageData, error in
                    guard let self = self else {
                        self?.error = true
                        self?.dispatchGroup.leave()
                        return
                    }
                    
                    if error != nil {
                        let recipeWithImage = self.mapperFromRecipeService.mapWithImageData(from: recipe, and: nil)
                        self.recipesToReturn.append(recipeWithImage)
                        self.dispatchGroup.leave()
                        return
                    }
                    
                    if let image = imageData {
                        self.error = false
                        let recipeWithImage = self.mapperFromRecipeService.mapWithImageData(from: recipe, and: image)
                        self.recipesToReturn.append(recipeWithImage)
                        self.dispatchGroup.leave()
                    }
                }
            }
        }
        
        dispatchGroup.notify(queue: dispatchQueue) {
            
            DispatchQueue.main.async {
                if self.error {
                    completion(nil, nil, .unexpectedError)
                } else {
                    completion(recipes, self.recipesToReturn, nil)
                }
            }
            
        }
    }
}
