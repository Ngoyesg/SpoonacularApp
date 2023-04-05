//
//  FakeGetDetailsRecipeUseCase.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 5/04/23.
//

import Foundation


class FakeGetDetailsRecipeUseCase: GetDetailsRecipeUseCaseProtocol {
        
    func getRecipesToDisplay(search id: Int, completion: @escaping (DetailedRecipe?, WebServiceError?) -> Void) {
        
        let composition = CaloricBreakdown(percentProtein: 33.0, percentFat: 33.0, percentCarbs: 34.0)
        
        let nutrition = Nutrition(composition: composition)
        
        let instructions = "<p>It is really easy to make this fake recipe!</p><ol><li>Take some XYZ ingredients of your favorite flavor</li><li>Add WYZ, TUV, and 1000 ML of ABC to your blender.</li><li>Stir occasionally until the volume of the mix is reduced by half. Uncover</li><li>Heat the olive oil in a large pot over medium heat.<ol><li>Allow to cook for about 1 hour, keep watching the state of the mix</li><li>After 30 minutes lower the heat to 1/4 of the initial temperature.</li></ol><li>Finish your recipe with some sliced WYZ and serve hot.</li>"
        
        
        let detailedRecipe = DetailedRecipe(vegetarian: true, vegan: true, glutenFree: true, dairyFree: true, preparationMinutes: 10, cookingMinutes: 10, id: 10, title: "Fake Recipe Tile", readyInMinutes: 10, servings: 1, sourceUrl: "sourceURL", image: "anyimageURL", nutrition: nutrition, instructions: instructions)
        
        completion(detailedRecipe, nil)
    }
    
    
}
