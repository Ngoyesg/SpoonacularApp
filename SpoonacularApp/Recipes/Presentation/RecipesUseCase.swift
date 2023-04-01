//
//  RecipesUseCase.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 31/03/23.
//

import Foundation

enum RecipesUseCase: String {
    case downloading = "Downloading information"
    case modifying = "Modifying favorite recipe"
}

enum RecipesUseCaseStatus: String {
    case failure = "Error"
    case success = "Success"
}
