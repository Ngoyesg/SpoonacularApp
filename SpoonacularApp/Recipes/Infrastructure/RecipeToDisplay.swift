//
//  RecipeToDisplay.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 31/03/23.
//

import Foundation

struct RecipeToDisplay: Codable, Equatable {
    
    var id: Int
    var title: String? = nil
    var image: Data? = nil
    var isFavorite: Bool = false
    
}
