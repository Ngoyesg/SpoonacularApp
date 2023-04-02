//
//  FakeFetchRecipesUseCase.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 2/04/23.
//

import Foundation
import UIKit

class FakeFetchRecipesUseCase: FetchRecipesUseCaseProtocol {
        
    func getRecipes(from offset: Int, to number: Int, search keyword: String, completion: @escaping (AllRecipesModel?, [RecipeToDisplay]?) -> Void) {
        
        let recipe0 = Recipe(id: 0, title: "this is recipe no.1", image: "https://media.licdn.com/dms/image/C4D0BAQHTIhUhiR4-nQ/company-logo_200_200/0/1600262279545?e=2147483647&v=beta&t=OXYVuiyNYnz9S__NyQvfFk8deTlKxNIZ8FBXPLPjna8")
        let recipe1 = Recipe(id: 1, title: "this is recipe no.2 with a longer title", image: nil)
        let recipes = [recipe0, recipe1]
        
        let allRecipesModel = AllRecipesModel(recipes: recipes, offset: 0, number: 0, totalResults: 2)
        
        let image = UIImage(named: "amaris")
        let recipeToDisplay0 = RecipeToDisplay(id: recipe0.id, title: recipe0.title, image: image!.pngData(), isFavorite: false)
        let recipeToDisplay1 = RecipeToDisplay(id: recipe1.id, title: recipe1.title, image: nil, isFavorite: false)
        
        let recipesToDisplay = [recipeToDisplay0, recipeToDisplay1]
        
        completion(allRecipesModel, recipesToDisplay)
    }
    
}
