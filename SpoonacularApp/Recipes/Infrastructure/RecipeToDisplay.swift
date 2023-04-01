//
//  RecipeToDisplay.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 31/03/23.
//

import Foundation

struct RecipeToDisplay {
    
    var id: Int?    = nil
    var title: String? = nil
    var image: Data? = nil
    var isFavorite: Bool = false
 
    mutating func updateRecipeFavoriteStatus(status: Bool){
        self.isFavorite = status
    }
}
