//
//  MapRecipeToDisplay.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 31/03/23.
//

import Foundation

protocol MapRecipeToDisplayProtocol: AnyObject {
    func convert(_ input: RecipeWithImageModel) -> RecipeToDisplay
}

class MapRecipeToDisplay: MapRecipeToDisplayProtocol {
    
    func convert(_ input: RecipeWithImageModel) -> RecipeToDisplay {
        RecipeToDisplay(id: input.id, title: input.title, image: input.image, isFavorite: false)
    }
}
