//
//  FavoritesUseCases.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 1/04/23.
//

import Foundation

enum FavoritesUseCases: String {
    case fetching = "Fetching favorites"
    case deleteOne = "Deleting favorite"
    case deleteAll = "Deleting all favorites"
}

enum FavoritesUseCasesStatus: String {
    case failure = "Error"
    case success = "Success"
}
