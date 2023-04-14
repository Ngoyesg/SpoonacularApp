//
//  FakeFetchRecipesUseCase.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 2/04/23.
//

import Foundation
import UIKit

class FakeFetchRecipesUseCase: FetchRecipesUseCaseProtocol {

    var successFetch: Bool = true
    
    let fakeRecipes = [Recipe(id: 0, title: "this is recipe no.1", image: "https://media.licdn.com/dms/image/C4D0BAQHTIhUhiR4-nQ/company-logo_200_200/0/1600262279545?e=2147483647&v=beta&t=OXYVuiyNYnz9S__NyQvfFk8deTlKxNIZ8FBXPLPjna8"), Recipe(id: 1, title: "this is recipe no.2 with a longer title", image: nil)]
        
    func getRecipes(from offset: Int, to number: Int, search keyword: String, completion: @escaping (AllRecipesModel?, [RecipeToDisplay]?) -> Void) {
        
        let allRecipesModel = AllRecipesModel(recipes: fakeRecipes, offset: 0, number: 0, totalResults: fakeRecipes.count)
        
        let fakeRecipesToDisplay = [RecipeToDisplay(id: fakeRecipes[0].id, title: fakeRecipes[0].title, image: UIImage(named: "amaris")!.pngData(), isFavorite: false), RecipeToDisplay(id: fakeRecipes[1].id, title: fakeRecipes[1].title, image: nil, isFavorite: false)]
                
        if successFetch {
            completion(allRecipesModel, fakeRecipesToDisplay)
        } else {
            completion(nil, nil)
        }
    }
    
}
